

-- Sequence Declaration--
DECLARE
  v_max_id NUMBER;
BEGIN
  -- Find the current maximum ID in the APPOINTMENT table
  SELECT COALESCE(MAX(appointment_id), 0) INTO v_max_id FROM APPOINTMENT;

  -- Increment the max value for the next ID
  v_max_id := v_max_id + 1;

  -- Drop the sequence if it already exists
  EXECUTE IMMEDIATE 'BEGIN EXECUTE IMMEDIATE ''DROP SEQUENCE appointment_id_seq''; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;';

  -- Create a sequence starting with the next ID
  EXECUTE IMMEDIATE 'CREATE SEQUENCE appointment_id_seq
                     START WITH ' || v_max_id || '
                     INCREMENT BY 1
                     NOCACHE
                     NOCYCLE';
END;
/
--================================================================================
---Procedure for inserting appointment---

CREATE OR REPLACE PROCEDURE insert_appointment (
    p_patient_id IN NUMBER,
    p_doctor_id IN NUMBER,
    p_appointment_date IN DATE,
    p_appointment_time IN DATE,
    p_status IN VARCHAR2
) AS
  v_appointment_id NUMBER;
  v_slot_id NUMBER;
  v_is_available CHAR(1);
  v_patient_exists NUMBER;
  v_doctor_exists NUMBER;
BEGIN
  -- Check if Patient ID is NULL or does not exist
  IF p_patient_id IS NULL THEN
    RAISE_APPLICATION_ERROR(-20010, 'Patient ID cannot be NULL.');
  END IF;
  -- Validate Future Date
  IF p_appointment_date < TRUNC(SYSDATE) THEN
    RAISE_APPLICATION_ERROR(-20015, 'Appointment date cannot be in the past.');
  END IF;


  SELECT COUNT(*) INTO v_patient_exists
  FROM PATIENT
  WHERE patient_id = p_patient_id;

  IF v_patient_exists = 0 THEN
    RAISE_APPLICATION_ERROR(-20011, 'Invalid Patient ID: Patient does not exist.');
  END IF;

  -- Check if Doctor ID is NULL or does not exist
  IF p_doctor_id IS NULL THEN
    RAISE_APPLICATION_ERROR(-20012, 'Doctor ID cannot be NULL.');
  END IF;

  SELECT COUNT(*) INTO v_doctor_exists
  FROM DOCTOR
  WHERE doctor_id = p_doctor_id;

  IF v_doctor_exists = 0 THEN
    RAISE_APPLICATION_ERROR(-20013, 'Invalid Doctor ID: Doctor does not exist.');
  END IF;

  -- Validate if the doctor is available for the given slot
  SELECT slot_id, is_available INTO v_slot_id, v_is_available
  FROM TIME_SLOT
  WHERE schedule_id IN (
        SELECT schedule_id
        FROM DOCTOR_SCHEDULE
        WHERE doctor_id = p_doctor_id
          AND schedule_date = p_appointment_date
    )
    AND start_time <= p_appointment_time
    AND end_time > p_appointment_time;

  IF v_is_available = 'N' THEN
    RAISE_APPLICATION_ERROR(-20001, 'The selected time slot is already booked.');
  END IF;

  -- Generate the next appointment ID
  SELECT appointment_id_seq.NEXTVAL INTO v_appointment_id FROM DUAL;

  -- Insert data into APPOINTMENT table
  INSERT INTO APPOINTMENT (
      appointment_id, patient_id, doctor_id, appointment_date, appointment_time, appoint_status
  ) VALUES (
      v_appointment_id, p_patient_id, p_doctor_id, p_appointment_date, p_appointment_time, p_status
  );

  -- Update the slot's status to 'Booked'
  UPDATE TIME_SLOT
  SET is_available = 'N',
      appointment_id = v_appointment_id
  WHERE slot_id = v_slot_id;

  DBMS_OUTPUT.PUT_LINE('Appointment created successfully with ID: ' || v_appointment_id);
  DBMS_OUTPUT.PUT_LINE('Slot ID ' || v_slot_id || ' status updated to Booked.');

  COMMIT;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, 'No available slots for the specified doctor and time.');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20003, 'Error while creating the appointment: ' || SQLERRM);
END;
/


--================================================================================

--triggers  
--Trigger to Prevent Overlapping Appointments for a Patient--

CREATE OR REPLACE TRIGGER prevent_overlapping_appointments
BEFORE INSERT OR UPDATE ON APPOINTMENT
FOR EACH ROW
DECLARE
  v_overlap_count NUMBER;
BEGIN
  -- Check if the patient already has an overlapping appointment
  SELECT COUNT(*)
  INTO v_overlap_count
  FROM APPOINTMENT
  WHERE patient_id = :NEW.patient_id
    AND appointment_date = :NEW.appointment_date
    AND appointment_time BETWEEN :NEW.appointment_time - INTERVAL '1' HOUR
                            AND :NEW.appointment_time + INTERVAL '1' HOUR;

  IF v_overlap_count > 0 THEN
    RAISE_APPLICATION_ERROR(-20004, 'The patient already has an overlapping appointment.');
  END IF;
END;
/


--Trigger to Prevent Overbooking for a Doctor--

CREATE OR REPLACE TRIGGER prevent_doctor_overbooking
BEFORE INSERT OR UPDATE ON APPOINTMENT
FOR EACH ROW
DECLARE
  v_booked_slots NUMBER;
  v_available_slots NUMBER;
BEGIN
  -- Count the booked slots for the doctor on the same date
  SELECT COUNT(*)
  INTO v_booked_slots
  FROM APPOINTMENT
  WHERE doctor_id = :NEW.doctor_id
    AND appointment_date = :NEW.appointment_date;

  -- Get the available slots from the doctor schedule
  SELECT slots_available_tobook
  INTO v_available_slots
  FROM DOCTOR_SCHEDULE
  WHERE doctor_id = :NEW.doctor_id
    AND schedule_date = :NEW.appointment_date;

  -- Validate that the number of booked slots doesn't exceed the available slots
  IF v_booked_slots >= v_available_slots THEN
    RAISE_APPLICATION_ERROR(-20005, 'The doctor is overbooked for the specified date.');
  END IF;
END;
/


  -- Validate that the number of booked slots doesn't exceed the available slots
 
--================================================================================

--inserting data into appointment table for validations if the triggers are working or not

-- 1. Insert Valid Data
BEGIN
    insert_appointment(
        p_patient_id => 2,
        p_doctor_id => 3,
        p_appointment_date => TO_DATE('2024-12-12', 'YYYY-MM-DD'),
        p_appointment_time => TO_DATE('2024-12-12 14:30:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_status => 'Scheduled'
    );
END;
/

-- 2. Insert Data for Already Booked Slot
BEGIN
    insert_appointment(
        p_patient_id => 2,
        p_doctor_id => 2,
        p_appointment_date => TO_DATE('2024-12-10', 'YYYY-MM-DD'),
        p_appointment_time => TO_DATE('2024-12-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_status => 'Scheduled'
    );
END;
/

-- 3. Insert Overlapping Appointments for a Patient
BEGIN
    insert_appointment(
        p_patient_id => 1,
        p_doctor_id => 3,
        p_appointment_date => TO_DATE('2024-12-10', 'YYYY-MM-DD'),
        p_appointment_time => TO_DATE('2024-12-10 10:30:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_status => 'Scheduled'
    );
END;
/

-- 4. Overbook a Doctor
BEGIN
    insert_appointment(
        p_patient_id => 3,
        p_doctor_id => 2,
        p_appointment_date => TO_DATE('2024-12-10', 'YYYY-MM-DD'),
        p_appointment_time => TO_DATE('2024-12-10 11:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_status => 'Scheduled'
    );
END;
/

-- 5. Insert Data for a Nonexistent Slot
BEGIN
    insert_appointment(
        p_patient_id => 4,
        p_doctor_id => 2,
        p_appointment_date => TO_DATE('2024-12-15', 'YYYY-MM-DD'),
        p_appointment_time => TO_DATE('2024-12-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_status => 'Scheduled'
    );
END;
/

-- 6. Insert Data with Invalid Patient or Doctor ID
BEGIN
    insert_appointment(
        p_patient_id => 999,  -- Nonexistent patient
        p_doctor_id => 2,
        p_appointment_date => TO_DATE('2024-12-10', 'YYYY-MM-DD'),
        p_appointment_time => TO_DATE('2024-12-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_status => 'Scheduled'
    );
END;
/

-- 7. Null Patient ID
BEGIN
    insert_appointment(
        p_patient_id => NULL,
        p_doctor_id => 2,
        p_appointment_date => TO_DATE('2024-12-10', 'YYYY-MM-DD'),
        p_appointment_time => TO_DATE('2024-12-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_status => 'Scheduled'
    );
END;
/

-- 8. Null Doctor ID
BEGIN
    insert_appointment(
        p_patient_id => 1,
        p_doctor_id => NULL,
        p_appointment_date => TO_DATE('2024-12-10', 'YYYY-MM-DD'),
        p_appointment_time => TO_DATE('2024-12-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        p_status => 'Scheduled'
    );
END;
/
