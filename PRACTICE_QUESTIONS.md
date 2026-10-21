# SQL Practice Questions — Student & Course

Based on `student_course.sql`. 20 Easy + 20 Intermediate + 20 Hard = 60 questions.
Covers: SELECT basics, WHERE/BETWEEN/IN/LIKE, DISTINCT, ORDER BY, DML (INSERT/UPDATE/DELETE),
JOIN, GROUP BY, HAVING, aggregates, subqueries (simple, correlated, nested),
EXISTS, ALL/ANY, string & date functions, CASE, VIEW, UNION, and window functions (RANK/DENSE_RANK).

---

## EASY (20)

1. Retrieve all columns and rows from the `student` table.
2. Retrieve all columns and rows from the `course` table.
3. Display `first_name`, `last_name`, and `cgpa` of all students.
4. List all female students (`gender = 'F'`).
5. List all students whose `status` is `'Active'`.
6. List all students whose `status` is `'Dropped'`.
7. Display students with a `cgpa` greater than 8.
8. Display students with `attendance_pct` between 70 and 90 (use `BETWEEN`).
9. List all distinct cities students belong to.
10. List all distinct `course_id` values present in the `student` table.
11. Display all students sorted by `cgpa` in descending order.
12. Display all students sorted by `first_name` in ascending order.
13. Find all students whose first name starts with the letter 'A'.
14. Find all students whose email contains `'shah'`.
15. Display all students who are in semester 2.
16. Display students with `attendance_pct` below 70 (at-risk students).
17. Count the total number of students.
18. Insert a new student of your choice into the `student` table.
19. Update the `cgpa` of the student with `student_id = 5` to 7.5.
20. Delete the student record with `student_id = 11`.

---

## INTERMEDIATE (20)

1. Display each student's name along with the course name they're enrolled in (`INNER JOIN`).
2. Display course name and the number of students enrolled in each course (`GROUP BY`).
3. Display course name and average `cgpa` of students in each course.
4. Display course name and count of `'Active'` students in each course.
5. List courses having more than 2 enrolled students (`HAVING`).
6. List courses where the average attendance is above 80 (`HAVING`).
7. Display students who scored above the average `cgpa` of the entire student table (subquery).
8. Display the student with the second highest `cgpa` (subquery).
9. Display all students enrolled in either `'BCA'` or `'BSc IT'` (`IN`, via `JOIN`).
10. Display students whose course name contains `'B.Tech'` (`LIKE`, via `JOIN`).
11. Display the age of each student in years, calculated from `dob`.
12. Display students who took admission after the year 2021.
13. Display the number of years each student has been enrolled, calculated from `admission_date`.
14. Display course name, department, and count of `'Graduated'` students in each course.
15. Display the full name (`first_name` + `last_name`) of each student using string concatenation.
16. Display each student's name in uppercase and city in lowercase.
17. Use `CASE WHEN` to label students as `'Excellent'`, `'Good'`, or `'Average'` based on `cgpa` ranges.
18. Display courses that currently have zero enrolled students (if any), using `LEFT JOIN`.
19. Display each student along with the difference between their attendance and their course's average attendance.
20. Display all students sorted by course name, then by `cgpa` descending (multi-column `ORDER BY`).

---

## HARD (20)

1. Display the top 3 students by `cgpa` (subquery/`LIMIT`, no window function).
2. Find the course with the highest average `cgpa` using a subquery.
3. Display each student along with the total fees owed, based on their enrolled course's `total_fees`.
4. Find the student(s) with the maximum `cgpa` within their own course (correlated subquery).
5. Use `EXISTS` to list courses that have at least one student with `cgpa` above 9.
6. Use `RANK()` or `DENSE_RANK()` to rank students by `cgpa` within each course (window function).
7. Find the third highest `cgpa` in the entire student table without using `LIMIT`/`OFFSET`.
8. Find all students whose `cgpa` is greater than every student in the `'BBA'` course (`ALL`).
9. Find all students whose `cgpa` is greater than at least one student in the `'B.Com'` course (`ANY`).
10. Create a `VIEW` that shows student name, course name, and `cgpa` for only `'Active'` students.
11. Find how many students share the same email domain (duplicate/grouping check).
12. Combine student names from the `'BCA'` and `'BSc IT'` courses into one result using `UNION`.
13. Find course(s) where every enrolled student has `attendance_pct` above 80 (correlated subquery / `NOT EXISTS`).
14. Using a CTE (or subquery), calculate each course's average `cgpa` compared to the overall student average.
15. Find students who are in their final semester (`semester = duration_years * 2`, via `JOIN`).
16. Display each course along with the percentage of its students who are `'Active'` versus total enrolled.
17. Find students whose `attendance_pct` is below their own course's average attendance (correlated subquery).
18. Display the number of students admitted each year, grouped and ordered chronologically.
19. Find courses whose total fee collection (`total_fees` × number of enrolled students) exceeds a given threshold.
20. Identify students who share the same `admission_date` as another student (self `JOIN` / duplicate detection).
