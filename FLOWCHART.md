# Placement Cell Management System - Flowchart & Working Process

This document outlines the workflow of the Placement Cell System, based on the requirements: **HTML, CSS, MySQL, Java, JDBC**.

## 1. High-Level System Architecture

+----------------+       +------------------+       +-------------------+
|   Frontend     | <---> |     Backend      | <---> |     Database      |
| (HTML / CSS)   |       | (Java Servlets)  |       |      (MySQL)      |
+----------------+       +------------------+       +-------------------+

## 2. User User Workflow (Flowchart)

### A. Landing Phase (Welcome Page)
1.  **User Visits Website**
    *   **Header**: Logo, Home, About, Placement Main, Contact Us.
    *   **Hero Section**: Welcome Message regarding "SGP".
    *   **Action Buttons**: [Login], [Register], [Circulars].
    *   **Footer**: Contact Details.

### B. Registration Phase (Sign Up)
*Designed for Students impacting the `students` and `academic_details` tables.*

1.  **Student clicks Sign Up**
2.  **Form Input**:
    *   **Personal Info**: First Name, Last Name, Reg No, Mobile, Branch, Gender, Email, Address.
    *   **Academic Info**:
        *   SSLC: % and Year.
        *   Diploma: % and Year.
        *   BE/B.Tech (Optional): % and Year.
        *   Backlogs: [Yes/No], Count, History.
    *   **Resume**: Upload function (or Auto-Generate option).
3.  **Submission**:
    *   Frontend validates inputs.
    *   Sends `POST` request to Java Servlet.
    *   Java Servlet uses **JDBC** to:
        *   Check if Reg No/Email exists.
        *   Insert into `users` table (generate Hash).
        *   Insert into `students` table.
        *   Insert into `academic_details` table.
4.  **Result**:
    *   Success: Redirect to Login Page.
    *   Failure: Show Error Message.

### C. Login Phase
1.  **User clicks Login**
2.  **Input**: Email/Reg No & Password.
3.  **Authentication**:
    *   Java Servlet checks credentials via JDBC.
    *   Retrieves User Role (`STUDENT` or `ADMIN`).
4.  **Redirection**:
    *   **If Admin**: Go to Admin Dashboard.
    *   **If Student**: Go to Student Dashboard.

### D. Student Dashboard
*   **Overview**: Welcome Message.
    *   *Option 1*: **Edit Profile** (Update Personal/Academic info).
    *   *Option 2*: **View Circulars** (See active job postings).
    *   *Option 3*: **Resume Update** (Upload new CV).
    *   *Option 4*: **DigiLocker** (View stored documents).

### E. Admin Dashboard
*   **Overview**: Admin stats.
    *   *Option 1*: **Student Management** (View List, Filter by GPA/Backlogs).
    *   *Option 2*: **Circulars** (Create/Edit/Delete Job Postings).
    *   *Option 3*: **Hiring Up** (Manage status of recruitments).

## 3. Detailed Data Flow

### Step 1: Database Setup (MySQL)
**Tables**: `users`, `students`, `academic_details`, `announcements`.

### Step 2: Java Backend (JDBC Connection)
*   **Connection Class**: `DBConnection.java` establishes link to MySQL.
*   **Controllers (Servlets)**:
    *   `RegisterServlet.java`: Handles user signup.
    *   `LoginServlet.java`: Handles authentication.
    *   `StudentController.java`: Fetches details for dashboard.
    *   `AdminController.java`: Fetches filtered lists.

### Step 3: Frontend Integration
*   **HTML Forms**: Submit data to Servlet URLs (e.g., `<form action="/register" method="POST">`).
*   **CSS**: Styling for "Premium" look (Glassmorphism, Vibrant Colors).

## 4. Requirement Mapping
| Component | Tech Stack | description |
| :--- | :--- | :--- |
| **Structure** | **HTML5** | Semantic tags, Forms, Layouts. |
| **Styling** | **CSS3** | Responsive, Custom Animations, Flexbox/Grid. |
| **Logic/API** | **Java (Servlets)** | Business logic, validations. |
| **Data Access** | **JDBC** | Raw SQL queries for performance. |
| **Storage** | **MySQL** | Relational data management. |
