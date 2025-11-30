/* 1. Database Setup
-- Create a database named "student_database." */

CREATE DATABASE student_database;

-- Create a table called " student_table "

CREATE TABLE student_table ( 
Student_id INTEGER PRIMARY KEY,
Stu_name TEXT NOT NULL,
Department TEXT,
email_id TEXT UNIQUE,
Phone_no NUMERIC(10),
Address TEXT,
Date_of_birth DATE,
Gender TEXT CHECK (Gender IN ('Male','Female','Other')),
Major TEXT,
GPA NUMERIC (3,2) CHECK (GPA BETWEEN 0 AND 10),
Grade TEXT CHECK (GRADE IN ('A','B','C','D','E','F'))
);

/* 2. Data Entry
-- Insert 10 sample records into the "student_table" using INSERT command. */

INSERT INTO student_table (Student_id, Stu_name, Department, email_id, Phone_no, Address, Date_of_birth, Gender ,Major, GPA, Grade)
VALUES
(1, 'Jonathan Joestar', 'Archaelogy', 'jojo1@jba.com',9876543210, 'Liverpool, England', '2000-01-01', 'Male', 'History',8.5, 'A'),
(2, 'Joseph Joestar', 'Science', 'omg@jba.com',9786543673, 'New York, USA', '2000-02-02', 'Male', 'Physics',7.2, 'B'),
(3, 'Jotaro Kujo', 'Science', 'oraora@jba.com',9090909090, 'Tokyo, Japan', '2000-03-03', 'Male', 'Marine Biology',9, 'A'),
(4, 'Josuke Higashikata', 'Engineering', 'dorara@jba.com',7868657862, 'Morioh, Japan', '2000-04-04', 'Male', 'Computer Science',6.8, 'B'),
(5, 'Giorno Giovanna', 'Business', 'mudamuda@jba.com',8976547326, 'Rome, Italy', '2000-05-05', 'Male', 'Corporate Law',8.9, 'A'),
(6, 'Jolyne Cujoh', 'Law', 'chichi@jba.com',6547891230, 'Florida, USA', '2000-06-06', 'Female', 'Criminal Law',7, 'B'),
(7, 'Dio Brando', 'Arts', 'dio@jba.com',9876478614, 'Liverpool, England', '2000-07-07', 'Male', 'Philosophy',4.5, 'C'),
(8, 'Bruno Bucciarati', 'Fashion', 'bruno@jba.com',7395763238, 'Rome, Italy', '2000-08-08', 'Male', 'Apparel Technology',9.1, 'A'),
(9, 'Erina Pendleton', 'Literature', 'erina@jba.com',8347562982, 'Liverpool, England', '2000-09-09', 'Female', 'English',6.3, 'B'),
(10, 'Koichi Hirose', 'Engineering', 'koichi@jba.com',9834358654, 'Morioh, Japan', '2000-10-10', 'Male', 'Electronics',4.9, 'C')

/* 3. Student Information Retrieval
Develop a query to retrieve all students' information from the "student_table" and sort them in descending order by their grade. */

SELECT * FROM student_table ORDER BY Grade DESC;

/* 4. Query for Male Students:
Implement a query to retrieve information about all male students from the "student_table." */

SELECT * FROM student_table WHERE gender = 'Male';

/* 5. Query for Students with GPA less than 5.0
Create a query to fetch the details of students who have a GPA less than 5.0 from the "student_table. */

SELECT * FROM student_table WHERE GPA < 5.0;


/* 6. Update Student Email and Grade
Write an update statement to modify the email and grade of a student with a specific ID in the "student_table." */

UPDATE student_table
SET email_id = 'konodioda@jba.com',
grade = 'A'
WHERE student_id = 7;

-- Checking for change in the table for student_id = 7
SELECT * FROM student_table WHERE student_id = 7;

/* Query for Students with Grade "B"
Develop a query to retrieve the names and ages of all students who have a grade of "B" from the "student_table." */

SELECT * FROM student_table WHERE grade = 'B';

/* 8. Grouping and Calculation
Create a query to group the "student_table" by the "Department" and "Gender" columns and calculate the average GPA for each combination. */

SELECT Department, Gender, ROUND(Avg(GPA),2) as average_gpa FROM student_table
GROUP BY Department, Gender;

/* 9. Table Renaming
Rename the "student_table" to "student_info" using the appropriate SQL statement. */

ALTER TABLE student_table 
RENAME TO student_info;

/* 10. Retrieve Student with Highest GPA
Write a query to retrieve the name of the student with the highest GPA from the "student_info" table. */

SELECT stu_name, GPA 
FROM student_info 
WHERE GPA = (SELECT MAX(GPA) FROM student_info);

