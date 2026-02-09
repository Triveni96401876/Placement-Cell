# Required Build Fixes for SGP Placement Cell

I have completed a full debugging session on your backend code.
The following critical issues were fixed:

1.  **Code Logic Fixes**:
    *   **LoginServlet**: Fixed Admin login logic (avoiding NullPointerException) and added error handling.
    *   **RegisterServlet**: Added proper backlog handling and fixed the redirect flow.
    *   **StudentDAO**: Updated database queries to correctly store `backlog_status` and `current_backlog_count`.
    *   **Student Model**: Updated fields to match the database schema (`Integer backlogCount`, `String backlogStatus`).
    *   **Admin Dashboard**: Reverted accidental UI changes to ensure Branch is displayed correctly.

2.  **Environment Setup (CRITICAL)**:
    *   The project cannot run because **Maven is not installed** in your environment.
    *   The JAR files (Servlet API, MySQL Connector) are missing.

## How to Run This Project WITHOUT Errors

Since you cannot run `mvn` commands directly in this terminal, please follow these steps:

### Option 1: Use an IDE (Recommended)
1.  Open **IntelliJ IDEA** or **Eclipse**.
2.  Select **File > Open** and choose the `c:\placementcell\backend` folder.
3.  The IDE will detect `pom.xml` and automatically download the missing libraries.
4.  Update the database password in:
    `src/main/java/com/placementcell/util/DBConnection.java`
5.  Right-click the project -> **Run As** -> **Run on Server**.

### Option 2: Install Maven Manually
1.  Download Apache Maven from: https://maven.apache.org/download.cgi
2.  Extract it to `C:\Maven`.
3.  Add `C:\Maven\bin` to your System PATH variable.
4.  Restart your terminal.
5.  Run: `mvn tomcat7:run` inside `c:\placementcell\backend`.

## Verification
You can verify the fixes by checking the code in:
*   `src/main/java/com/placementcell/controller/RegisterServlet.java`
*   `src/main/java/com/placementcell/dao/StudentDAO.java`
