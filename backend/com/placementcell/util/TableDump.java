package com.placementcell.util;

import java.sql.*;

public class TableDump {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement()) {
            System.out.println("--- JOB_APPLICATIONS BRANCHES ---");
            try (ResultSet rs = stmt.executeQuery("SELECT branch, COUNT(*) FROM job_applications GROUP BY branch")) {
                while (rs.next()) {
                    System.out.println("Branch in Job Apps: '" + rs.getString(1) + "' Count: " + rs.getInt(2));
                }
            }
            System.out.println("--- STUDENTS COLUMNS ---");
            try (ResultSet rs = stmt.executeQuery("SHOW COLUMNS FROM students")) {
                while (rs.next()) {
                    System.out.println("Column: " + rs.getString(1) + " Type: " + rs.getString(2));
                }
            }
            System.out.println("--- ALL APPLICATIONS ---");
            try (ResultSet rs = stmt
                    .executeQuery("SELECT student_name, register_number, branch FROM job_applications")) {
                while (rs.next()) {
                    System.out.println(rs.getString(1) + " | " + rs.getString(2) + " | " + rs.getString(3));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
