# How to Run the SGP Placement Cell Project

Since this project uses **Java Servlets, JDBC, and MySQL**, it requires a **Web Server** (like Apache Tomcat) to run the backend logic.

## 1. Database Setup (MySQL)
1.  Open your MySQL Workbench or Command Line.
2.  Run the script located at:
    `c:\placementcell\backend\database_schema.sql`
3.  This will create the `placement_cell` database and all necessary tables.
4.  **Important**: Update the password in `src/main/java/com/placementcell/util/DBConnection.java` if your MySQL password is not `root`.

## 2. Image Setup
You provided a Logo and Officer Photo. Please save them in the following folder:
`c:\placementcell\backend\src\main\webapp\images\`
*   Rename the college logo to: **`logo.png`**
*   Rename the officer photo to: **`officer.jpg`**

## 3. Running the Application

### Option A: Using an IDE (Eclipse / IntelliJ) - Recommended
1.  Open **Eclipse** or **IntelliJ IDEA**.
2.  Import the `c:\placementcell\backend` folder as a **Maven Project**.
3.  Right-click on the project -> **Run As** -> **Run on Server** (Select Apache Tomcat).
4.  The application will start at: `http://localhost:8080/placement-scms/`

### Option B: Viewing Frontend Only (No Backend)
You can view the design of the pages directly by opening this file in your browser:
`file:///c:/placementcell/backend/src/main/webapp/index.html`

## 4. URLs
Once the server is running, your pages will be available at:
*   **Home/Welcome**: `http://localhost:8080/placement-scms/index.html`
*   **Register**: `http://localhost:8080/placement-scms/register.html`
*   **Login**: `http://localhost:8080/placement-scms/login.html`
