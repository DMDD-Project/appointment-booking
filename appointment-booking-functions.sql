CREATE OR REPLACE FUNCTION GetPatientAppointmentHistory(PatientID INT)
RETURN SYS_REFCURSOR IS
    appointment_cursor SYS_REFCURSOR;
BEGIN
    OPEN appointment_cursor FOR
        SELECT A.appointment_id, A.appointment_date, A.appoint_status, A.appointment_time
        FROM APPOINTMENT A
        WHERE A.patient_id = PatientID
        ORDER BY A.appointment_date DESC;

    RETURN appointment_cursor;
END;
/


CREATE OR REPLACE FUNCTION GetDoctorSchedule(DoctorID INT)
RETURN SYS_REFCURSOR IS
    schedule_cursor SYS_REFCURSOR;
BEGIN
    OPEN schedule_cursor FOR
        SELECT S.schedule_id, S.schedule_date, T.start_time, T.end_time, T.is_available
        FROM DOCTOR_SCHEDULE S
        JOIN TIME_SLOT T ON S.schedule_id = T.schedule_id
        WHERE S.doctor_id = DoctorID
        ORDER BY S.schedule_date, T.start_time;

    RETURN schedule_cursor;
END;
/


CREATE OR REPLACE FUNCTION GetDoctorPerformanceMetrics(DoctorID INT)
RETURN NUMBER IS
    AvgFeedback NUMBER;
BEGIN
    SELECT AVG(F.satisfaction_rating)
    INTO AvgFeedback
    FROM FEEDBACK F
    JOIN APPOINTMENT A ON F.appointment_id = A.appointment_id
    JOIN DOCTOR_SCHEDULE S ON A.DOCTOR_ID = S.DOCTOR_ID
    WHERE S.doctor_id = DoctorID;

    RETURN NVL(AvgFeedback, 0);
END;
/


CREATE OR REPLACE FUNCTION CheckDoctorAvailability(DoctorID INT, StartTime DATE, EndTime DATE)
RETURN NUMBER IS
    IsAvailable NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO IsAvailable
    FROM TIME_SLOT T
    JOIN DOCTOR_SCHEDULE S ON T.schedule_id = S.schedule_id
    WHERE S.doctor_id = DoctorID
      AND T.is_available = 'Y'
      AND T.start_time <= StartTime
      AND T.end_time >= EndTime;

    RETURN IsAvailable;
END;
/

SELECT CheckDoctorAvailability(1, TO_DATE('10-DEC-24 09:00:00', 'DD-MON-YY HH24:MI:SS'),
                                  TO_DATE('10-DEC-24 10:00:00', 'DD-MON-YY HH24:MI:SS')) AS IsAvailable
FROM DUAL;


CREATE OR REPLACE FUNCTION GetNextAppointment(DoctorID INT)
RETURN SYS_REFCURSOR IS
    next_appointment_cursor SYS_REFCURSOR;
BEGIN
    OPEN next_appointment_cursor FOR
        SELECT A.appointment_id, A.appointment_date, P.patient_name, T.start_time
        FROM APPOINTMENT A
        JOIN TIME_SLOT T ON A.appointment_id = T.appointment_id
        JOIN PATIENT P ON A.patient_id = P.patient_id
        WHERE T.schedule_id IN (
            SELECT schedule_id FROM DOCTOR_SCHEDULE WHERE doctor_id = DoctorID
        )
        ORDER BY A.appointment_date, T.start_time;

    RETURN next_appointment_cursor;
END;
/



-- Check Appointment Overlap

CREATE OR REPLACE FUNCTION CheckAppointmentOverlap(DoctorID INT, StartTime DATE, EndTime DATE)
RETURN NUMBER IS
    OverlapCount NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO OverlapCount
    FROM TIME_SLOT T
    JOIN DOCTOR_SCHEDULE S ON T.schedule_id = S.schedule_id
    WHERE S.doctor_id = DoctorID
      AND (T.start_time < EndTime AND T.end_time > StartTime);

    RETURN OverlapCount;
END;
/


-- Get Lab Test Details

CREATE OR REPLACE FUNCTION GetLabTestDetails(AppointmentID INT)
RETURN SYS_REFCURSOR IS
    lab_test_cursor SYS_REFCURSOR;
BEGIN
    OPEN lab_test_cursor FOR
        SELECT LT.test_id, LT.test_type, LT.result, LT.test_date, L.name AS lab_name
        FROM LAB_TEST LT
        JOIN LAB L ON LT.lab_id = L.lab_id
        WHERE LT.appointment_id = AppointmentID;

    RETURN lab_test_cursor;
END;
/


-- Get Lab Workload

CREATE OR REPLACE FUNCTION GetLabWorkload(DepartmentID INT)
RETURN NUMBER IS
    LabWorkload NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO LabWorkload
    FROM LAB_TEST LT
    JOIN LAB L ON LT.lab_id = L.lab_id
    WHERE L.department_id = DepartmentID;

    RETURN LabWorkload;
END;
/

 
-- Get Appointment Feedback

CREATE OR REPLACE FUNCTION GetAppointmentFeedback(AppointmentID INT)
RETURN SYS_REFCURSOR IS
    feedback_cursor SYS_REFCURSOR;
BEGIN
    OPEN feedback_cursor FOR
        SELECT F.feedback_id, F.satisfaction_rating, F.comments
        FROM FEEDBACK F
        WHERE F.appointment_id = AppointmentID;

    RETURN feedback_cursor;
END;
/