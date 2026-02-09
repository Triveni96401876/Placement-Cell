package com.placementcell.dao;

import com.placementcell.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CircularDAO {

    public List<String> getActiveCirculars() {
        List<String> circulars = new ArrayList<>();
        String sql = "SELECT message FROM circulars WHERE is_active = TRUE ORDER BY created_at DESC";
        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                circulars.add(rs.getString("message"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return circulars;
    }

    public void addCircular(String message) {
        String sql = "INSERT INTO circulars (message, is_active) VALUES (?, TRUE)";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, message);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
