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

-- Insert Sample Data for DEPARTMENT
INSERT INTO DEPARTMENT (department_id, department_name) VALUES (1, 'Cardiology');
INSERT INTO DEPARTMENT (department_id, department_name) VALUES (2, 'Neurology');
INSERT INTO DEPARTMENT (department_id, department_name) VALUES (3, 'Orthopedics');
INSERT INTO DEPARTMENT (department_id, department_name) VALUES (4, 'Dermatology');
INSERT INTO DEPARTMENT (department_id, department_name) VALUES (5, 'Pediatrics');
INSERT INTO DEPARTMENT (department_id, department_name) VALUES (6, 'Oncology');

-- Insert Sample Data for DOCTOR
INSERT INTO DOCTOR (doctor_id, doctor_name, doctor_specialisation, department_id, experience_years, contact_number, email) 
VALUES (1, 'Dr. John Doe', 'Cardiologist', 1, 10, '1234567890', 'johndoe@hospital.com');
INSERT INTO DOCTOR (doctor_id, doctor_name, doctor_specialisation, department_id, experience_years, contact_number, email) 
VALUES (2, 'Dr. Jane Smith', 'Neurologist', 2, 8, '0987654321', 'janesmith@hospital.com');
INSERT INTO DOCTOR (doctor_id, doctor_name, doctor_specialisation, department_id, experience_years, contact_number, email) 
VALUES (3, 'Dr. Emily Brown', 'Orthopedic', 3, 5, '1122334455', 'emilybrown@hospital.com');
INSERT INTO DOCTOR (doctor_id, doctor_name, doctor_specialisation, department_id, experience_years, contact_number, email) 
VALUES (4, 'Dr. Robert White', 'Dermatologist', 4, 15, '2233445566', 'robertwhite@hospital.com');
INSERT INTO DOCTOR (doctor_id, doctor_name, doctor_specialisation, department_id, experience_years, contact_number, email) 
VALUES (5, 'Dr. Sarah Johnson', 'Pediatrician', 5, 12, '3344556677', 'sarahjohnson@hospital.com');
INSERT INTO DOCTOR (doctor_id, doctor_name, doctor_specialisation, department_id, experience_years, contact_number, email) 
VALUES (6, 'Dr. Michael Green', 'Oncologist', 6, 7, '6677889900', 'michaelgreen@hospital.com');


-- Insert Sample Data for PATIENT
INSERT INTO PATIENT (patient_id, patient_name, contact_number, date_of_birth, gender, email, address) 
VALUES (1, 'Alice Williams', '1111111111', TO_DATE('1990-01-01', 'YYYY-MM-DD'), 'F', 'alicewilliams@gmail.com', '123 Main St, Springfield');
INSERT INTO PATIENT (patient_id, patient_name, contact_number, date_of_birth, gender, email, address) 
VALUES (2, 'Bob Johnson', '2222222222', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 'M', 'bobjohnson@gmail.com', '456 Elm St, Springfield');
INSERT INTO PATIENT (patient_id, patient_name, contact_number, date_of_birth, gender, email, address) 
VALUES (3, 'Charlie Davis', '3333333333', TO_DATE('1995-07-20', 'YYYY-MM-DD'), 'M', 'charliedavis@gmail.com', '789 Oak St, Springfield');
INSERT INTO PATIENT (patient_id, patient_name, contact_number, date_of_birth, gender, email, address) 
VALUES (4, 'Diana Prince', '4444444444', TO_DATE('1992-11-10', 'YYYY-MM-DD'), 'F', 'dianaprince@gmail.com', '321 Pine St, Springfield');
INSERT INTO PATIENT (patient_id, patient_name, contact_number, date_of_birth, gender, email, address) 
VALUES (5, 'Ethan Hunt', '5555555555', TO_DATE('1988-02-28', 'YYYY-MM-DD'), 'M', 'ethanhunt@gmail.com', '654 Cedar St, Springfield');
INSERT INTO PATIENT (patient_id, patient_name, contact_number, date_of_birth, gender, email, address) 
VALUES (6, 'Frank West', '6666666666', TO_DATE('1991-06-10', 'YYYY-MM-DD'), 'M', 'frankwest@gmail.com', '987 Lake St, Springfield');

-- Insert Sample Data for DOCTOR_SCHEDULE with random dates
INSERT INTO DOCTOR_SCHEDULE (schedule_id, schedule_date, doctor_id, slots_available_tobook)
VALUES (1, TO_DATE('10-30-24', 'MM-DD-YY'), 1, 2);  -- Past date
INSERT INTO DOCTOR_SCHEDULE (schedule_id, schedule_date, doctor_id, slots_available_tobook)
VALUES (2, TO_DATE('11-04-24', 'MM-DD-YY'), 2, 2);  -- Future date
INSERT INTO DOCTOR_SCHEDULE (schedule_id, schedule_date, doctor_id, slots_available_tobook)
VALUES (3, TO_DATE('11-10-24', 'MM-DD-YY'), 3, 3);  -- Future date
INSERT INTO DOCTOR_SCHEDULE (schedule_id, schedule_date, doctor_id, slots_available_tobook)
VALUES (4, TO_DATE('11-15-24', 'MM-DD-YY'), 4, 4);  -- Future date
INSERT INTO DOCTOR_SCHEDULE (schedule_id, schedule_date, doctor_id, slots_available_tobook)
VALUES (5, TO_DATE('12-02-24', 'MM-DD-YY'), 5, 1);  -- Future date
INSERT INTO DOCTOR_SCHEDULE (schedule_id, schedule_date, doctor_id, slots_available_tobook)
VALUES (6, TO_DATE('12-05-24', 'MM-DD-YY'), 6, 5);  -- Future date


-- Insert Sample Data for APPOINTMENT with random dates
INSERT INTO Appointment (appointment_id, appointment_date, patient_id, doctor_id, appoint_status, appointment_time) 
VALUES (1, TO_DATE('10-25-24', 'MM-DD-YY'), 1, 1, 'Completed', TO_DATE('10-25-24 09:00 AM', 'MM-DD-YY HH:MI AM'));
INSERT INTO Appointment (appointment_id, appointment_date, patient_id, doctor_id, appoint_status, appointment_time) 
VALUES (2, TO_DATE('11-06-24', 'MM-DD-YY'), 2, 2, 'Scheduled', TO_DATE('11-06-24 10:00 AM', 'MM-DD-YY HH:MI AM')); -- Today
INSERT INTO Appointment (appointment_id, appointment_date, patient_id, doctor_id, appoint_status, appointment_time) 
VALUES (3, TO_DATE('11-01-24', 'MM-DD-YY'), 3, 3, 'Completed', TO_DATE('11-01-24 01:00 PM', 'MM-DD-YY HH:MI AM'));
INSERT INTO Appointment (appointment_id, appointment_date, patient_id, doctor_id, appoint_status, appointment_time) 
VALUES (4, TO_DATE('11-20-24', 'MM-DD-YY'), 4, 4, 'Scheduled', TO_DATE('11-20-24 02:00 PM', 'MM-DD-YY HH:MI AM'));  -- Future date
INSERT INTO Appointment (appointment_id, appointment_date, patient_id, doctor_id, appoint_status, appointment_time) 
VALUES (5, TO_DATE('12-10-24', 'MM-DD-YY'), 5, 5, 'Scheduled', TO_DATE('12-10-24 11:00 AM', 'MM-DD-YY HH:MI AM'));  -- Future date
INSERT INTO Appointment (appointment_id, appointment_date, patient_id, doctor_id, appoint_status, appointment_time) 
VALUES (6, TO_DATE('11-10-24', 'MM-DD-YY'), 6, 6, 'Scheduled', TO_DATE('11-10-24 09:00 AM', 'MM-DD-YY HH:MI AM')); -- Future date

-- Insert Sample Data for LAB
INSERT INTO LAB (lab_id, name, specialty, department_id, contact_number) 
VALUES (1, 'Lab A', 'Blood Test', 1, '6666666666');
INSERT INTO LAB (lab_id, name, specialty, department_id, contact_number) 
VALUES (2, 'Lab B', 'MRI', 2, '7777777777');
INSERT INTO LAB (lab_id, name, specialty, department_id, contact_number) 
VALUES (3, 'Lab C', 'X-Ray', 3, '8888888888');
INSERT INTO LAB (lab_id, name, specialty, department_id, contact_number) 
VALUES (4, 'Lab D', 'Allergy Test', 4, '9999999999');
INSERT INTO LAB (lab_id, name, specialty, department_id, contact_number) 
VALUES (5, 'Lab E', 'Pediatric Test', 5, '0000000000');
INSERT INTO LAB (lab_id, name, specialty, department_id, contact_number) 
VALUES (6, 'Lab F', 'Pathology Test', 6, '1231231234');

-- Insert Sample Data for LAB_TEST
INSERT INTO LAB_TEST (test_id, test_type, result, test_date, appointment_id, lab_id) 
VALUES (1, 'Blood Test', 'Normal', TO_DATE('11-01-24', 'MM-DD-YY'), 1, 1);
INSERT INTO LAB_TEST (test_id, test_type, result, test_date, appointment_id, lab_id) 
VALUES (2, 'MRI', 'Clear', TO_DATE('10-25-24', 'MM-DD-YY'), 2, 2);
INSERT INTO LAB_TEST (test_id, test_type, result, test_date, appointment_id, lab_id) 
VALUES (3, 'X-Ray', 'No Issues', TO_DATE('11-04-24', 'MM-DD-YY'), 3, 3);
INSERT INTO LAB_TEST (test_id, test_type, result, test_date, appointment_id, lab_id) 
VALUES (4, 'Allergy Test', 'Mild Allergy', TO_DATE('11-08-24', 'MM-DD-YY'), 4, 4);
INSERT INTO LAB_TEST (test_id, test_type, result, test_date, appointment_id, lab_id) 
VALUES (5, 'Pediatric Test', 'Healthy', TO_DATE('11-20-24', 'MM-DD-YY'), 5, 5);
INSERT INTO LAB_TEST (test_id, test_type, result, test_date, appointment_id, lab_id) 
VALUES (6, 'Pathology Test', 'Pending', TO_DATE('11-10-24', 'MM-DD-YY'), 6, 6);

-- Insert Sample Data for TIME_SLOT
INSERT INTO TIME_SLOT (slot_id, start_time, end_time, is_available, schedule_id, appointment_id) 
VALUES (1, TO_DATE('11-06-24 09:00 AM', 'MM-DD-YY HH:MI AM'), TO_DATE('11-06-24 10:00 AM', 'MM-DD-YY HH:MI AM'), 'Y', 1, null);
INSERT INTO TIME_SLOT (slot_id, start_time, end_time, is_available, schedule_id, appointment_id) 
VALUES (2, TO_DATE('11-06-24 10:00 AM', 'MM-DD-YY HH:MI AM'), TO_DATE('11-06-24 11:00 AM', 'MM-DD-YY HH:MI AM'), 'N', 1, 2);
INSERT INTO TIME_SLOT (slot_id, start_time, end_time, is_available, schedule_id, appointment_id) 
VALUES (3, TO_DATE('11-08-24 01:00 PM', 'MM-DD-YY HH:MI AM'), TO_DATE('11-08-24 02:00 PM', 'MM-DD-YY HH:MI AM'), 'N', 2, 3);
INSERT INTO TIME_SLOT (slot_id, start_time, end_time, is_available, schedule_id, appointment_id) 
VALUES (4, TO_DATE('11-20-24 03:00 PM', 'MM-DD-YY HH:MI AM'), TO_DATE('11-20-24 04:00 PM', 'MM-DD-YY HH:MI AM'), 'N', 2, 4);
INSERT INTO TIME_SLOT (slot_id, start_time, end_time, is_available, schedule_id, appointment_id) 
VALUES (5, TO_DATE('12-02-24 08:00 AM', 'MM-DD-YY HH:MI AM'), TO_DATE('12-02-24 09:00 AM', 'MM-DD-YY HH:MI AM'), 'Y', 5, null);
INSERT INTO TIME_SLOT (slot_id, start_time, end_time, is_available, schedule_id, appointment_id) 
VALUES (6, TO_DATE('12-05-24 02:00 PM', 'MM-DD-YY HH:MI AM'), TO_DATE('12-05-24 03:00 PM', 'MM-DD-YY HH:MI AM'), 'N', 6, 6);

-- Insert Sample Data for FEEDBACK
INSERT INTO FEEDBACK (feedback_id, satisfaction_rating, comments, appointment_id) 
VALUES (1, 5, 'Excellent service!', 1);
INSERT INTO FEEDBACK (feedback_id, satisfaction_rating, comments, appointment_id) 
VALUES (2, 4, 'Very professional, but the wait was long.', 2);
INSERT INTO FEEDBACK (feedback_id, satisfaction_rating, comments, appointment_id) 
VALUES (3, 5, 'The doctor was very attentive.', 3);
INSERT INTO FEEDBACK (feedback_id, satisfaction_rating, comments, appointment_id) 
VALUES (4, 3, 'Test results took longer than expected.', 4);
INSERT INTO FEEDBACK (feedback_id, satisfaction_rating, comments, appointment_id) 
VALUES (5, 4, 'Satisfied with the overall care.', 5);
INSERT INTO FEEDBACK (feedback_id, satisfaction_rating, comments, appointment_id) 
VALUES (6, 5, 'Excellent care and service.', 6);
