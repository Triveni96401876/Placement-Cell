package com.placementcell.util;

import java.sql.*;

public class CheckDB {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT diploma_path FROM resumes WHERE student_id = 4";
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String path = rs.getString("diploma_path");
                    System.out.println("DIPLOMA_PATH_VALUE:|" + (path == null ? "NULL" : path) + "|");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
