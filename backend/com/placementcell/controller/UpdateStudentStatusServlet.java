package com.placementcell.controller;

import com.placementcell.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateStudentStatusServlet")
public class UpdateStudentStatusServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String id = request.getParameter("id");
        String status = request.getParameter("status");

        if (id != null && status != null) {
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "UPDATE students SET approval_status = ? WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, status.toUpperCase());
                    stmt.setLong(2, Long.parseLong(id));
                    stmt.executeUpdate();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Redirect back to HOD dashboard with current branch if available
        String branch = request.getParameter("branch");
        String redirectUrl = "HODDashboardServlet";
        if (branch != null && !branch.isEmpty()) {
            redirectUrl += "?branch=" + branch;
        }
        response.sendRedirect(redirectUrl);
    }
}
