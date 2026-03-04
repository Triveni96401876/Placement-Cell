package com.placementcell.util;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ClearBrokenLink {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(
                        "UPDATE resumes SET diploma_path = NULL WHERE student_id = (SELECT id FROM students WHERE register_number = '459cs23026')")) {
            int rows = stmt.executeUpdate();
            System.out.println("Rows updated: " + rows);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
