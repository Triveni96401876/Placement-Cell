package com.placementcell.test;

import com.placementcell.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TestDoclocker {
    public static void main(String[] args) {
        System.out.println("Testing Database Connection...");

        try (Connection conn = DBConnection.getConnection()) {
            System.out.println("Connection successful!");

            // Check for student records
            String checkStudent = "SELECT s.id, s.full_name, s.register_number FROM students s LIMIT 5";
            try (PreparedStatement stmt = conn.prepareStatement(checkStudent);
                    ResultSet rs = stmt.executeQuery()) {

                System.out.println("\nChecking Students:");
                while (rs.next()) {
                    long id = rs.getLong("id");
                    String name = rs.getString("full_name");
                    String regNo = rs.getString("register_number");
                    System.out.println("ID: " + id + ", Name: " + name + ", RegNo: " + regNo);

                    // Check resume paths for this student
                    checkResumePaths(conn, id);
                }
            }

        } catch (SQLException e) {
            System.err.println("Connection Failed!");
            e.printStackTrace();
        }
    }

    private static void checkResumePaths(Connection conn, long studentId) {
        String query = "SELECT sslc_path, diploma_path, resume_path FROM resumes WHERE student_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setLong(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    System.out.println("  -> Document Paths found for Student ID " + studentId + ":");
                    System.out.println("     SSLC: " + rs.getString("sslc_path"));
                    System.out.println("     Diploma: " + rs.getString("diploma_path"));
                    System.out.println("     Resume: " + rs.getString("resume_path"));
                } else {
                    System.out.println("  -> No document paths found in 'resumes' table for Student ID " + studentId);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error query resume paths: " + e.getMessage());
        }
    }
}
