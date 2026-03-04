package com.placementcell.dao;

import com.placementcell.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CircularDAO {

    public List<String[]> getActiveCirculars(String targetRole) {
        List<String[]> circularsList = new ArrayList<>();
        String sql = "SELECT id, title, message, file_path, created_at FROM circulars WHERE is_active = TRUE AND (send_to = ? OR send_to = 'ALL') ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, targetRole);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                circularsList.add(new String[] {
                        String.valueOf(rs.getInt("id")),
                        rs.getString("title"),
                        rs.getString("message"),
                        rs.getString("file_path"),
                        String.valueOf(rs.getTimestamp("created_at"))
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return circularsList;
    }

    public void addCircular(String title, String message, String targetRole, String filePath) {
        String sql = "INSERT INTO circulars (title, message, send_to, file_path, is_active) VALUES (?, ?, ?, ?, TRUE)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, title);
            stmt.setString(2, message);
            stmt.setString(3, targetRole);
            stmt.setString(4, filePath);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
