package com.placementcell.controller;

import com.placementcell.util.DBConnection;
import com.placementcell.model.User;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

/**
 * Deactivates a single circular (soft-delete: sets is_active = FALSE).
 * Admin-only endpoint.
 */
@WebServlet({ "/DeleteCircularServlet", "/admin/DeleteCircularServlet" })
public class DeleteCircularServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        // Auth guard
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("DashboardServlet");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("AdminDashboardServlet?status=error&msg=missing_id");
            return;
        }

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(
                        "UPDATE circulars SET is_active = FALSE WHERE id = ?")) {

            stmt.setLong(1, Long.parseLong(idParam));
            int rows = stmt.executeUpdate();

            if (rows > 0) {
                response.sendRedirect("AdminDashboardServlet?status=success&msg=circular_deleted");
            } else {
                response.sendRedirect("AdminDashboardServlet?status=error&msg=circular_not_found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminDashboardServlet?status=error&msg=" + e.getMessage());
        }
    }

    // Also allow GET so a link click works
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        doPost(request, response);
    }
}
