CREATE OR REPLACE PACKAGE healthcare_simple AS
    -- Function to calculate the total number of appointments for a doctor
    FUNCTION GetDoctorTotalAppointments(p_doctor_id IN NUMBER) RETURN NUMBER;

    -- Procedure to update the status of an appointment
    PROCEDURE UpdateAppointmentStatus(p_appointment_id IN NUMBER, p_status IN VARCHAR2);
END healthcare_simple;
/


CREATE OR REPLACE PACKAGE BODY healthcare_simple AS
    -- Function to calculate total appointments for a doctor
    FUNCTION GetDoctorTotalAppointments(p_doctor_id IN NUMBER) RETURN NUMBER IS
        v_total_appointments NUMBER;
    BEGIN
        SELECT COUNT(*) 
        INTO v_total_appointments
        FROM APPOINTMENT
        WHERE doctor_id = p_doctor_id;

        RETURN NVL(v_total_appointments, 0); -- Return 0 if no appointments
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END GetDoctorTotalAppointments;

    -- Procedure to update the status of an appointment
    PROCEDURE UpdateAppointmentStatus(p_appointment_id IN NUMBER, p_status IN VARCHAR2) IS
        v_appointment_exists NUMBER;
    BEGIN
        -- Check if the appointment exists
        SELECT COUNT(*)
        INTO v_appointment_exists
        FROM APPOINTMENT
        WHERE appointment_id = p_appointment_id;

        IF v_appointment_exists = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Appointment not found!');
        END IF;

        -- Update the appointment status
        UPDATE APPOINTMENT
        SET appoint_status = p_status
        WHERE appointment_id = p_appointment_id;

        DBMS_OUTPUT.PUT_LINE('Appointment status updated successfully.');
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002, 'Error updating appointment: ' || SQLERRM);
    END UpdateAppointmentStatus;
END healthcare_simple;
/

--================================================================================

checkin the package and package body
SET SERVEROUTPUT ON;

DECLARE
    v_total_appointments NUMBER;
BEGIN
    -- Replace 1 with a valid doctor_id from your APPOINTMENT table
    v_total_appointments := healthcare_simple.GetDoctorTotalAppointments(1);
    DBMS_OUTPUT.PUT_LINE('Total Appointments for Doctor 1: ' || v_total_appointments);
END;
/