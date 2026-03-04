package com.placementcell.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TestAnnouncements {
    private static final String URL = "jdbc:mysql://localhost:3306/placement_cell?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = "triveni9100@";

    public static void main(String[] args) {
        System.out.println("Testing Announcements Database Connection...");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
                System.out.println("Connection successful!");

                // 1. Insert a test announcement
                System.out.println("\nInserting Test Announcement...");
                String insertSQL = "INSERT INTO announcements (title, description, announcement_type, created_by) VALUES (?, ?, 'JOB', ?)";
                try (PreparedStatement stmt = conn.prepareStatement(insertSQL)) {
                    stmt.setString(1, "Test Job Update " + System.currentTimeMillis());
                    stmt.setString(2, "This is a test job posted from the script.");
                    stmt.setLong(3, 1); // Assuming Admin ID 1 exists

                    int rows = stmt.executeUpdate();
                    System.out.println("Inserted " + rows + " row(s).");
                } catch (SQLException e) {
                    System.out.println("Insert failed (maybe Admin ID 1 missing?): " + e.getMessage());
                }

                // 2. Query announcements like DashboardServlet
                System.out.println("\nFetching Announcements (Dashboard Logic)...");
                String query = "SELECT title, description, created_at FROM announcements ORDER BY created_at DESC LIMIT 5";
                try (PreparedStatement stmt = conn.prepareStatement(query);
                        ResultSet rs = stmt.executeQuery()) {

                    boolean found = false;
                    while (rs.next()) {
                        found = true;
                        String title = rs.getString("title");
                        String desc = rs.getString("description");
                        String date = rs.getTimestamp("created_at").toString();

                        System.out.println("--------------------------------------------------");
                        System.out.println("Title: " + title);
                        System.out.println("Date: " + date);
                        System.out.println(
                                "Desc: " + (desc != null && desc.length() > 50 ? desc.substring(0, 50) + "..." : desc));
                    }

                    if (!found) {
                        System.out.println("No announcements found.");
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            System.err.println("Driver Not Found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Connection Failed!");
            e.printStackTrace();
        }
    }
}
