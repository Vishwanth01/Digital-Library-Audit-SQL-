# 📚 Digital Library Audit System

## 📌 Overview

This project implements a **Digital Library Management System** using SQL. It helps a community college track book borrowing, identify overdue books, calculate penalties, and analyze borrowing trends.

---

## 🎯 Objectives

The system is designed to:

* Manage books and student records
* Track issued and returned books
* Identify overdue books (beyond 14 days)
* Generate a penalty report for late returns
* Analyze the most popular book categories
* Remove inactive student records

---

## 🗂️ Database Structure

### 1. Books Table

Stores information about books available in the library:

* `bookid` – Unique ID for each book
* `title` – Book title
* `author` – Author name
* `category` – Genre/category of the book

---

### 2. Students Table

Stores student details:

* `studentid` – Unique student ID
* `name` – Student name
* `email` – Student email (unique)

---

### 3. IssuedBooks Table

Tracks book borrowing:

* `issueid` – Unique issue ID
* `bookid` – Reference to Books table
* `studentid` – Reference to Students table
* `issuedate` – Date when book was issued
* `returndate` – Date when book was returned (NULL if not returned)

---

## ⚙️ Features & Queries

### 🔴 1. Overdue Books Detection

Identifies books not returned within 14 days.

**Logic:**

* `returndate IS NULL`
* `issuedate < CURRENT_DATE - INTERVAL 14 DAY`

---

### 💰 2. Penalty Report

Calculates fine for overdue books.

**Details:**

* Total days = difference between current date and issue date
* Overdue days = total days - 14
* Penalty = ₹5 per day

---

### 📊 3. Popularity Analysis

Finds the most borrowed book categories using:

* `COUNT()`
* `GROUP BY`
* `ORDER BY`

---

### 🧹 4. Data Cleanup

Deletes students who have not borrowed books in the last 3 years.

---

## 🛠️ Technologies Used

* SQL (MySQL compatible)
* Relational Database Concepts
* Joins, Aggregations, and Date Functions

## 📌 Notes

* `CURRENT_DATE` is used to dynamically calculate overdue days
* Foreign keys ensure referential integrity
* Sample data is included for testing

---

## 🚀 Future Enhancements

* Add fine payment tracking
* Implement stored procedures for issuing/returning books
* Create views for reports
* Add user interface integration

---

## 🏁 Conclusion

This project demonstrates the use of SQL for real-world database operations such as data management, reporting, and analytics in a library system.

---
