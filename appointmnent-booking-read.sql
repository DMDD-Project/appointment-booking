BEGIN
  -- Granting session privileges to all users
  BEGIN
    EXECUTE IMMEDIATE 'GRANT CREATE SESSION, CONNECT TO RECEPTIONIST, DOCTOR, DEPARTMENT_HEAD, LAB_TECHNICIAN, PATIENT';
    DBMS_OUTPUT.PUT_LINE('Session privileges granted to all users');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error granting session privileges to users');
  END;

  -- Granting read access on "appointment_history_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT SELECT ON appointment_history_view TO RECEPTIONIST, DOCTOR, DEPARTMENT_HEAD, PATIENT';
    DBMS_OUTPUT.PUT_LINE('Read access granted on appointment_history_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Read permission given on appointment_history_view');
  END;

  -- Granting read access on "doctor_schedule_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT SELECT ON doctor_schedule_view TO RECEPTIONIST, DOCTOR, DEPARTMENT_HEAD';
    DBMS_OUTPUT.PUT_LINE('Read access granted on doctor_schedule_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Read permission already given on doctor_schedule_view');
  END;

  -- Granting read access on "patient_feedback_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT SELECT ON patient_feedback_view TO RECEPTIONIST, PATIENT, DEPARTMENT_HEAD';
    DBMS_OUTPUT.PUT_LINE('Read access granted on patient_feedback_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Read permission already given on patient_feedback_view');
  END;

  -- Granting read access on "doctor_appointment_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT SELECT ON doctor_appointment_view TO RECEPTIONIST, DOCTOR, patient';
    DBMS_OUTPUT.PUT_LINE('Read access granted on doctor_appointment_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Read permission already given on doctor_appointment_view');
  END;

  -- Granting read access on "lab_test_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT SELECT ON lab_test_view TO  LAB_TECHNICIAN, PATIENT, DOCTOR';
    DBMS_OUTPUT.PUT_LINE('Read access granted on lab_test_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Read permission already  given on lab_test_view');
  END;

  -- Granting read access on "each_department_doctors_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT SELECT ON each_department_doctors_view TO RECEPTIONIST, DEPARTMENT_HEAD';
    DBMS_OUTPUT.PUT_LINE('Read access granted on each_department_doctors_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Read permission already given on each_department_doctors_view');
  END;

  -- Granting read access on "patient_lab_results_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT SELECT ON patient_lab_results_view TO  LAB_TECHNICIAN, PATIENT, DOCTOR';
    DBMS_OUTPUT.PUT_LINE('Read access granted on patient_lab_results_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Read permission already  given on patient_lab_results_view');
  END;

  -- Granting read access on "available_time_slots_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT SELECT ON available_time_slots_view TO RECEPTIONIST, DOCTOR';
    DBMS_OUTPUT.PUT_LINE('Read access granted on available_time_slots_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE( 'Read permission already given on available_time_slots_view');
  END;

END;
/
