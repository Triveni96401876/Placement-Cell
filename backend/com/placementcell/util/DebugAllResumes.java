package com.placementcell.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DebugAllResumes {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM resumes")) {
            ResultSet rs = stmt.executeQuery();
            System.out.println("ID | StudentID | SSLC | Diploma | Resume");
            while (rs.next()) {
                System.out
                        .println(rs.getLong("id") + " | " + rs.getLong("student_id") + " | " + rs.getString("sslc_path")
                                + " | " + rs.getString("diploma_path") + " | " + rs.getString("resume_path"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
