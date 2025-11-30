------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

-- Task 3 - Project: Event Management System using PostgreSQL. 

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------


/* 
1. Database Creation
Create a database named "EventsManagement."
*/


CREATE DATABASE EventsManagement;


------------------------------------------------------------------------------------------------------------------------------------


/* 
2. Data Creation
Insert some sample data for Events, Attendees, and Registrations tables with respective fields.
*/

CREATE TABLE Events (

Event_Id SERIAL PRIMARY KEY,
Event_Name TEXT NOT NULL,
Event_Date DATE NOT NULL,
Event_Location TEXT NOT NULL,
Event_Description TEXT
);

CREATE TABLE Attendees (
Attendee_ID SERIAL PRIMARY KEY,
Attendee_Name TEXT NOT NULL,
Attendee_Phone NUMERIC(10),
Attendee_Email TEXT UNIQUE,
Attendee_City TEXT
);

CREATE TABLE Registrations (
Registration_Id SERIAL PRIMARY KEY,
Event_Id INT,
Attendee_Id INT,
Registration_Date DATE NOT NULL,
Registration_Amount NUMERIC(8,2),

CONSTRAINT fk_event FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id) ON DELETE CASCADE,
CONSTRAINT fk_attendee FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id) ON DELETE CASCADE
);


------------------------------------------------------------------------------------------------------------------------------------


/* 
2. Data Creation
*/

-- Insert some sample data for Events, Attendees, and Registrations tables with respective fields.


INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
('Tech Conference 2024', '2024-12-10', 'New York', 'Technology trends and innovations'),
('Music Fest', '2024-11-05', 'Los Angeles', 'Annual music festival'),
('Business Summit', '2024-10-22', 'Chicago', 'Entrepreneurship and business growth'),
('Art Exhibition', '2024-09-15', 'San Francisco', 'Modern art display'),
('Sports Marathon', '2024-08-20', 'Boston', 'Annual city marathon');


INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
('Jonathan Joestar', 9876543210, 'jojo1@jba.com', 'Liverpool'),
('Joseph Joestar', 9123456780, 'joseph@jba.com', 'New York'),
('Jotaro Kujo', 9012345678, 'oraora@jba.com', 'Tokyo'),
('Josuke Higashikata', 9345678123, 'dorara@jba.com', 'Morioh'),
('Giorno Giovanna', 9456123789, 'mudamuda@jba.com', 'Rome');


INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
(1, 1, '2024-09-01', 150.00),
(2, 2, '2024-09-05', 80.00),
(3, 3, '2024-09-10', 120.00),
(4, 4, '2024-09-12', 60.00),
(5, 5, '2024-09-15', 50.00),
(1, 2, '2024-09-18', 150.00),
(2, 3, '2024-09-20', 80.00),
(3, 4, '2024-09-25', 120.00);


------------------------------------------------------------------------------------------------------------------------------------


/* 
3. Manage Event Details
*/

-- a) Inserting a new event.


INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
('How to defeat the Joestars?','2025-01-15','Seattle','Strategies to defeat the Joestar Bloodline')


-- b) Updating an event's information.

UPDATE Events
SET Event_Location = 'Chennai, India'
WHERE Event_ID = 3

-- c) Deleting an event.

DELETE FROM Events 
WHERE Event_Name = 'Music Fest'


------------------------------------------------------------------------------------------------------------------------------------


/*
4) Manage Track Attendees & Handle Events
*/

-- a) Inserting a new attendee. 

INSERT INTO Attendees (Attendee_ID, Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
(6,'Dio Brando',8570898760,'konodioda@jba.com','Liverpool')


-- b)Registering an attendee for an event.

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
(6,6,'2024-09-12',1000.00)


------------------------------------------------------------------------------------------------------------------------------------


/* 
5. Develop queries to retrieve event information, generate attendee lists, and calculate event attendance statistics.
*/

-- Retrieve event information

-- All events
SELECT * FROM Events;

-- Specific event(s)

SELECT * FROM Events
WHERE Event_Date > '2025-01-01'



-- Generate Attendee Lists

SELECT * FROM Attendees;


-- Calculate event attendance statistics

-- Attendee List for each event

SELECT e.Event_name, a.Attendee_name, a.Attendee_email, a.Attendee_phone
FROM Registrations r
INNER JOIN Events e
ON r.Event_ID = e.Event_ID
INNER JOIN Attendees a
ON a.Attendee_ID = r.Attendee_ID

-- No. of Attendees per event

SELECT e.Event_Name, COUNT(r.Attendee_ID) as No_of_Attendees
FROM Events e
LEFT JOIN Registrations r 
ON e.Event_ID = r.Event_ID 
GROUP BY e.Event_name
ORDER BY No_of_Attendees DESC


-- Events with the highest attendance
SELECT e.Event_Name, COUNT(r.Attendee_ID) as No_of_Attendees
FROM Events e
LEFT JOIN Registrations r 
ON e.Event_ID = r.Event_ID 
GROUP BY e.Event_name
HAVING COUNT(r.Attendee_ID) = 
(SELECT MAX(attendee_count_per_event) 
FROM (
	SELECT COUNT(*) AS attendee_count_per_event 
	FROM REGISTRATIONS 
	GROUP BY Event_ID) sub
);

------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------

