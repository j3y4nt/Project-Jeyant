-- Project Title: Academic Management System (using SQL)

-- 1. Database Creation:

-- Creating Database
CREATE database AcademicManagementSystem;

-- Calling the Database for Use
USE AcademicManagementSystem;

-- Creating Tables
CREATE TABLE StudentInfo 
(STU_ID int PRIMARY KEY, STU_NAME varchar(50), DOB date, PHONE_NO varchar(10), EMAIL_ID varchar(50), ADDRESS varchar(255));

CREATE TABLE CoursesInfo
(COURSE_ID varchar(10) PRIMARY KEY, COURSE_NAME varchar(50), COURSE_INSTRUCTOR_NAME varchar(50));

CREATE TABLE EnrollmentInfo
(ENROLLMENT_ID int PRIMARY KEY, STU_ID int, COURSE_ID varchar(10), ENROLL_STATUS Enum('Enrolled','Not Enrolled') NOT NULL,
FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID), FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID));

-- 2. Data Creation:
-- Inserting data into tables

INSERT INTO StudentInfo (STU_ID,STU_NAME,DOB,PHONE_NO,EMAIL_ID,ADDRESS)
VALUES 
(01,'Jonathan Joestar','1800-01-01',9876543210,'jojo1@jba.com','Liverpool, England'),
(02,'Joseph Joestar','1930-02-02',9786543673,'omg@jba.com','New York, USA'),
(03,'Jotaro Kujo','1950-03-03',9090909090,'oraora@jba.com','Tokyo, Japan'),
(04,'Josuke Higashikata','1980-04-04',7868657862,'dorara@jba.com','Morioh, Japan'),
(05, 'Giorno Giovanna','2000-05-05',8976547326,'mudamuda@jba.com','Rome, Italy'),
(06,'Jolyne Cujoh','2020-06-06',6547891230,'chichi@jba.com','Florida, USA');

INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME)
VALUES
(101, 'Hamon Fundamentals', 'Baron Zeppeli'),
(102, 'Stand Combat Training', 'Muhammad Avdol'),
(103, 'Marine Biology', 'Dr. Jotaro Kujo'),
(104, 'Physical Fitness & Morioh Safety', 'Ryohei Higashikata'),
(105, 'Gangstar Leadership Program', 'Leone Abbacchio');

INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES
(1, 1, 101, 'Enrolled'),
(2, 1, 102, 'Not Enrolled'),
(3, 2, 101, 'Enrolled'),
(4, 2, 102, 'Enrolled'),
(5, 3, 103, 'Enrolled'),
(6, 3, 102, 'Enrolled'),
(7, 4, 104, 'Enrolled'),
(8, 4, 102, 'Not Enrolled'),
(9, 5, 105, 'Enrolled'),
(10, 5, 102, 'Enrolled'),
(11, 6, 103, 'Enrolled'),
(12, 6, 101, 'Not Enrolled');

-- 3) Retrieve the Student Information

-- Write a query to retrieve student details, such as student name, contact informations, and Enrollment status.
SELECT s.STU_ID, s.STU_NAME, s.PHONE_NO, s.EMAIL_ID, c.COURSE_NAME, e.ENROLL_STATUS
FROM StudentInfo s
LEFT JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
LEFT JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID;

-- Write a query to retrieve a list of courses in which a specific student is enrolled.
SELECT s.STU_ID, s.STU_NAME, s.PHONE_NO, s.EMAIL_ID, c.COURSE_NAME, e.ENROLL_STATUS
FROM StudentInfo s
LEFT JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
LEFT JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE ENROLL_STATUS = 'Enrolled' AND STU_NAME LIKE 'Gio%';

-- Write a query to retrieve course information, including course name, instructor information
SELECT * FROM CoursesInfo;

-- Write a query to retrieve course information for a specific course
SELECT * FROM CoursesInfo
WHERE COURSE_NAME = 'Hamon Fundamentals';

-- Write a query to retrieve course information for multiple courses
SELECT * FROM CoursesInfo
WHERE COURSE_NAME IN ('Hamon Fundamentals','Gangstar Leadership Program','Marine Biology');

SELECT * FROM CoursesInfo
WHERE COURSE_ID IN (102,104,105);

-- 4. Reporting and Analytics (Using joining queries)

-- Write a query to retrieve the number of students enrolled in each course


SELECT c.COURSE_ID, c.COURSE_NAME, c.COURSE_INSTRUCTOR_NAME, COUNT(e.STU_ID) AS NUMBER_OF_STUDENTS_ENROLLED
FROM CoursesInfo c
LEFT JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID 
AND e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_ID, c.COURSE_NAME, c.COURSE_INSTRUCTOR_NAME


-- Write a query to retrieve the list of students enrolled in a specific course

SELECT c.COURSE_NAME, s.STU_ID, s.STU_NAME, e.ENROLL_STATUS
FROM StudentInfo s
INNER JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
INNER JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE c.COURSE_NAME = 'Hamon Fundamentals' AND e.ENROLL_STATUS = 'Enrolled';


-- Write a query to retrieve the count of enrolled students for each instructor.
SELECT c.COURSE_INSTRUCTOR_NAME, COUNT(e.STU_ID) AS 'No_of_Students_Enrolled'
FROM CoursesInfo c
LEFT JOIN EnrollmentInfo e ON e.COURSE_ID = c.COURSE_ID
AND e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_INSTRUCTOR_NAME
ORDER BY COUNT(e.STU_ID) DESC;

-- Write a query to retrieve the list of students who are enrolled in multiple courses
SELECT s.STU_ID, s.STU_NAME, COUNT(e.COURSE_ID) AS 'No_of_Courses'
FROM EnrollmentInfo e
INNER JOIN StudentInfo s ON e.STU_ID = s.STU_ID
AND e.ENROLL_STATUS = 'Enrolled'
GROUP BY s.STU_ID, s.STU_NAME
HAVING COUNT(e.COURSE_ID) > 1;


-- Write a query to retrieve the courses that have the highest number of enrolled students(arranging from highest to lowest)
SELECT c.COURSE_ID, c.COURSE_NAME, COUNT(e.STU_ID) AS 'No_of_Students_Enrolled'
FROM CoursesInfo c
LEFT JOIN EnrollmentInfo e ON e.COURSE_ID = c.COURSE_ID
AND e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_ID, c.COURSE_NAME
ORDER BY COUNT(e.STU_ID) DESC;