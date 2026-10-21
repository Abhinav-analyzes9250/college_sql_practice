-- COLLEGE DATA VALIDATION CHECKS
-- Database: college_sql_practice. Every result set is a diagnostic.
USE college_sql_practice;

-- 1. Row counts: expected 8 courses and 50 students.
SELECT 'course' AS table_name, COUNT(*) AS row_count FROM course
UNION ALL
SELECT 'student', COUNT(*) FROM student;

-- 2. Count NULLs in intentionally nullable student fields.
SELECT
  SUM(course_id IS NULL) AS missing_course_id,
  SUM(dob IS NULL) AS missing_dob,
  SUM(admission_date IS NULL) AS missing_admission_date,
  SUM(cgpa IS NULL) AS missing_cgpa,
  SUM(attendance_pct IS NULL) AS missing_attendance,
  SUM(email IS NULL) AS missing_email,
  SUM(phone IS NULL) AS missing_phone,
  SUM(city IS NULL) AS missing_city
FROM student;

-- 3. Validate expected score ranges; returns rows only if out-of-range values exist.
SELECT student_id, cgpa FROM student
WHERE cgpa IS NOT NULL AND (cgpa < 0 OR cgpa > 10);
SELECT student_id, attendance_pct FROM student
WHERE attendance_pct IS NOT NULL AND (attendance_pct < 0 OR attendance_pct > 100);

-- 4. Check non-positive semester values (if any).
SELECT student_id, semester FROM student
WHERE semester IS NOT NULL AND semester < 1;

-- 5. Foreign-key/assignment coverage: list students not currently attached to a course.
SELECT student_id, first_name, last_name
FROM student WHERE course_id IS NULL;

-- 6. Enrolment counts, including the empty course.
SELECT c.course_name, COUNT(s.student_id) AS student_count
FROM course AS c LEFT JOIN student AS s ON s.course_id = c.course_id
GROUP BY c.course_id, c.course_name ORDER BY c.course_name;

-- 7. Email domain completeness and frequency (NULL email is expected in sample data).
SELECT CASE WHEN email IS NULL OR email NOT LIKE '%@%' THEN 'Missing/invalid email'
            ELSE SUBSTRING_INDEX(email, '@', -1) END AS email_domain,
       COUNT(*) AS student_count
FROM student GROUP BY email_domain ORDER BY student_count DESC;

-- 8. Duplicate admission-date cohorts (a review signal, not automatically an error).
SELECT admission_date, COUNT(*) AS student_count
FROM student WHERE admission_date IS NOT NULL
GROUP BY admission_date HAVING COUNT(*) > 1 ORDER BY admission_date;

-- 9. Required fields are protected by NOT NULL; this should return zero rows.
SELECT student_id FROM student
WHERE first_name IS NULL OR last_name IS NULL;
