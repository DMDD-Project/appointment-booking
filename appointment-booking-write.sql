BEGIN
  -- Granting write access on "appointment_history_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON appointment_history_view TO RECEPTIONIST, DEPARTMENT_HEAD';
    DBMS_OUTPUT.PUT_LINE('Write access granted on appointment_history_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error granting write access on appointment_history_view');
  END;

  -- Granting write access on "doctor_schedule_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON doctor_schedule_view TO DOCTOR, DEPARTMENT_HEAD';
    EXECUTE IMMEDIATE 'GRANT UPDATE ON doctor_schedule_view TO RECEPTIONIST';
    DBMS_OUTPUT.PUT_LINE('Write access granted on doctor_schedule_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error granting write access on doctor_schedule_view');
  END;

  -- Granting write access on "patient_feedback_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT INSERT ON patient_feedback_view TO PATIENT';
    DBMS_OUTPUT.PUT_LINE('Write access granted on patient_feedback_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error granting write access on patient_feedback_view');
  END;

  -- Granting write access on "doctor_appointment_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON doctor_appointment_view TO RECEPTIONIST, DOCTOR, DEPARTMENT_HEAD';
    DBMS_OUTPUT.PUT_LINE('Write access granted on doctor_appointment_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error granting write access on doctor_appointment_view');
  END;

  -- Granting write access on "lab_test_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON lab_test_view TO LAB_TECHNICIAN';
    DBMS_OUTPUT.PUT_LINE('Write access granted on lab_test_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error granting write access on lab_test_view');
  END;

  -- Granting write access on "each_department_doctors_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON each_department_doctors_view TO DEPARTMENT_HEAD';
    DBMS_OUTPUT.PUT_LINE('Write access granted on each_department_doctors_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error granting write access on each_department_doctors_view');
  END;

  -- Granting write access on "patient_lab_results_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON patient_lab_results_view TO LAB_TECHNICIAN';
    DBMS_OUTPUT.PUT_LINE('Write access granted on patient_lab_results_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error granting write access on patient_lab_results_view');
  END;

  -- Granting write access on "available_time_slots_view"
  BEGIN
    EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON available_time_slots_view TO RECEPTIONIST, DOCTOR';
    DBMS_OUTPUT.PUT_LINE('Write access granted on available_time_slots_view');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error granting write access on available_time_slots_view');
  END;

END;
