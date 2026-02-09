package com.placementcell.controller;

import com.placementcell.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SaveCircularServlet")
public class SaveCircularServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String message = request.getParameter("message");

        if (message == null || message.trim().isEmpty()) {
            response.sendRedirect("admin-dashboard.html?status=error&msg=empty_message");
            return;
        }

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();

            // First, deactivate all previous circulars (optional, but requested for 'pop up
            // circular message')
            // Usually, only the latest one pops up anyway.
            String deactivateSql = "UPDATE circulars SET is_active = FALSE";
            conn.prepareStatement(deactivateSql).executeUpdate();

            // Insert new circular
            String sql = "INSERT INTO circulars (message, is_active) VALUES (?, TRUE)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, message);
            stmt.executeUpdate();

            response.sendRedirect("admin-dashboard.html?status=success&msg=circular_posted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.html?status=error&msg=" + e.getMessage());
        } finally {
            if (conn != null)
                try {
                    conn.close();
                } catch (Exception e) {
                }
        }
    }
}
