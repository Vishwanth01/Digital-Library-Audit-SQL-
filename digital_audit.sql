-- =========================
-- CREATE DATABASE
-- =========================
CREATE DATABASE IF NOT EXISTS DigitalLibrary;
USE DigitalLibrary;

-- =========================
-- DROP TABLES (optional reset)
-- =========================
DROP TABLE IF EXISTS IssuedBooks;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Books;

-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE Books (
    bookid INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE Students (
    studentid INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE IssuedBooks (
    issueid INT PRIMARY KEY,
    bookid INT,
    studentid INT,
    issuedate DATE,
    returndate DATE,
    FOREIGN KEY (bookid) REFERENCES Books(bookid),
    FOREIGN KEY (studentid) REFERENCES Students(studentid)
);

-- =========================
-- INSERT SAMPLE DATA
-- =========================

INSERT INTO Books VALUES
(1,'Java Basics','James Gosling','Programming'),
(2,'Python Guide','Guido van Rossum','Programming'),
(3,'Let us C','Yashwanth Kanetkar','Programming'),
(4,'Rich Dad Poor Dad','Robert Kiyosaki','Finance'),
(5,'The Midnight Feast','Lucy Foley','Thriller'),
(6,'Atomic Habits','James Clear','Self Help'),
(7,'Ultimate Spiderman','Jonathan Hickman','Action Comic');

INSERT INTO Students VALUES
(101,'Vishwanth','vishwanth079@gmail.com'),
(102,'Sai','sai123@gmail.com'),
(103,'Sathwik','sathwik045@gmail.com'),
(104,'Hiran','hiranharipuri@gmail.com'),
(105,'Ravishetty','ravi934@gmail.com');

INSERT INTO IssuedBooks VALUES
(1,1,101,'2026-04-01',NULL),
(2,2,102,'2026-04-05','2026-04-10'),
(3,3,103,'2026-03-20',NULL),
(4,4,104,'2026-04-10','2026-04-12'),
(5,5,105,'2026-04-01',NULL);

-- =========================
-- 1. OVERDUE BOOKS (>14 days)
-- =========================

SELECT s.studentid, s.name, b.title, i.issuedate
FROM IssuedBooks i
JOIN Students s ON i.studentid = s.studentid
JOIN Books b ON i.bookid = b.bookid
WHERE i.returndate IS NULL
AND i.issuedate < CURRENT_DATE - INTERVAL 14 DAY;

-- =========================
-- 2. PENALTY REPORT
-- =========================

SELECT 
    s.studentid,
    s.name,
    b.title,
    i.issuedate,
    DATEDIFF(CURRENT_DATE, i.issuedate) AS total_days,
    (DATEDIFF(CURRENT_DATE, i.issuedate) - 14) AS overdue_days,
    (DATEDIFF(CURRENT_DATE, i.issuedate) - 14) * 5 AS penalty_amount
FROM IssuedBooks i
JOIN Students s ON i.studentid = s.studentid
JOIN Books b ON i.bookid = b.bookid
WHERE i.returndate IS NULL
AND i.issuedate < CURRENT_DATE - INTERVAL 14 DAY;

-- =========================
-- 3. MOST POPULAR CATEGORY
-- =========================

SELECT b.category, COUNT(*) AS total
FROM IssuedBooks i
JOIN Books b ON i.bookid = b.bookid
GROUP BY b.category
ORDER BY total DESC;

-- =========================
-- 4. DELETE INACTIVE STUDENTS
-- =========================

DELETE s
FROM Students s
LEFT JOIN IssuedBooks i 
ON s.studentid = i.studentid 
AND i.issuedate >= CURRENT_DATE - INTERVAL 3 YEAR
WHERE i.studentid IS NULL;