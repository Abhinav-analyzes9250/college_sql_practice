-- COLLEGE SQL PRACTICE PROJECT: schema + synthetic seed data
-- MySQL 8.0+ recommended. This script only works in college_sql_practice.
-- Re-running drops/recreates the two project tables in that database.

CREATE DATABASE IF NOT EXISTS college_sql_practice;
USE college_sql_practice;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    duration_years INT NULL,
    department VARCHAR(70) NULL,
    coordinator_name VARCHAR(70) NULL,
    total_fees DECIMAL(10,2) NULL,
    start_date DATE NULL
) ENGINE=InnoDB;

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender CHAR(1) NULL,
    dob DATE NULL,
    admission_date DATE NULL,
    course_id INT NULL,
    semester INT NULL,
    cgpa DECIMAL(3,2) NULL,
    attendance_pct DECIMAL(5,2) NULL,
    email VARCHAR(100) NULL UNIQUE,
    phone VARCHAR(15) NULL,
    city VARCHAR(50) NULL,
    status VARCHAR(12) NULL DEFAULT 'Active',
    CONSTRAINT fk_student_course FOREIGN KEY (course_id)
        REFERENCES course(course_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    INDEX idx_student_course_id (course_id),
    INDEX idx_student_admission_date (admission_date)
) ENGINE=InnoDB;

-- Intentionally includes one course with zero enrollments and nullable course metadata.
INSERT INTO course (course_id, course_name, duration_years, department, coordinator_name, total_fees, start_date) VALUES
    (1, 'BCA', 3, 'Computer Applications', 'Dr. Ashok Sharma', 150000.0, '2015-07-01'),
    (2, 'B.Tech CSE', 4, 'Computer Science & Engineering', 'Dr. Meenakshi Rao', 400000.0, '2010-08-01'),
    (3, 'BBA', 3, 'Business Administration', 'Dr. Vinod Kumar', 180000.0, '2012-07-15'),
    (4, 'B.Com', 3, 'Commerce', 'Dr. Shalini Gupta', 100000.0, '2008-07-01'),
    (5, 'BSc IT', 3, 'Information Technology', 'Dr. Rakesh Yadav', 160000.0, '2013-07-10'),
    (6, 'MCA', 2, 'Advanced Computing', 'Dr. Kavita Singh', 220000.0, '2017-08-01'),
    (7, 'BA English', 3, 'Humanities', NULL, 90000.0, '2018-07-01'),
    (8, 'BA Economics', 3, NULL, 'Dr. Neelam Joshi', NULL, NULL);


-- Exactly 50 synthetic student rows. NULLs are intentional for data-quality practice.
INSERT INTO student (student_id, first_name, last_name, gender, dob, admission_date, course_id, semester, cgpa, attendance_pct, email, phone, city, status) VALUES
    (1, 'Abhinav', 'Verma', 'M', '2003-05-14', '2021-07-15', 1, 4, 8.2, 88.5, 'abhinav.verma01@student.edu', '9123456780', 'Lucknow', 'Active'),
    (2, 'Ishita', 'Singh', 'F', '2003-09-02', '2021-07-15', 1, 4, 9.1, 95.0, 'ishita.singh@student.edu', '9123456781', 'Kanpur', 'Active'),
    (3, 'Rahul', 'Yadav', 'M', '2002-11-20', '2020-07-10', 1, 6, 7.5, 78.0, 'rahul.yadav@student.edu', '9123456782', 'Sitapur', 'Active'),
    (4, 'Simran', 'Kaur', 'F', '2004-01-08', '2022-08-01', 2, 2, 8.8, 91.0, 'simran.kaur@student.edu', '9123456783', 'Delhi', 'Active'),
    (5, 'Aditya', 'Pandey', 'M', '2003-03-17', '2021-08-01', 2, 4, 6.9, 65.0, 'aditya.pandey@student.edu', '9123456784', 'Kanpur', 'Active'),
    (6, 'Priyanka', 'Reddy', 'F', '2002-07-25', '2019-08-01', 2, 8, 9.4, 97.0, 'priyanka.reddy@student.edu', '9123456785', 'Hyderabad', 'Active'),
    (7, 'Mohit', 'Chawla', 'M', '2003-12-30', '2021-07-20', 3, 4, 7.1, 72.0, 'mohit.chawla@student.edu', '9123456786', 'Chandigarh', 'Active'),
    (8, 'Tanvi', 'Shah', 'F', '2004-02-14', '2022-07-18', 3, 2, 8.0, 85.0, 'tanvi.shah@student.edu', '9123456787', 'Ahmedabad', 'Active'),
    (9, 'Harshvardhan', 'Rathore', 'M', '2001-06-09', '2019-07-15', 3, 6, 6.5, 60.0, 'harshvardhan.rathore@student.edu', '9123456788', 'Jaipur', 'Graduated'),
    (10, 'Neha', 'Bansal', 'F', '2004-04-22', '2022-07-05', 4, 2, 7.8, 82.0, 'neha.bansal@student.edu', '9123456789', 'Kanpur', 'Active');

INSERT INTO student (student_id, first_name, last_name, gender, dob, admission_date, course_id, semester, cgpa, attendance_pct, email, phone, city, status) VALUES
    (11, 'Kunal', 'Mishra', 'M', '2003-10-11', '2021-07-05', 4, 4, 6.2, 58.0, 'kunal.mishra@student.edu', '9123456790', 'Lucknow', 'Dropped'),
    (12, 'Divya', 'Saxena', 'F', '2002-08-19', '2020-07-05', 4, 6, 8.6, 89.0, 'divya.saxena@student.edu', '9123456791', 'Varanasi', 'Active'),
    (13, 'Rohit', 'Bhatt', 'M', '2003-02-27', '2021-07-10', 5, 4, 7.4, 75.0, 'rohit.bhatt@student.edu', '9123456792', 'Pune', 'Active'),
    (14, 'Ananya', 'Menon', 'F', '2004-06-05', '2022-07-10', 5, 2, 9.0, 93.0, 'ananya.menon@student.edu', '9123456793', 'Kochi', 'Active'),
    (15, 'Vikas', 'Chandra', 'M', '2002-12-13', '2020-07-10', 5, 6, 8.1, 80.0, 'vikas.chandra@student.edu', '9123456794', 'Patna', 'Active'),
    (16, 'Sakshi', 'Gupta', 'F', '2002-09-10', '2025-07-13', 1, 2, 9.2, 96, 'sakshi.gupta16@student.edu', '9100000016', 'Prayagraj', 'Active'),
    (17, 'Aarav', 'Joshi', 'M', '2000-02-19', '2024-07-16', 1, 4, 7.6, 79, 'aarav.joshi17@gmail.com', '9100000017', 'Lucknow', 'Active'),
    (18, 'Meera', 'Khan', 'F', '1998-07-01', '2023-07-19', 1, 6, NULL, 84, 'meera.khan18@outlook.com', '9100000018', 'Delhi', 'Dropped'),
    (19, 'Kartik', 'Malhotra', 'M', '2005-12-10', '2025-07-22', 1, 2, 8.1, 87, 'kartik.malhotra19@college.example', '9100000019', 'Jaipur', 'Active'),
    (20, 'Pooja', 'Das', 'F', '2003-05-19', '2024-07-05', 1, 4, 7.3, 73, 'pooja.das20@mail.example', '9100000020', 'Kanpur', 'Graduated');

INSERT INTO student (student_id, first_name, last_name, gender, dob, admission_date, course_id, semester, cgpa, attendance_pct, email, phone, city, status) VALUES
    (21, 'Riya', 'Kapoor', 'F', '2001-10-01', '2024-08-08', 2, 4, 8.5, 92, 'riya.kapoor21@student.edu', '9100000021', 'Lucknow', 'Active'),
    (22, 'Arjun', 'Patel', 'M', '1999-03-10', '2025-08-11', 2, 2, 7.2, NULL, 'arjun.patel22@gmail.com', '9100000022', 'Bhopal', 'Active'),
    (23, 'Nisha', 'Sharma', 'F', '2006-08-19', '2023-08-14', 2, 6, 9.6, 81, 'nisha.sharma23@outlook.com', '9100000023', 'Agra', 'Graduated'),
    (24, 'Manav', 'Sinha', 'M', NULL, '2022-08-17', 2, 8, 6.7, 69, 'manav.sinha24@college.example', '9100000024', 'Gorakhpur', 'Active'),
    (25, 'Kavya', 'Agarwal', 'F', '2002-06-10', '2024-08-20', 2, 4, 8.3, 86, 'kavya.agarwal25@mail.example', '9100000025', 'Kanpur', 'Active'),
    (26, 'Sourabh', 'Tripathi', 'M', '2000-11-19', '2023-07-23', 3, 6, 7.8, 74, NULL, '9100000026', 'Sitapur', 'Active'),
    (27, 'Aniket', 'Jain', 'M', '1998-04-01', '2024-07-06', 3, 4, 6.4, 88, 'aniket.jain27@gmail.com', '9100000027', 'Lucknow', 'Dropped'),
    (28, 'Diya', 'Nair', 'F', '2005-09-10', '2025-07-09', 3, 2, 7.6, 77, 'diya.nair28@outlook.com', '9100000028', 'Kochi', 'Active'),
    (29, 'Shivam', 'Tiwari', 'M', '2003-02-19', '2023-07-12', 3, 6, 8.9, 91, 'shivam.tiwari29@college.example', NULL, 'Delhi', 'Active'),
    (30, 'Tanya', 'Mehta', 'F', '2001-07-01', '2024-07-15', 4, 4, 6.1, 63, 'tanya.mehta30@mail.example', '9100000030', 'Patna', 'Graduated');

INSERT INTO student (student_id, first_name, last_name, gender, dob, admission_date, course_id, semester, cgpa, attendance_pct, email, phone, city, status) VALUES
    (31, 'Yash', 'Chauhan', 'M', '1999-12-10', '2025-07-18', 4, 2, 7.4, NULL, 'yash.chauhan31@student.edu', '9100000031', 'Varanasi', 'Active'),
    (32, 'Rekha', 'Bose', 'F', '2006-05-19', '2023-07-21', 4, 6, 8.2, 83, 'rekha.bose32@gmail.com', '9100000032', 'Lucknow', 'Dropped'),
    (33, 'Pranav', 'Pillai', 'M', '2004-10-01', '2024-07-24', 4, 4, NULL, 59, 'pranav.pillai33@outlook.com', '9100000033', 'Agra', 'Active'),
    (34, 'Anjali', 'Rao', 'F', '2002-03-10', '2025-07-07', 5, 2, 7.7, 89, 'anjali.rao34@college.example', '9100000034', 'Jaipur', 'Active'),
    (35, 'Vihaan', 'Iyer', 'M', '2000-08-19', '2024-07-10', 5, 4, 8.6, 75, 'vihaan.iyer35@mail.example', '9100000035', 'Pune', 'Active'),
    (36, 'Shreya', 'Ghosh', 'F', '1998-01-01', '2023-07-13', 5, 6, 7.9, 93, 'shreya.ghosh36@student.edu', '9100000036', 'Kanpur', 'Active'),
    (37, 'Dev', 'Kulkarni', 'M', '2005-06-10', '2024-07-16', 5, 4, 9.8, 80, 'dev.kulkarni37@gmail.com', '9100000037', 'Bengaluru', 'Graduated'),
    (38, 'Mehul', 'Desai', 'M', '2003-11-19', '2025-07-19', 5, 2, 8.1, 67, NULL, '9100000038', 'Patna', 'Active'),
    (39, 'Palak', 'Thomas', 'F', '2001-04-01', '2023-07-22', 5, 6, 6.9, 86, 'palak.thomas39@college.example', '9100000039', 'Kochi', 'Active'),
    (40, 'Arnav', 'Arora', 'M', '1999-09-10', '2024-08-05', 6, 4, 8.7, 72, 'arnav.arora40@mail.example', '9100000040', 'Delhi', 'Active');

INSERT INTO student (student_id, first_name, last_name, gender, dob, admission_date, course_id, semester, cgpa, attendance_pct, email, phone, city, status) VALUES
    (41, 'Sneha', 'Mishra', 'F', '2006-02-19', '2025-08-08', 6, 2, 7.5, 95, 'sneha.mishra41@student.edu', '9100000041', 'Lucknow', 'Active'),
    (42, 'Abhishek', 'Kumar', 'M', '2004-07-01', '2024-08-11', 6, 4, NULL, 84, 'abhishek.kumar42@gmail.com', '9100000042', 'Kanpur', 'Dropped'),
    (43, 'Myra', 'Sethi', 'F', '2002-12-10', '2025-08-14', 6, 2, 8.3, NULL, 'myra.sethi43@outlook.com', '9100000043', 'Mumbai', 'Active'),
    (44, 'Raj', 'Rana', 'M', '2000-05-19', '2025-07-17', 7, 2, 8.8, 91.0, 'raj.rana44@college.example', '9100000044', 'Hyderabad', 'Active'),
    (45, 'Khushi', 'Kapoor', 'F', '1998-10-01', '2024-07-20', 7, 4, 7.1, 94.0, 'khushi.kapoor45@mail.example', '9100000045', 'Pune', 'Graduated'),
    (46, 'Varun', 'Verma', 'M', '2005-03-10', '2023-07-23', 7, 6, 9.3, 88.0, 'varun.verma46@student.edu', '9100000046', 'Varanasi', 'Active'),
    (47, 'Anushka', 'Dutta', 'F', '2003-08-19', '2025-07-06', 7, 2, 7.2, 96.0, 'anushka.dutta47@gmail.com', '9100000047', 'Delhi', 'Active'),
    (48, 'Irfan', 'Ali', 'M', '2001-01-01', '2024-07-09', 7, 4, 8.4, 92.0, 'irfan.ali48@outlook.com', '9100000048', 'Lucknow', 'Dropped'),
    (49, 'Sameer', 'Saxena', 'M', '1999-06-10', '2024-07-12', NULL, 2, 6.6, 81, 'sameer.saxena49@college.example', '9100000049', NULL, 'Active'),
    (50, 'Trisha', 'Pandey', 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Active');

SELECT COUNT(*) AS course_rows FROM course;
SELECT COUNT(*) AS student_rows FROM student;
