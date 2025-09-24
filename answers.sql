-- Table: patients
CREATE TABLE patients (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  dob DATE NOT NULL,
  gender ENUM('male','female','other') NOT NULL,
  phone VARCHAR(20),
  email VARCHAR(100),
  address VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Table: doctors
CREATE TABLE doctors (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  specialty VARCHAR(100),
  phone VARCHAR(20),
  email VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Table: rooms
CREATE TABLE rooms (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  room_number VARCHAR(10) NOT NULL,
  type VARCHAR(50),
  status ENUM('available','occupied','maintenance') DEFAULT 'available'
) ENGINE=InnoDB;

-- Table: insurance_providers
CREATE TABLE insurance_providers (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  phone VARCHAR(20),
  address VARCHAR(255)
) ENGINE=InnoDB;

-- Table: patient_insurance
CREATE TABLE patient_insurance (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  patient_id INT UNSIGNED NOT NULL,
  provider_id INT UNSIGNED NOT NULL,
  policy_number VARCHAR(50),
  valid_from DATE,
  valid_to DATE,
  FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (provider_id) REFERENCES insurance_providers(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table: appointments
CREATE TABLE appointments (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  patient_id INT UNSIGNED NOT NULL,
  doctor_id INT UNSIGNED NOT NULL,
  room_id INT UNSIGNED,
  scheduled_at DATETIME NOT NULL,
  status ENUM('scheduled','completed','cancelled','no_show') DEFAULT 'scheduled',
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table: treatments
CREATE TABLE treatments (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
) ENGINE=InnoDB;

-- Table: appointment_treatments
CREATE TABLE appointment_treatments (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  appointment_id BIGINT UNSIGNED NOT NULL,
  treatment_id INT UNSIGNED NOT NULL,
  notes TEXT,
  FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Table: medications
CREATE TABLE medications (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT
) ENGINE=InnoDB;

-- Table: prescriptions
CREATE TABLE prescriptions (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  appointment_id BIGINT UNSIGNED NOT NULL,
  medication_id INT UNSIGNED NOT NULL,
  dosage VARCHAR(50),
  frequency VARCHAR(50),
  duration VARCHAR(50),
  notes TEXT,
  FOREIGN KEY (appointment_id) REFERENCES appointments(id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (medication_id) REFERENCES medications(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Indexes for performance
CREATE INDEX idx_patient_id ON appointments(patient_id);
CREATE INDEX idx_doctor_id ON appointments(doctor_id);
CREATE INDEX idx_room_id ON appointments(room_id);
CREATE INDEX idx_appointment_id ON appointment_treatments(appointment_id);
CREATE INDEX idx_treatment_id ON appointment_treatments(treatment_id);
CREATE INDEX idx_appointment_id_prescriptions ON prescriptions(appointment_id);
CREATE INDEX idx_medication_id ON prescriptions(medication_id);
