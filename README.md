# database-wk-8
# Clinic Booking System Database (MySQL)

## 📌 Overview
This project is a **relational database management system** designed for a **Clinic Booking System**.  
It demonstrates a complete MySQL schema with tables, constraints, and relationships commonly used in real-world healthcare management applications.

The database supports:
- Patients, Doctors, Specialties, and Insurance
- Appointment scheduling with doctors and rooms
- Treatments, Prescriptions, and Medications
- Invoicing and Billing

## 🗂️ Features
- **Well-structured tables** with proper `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, and `UNIQUE` constraints.  
- **Relationships**:
  - One-to-Many: Patients → Appointments, Doctors → Appointments  
  - Many-to-Many: Doctors ↔ Specialties, Appointments ↔ Treatments, Prescriptions ↔ Medications  
  - One-to-One-ish: Invoices ↔ Appointments  
- **Business logic considerations**: constraints on double-booking doctors, invoice line items, active insurance policies.

## ⚙️ Installation & Usage
1. Open your MySQL client (CLI, Workbench, or phpMyAdmin).
2. Run the provided SQL script:

   ```sql
   SOURCE clinic_db.sql;
