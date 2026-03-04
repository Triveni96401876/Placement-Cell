package com.placementcell.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DebugDB {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(
                        "SELECT diploma_path FROM resumes WHERE student_id = (SELECT id FROM students WHERE register_number = '459cs23026')")) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                System.out.println("CURRENT_DIPLOMA_PATH: [" + rs.getString("diploma_path") + "]");
            } else {
                System.out.println("RECORD_NOT_FOUND");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
