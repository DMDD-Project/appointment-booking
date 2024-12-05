--GRANT Permissions for functions, STORED PROCEDURES AND PACKAGES

GRANT EXECUTE ON GetPatientAppointmentHistory TO Receptionist;

GRANT EXECUTE ON GetDoctorSchedule TO Receptionist;
GRANT EXECUTE ON GetDoctorSchedule TO Doctor;

GRANT EXECUTE ON GetDoctorPerformanceMetrics TO Receptionist;
GRANT EXECUTE ON GetDoctorPerformanceMetrics TO Doctor;

GRANT EXECUTE ON CheckDoctorAvailability TO Receptionist;
GRANT EXECUTE ON CheckDoctorAvailability TO Patient;

GRANT EXECUTE ON GetNextAppointment TO Patient;
GRANT EXECUTE ON GetNextAppointment TO Receptionist;

GRANT EXECUTE ON CheckAppointmentOverlap TO Receptionist;
GRANT EXECUTE ON CheckAppointmentOverlap TO Doctor;


GRANT EXECUTE ON GetLabTestDetails TO Doctor;
GRANT EXECUTE ON GetLabTestDetails TO Lab_technician;

GRANT EXECUTE ON GetLabWorkload TO Lab_technician;

GRANT EXECUTE ON GetAppointmentFeedback TO Receptionist;
GRANT EXECUTE ON GetAppointmentFeedback TO Doctor;


GRANT EXECUTE ON INSERT_APPOINTMENT TO RECEPTIONIST;
GRANT EXECUTE ON RegisterPatient TO RECEPTIONIST;
GRANT EXECUTE ON ENTERLABTEST TO Lab_technician;


GRANT EXECUTE ON HEALTHCARE_SIMPLE TO RECEPTIONIST;
