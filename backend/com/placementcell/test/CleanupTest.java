package com.placementcell.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class CleanupTest {
    private static final String URL = "jdbc:mysql://localhost:3306/placement_cell?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = "triveni9100@";

    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
                String sql = "DELETE FROM announcements WHERE title LIKE 'Test Job Update%'";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    int rows = stmt.executeUpdate();
                    System.out.println("Cleaned up " + rows + " test record(s).");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
