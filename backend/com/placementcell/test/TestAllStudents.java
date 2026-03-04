package com.placementcell.test;

import java.sql.*;

public class TestAllStudents {
    public static void main(String[] args) {
        try {
            String url = "jdbc:mysql://localhost:3306/placement_cell?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            Connection conn = DriverManager.getConnection(url, "root", "triveni9100@");

            // Get all students with their document paths
            String sql = "SELECT s.id, s.user_id, s.register_number, s.full_name, " +
                    "r.sslc_path, r.diploma_path, r.resume_path " +
                    "FROM students s LEFT JOIN resumes r ON s.id = r.student_id " +
                    "ORDER BY s.id";

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            System.out.println("=== ALL STUDENTS IN DATABASE ===");
            System.out.println(String.format("%-5s %-10s %-15s %-25s %-30s %-30s %-30s",
                    "ID", "UserID", "RegNo", "Name", "SSLC", "Diploma", "Resume"));
            System.out.println("=".repeat(150));

            while (rs.next()) {
                System.out.println(String.format("%-5d %-10s %-15s %-25s %-30s %-30s %-30s",
                        rs.getLong("id"),
                        rs.getObject("user_id"),
                        rs.getString("register_number"),
                        rs.getString("full_name"),
                        rs.getString("sslc_path") != null ? rs.getString("sslc_path") : "NULL",
                        rs.getString("diploma_path") != null ? rs.getString("diploma_path") : "NULL",
                        rs.getString("resume_path") != null ? rs.getString("resume_path") : "NULL"));
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
