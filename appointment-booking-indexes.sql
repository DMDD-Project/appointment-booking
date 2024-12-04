SET SERVEROUTPUT ON;

DECLARE
    v_count NUMBER;
BEGIN
    -- Index for PATIENT contact number
    SELECT COUNT(*) INTO v_count
    FROM all_indexes i
    JOIN all_ind_columns c ON i.index_name = c.index_name
    WHERE i.table_name = 'PATIENT' AND c.column_name = 'CONTACT_NUMBER' AND i.owner = USER;
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX idx_patient_contact ON PATIENT (contact_number)';
        DBMS_OUTPUT.PUT_LINE('Index IDX_PATIENT_CONTACT created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Index IDX_PATIENT_CONTACT already exists.');
    END IF;

    -- Index for PATIENT email
    SELECT COUNT(*) INTO v_count
    FROM all_indexes i
    JOIN all_ind_columns c ON i.index_name = c.index_name
    WHERE i.table_name = 'PATIENT' AND c.column_name = 'EMAIL' AND i.owner = USER;
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX idx_patient_email ON PATIENT (email)';
        DBMS_OUTPUT.PUT_LINE('Index IDX_PATIENT_EMAIL created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Index IDX_PATIENT_EMAIL already exists.');
    END IF;

    -- Index for APPOINTMENT patient_id
    SELECT COUNT(*) INTO v_count
    FROM all_indexes i
    JOIN all_ind_columns c ON i.index_name = c.index_name
    WHERE i.table_name = 'APPOINTMENT' AND c.column_name = 'PATIENT_ID' AND i.owner = USER;
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX idx_appointment_patient ON APPOINTMENT (patient_id)';
        DBMS_OUTPUT.PUT_LINE('Index IDX_APPOINTMENT_PATIENT created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Index IDX_APPOINTMENT_PATIENT already exists.');
    END IF;

    -- Index for APPOINTMENT doctor_id
    SELECT COUNT(*) INTO v_count
    FROM all_indexes i
    JOIN all_ind_columns c ON i.index_name = c.index_name
    WHERE i.table_name = 'APPOINTMENT' AND c.column_name = 'DOCTOR_ID' AND i.owner = USER;
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX idx_appointment_doctor ON APPOINTMENT (doctor_id)';
        DBMS_OUTPUT.PUT_LINE('Index IDX_APPOINTMENT_DOCTOR created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Index IDX_APPOINTMENT_DOCTOR already exists.');
    END IF;

    -- Index for DOCTOR department_id
    SELECT COUNT(*) INTO v_count
    FROM all_indexes i
    JOIN all_ind_columns c ON i.index_name = c.index_name
    WHERE i.table_name = 'DOCTOR' AND c.column_name = 'DEPARTMENT_ID' AND i.owner = USER;
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX idx_doctor_department ON DOCTOR (department_id)';
        DBMS_OUTPUT.PUT_LINE('Index IDX_DOCTOR_DEPARTMENT created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Index IDX_DOCTOR_DEPARTMENT already exists.');
    END IF;

    -- Index for TIME_SLOT schedule_id
    SELECT COUNT(*) INTO v_count
    FROM all_indexes i
    JOIN all_ind_columns c ON i.index_name = c.index_name
    WHERE i.table_name = 'TIME_SLOT' AND c.column_name = 'SCHEDULE_ID' AND i.owner = USER;
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX idx_time_slot_schedule ON TIME_SLOT (schedule_id)';
        DBMS_OUTPUT.PUT_LINE('Index IDX_TIME_SLOT_SCHEDULE created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Index IDX_TIME_SLOT_SCHEDULE already exists.');
    END IF;

    -- Index for LAB_TEST lab_id
    SELECT COUNT(*) INTO v_count
    FROM all_indexes i
    JOIN all_ind_columns c ON i.index_name = c.index_name
    WHERE i.table_name = 'LAB_TEST' AND c.column_name = 'LAB_ID' AND i.owner = USER;
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX idx_lab_test_lab ON LAB_TEST (lab_id)';
        DBMS_OUTPUT.PUT_LINE('Index IDX_LAB_TEST_LAB created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Index IDX_LAB_TEST_LAB already exists.');
    END IF;

    -- Index for LAB_TEST appointment_id
    SELECT COUNT(*) INTO v_count
    FROM all_indexes i
    JOIN all_ind_columns c ON i.index_name = c.index_name
    WHERE i.table_name = 'LAB_TEST' AND c.column_name = 'APPOINTMENT_ID' AND i.owner = USER;
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX idx_lab_test_appointment ON LAB_TEST (appointment_id)';
        DBMS_OUTPUT.PUT_LINE('Index IDX_LAB_TEST_APPOINTMENT created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Index IDX_LAB_TEST_APPOINTMENT already exists.');
    END IF;

    -- Index for DEPARTMENT department_name
    SELECT COUNT(*) INTO v_count
    FROM all_indexes i
    JOIN all_ind_columns c ON i.index_name = c.index_name
    WHERE i.table_name = 'DEPARTMENT' AND c.column_name = 'DEPARTMENT_NAME' AND i.owner = USER;
    IF v_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE INDEX idx_department_name ON DEPARTMENT (department_name)';
        DBMS_OUTPUT.PUT_LINE('Index IDX_DEPARTMENT_NAME created.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Index IDX_DEPARTMENT_NAME already exists.');
    END IF;

END;
/
