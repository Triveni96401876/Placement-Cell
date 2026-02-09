resume template # SGP Ballari - Placement Cell Portal Documentation

## 1. Project Overview
The **SGP Placement Cell Portal** is a high-performance, modern web application designed to streamline campus placements for Sanjay Gandhi Polytechnic, Ballari. It bridges the gap between students and the administration, offering a seamless experience for registration, profile management, and career tracking.

---

## 2. Technical Stack
*   **Frontend Ecosystem**:
    *   **Core**: HTML5, Vanilla JavaScript.
    *   **Styling**: Modern CSS3 (Glassmorphism, Flexbox, CSS Grid).
    *   **Typography**: Google Fonts (Poppins, Inter).
    *   **Icons**: Font Awesome 6.4.0.
    *   **Frameworks**: React.js (Integrated for Admin Dashboard).
*   **Backend Infrastructure**:
    *   **Language**: Java 17+.
    *   **Architecture**: Java Servlets & JSP (Model-View-Controller pattern).
    *   **Database**: MySQL 8.0.
    *   **Persistence**: JDBC with DAO (Data Access Object) design.
*   **Build & Deployment**:
    *   **Dependency Management**: Maven (`pom.xml`).
    *   **Application Server**: Apache Tomcat.

---

## 3. Core Modules & Features

### A. Student Module
*   **Advanced Enrollment Form**: A multi-step form capturing Personal, Academic (SSLC, PUC/ITI), and Diploma semester details.
*   **Premium Success Flow**: After submission, students see a high-end animated checkmark modal with a smooth redirection to the login page.
*   **AI Auto-Resume Generator**: Instantly generates a professional PDF-style resume with student data and profile photo.
*   **Dynamic Dashboard**:
    *   **State-of-the-art UI**: Right-aligned "Welcome [User Name]" greeting.
    *   **Clean Branding**: Automatic removal of system-level prefixes (e.g., stripping "Student" label from greetings).
    *   **Visual Stats**: Real-time progress bars for CGPA and profile completeness.

### B. Admin Module
*   **Interactive Panel**: React-based dashboard for real-time monitoring.
*   **Circular Management**: System to push placement notices and circulars to student dashboards instantly.
*   **Student Filtering**: (In Progress) Ability to filter students based on branch, CGPA, and eligibility criteria.

### C. Backend Engine
*   **Data Models**: Robust Java POJOs (Student, User, EligibleStudent) with smart business logic.
*   **Database Schema**: normalized tables for high data integrity (`users`, `students`, `academic_details`, `circulars`).
*   **Secured Access**: Role-based authentication (Student/Admin).

---

## 4. Key Implementation Highlights (Latest Milestones)
1.  **Greeting Intelligence**: Implemented a `getWelcomeName()` method in the Java model to automatically clean titles from the database (e.g., turning `Student (dolly1234)` into `dolly1234`).
2.  **Dual-Environment Support**: The system detects if it is running on a **Preview Server** (Port 8000) or **Production** (Tomcat). On preview, it allows a frictionless UI walk-through without backend errors.
3.  **UI/UX Aesthetic**: Shifted from basic blue themes to a premium "Academic Navy & Sky Blue" palette with translucent card effects.

---

## 5. Project Directory Structure
```text
/placementcell
|-- /backend (Main Java Project)
|   |-- /src/main/java (Models, Controllers, DAOs)
|   |-- /src/main/webapp (JSPs, HTML, CSS, JS)
|   `-- pom.xml (Maven Configuration)
|-- /admin-frontend (React-based Admin Panel)
|-- /frontend-vanilla (Core UI Templates)
|-- database_schema.sql (System DB Structure)
`-- PROJECT_DOCUMENTATION.md (This File)
```

---

## 6. How to Run (Development Mode)
1.  **Frontend Preview**: Run a Python server in `backend/src/main/webapp` on port 8000 to see the UI.
2.  **Admin Panel**: Navigate to `admin-frontend` and run `npm start` (Port 3000).
3.  **Full Logic**: Deploy the `backend` project to an **Apache Tomcat** server and connect to a running **MySQL** instance.

---
**Last Updated**: Feb 7, 2026
**Status**: Beta (UI/UX Finalized, Backend Integration Ongoing)
