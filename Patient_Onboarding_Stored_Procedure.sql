SET SERVEROUTPUT ON;
------------------------------------------------------------------------ SEQUENCE --------------------------------------------------------------

DECLARE
    v_max_patient_id NUMBER;
BEGIN

    SELECT COALESCE(MAX(patient_id), 0) INTO v_max_patient_id FROM appadmin.patient;

    v_max_patient_id := v_max_patient_id + 1;

    BEGIN
        EXECUTE IMMEDIATE 'DROP SEQUENCE patient_id_seq';
        DBMS_OUTPUT.PUT_LINE('Existing sequence dropped successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2289 THEN
                DBMS_OUTPUT.PUT_LINE('Creating a new sequence');
            ELSE
                RAISE;
            END IF;
    END;

    EXECUTE IMMEDIATE 'CREATE SEQUENCE patient_id_seq
                       START WITH ' || v_max_patient_id || '
                       INCREMENT BY 1
                       NOCACHE
                       NOCYCLE';
END;
/

------------------------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE RegisterPatient(
    p_patient_name VARCHAR2,
    p_contact_number VARCHAR2,
    p_date_of_birth DATE,
    p_gender VARCHAR2,
    p_email VARCHAR2,
    p_address VARCHAR2
)
AS
    v_patient_id NUMBER;
BEGIN
    -- Validate gender input
    IF p_gender NOT IN ('M', 'F', 'O') THEN
        RAISE_APPLICATION_ERROR(-20003, 'Invalid gender. Allowed values are M, F, or O.');
    END IF;

    -- Validate for duplicates
    BEGIN
        SELECT patient_id
        INTO v_patient_id
        FROM appadmin.patient
        WHERE contact_number = p_contact_number;

        -- Update the existing record
        UPDATE appadmin.patient SET 
            patient_name = p_patient_name,
            date_of_birth = p_date_of_birth,
            gender = p_gender,
            email = p_email,
            address = p_address
        WHERE patient_id = v_patient_id;

        DBMS_OUTPUT.PUT_LINE('Successfully Updated the existing Patient Record with the id: ' || v_patient_id);
        RETURN; -- Exit after updating
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            NULL; -- Proceed to check for duplicate email
    END;

    -- Validate by email
    BEGIN
        SELECT patient_id
        INTO v_patient_id
        FROM appadmin.patient
        WHERE email = p_email;

        RAISE_APPLICATION_ERROR(-20001, 'Duplicate email: ' || p_email || '.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            NULL; -- Proceed to insert
    END;

    -- Generate new patient_id and insert the record
    SELECT patient_id_seq.NEXTVAL INTO v_patient_id FROM DUAL;

    INSERT INTO appadmin.patient (patient_id, patient_name, contact_number, date_of_birth, gender, email, address)
    VALUES (v_patient_id, p_patient_name, p_contact_number, p_date_of_birth, p_gender, p_email, p_address);

    DBMS_OUTPUT.PUT_LINE('Successfully Created a Patient Record with the id: ' || v_patient_id);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in RegisterPatient: ' || SQLERRM);
        RAISE;
END;
/


--NEW PATIENT RECORD
BEGIN
    RegisterPatient('DAVID', '1239874560', TO_DATE('1990-12-15', 'YYYY-MM-DD'), 'M', 'David@gmail.com', 'park street, Boston');
END;
/

-- Updating an Existing Patient Record
BEGIN
    RegisterPatient('Juan', '9999999999', TO_DATE('1990-12-15', 'YYYY-MM-DD'), 'M', 'Juan@gmail.com', 'park street, Boston');
END;
/