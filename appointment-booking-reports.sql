
--1. Doctor Availability Report

SET SERVEROUTPUT ON;

------------------------------------ Will show all upcoming appointments for a doctor -------------------------------------------
DECLARE
    v_doctor_id INT := 1;
    appointment_cursor SYS_REFCURSOR;
    appointment_id INT;
    appointment_date DATE;
    patient_name VARCHAR2(100);
    appointment_time DATE;
    v_doctor_name VARCHAR2(100);
    v_doctor_specialisation VARCHAR2(50);

BEGIN
    -- Fetch Doctor details
    SELECT D.doctor_name, D.doctor_specialisation
    INTO v_doctor_name, v_doctor_specialisation
    FROM DOCTOR D
    WHERE D.doctor_id = v_doctor_id;

    DBMS_OUTPUT.PUT_LINE('Doctor Name: ' || v_doctor_name);
    DBMS_OUTPUT.PUT_LINE('Specialization: ' || v_doctor_specialisation);
    DBMS_OUTPUT.PUT_LINE('=========================================');

    -- Get the next appointment(s) using the function
    appointment_cursor := GetNextAppointment(v_doctor_id);

    -- Fetch all appointments and display details
    LOOP
        FETCH appointment_cursor INTO appointment_id, appointment_date, patient_name, appointment_time;
        EXIT WHEN appointment_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Appointment ID: ' || appointment_id);
        DBMS_OUTPUT.PUT_LINE('Appointment Date: ' || TO_CHAR(appointment_date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('Patient Name: ' || patient_name);
        DBMS_OUTPUT.PUT_LINE('Appointment Time: ' || TO_CHAR(appointment_time, 'HH24:MI'));
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
    END LOOP;

    CLOSE appointment_cursor;

    DBMS_OUTPUT.PUT_LINE('Report generation completed.');

END;
/

---------------------------------------------- Will Show total lab tests done under a department ----------------------------------

SET SERVEROUTPUT ON;

DECLARE
    v_department_id DEPARTMENT.DEPARTMENT_ID%TYPE;
    v_lab_workload NUMBER;
BEGIN

    v_department_id := 2;

    -- Fetch lab workload using the function
    v_lab_workload := GetLabWorkload(v_department_id);

    -- Print the report
    DBMS_OUTPUT.PUT_LINE('Lab Workload Report for Department ID: ' || v_department_id);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Lab Tests Conducted: ' || v_lab_workload);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
END;
/

DECLARE
    v_doctor_id DOCTOR.DOCTOR_ID%TYPE;
    v_start_time DATE;
    v_end_time DATE;
    v_is_available NUMBER;
BEGIN
    -- Doctor ID and time range for the report
    v_doctor_id := 1; -- Replace with desired Doctor ID
    v_start_time := TO_DATE('10-DEC-2024 09:00:00', 'DD-MON-YYYY HH24:MI:SS');
    v_end_time := TO_DATE('10-DEC-2024 10:00:00', 'DD-MON-YYYY HH24:MI:SS');

    -- Check availability using the function
    v_is_available := CheckDoctorAvailability(v_doctor_id, v_start_time, v_end_time);

    -- Print the report
    DBMS_OUTPUT.PUT_LINE('Doctor Availability Report');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Doctor ID: ' || v_doctor_id);
    DBMS_OUTPUT.PUT_LINE('Time Range: ' || TO_CHAR(v_start_time, 'DD-MON-YYYY HH24:MI') || ' - ' || TO_CHAR(v_end_time, 'DD-MON-YYYY HH24:MI'));
    DBMS_OUTPUT.PUT_LINE('Available: ' || CASE WHEN v_is_available > 0 THEN 'Yes' ELSE 'No' END);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
END;
/







-- A patient Report of appointments and history of lab test--

SET SERVEROUTPUT ON;

DECLARE
    v_patient_id PATIENT.PATIENT_ID%TYPE;
    v_appointment_cursor SYS_REFCURSOR;
    v_lab_test_cursor SYS_REFCURSOR;

    -- Variables for appointment details
    v_appointment_id APPOINTMENT.APPOINTMENT_ID%TYPE;
    v_appointment_date APPOINTMENT.APPOINTMENT_DATE%TYPE;
    v_appointment_status APPOINTMENT.APPOINT_STATUS%TYPE;
    v_appointment_time APPOINTMENT.APPOINTMENT_TIME%TYPE;

    -- Variables for lab test details
    v_test_id LAB_TEST.TEST_ID%TYPE;
    v_test_type LAB_TEST.TEST_TYPE%TYPE;
    v_result LAB_TEST.RESULT%TYPE;
    v_test_date LAB_TEST.TEST_DATE%TYPE;
    v_lab_name LAB.NAME%TYPE;
BEGIN
    -- Patient ID for report
    v_patient_id := 1; -- Replace with the desired Patient ID

    -- Fetch appointment history using the function
    v_appointment_cursor := GetPatientAppointmentHistory(v_patient_id);

    -- Print the header
    DBMS_OUTPUT.PUT_LINE('Appointment History for Patient ID: ' || v_patient_id);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('ID | Date       | Status    | Time');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');

    -- Loop through appointment cursor and print each record
    LOOP
        FETCH v_appointment_cursor INTO v_appointment_id, v_appointment_date, v_appointment_status, v_appointment_time;
        EXIT WHEN v_appointment_cursor%NOTFOUND;

        -- Print appointment details
        DBMS_OUTPUT.PUT_LINE(v_appointment_id || ' | ' || TO_CHAR(v_appointment_date, 'DD-MON-YYYY') || ' | ' || v_appointment_status || ' | ' || TO_CHAR(v_appointment_time, 'HH:MI AM'));

        -- Fetch lab test details for the current appointment
        v_lab_test_cursor := GetLabTestDetails(v_appointment_id);

        -- Print lab test header
        DBMS_OUTPUT.PUT_LINE('    Lab Tests:');
        DBMS_OUTPUT.PUT_LINE('    ID | Type         | Result      | Date       | Lab Name');
        DBMS_OUTPUT.PUT_LINE('    ----------------------------------------------------');

        -- Loop through lab test cursor and print each record
        LOOP
            FETCH v_lab_test_cursor INTO v_test_id, v_test_type, v_result, v_test_date, v_lab_name;
            EXIT WHEN v_lab_test_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('    ' || v_test_id || ' | ' || RPAD(v_test_type, 12) || ' | ' || RPAD(v_result, 10) || ' | ' || TO_CHAR(v_test_date, 'DD-MON-YYYY') || ' | ' || v_lab_name);
        END LOOP;

        -- Close the lab test cursor
        CLOSE v_lab_test_cursor;

        -- Separator between appointments
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
    END LOOP;

    -- Close the appointment cursor
    CLOSE v_appointment_cursor;

    DBMS_OUTPUT.PUT_LINE('------------------------------------------------');
END;
/

-- Feedback Report for an Appointment--   

SET SERVEROUTPUT ON;

DECLARE
    v_appointment_id APPOINTMENT.APPOINTMENT_ID%TYPE;
    v_feedback_cursor SYS_REFCURSOR;

    v_feedback_id FEEDBACK.FEEDBACK_ID%TYPE;
    v_satisfaction_rating FEEDBACK.SATISFACTION_RATING%TYPE;
    v_comments FEEDBACK.COMMENTS%TYPE;
BEGIN
    -- Appointment ID for the report
    v_appointment_id := 1; -- Replace with desired Appointment ID

    -- Fetch feedback details using the function
    v_feedback_cursor := GetAppointmentFeedback(v_appointment_id);

    -- Print the header
    DBMS_OUTPUT.PUT_LINE('Feedback for Appointment ID: ' || v_appointment_id);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('ID | Rating | Comments');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');

    -- Loop through cursor and print each record
    LOOP
        FETCH v_feedback_cursor INTO v_feedback_id, v_satisfaction_rating, v_comments;
        EXIT WHEN v_feedback_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_feedback_id || ' | ' || v_satisfaction_rating || '      | ' || v_comments);
    END LOOP;

    -- Close the cursor
    CLOSE v_feedback_cursor;

    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
END;
/
