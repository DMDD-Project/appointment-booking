SET SERVEROUTPUT ON;

DECLARE
    v_user_count NUMBER;
BEGIN
    -- Granting permissions for Creation of user Receptionist
    SELECT COUNT(*)
    INTO v_user_count
    FROM dba_users
    WHERE username = 'RECEPTIONIST';

    IF v_user_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE USER Receptionist IDENTIFIED BY appointmentR2024';
        EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Receptionist';
        DBMS_OUTPUT.PUT_LINE('User Receptionist created successfully');
    ELSE
        DBMS_OUTPUT.PUT_LINE('User Receptionist already exists');
    END IF;

    -- Granting permissions for Creation of user Doctor
    SELECT COUNT(*)
    INTO v_user_count
    FROM dba_users
    WHERE username = 'DOCTOR';

    IF v_user_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE USER Doctor IDENTIFIED BY appointmentD2024';
        EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Doctor';
        DBMS_OUTPUT.PUT_LINE('User Doctor created successfully');
    ELSE
        DBMS_OUTPUT.PUT_LINE('User Doctor already exists');
    END IF;

    -- Granting permissions for Creation of user Patient
    SELECT COUNT(*)
    INTO v_user_count
    FROM dba_users
    WHERE username = 'PATIENT';

    IF v_user_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE USER Patient IDENTIFIED BY appointmentP2024';
        EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Patient';
        DBMS_OUTPUT.PUT_LINE('User Patient created successfully');
    ELSE
        DBMS_OUTPUT.PUT_LINE('User Patient already exists');
    END IF;

    -- Granting permissions for Creation of user Lab_Technician
    SELECT COUNT(*)
    INTO v_user_count
    FROM dba_users
    WHERE username = 'LAB_TECHNICIAN';

    IF v_user_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE USER Lab_Technician IDENTIFIED BY appointmentL2024';
        EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Lab_Technician';
        DBMS_OUTPUT.PUT_LINE('User Lab Technician created successfully');
    ELSE
        DBMS_OUTPUT.PUT_LINE('User Lab Technician already exists');
    END IF;

    -- Granting permissions for Creation of user Department_Head
    SELECT COUNT(*)
    INTO v_user_count
    FROM dba_users
    WHERE username = 'DEPARTMENT_HEAD';

    IF v_user_count = 0 THEN
        EXECUTE IMMEDIATE 'CREATE USER Department_Head IDENTIFIED BY appointmentD2024';
        EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO Department_Head';
        DBMS_OUTPUT.PUT_LINE('User Department Head created successfully');
    ELSE
        DBMS_OUTPUT.PUT_LINE('User Department Head already exists');
    END IF;
EXCEPTION

    WHEN OTHERS THEN

        -- Error Handling

        DBMS_OUTPUT.PUT_LINE('User already exists');

END;
/