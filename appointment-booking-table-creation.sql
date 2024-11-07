--This is the first script and this script will create tables --

-- Updating the Insertion Statements for all tables--

--See if the table already exists, if yes then drop the table and if no then move on to the next block of code--
SET SERVEROUTPUT ON;

DECLARE
  v_table_exists NUMBER;
BEGIN
  -- Check and drop FEEDBACK table
  SELECT COUNT(*) INTO v_table_exists FROM user_tables WHERE table_name = 'FEEDBACK';
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE FEEDBACK CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table FEEDBACK dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table FEEDBACK needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table FEEDBACK already exists');
END;
/




DECLARE
  v_table_exists NUMBER;
BEGIN  
  -- Check and drop LAB_TEST table
  SELECT COUNT(*) INTO v_table_exists FROM user_tables WHERE table_name = 'LAB_TEST';
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE LAB_TEST CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table LAB_TEST dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table LAB_TEST needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table LAB_TEST already exists');
END;  
/
  
  
  
    

  -- Check and drop TIME_SLOT table
DECLARE
  v_table_exists NUMBER;
BEGIN  
  SELECT COUNT(*) INTO v_table_exists FROM user_tables WHERE table_name = 'TIME_SLOT';
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE TIME_SLOT CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table TIME_SLOT dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table TIME_SLOT needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table TIME_SLOT already exists');
END;  
/

  -- Check and drop APPOINTMENT table
DECLARE
  v_table_exists NUMBER;
BEGIN  
  SELECT COUNT(*) INTO v_table_exists FROM user_tables WHERE table_name = 'APPOINTMENT';
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE APPOINTMENT CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table APPOINTMENT dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table APPOINTMENT needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE(' APPOINTMENT already exists');
END;  

/
  
  

  -- Check and drop PATIENT table
DECLARE
  v_table_exists NUMBER;
BEGIN  
  SELECT COUNT(*) INTO v_table_exists FROM user_tables WHERE table_name = 'PATIENT';
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE PATIENT CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table PATIENT dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table PATIENT needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table PATIENT already exists');
END;
/  
  

  -- Check and drop LAB table
DECLARE
  v_table_exists NUMBER;
BEGIN  
  SELECT COUNT(*) INTO v_table_exists FROM user_tables WHERE table_name = 'LAB';
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE LAB CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table LAB dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table LAB needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table LAB already exists');
END;
/  

  -- Check and drop DOCTOR_SCHEDULE table
DECLARE
  v_table_exists NUMBER;
BEGIN  
  SELECT COUNT(*) INTO v_table_exists FROM user_tables WHERE table_name = 'DOCTOR_SCHEDULE';
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE DOCTOR_SCHEDULE CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table DOCTOR_SCHEDULE dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table DOCTOR_SCHEDULE needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table DOCTOR_SCHEDULE already exists');
END;
/  


  -- Check and drop DOCTOR table
DECLARE
  v_table_exists NUMBER;
BEGIN  
  SELECT COUNT(*) INTO v_table_exists FROM user_tables WHERE table_name = 'DOCTOR';
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE DOCTOR CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table DOCTOR dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table DOCTOR needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    -- Catch and display any error that occurs during the drop operation
    DBMS_OUTPUT.PUT_LINE('Table Doctor already exists');
END;
/  

  -- Check and drop DEPARTMENT table
DECLARE
  v_table_exists NUMBER;
BEGIN   
  SELECT COUNT(*) INTO v_table_exists FROM user_tables WHERE table_name = 'DEPARTMENT';
  IF v_table_exists > 0 THEN
    EXECUTE IMMEDIATE 'DROP TABLE DEPARTMENT CASCADE CONSTRAINTS';
    DBMS_OUTPUT.PUT_LINE('Table DEPARTMENT dropped successfully.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Table DEPARTMENT needs to be created.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Table Department Already Exits');
END;
/





