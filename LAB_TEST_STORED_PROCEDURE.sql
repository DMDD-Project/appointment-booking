SET SERVEROUTPUT ON;

DECLARE
    v_test_id NUMBER;
BEGIN

    SELECT COALESCE(MAX(test_id), 0) INTO v_test_id FROM appadmin.LAB_TEST;

    v_test_id := v_test_id + 1;

    BEGIN
        EXECUTE IMMEDIATE 'DROP SEQUENCE test_id_seq';
        DBMS_OUTPUT.PUT_LINE('Existing sequence dropped successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2289 THEN
                DBMS_OUTPUT.PUT_LINE('Creating a new sequence');
            ELSE
                RAISE;
            END IF;
    END;

    EXECUTE IMMEDIATE 'CREATE SEQUENCE test_id_seq
                       START WITH ' || v_test_id || '
                       INCREMENT BY 1
                       NOCACHE
                       NOCYCLE';
END;
/

CREATE OR REPLACE PROCEDURE EnterLabTest(
    l_test_type VARCHAR2,
    l_result VARCHAR2,
    l_test_date DATE,
    l_appointment_id INTEGER,
    l_lab_id INTEGER
) IS 
    l_new_test_id NUMBER;
    l_lab_exists NUMBER;
    l_appointment_id_check NUMBER;

BEGIN
    SELECT COUNT(*) INTO l_lab_exists
    FROM appadmin.lab
    WHERE lab_id = l_lab_id;

    IF l_lab_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid lab_id: ' || l_lab_id || '.');
    END IF;

    SELECT COUNT(*) INTO l_appointment_id_check
    FROM appadmin.APPOINTMENT
    WHERE appointment_id = l_appointment_id;

    IF l_appointment_id_check = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Invalid appointment_id: ' || l_appointment_id || '.');
    END IF;

    SELECT test_id_seq.NEXTVAL INTO l_new_test_id FROM DUAL;

    INSERT INTO appadmin.LAB_TEST (test_id, test_type, result, test_date, appointment_id, lab_id)
    VALUES (l_new_test_id, l_test_type, l_result, l_test_date, l_appointment_id, l_lab_id);

    DBMS_OUTPUT.PUT_LINE('Successfully Insrted a Lab Record with id: ' || l_new_test_id );

    commit;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error While Inserting Lab Record.');
        RAISE;
END EnterLabTest;
/

BEGIN
    EnterLabTest('Blood Test', 'Normal', TO_DATE('2024-10-25', 'YYYY-MM-DD'), 1, 1);
END;
/


