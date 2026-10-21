-- COLLEGE SQL PRACTICE: 60 ANSWERS
-- Database: college_sql_practice | MySQL 8.0+
-- Questions are grouped in Easy, Intermediate, Hard sections.
-- Questions requiring INSERT/UPDATE/DELETE are commented out to protect the seed data.
USE college_sql_practice;

-- ============================================================
-- EASY (20)
-- ============================================================
-- E01. Retrieve all columns and rows from student.
SELECT * FROM student;

-- E02. Retrieve all columns and rows from course.
SELECT * FROM course;

-- E03. first_name, last_name, cgpa for all students.
SELECT first_name, last_name, cgpa FROM student;

-- E04. Female students.
SELECT * FROM student WHERE gender = 'F';

-- E05. Active students.
SELECT * FROM student WHERE status = 'Active';

-- E06. Dropped students.
SELECT * FROM student WHERE status = 'Dropped';

-- E07. Students with CGPA greater than 8.
SELECT * FROM student WHERE cgpa > 8;

-- E08. Attendance between 70 and 90 inclusive.
SELECT * FROM student WHERE attendance_pct BETWEEN 70 AND 90;

-- E09. Distinct cities, including NULL if present.
SELECT DISTINCT city FROM student ORDER BY city;

-- E10. Distinct course IDs currently present in student.
SELECT DISTINCT course_id FROM student ORDER BY course_id;

-- E11. Students sorted by CGPA descending.
SELECT * FROM student ORDER BY cgpa DESC, student_id;

-- E12. Students sorted by first name ascending.
SELECT * FROM student ORDER BY first_name ASC, last_name ASC;

-- E13. First names beginning with A.
SELECT * FROM student WHERE first_name LIKE 'A%';

-- E14. Email contains 'shah'.
SELECT * FROM student WHERE email LIKE '%shah%';

-- E15. Students in semester 2.
SELECT * FROM student WHERE semester = 2;

-- E16. Attendance below 70. NULL attendance values are not classified as below 70.
SELECT * FROM student WHERE attendance_pct < 70;

-- E17. Total number of student records, including students with NULL fields.
SELECT COUNT(*) AS total_students FROM student;

-- E18. Insert a new student (run manually once; uncomment only when needed).
-- INSERT INTO student (student_id, first_name, last_name, gender, dob, admission_date,
--     course_id, semester, cgpa, attendance_pct, email, phone, city, status)
-- VALUES (51, 'Aarohi', 'Sharma', 'F', '2005-05-12', '2025-07-15', 1, 2,
--     8.25, 90.00, 'aarohi.sharma51@student.edu', '919900000051', 'Lucknow', 'Active');

-- E19. Update student 5 CGPA to 7.5 (run manually; uncomment if needed).
-- UPDATE student SET cgpa = 7.50 WHERE student_id = 5;

-- E20. Delete student 11 (run manually; uncomment only if you intentionally want to remove it).
-- DELETE FROM student WHERE student_id = 11;

-- ============================================================
-- INTERMEDIATE (20)
-- ============================================================
-- I01. Student name and course name (INNER JOIN).
SELECT s.student_id, CONCAT(s.first_name, ' ', s.last_name) AS student_name, c.course_name
FROM student AS s
INNER JOIN course AS c ON s.course_id = c.course_id
ORDER BY c.course_name, student_name;

-- I02. Course name and enrolment count, including zero-enrolment courses.
SELECT c.course_name, COUNT(s.student_id) AS student_count
FROM course AS c
LEFT JOIN student AS s ON s.course_id = c.course_id
GROUP BY c.course_id, c.course_name
ORDER BY c.course_name;

-- I03. Average CGPA per course.
SELECT c.course_name, ROUND(AVG(s.cgpa), 2) AS average_cgpa
FROM course AS c
LEFT JOIN student AS s ON s.course_id = c.course_id
GROUP BY c.course_id, c.course_name
ORDER BY c.course_name;

-- I04. Count Active students in each course.
SELECT c.course_name,
       SUM(CASE WHEN s.status = 'Active' THEN 1 ELSE 0 END) AS active_students
FROM course AS c
LEFT JOIN student AS s ON s.course_id = c.course_id
GROUP BY c.course_id, c.course_name
ORDER BY c.course_name;

-- I05. Courses with more than 2 enrolled students.
SELECT c.course_name, COUNT(s.student_id) AS student_count
FROM course AS c
JOIN student AS s ON s.course_id = c.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(s.student_id) > 2
ORDER BY student_count DESC;

-- I06. Courses with average attendance above 80 (AVG ignores NULL values).
SELECT c.course_name, ROUND(AVG(s.attendance_pct), 2) AS average_attendance
FROM course AS c
JOIN student AS s ON s.course_id = c.course_id
GROUP BY c.course_id, c.course_name
HAVING AVG(s.attendance_pct) > 80;

-- I07. Students above the overall average CGPA.
SELECT student_id, first_name, last_name, cgpa
FROM student
WHERE cgpa > (SELECT AVG(cgpa) FROM student)
ORDER BY cgpa DESC;

-- I08. Student(s) with the second-highest distinct CGPA; handles ties.
SELECT student_id, first_name, last_name, cgpa
FROM student
WHERE cgpa = (
    SELECT MAX(cgpa) FROM student
    WHERE cgpa < (SELECT MAX(cgpa) FROM student WHERE cgpa IS NOT NULL)
)
ORDER BY student_id;

-- I09. Students enrolled in BCA or BSc IT.
SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM student AS s
JOIN course AS c ON c.course_id = s.course_id
WHERE c.course_name IN ('BCA', 'BSc IT')
ORDER BY c.course_name, s.student_id;

-- I10. Students whose course name contains B.Tech.
SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM student AS s
JOIN course AS c ON c.course_id = s.course_id
WHERE c.course_name LIKE '%B.Tech%';

-- I11. Age in completed years. NULL DOB returns NULL.
SELECT student_id, first_name, last_name,
       TIMESTAMPDIFF(YEAR, dob, CURDATE()) AS age_years
FROM student
ORDER BY student_id;

-- I12. Students admitted after calendar year 2021.
SELECT * FROM student
WHERE admission_date >= '2022-01-01'
ORDER BY admission_date;

-- I13. Years enrolled, in completed years.
SELECT student_id, first_name, last_name,
       TIMESTAMPDIFF(YEAR, admission_date, CURDATE()) AS years_enrolled
FROM student
ORDER BY student_id;

-- I14. Course, department and count of Graduated students (include courses with zero graduates).
SELECT c.course_name, c.department,
       SUM(CASE WHEN s.status = 'Graduated' THEN 1 ELSE 0 END) AS graduated_students
FROM course AS c
LEFT JOIN student AS s ON s.course_id = c.course_id
GROUP BY c.course_id, c.course_name, c.department
ORDER BY c.course_name;

-- I15. Full name using CONCAT.
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM student ORDER BY full_name;

-- I16. Student name uppercased and city lowercased.
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS student_name,
       LOWER(city) AS city_lowercase
FROM student;

-- I17. CGPA labels; NULL CGPA is explicitly marked Not Available.
SELECT student_id, first_name, last_name, cgpa,
       CASE WHEN cgpa IS NULL THEN 'Not Available'
            WHEN cgpa >= 9 THEN 'Excellent'
            WHEN cgpa >= 7 THEN 'Good'
            ELSE 'Average' END AS academic_label
FROM student;

-- I18. Courses that currently have zero enrolled students.
SELECT c.course_id, c.course_name
FROM course AS c
LEFT JOIN student AS s ON s.course_id = c.course_id
GROUP BY c.course_id, c.course_name
HAVING COUNT(s.student_id) = 0;

-- I19. Each student's attendance minus their course's average attendance.
SELECT s.student_id, s.first_name, s.last_name, s.attendance_pct,
       ROUND(s.attendance_pct - a.average_attendance, 2) AS attendance_vs_course_average
FROM student AS s
LEFT JOIN (
    SELECT course_id, AVG(attendance_pct) AS average_attendance
    FROM student
    WHERE course_id IS NOT NULL
    GROUP BY course_id
) AS a ON a.course_id = s.course_id
ORDER BY s.student_id;

-- I20. Students sorted by course name then CGPA descending.
SELECT s.student_id, s.first_name, s.last_name, c.course_name, s.cgpa
FROM student AS s
LEFT JOIN course AS c ON c.course_id = s.course_id
ORDER BY c.course_name, s.cgpa DESC, s.student_id;

-- ============================================================
-- HARD (20)
-- ============================================================
-- H01. Top 3 students by CGPA, no window function.
SELECT student_id, first_name, last_name, cgpa
FROM student
WHERE cgpa IS NOT NULL
ORDER BY cgpa DESC, student_id
LIMIT 3;

-- H02. Course(s) with the highest average CGPA, using a subquery.
SELECT c.course_name, AVG(s.cgpa) AS average_cgpa
FROM course AS c
JOIN student AS s ON s.course_id = c.course_id
GROUP BY c.course_id, c.course_name
HAVING AVG(s.cgpa) = (
    SELECT MAX(course_average)
    FROM (
        SELECT AVG(s2.cgpa) AS course_average
        FROM student AS s2
        WHERE s2.course_id IS NOT NULL
        GROUP BY s2.course_id
    ) AS course_averages
);

-- H03. Fees associated with each student based on their course's published total fees.
SELECT s.student_id, CONCAT(s.first_name, ' ', s.last_name) AS student_name,
       c.course_name, c.total_fees AS fees_for_course
FROM student AS s
LEFT JOIN course AS c ON c.course_id = s.course_id
ORDER BY s.student_id;

-- H04. Student(s) with the maximum CGPA in their own course (correlated subquery).
SELECT s.student_id, s.first_name, s.last_name, s.course_id, s.cgpa
FROM student AS s
WHERE s.course_id IS NOT NULL AND s.cgpa IS NOT NULL
  AND s.cgpa = (
      SELECT MAX(s2.cgpa) FROM student AS s2
      WHERE s2.course_id = s.course_id AND s2.cgpa IS NOT NULL
  )
ORDER BY s.course_id, s.student_id;

-- H05. Courses with at least one student whose CGPA is above 9 (EXISTS).
SELECT c.course_id, c.course_name
FROM course AS c
WHERE EXISTS (
    SELECT 1 FROM student AS s
    WHERE s.course_id = c.course_id AND s.cgpa > 9
);

-- H06. Rank students by CGPA within each course using DENSE_RANK.
SELECT s.student_id, s.first_name, s.last_name, c.course_name, s.cgpa,
       DENSE_RANK() OVER (PARTITION BY s.course_id ORDER BY s.cgpa DESC) AS cgpa_rank
FROM student AS s
JOIN course AS c ON c.course_id = s.course_id
WHERE s.cgpa IS NOT NULL
ORDER BY c.course_name, cgpa_rank, s.student_id;

-- H07. Third-highest distinct CGPA without LIMIT/OFFSET.
SELECT s.student_id, s.first_name, s.last_name, s.cgpa
FROM student AS s
WHERE s.cgpa IS NOT NULL
  AND 2 = (
      SELECT COUNT(DISTINCT s2.cgpa)
      FROM student AS s2
      WHERE s2.cgpa > s.cgpa
  )
ORDER BY s.student_id;

-- H08. Students whose CGPA is greater than every non-NULL CGPA in BBA.
SELECT s.student_id, s.first_name, s.last_name, s.cgpa
FROM student AS s
WHERE s.cgpa IS NOT NULL
  AND s.cgpa > ALL (
      SELECT s2.cgpa
      FROM student AS s2
      JOIN course AS c2 ON c2.course_id = s2.course_id
      WHERE c2.course_name = 'BBA' AND s2.cgpa IS NOT NULL
  )
ORDER BY s.cgpa DESC;

-- H09. Students whose CGPA is greater than at least one non-NULL CGPA in B.Com.
SELECT s.student_id, s.first_name, s.last_name, s.cgpa
FROM student AS s
WHERE s.cgpa IS NOT NULL
  AND s.cgpa > ANY (
      SELECT s2.cgpa
      FROM student AS s2
      JOIN course AS c2 ON c2.course_id = s2.course_id
      WHERE c2.course_name = 'B.Com' AND s2.cgpa IS NOT NULL
  )
ORDER BY s.cgpa DESC;

-- H10. Create/replace view for Active students with course and CGPA.
CREATE OR REPLACE VIEW v_active_student_course_cgpa AS
SELECT s.student_id, CONCAT(s.first_name, ' ', s.last_name) AS student_name,
       c.course_name, s.cgpa
FROM student AS s
LEFT JOIN course AS c ON c.course_id = s.course_id
WHERE s.status = 'Active';
-- Inspect view separately when desired:
-- SELECT * FROM v_active_student_course_cgpa;

-- H11. Count email domains shared by multiple students. NULL emails are skipped.
SELECT SUBSTRING_INDEX(email, '@', -1) AS email_domain, COUNT(*) AS student_count
FROM student
WHERE email IS NOT NULL AND email LIKE '%@%'
GROUP BY SUBSTRING_INDEX(email, '@', -1)
HAVING COUNT(*) > 1
ORDER BY student_count DESC, email_domain;

-- H12. Combine student names from BCA and BSc IT using UNION.
SELECT CONCAT(s.first_name, ' ', s.last_name) AS student_name
FROM student AS s JOIN course AS c ON c.course_id = s.course_id
WHERE c.course_name = 'BCA'
UNION
SELECT CONCAT(s.first_name, ' ', s.last_name) AS student_name
FROM student AS s JOIN course AS c ON c.course_id = s.course_id
WHERE c.course_name = 'BSc IT'
ORDER BY student_name;

-- H13. Courses where every enrolled student has attendance >80; NULL attendance fails the condition.
SELECT c.course_id, c.course_name
FROM course AS c
WHERE EXISTS (SELECT 1 FROM student AS s WHERE s.course_id = c.course_id)
  AND NOT EXISTS (
      SELECT 1 FROM student AS s
      WHERE s.course_id = c.course_id
        AND (s.attendance_pct IS NULL OR s.attendance_pct <= 80)
  );

-- H14. Course average CGPA compared with overall student average (CTEs).
WITH overall_average AS (
    SELECT AVG(cgpa) AS overall_avg_cgpa FROM student
), course_averages AS (
    SELECT c.course_id, c.course_name, AVG(s.cgpa) AS course_avg_cgpa
    FROM course AS c
    LEFT JOIN student AS s ON s.course_id = c.course_id
    GROUP BY c.course_id, c.course_name
)
SELECT ca.course_name, ROUND(ca.course_avg_cgpa, 2) AS course_avg_cgpa,
       ROUND(oa.overall_avg_cgpa, 2) AS overall_avg_cgpa,
       ROUND(ca.course_avg_cgpa - oa.overall_avg_cgpa, 2) AS difference_from_overall
FROM course_averages AS ca CROSS JOIN overall_average AS oa
ORDER BY ca.course_name;

-- H15. Students in the final semester (semester = duration_years * 2).
SELECT s.student_id, s.first_name, s.last_name, c.course_name, s.semester
FROM student AS s
JOIN course AS c ON c.course_id = s.course_id
WHERE s.semester = c.duration_years * 2
ORDER BY c.course_name, s.student_id;

-- H16. Active-student percentage out of each course's enrolled students.
SELECT c.course_name,
       COUNT(s.student_id) AS total_students,
       SUM(CASE WHEN s.status = 'Active' THEN 1 ELSE 0 END) AS active_students,
       COALESCE(ROUND(100.0 * SUM(CASE WHEN s.status = 'Active' THEN 1 ELSE 0 END)
           / NULLIF(COUNT(s.student_id), 0), 2), 0.00) AS active_percentage
FROM course AS c
LEFT JOIN student AS s ON s.course_id = c.course_id
GROUP BY c.course_id, c.course_name
ORDER BY c.course_name;

-- H17. Students whose attendance is below their own course average.
SELECT s.student_id, s.first_name, s.last_name, s.attendance_pct
FROM student AS s
WHERE s.course_id IS NOT NULL AND s.attendance_pct IS NOT NULL
  AND s.attendance_pct < (
      SELECT AVG(s2.attendance_pct) FROM student AS s2
      WHERE s2.course_id = s.course_id
  )
ORDER BY s.course_id, s.student_id;

-- H18. Number of students admitted each year, chronological order.
SELECT YEAR(admission_date) AS admission_year, COUNT(*) AS student_count
FROM student
WHERE admission_date IS NOT NULL
GROUP BY YEAR(admission_date)
ORDER BY admission_year;

-- H19. Courses whose estimated fee amount (course fee x enrolled count) exceeds 500,000.
-- This is an illustrative estimate of listed course fees, not verified collections.
SELECT c.course_name, c.total_fees, COUNT(s.student_id) AS enrolled_students,
       c.total_fees * COUNT(s.student_id) AS estimated_fee_amount
FROM course AS c
JOIN student AS s ON s.course_id = c.course_id
WHERE c.total_fees IS NOT NULL
GROUP BY c.course_id, c.course_name, c.total_fees
HAVING c.total_fees * COUNT(s.student_id) > 500000
ORDER BY estimated_fee_amount DESC;

-- H20. Pairs of students who share the same non-NULL admission date.
SELECT s1.student_id AS student_id_1,
       CONCAT(s1.first_name, ' ', s1.last_name) AS student_1,
       s2.student_id AS student_id_2,
       CONCAT(s2.first_name, ' ', s2.last_name) AS student_2,
       s1.admission_date
FROM student AS s1
JOIN student AS s2
  ON s1.admission_date = s2.admission_date
 AND s1.student_id < s2.student_id
WHERE s1.admission_date IS NOT NULL
ORDER BY s1.admission_date, s1.student_id, s2.student_id;
