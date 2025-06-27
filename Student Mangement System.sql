#>>>>> STUDENT MANAGEMENT SYSTEM <<<<<#
#1 Create Database
CREATE DATABASE student_management;
USE student_management;

#2.Create Tables
#2.1 Students Table
CREATE TABLE students(
student_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50),
last_name VARCHAR(50),
gender VARCHAR(10),
dob DATE,
email VARCHAR(100)
);
#2.2 Courses Table
CREATE TABLE courses (
course_id INT PRIMARY KEY AUTO_INCREMENT,
course_name VARCHAR(100),
department VARCHAR(50),
credits INT 
);
#2.3 Instructors Table
CREATE TABLE instructors (
instructors_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100),
email VARCHAR(100),
department VARCHAR(50)
);
#2.4 Enrollments Table
CREATE TABLE enrollments (
enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
student_id INT,
course_id INT,
enrollment_date DATE,
grade CHAR(2),
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

#3 Insert Sample Data 
#3.1 Students
INSERT INTO students (first_name, last_name, gender, dob, email) 
VALUES
('Sachin', 'Giree', 'Male', '1999-10-03', 'rahul@gmail.com'),
('Manikant', 'Sugure', 'Male', '2000-10-13', 'manikantsugure@gmail.com'),
('Amar', 'Biradar', 'Male', '1997-04-12', 'amarbiradar@gmail.com');
#3.2 courses
INSERT INTO courses (course_name, department, credits)
VALUES
('Data Structures', 'Computer Science', 3),
('Marketing 101', 'Business', 2),
('Statistics', 'Mathematics', 4);
#3.3 Instructors
INSERT INTO instructors (name, email, department)
VALUES
('Dr. Meena', 'meena@college.edu', 'Mathematics'),
('Mr. Roy', 'roy@college.edu', 'Computer Science'),
('Mr. Chopra', 'chopra@college.edu', 'Economics');
#3.4 Enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
VALUES
(1, 1, '2024-06-10', 'A'),
(2, 2, '2024-06-11', 'B'),
(3, 3, '2024-06-12', 'C'),
(1, 3, '2024-06-13', 'A');

#4 SQL Queries-Project Tasks
#4.1 show all students
SELECT * FROM students;
#4.2 Display all students with their enrolled courses and grades
SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id;
#4.3 Number of students per course
SELECT c.course_name, COUNT(*) AS total_enrolled
FROM enrollments e
JOIN courses c ON c.course_id = e.course_id
GROUP BY c.course_name;
#4.4 Students who got 'A' grade
SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
WHERE e.grade = 'A';
# Average grade score per course (A=4, B=3, C=2)
SELECT c.course_name,
  AVG(
    CASE 
      WHEN e.grade = 'A' THEN 4
      WHEN e.grade = 'B' THEN 3
      WHEN e.grade = 'C' THEN 2
      ELSE 0
    END
  ) AS average_grade_score
FROM enrollments e
JOIN courses c ON c.course_id = e.course_id
GROUP BY c.course_name;
#4.6 List of instructors
SELECT * FROM instructors;

#5.Create View
CREATE VIEW v_student_course_grade AS
SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id;

#6.Stored Procedure: Enroll a Student
DELIMITER //

CREATE PROCEDURE EnrollStudent (
  IN sid INT,
  IN cid INT,
  IN grade CHAR(2)
)
BEGIN
  INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
  VALUES (sid, cid, CURDATE(), grade);
END //

DELIMITER ;
CALL EnrollStudent(2, 3, 'B');

📁 Project: Student Management System

📌 Project Goal

The goal of this project is to build a Student Management System that tracks students, courses, instructors, and enrollments using SQL. It helps administrators analyze academic performance and enrollment trends effectively.

🛠 Database Design

Tables used in this project:

students – Stores basic student information

courses – Details about available courses

instructors – Faculty members and their departments

enrollments – Maps students to the courses they enrolled in

ER Diagram: (Attach ERD screenshot from dbdiagram.io)

🧱 Schema and Sample Data

All table creation and sample data scripts are in student_management_system.sql.
Includes:

CREATE TABLE statements for all 4 tables

INSERT INTO values for students, courses, instructors, and enrollments

📊 Key SQL Queries

Show all students with their enrolled courses and grades:

SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id;

Total number of students enrolled in each course:

SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

Students with multiple enrollments:

SELECT s.first_name, s.last_name, COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
HAVING COUNT(e.course_id) > 1;

Average grade per course:

SELECT c.course_name, AVG(CASE 
  WHEN e.grade = 'A' THEN 4
  WHEN e.grade = 'B' THEN 3
  WHEN e.grade = 'C' THEN 2
  ELSE 0
END) AS avg_grade_points
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.course_name;

📈 Insights

Students prefer courses in Computer Science and Business.

Many students enroll in more than one course.

The highest average grades were seen in the course "Statistics".

Low churn rate due to active student participation across multiple courses.

📎 Files Included

student_management_system.sql – Full SQL script (schema + data + queries)

ERD.png – ER diagram of the database

README.md – This documentation







