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


-- Create DEPARTMENT Table
CREATE TABLE DEPARTMENT (
    department_id INTEGER PRIMARY KEY,
    department_name VARCHAR2(100) NOT NULL UNIQUE
);

-- Create DOCTOR Table
CREATE TABLE DOCTOR (
    doctor_id INTEGER PRIMARY KEY,
    doctor_name VARCHAR2(100) NOT NULL,
    doctor_specialisation VARCHAR2(100) NOT NULL,
    department_id INTEGER NOT NULL,
    experience_years INTEGER CHECK (experience_years >= 0),
    contact_number VARCHAR2(15) UNIQUE,
    email VARCHAR2(100) UNIQUE,
    CONSTRAINT DOCTOR_DEPARTMENT_FK FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
);

-- Create DOCTOR_SCHEDULE Table
CREATE TABLE DOCTOR_SCHEDULE (
    schedule_id INTEGER PRIMARY KEY,
    schedule_date DATE NOT NULL,
    doctor_id INTEGER NOT NULL,
    slots_available_tobook INTEGER NOT NULL CHECK (slots_available_tobook >= 0),
    CONSTRAINT DOCTOR_SCHEDULE_DOCTOR_FK FOREIGN KEY (doctor_id) REFERENCES DOCTOR(doctor_id)
);

-- Create LAB Table
CREATE TABLE LAB (
    lab_id INTEGER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    specialty VARCHAR2(100) NOT NULL,
    department_id INTEGER NOT NULL,
    contact_number VARCHAR2(15) UNIQUE,
    CONSTRAINT LAB_DEPARTMENT_FK FOREIGN KEY (department_id) REFERENCES DEPARTMENT(department_id)
);

-- Create PATIENT Table
CREATE TABLE PATIENT (
    patient_id INTEGER PRIMARY KEY,
    patient_name VARCHAR2(100) NOT NULL,
    contact_number VARCHAR2(15) UNIQUE NOT NULL,
    date_of_birth DATE,
    gender CHAR(1) CHECK (gender IN ('M', 'F', 'O')),
    email VARCHAR2(100) UNIQUE,
    address VARCHAR2(255)
);

-- Create Appointment Table
CREATE TABLE Appointment (
    appointment_id INTEGER PRIMARY KEY,
    appointment_date DATE NOT NULL,
    patient_id INTEGER NOT NULL,
    doctor_id INTEGER NOT NULL,
    appoint_status VARCHAR2(50) CHECK (appoint_status IN ('Scheduled', 'Completed', 'Cancelled')),
    appointment_time DATE NOT NULL,
    CONSTRAINT Appointment_PATIENT_FK FOREIGN KEY (patient_id) REFERENCES PATIENT(patient_id),
    CONSTRAINT Appointment_DOCTOR_FK FOREIGN KEY (doctor_id) REFERENCES DOCTOR(doctor_id)
);

-- Create TIME_SLOT Table
CREATE TABLE TIME_SLOT (
    slot_id INTEGER PRIMARY KEY,
    start_time DATE NOT NULL,
    end_time DATE NOT NULL,
    is_available CHAR(1) CHECK (is_available IN ('Y', 'N')) NOT NULL,
    schedule_id INTEGER NOT NULL,
    appointment_id INTEGER,
    CONSTRAINT TIME_SLOT_SCHEDULE_FK FOREIGN KEY (schedule_id) REFERENCES DOCTOR_SCHEDULE(schedule_id),
    CONSTRAINT TIME_SLOT_APPOINTMENT_FK FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- Create LAB_TEST Table
CREATE TABLE LAB_TEST (
    test_id INTEGER PRIMARY KEY,
    test_type VARCHAR2(100) NOT NULL,
    result VARCHAR2(100),
    test_date DATE,
    appointment_id INTEGER NOT NULL,
    lab_id INTEGER NOT NULL,
    CONSTRAINT LAB_TEST_LAB_FK FOREIGN KEY (lab_id) REFERENCES LAB(lab_id),
    CONSTRAINT LAB_TEST_APPOINTMENT_FK FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

-- Create FEEDBACK Table
CREATE TABLE FEEDBACK (
    feedback_id INTEGER PRIMARY KEY,
    satisfaction_rating INTEGER CHECK (satisfaction_rating BETWEEN 1 AND 5),
    comments VARCHAR2(255),
    appointment_id INTEGER NOT NULL,
    CONSTRAINT FEEDBACK_APPOINTMENT_FK FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);




