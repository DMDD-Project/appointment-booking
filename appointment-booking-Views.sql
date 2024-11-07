--Appointment History View

CREATE OR REPLACE VIEW appointment_history_view AS
SELECT 
    a.appointment_id,
    a.appointment_date,
    a.appoint_status,
    p.patient_id,
    p.patient_name,
    p.contact_number
FROM 
    Appointment a
JOIN 
    Patient p ON a.patient_id = p.patient_id;


--Doctor Schedule View

CREATE OR REPLACE VIEW doctor_schedule_view AS
SELECT 
    ds.schedule_id,
    ds.schedule_date,
    ds.slots_available_tobook,
    d.doctor_id,
    d.doctor_name,
    d.doctor_specialisation,
    dep.department_name
FROM 
    Doctor_Schedule ds
JOIN 
    Doctor d ON ds.doctor_id = d.doctor_id
JOIN 
    Department dep ON d.department_id = dep.department_id;

--Patient Feedback View

CREATE OR REPLACE VIEW patient_feedback_view AS
SELECT 
    f.feedback_id,
    f.satisfaction_rating,
    f.comments,
    a.appointment_id,
    a.appointment_date,
    p.patient_id,
    p.patient_name
FROM 
    Feedback f
JOIN 
    Appointment a ON f.appointment_id = a.appointment_id
JOIN 
    Patient p ON a.patient_id = p.patient_id;



-- Doctor Apoointment View   

CREATE OR REPLACE VIEW doctor_appointment_view AS
SELECT 
    a.appointment_id,
    a.appointment_date,
    a.appointment_time,
    a.appoint_status,
    p.patient_id,
    p.patient_name,
    d.doctor_id,
    d.doctor_name
FROM 
    Appointment a
JOIN 
    Doctor_Schedule ds ON a.appointment_id = ds.schedule_id
JOIN 
    Doctor d ON ds.doctor_id = d.doctor_id
JOIN 
    Patient p ON a.patient_id = p.patient_id;



-- Lab Test View

CREATE OR REPLACE VIEW lab_test_view AS
SELECT 
    lt.test_id,
    lt.test_type,
    lt.result,
    lt.test_date,
    a.appointment_id,
    a.appointment_date,
    p.patient_id,
    p.patient_name,
    l.lab_id,
    l.name AS lab_name,
    l.specialty
FROM 
    Lab_Test lt
JOIN 
    Appointment a ON lt.appointment_id = a.appointment_id
JOIN 
    Patient p ON a.patient_id = p.patient_id
JOIN 
    Lab l ON lt.lab_id = l.lab_id;


--each_department_doctors_view View--

CREATE OR REPLACE VIEW each_department_doctors_view AS
SELECT 
    dep.department_id,
    dep.department_name,
    d.doctor_id,
    d.doctor_name,
    d.doctor_specialisation
FROM 
    Department dep
JOIN 
    Doctor d ON dep.department_id = d.department_id;


--patient_lab_results_view View--

CREATE OR REPLACE VIEW patient_lab_results_view AS
SELECT 
    lt.test_id,
    lt.test_type,
    lt.result,
    lt.test_date,
    p.patient_id,
    p.patient_name,
    a.appointment_id,
    a.appointment_date
FROM 
    Lab_Test lt
JOIN 
    Appointment a ON lt.appointment_id = a.appointment_id
JOIN 
    Patient p ON a.patient_id = p.patient_id;


--available_slots_view View--

CREATE OR REPLACE VIEW available_time_slots_view AS
SELECT 
    ts.slot_id,
    ts.start_time,
    ts.end_time,
    ts.is_available,
    ds.schedule_date,
    d.doctor_id,
    d.doctor_name
FROM 
    Time_Slot ts
JOIN 
    Doctor_Schedule ds ON ts.schedule_id = ds.schedule_id
JOIN 
    Doctor d ON ds.doctor_id = d.doctor_id
WHERE 
    ts.is_available = 'Y';
    
CREATE OR REPLACE VIEW appointment_history_view AS
SELECT 
    a.appointment_id,
    a.appointment_date,
    a.appoint_status,
    p.patient_id,
    p.patient_name,
    p.contact_number
FROM 
    Appointment a
JOIN 
    Patient p ON a.patient_id = p.patient_id;