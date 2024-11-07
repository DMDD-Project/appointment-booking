SET SERVEROUTPUT ON ;

DECLARE
    v_user_count NUMBER;
BEGIN
    -- Check for Receptionist
    SELECT COUNT(*)
    INTO v_user_count
    FROM dba_users
    WHERE username = 'RECEPTIONIST';

    IF v_user_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER Receptionist CASCADE';
        DBMS_OUTPUT.PUT_LINE('Existing user Receptionist dropped.');
    END IF;

    EXECUTE IMMEDIATE 'CREATE USER Receptionist IDENTIFIED BY appointmentR2024';
    EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Receptionist';
    DBMS_OUTPUT.PUT_LINE('User Receptionist created successfully.');

    -- Check for Doctor
    SELECT COUNT(*)
    INTO v_user_count
    FROM dba_users
    WHERE username = 'DOCTOR';

    IF v_user_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER Doctor CASCADE';
        DBMS_OUTPUT.PUT_LINE('Existing user Doctor dropped.');
    END IF;

    EXECUTE IMMEDIATE 'CREATE USER Doctor IDENTIFIED BY appointmentD2024';
    EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Doctor';
    DBMS_OUTPUT.PUT_LINE('User Doctor created successfully.');

    -- Check for Patient
    SELECT COUNT(*)
    INTO v_user_count
    FROM dba_users
    WHERE username = 'PATIENT';

    IF v_user_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER Patient CASCADE';
        DBMS_OUTPUT.PUT_LINE('Existing user Patient dropped.');
    END IF;

    EXECUTE IMMEDIATE 'CREATE USER Patient IDENTIFIED BY appointmentP2024';
    EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Patient';
    DBMS_OUTPUT.PUT_LINE('User Patient created successfully.');

    -- Check for Lab_Technician
    SELECT COUNT(*)
    INTO v_user_count
    FROM dba_users
    WHERE username = 'LAB_TECHNICIAN';

    IF v_user_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER Lab_Technician CASCADE';
        DBMS_OUTPUT.PUT_LINE('Existing user Lab Technician dropped.');
    END IF;

    EXECUTE IMMEDIATE 'CREATE USER Lab_Technician IDENTIFIED BY appointmentL2024';
    EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Lab_Technician';
    DBMS_OUTPUT.PUT_LINE('User Lab Technician created successfully.');

    -- Check for Department_Head
    SELECT COUNT(*)
    INTO v_user_count
    FROM dba_users
    WHERE username = 'DEPARTMENT_HEAD';

    IF v_user_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP USER Department_Head CASCADE';
        DBMS_OUTPUT.PUT_LINE('Existing user Department Head dropped.');
    END IF;

    EXECUTE IMMEDIATE 'CREATE USER Department_Head IDENTIFIED BY appointmentD2024';
    EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Department_Head';
    DBMS_OUTPUT.PUT_LINE('User Department Head created successfully.');
END;
