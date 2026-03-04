package com.placementcell.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Test Database Connection Utility
 * Run this program to verify your MySQL database connection is working
 * 
 * How to run:
 * 1. Make sure MySQL is running
 * 2. Make sure database_schema.sql has been executed
 * 3. Update PASSWORD in DBConnection.java if needed
 * 4. Run: mvn exec:java
 * -Dexec.mainClass="com.placementcell.util.TestDBConnection"
 */
public class TestDBConnection {

    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("DATABASE CONNECTION TEST");
        System.out.println("========================================\n");

        // Step 1: Test basic connection
        System.out.println("Step 1: Attempting to connect to MySQL...");

        try {
            Connection conn = DBConnection.getConnection();

            if (conn != null && !conn.isClosed()) {
                System.out.println("SUCCESS! Connected to MySQL database.");
                System.out.println();

                // Print connection details
                System.out.println("CONNECTION DETAILS:");
                System.out.println("   Database: placement_cell");
                System.out.println("   Host: localhost");
                System.out.println("   Port: 3306");
                System.out.println("   JDBC URL: jdbc:mysql://localhost:3306/placement_cell");
                System.out.println();

                // Step 2: Check if database exists
                System.out.println("Step 2: Verifying database schema...");
                Statement stmt = conn.createStatement();

                // Get database name
                ResultSet rsDB = stmt.executeQuery("SELECT DATABASE() as db_name");
                if (rsDB.next()) {
                    String dbName = rsDB.getString("db_name");
                    System.out.println("Using database: " + dbName);
                }
                rsDB.close();
                System.out.println();

                // Step 3: List all tables
                System.out.println("Step 3: Checking tables in database...");
                ResultSet rs = stmt.executeQuery(
                        "SELECT TABLE_NAME FROM information_schema.tables " +
                                "WHERE table_schema = 'placement_cell' ORDER BY TABLE_NAME");

                System.out.println("TABLES FOUND:");
                int count = 0;
                while (rs.next()) {
                    count++;
                    System.out.println("   " + count + ". " + rs.getString("TABLE_NAME"));
                }
                System.out.println();

                if (count >= 10) {
                    System.out.println("Found " + count + " tables (Expected: 10+)");
                } else {
                    System.out.println("Found only " + count + " tables. Expected at least 10.");
                    System.out.println("   Run database_schema.sql to create all tables.");
                }
                System.out.println();

                // Step 4: Check key tables exist
                System.out.println("Step 4: Verifying required tables...");
                String[] requiredTables = {
                        "users", "students", "academic_details",
                        "circulars", "login_logs", "admins",
                        "resumes", "announcements", "eligibility_criteria",
                        "eligible_students"
                };

                int foundTables = 0;
                for (String tableName : requiredTables) {
                    ResultSet rsTable = stmt.executeQuery(
                            "SELECT COUNT(*) as cnt FROM information_schema.tables " +
                                    "WHERE table_schema = 'placement_cell' AND table_name = '" + tableName + "'");
                    if (rsTable.next() && rsTable.getInt("cnt") > 0) {
                        System.out.println("   [OK] " + tableName);
                        foundTables++;
                    } else {
                        System.out.println("   [MISSING] " + tableName);
                    }
                    rsTable.close();
                }
                System.out.println();

                // Step 5: Test sample queries
                System.out.println("Step 5: Testing database queries...");

                // Count users
                ResultSet rsUsers = stmt.executeQuery("SELECT COUNT(*) as user_count FROM users");
                if (rsUsers.next()) {
                    int userCount = rsUsers.getInt("user_count");
                    System.out.println("   Users in database: " + userCount);
                }
                rsUsers.close();

                // Count students
                ResultSet rsStudents = stmt.executeQuery("SELECT COUNT(*) as student_count FROM students");
                if (rsStudents.next()) {
                    int studentCount = rsStudents.getInt("student_count");
                    System.out.println("   Students in database: " + studentCount);
                }
                rsStudents.close();

                // Count circulars
                ResultSet rsCirculars = stmt.executeQuery("SELECT COUNT(*) as circular_count FROM circulars");
                if (rsCirculars.next()) {
                    int circularCount = rsCirculars.getInt("circular_count");
                    System.out.println("   Circulars in database: " + circularCount);
                }
                rsCirculars.close();

                System.out.println();

                // Clean up
                rs.close();
                stmt.close();
                conn.close();

                // Final summary
                System.out.println("========================================");
                if (foundTables == requiredTables.length) {
                    System.out.println("ALL TESTS PASSED!");
                    System.out.println("Database connection is working perfectly!");
                    System.out.println("All required tables exist!");
                    System.out.println("Database queries are working!");
                    System.out.println();
                    System.out.println("You can now start the backend server!");
                } else {
                    System.out.println("CONNECTION SUCCESSFUL BUT...");
                    System.out.println("Some required tables are missing.");
                    System.out.println("Please run database_schema.sql to create all tables.");
                }
                System.out.println("========================================");

            } else {
                System.out.println("❌ FAILED! Could not establish connection.");
                printTroubleshooting();
            }

        } catch (java.sql.SQLException e) {
            System.out.println("❌ DATABASE ERROR!");
            System.out.println();
            System.out.println("Error Code: " + e.getErrorCode());
            System.out.println("SQL State: " + e.getSQLState());
            System.out.println("Message: " + e.getMessage());
            System.out.println();

            // Specific error handling
            if (e.getMessage().contains("Access denied")) {
                System.out.println("🔧 SOLUTION: Wrong MySQL password!");
                System.out.println("   1. Open DBConnection.java");
                System.out.println("   2. Update PASSWORD on line 12");
                System.out.println("   3. Use your actual MySQL root password");
                System.out.println("   4. Save and rebuild the project");
            } else if (e.getMessage().contains("Unknown database")) {
                System.out.println("🔧 SOLUTION: Database doesn't exist!");
                System.out.println("   1. Open MySQL Workbench or Command Line");
                System.out.println("   2. Run: SOURCE c:/placementcell/backend/database_schema.sql;");
                System.out.println("   3. Verify: SHOW DATABASES;");
            } else if (e.getMessage().contains("Communications link failure")) {
                System.out.println("🔧 SOLUTION: MySQL service not running!");
                System.out.println("   1. Check if MySQL service is running");
                System.out.println("   2. Start service: net start MySQL80");
                System.out.println("   3. Or use XAMPP Control Panel");
            } else {
                printTroubleshooting();
            }

            System.out.println();
            e.printStackTrace();

        } catch (Exception e) {
            System.out.println("❌ UNEXPECTED ERROR!");
            System.out.println("Error: " + e.getMessage());
            System.out.println();
            e.printStackTrace();
            printTroubleshooting();
        }
    }

    private static void printTroubleshooting() {
        System.out.println();
        System.out.println("========================================");
        System.out.println("🔧 TROUBLESHOOTING STEPS:");
        System.out.println("========================================");
        System.out.println("1. ✅ Check MySQL Service");
        System.out.println("   - Open: services.msc");
        System.out.println("   - Find: MySQL80 or MySQL");
        System.out.println("   - Status should be: Running");
        System.out.println();
        System.out.println("2. ✅ Verify MySQL Password");
        System.out.println("   - File: DBConnection.java (line 12)");
        System.out.println("   - Update PASSWORD to match your MySQL installation");
        System.out.println();
        System.out.println("3. ✅ Check Database Exists");
        System.out.println("   - Run in MySQL: SHOW DATABASES;");
        System.out.println("   - Should see: placement_cell");
        System.out.println("   - If missing, run: SOURCE database_schema.sql;");
        System.out.println();
        System.out.println("4. ✅ Test MySQL Connection");
        System.out.println("   - Command: mysql -u root -p");
        System.out.println("   - Should connect without errors");
        System.out.println();
        System.out.println("5. ✅ Check Port 3306");
        System.out.println("   - Ensure MySQL is running on port 3306");
        System.out.println("   - Command: netstat -ano | findstr :3306");
        System.out.println("========================================");
    }
}
