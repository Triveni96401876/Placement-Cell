package com.placementcell.controller;

import com.placementcell.util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/deleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        com.placementcell.model.User user = (session != null)
                ? (com.placementcell.model.User) session.getAttribute("user")
                : null;
        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String studentId = request.getParameter("id");
        if (studentId != null && !studentId.isEmpty()) {
            try (Connection conn = DBConnection.getConnection()) {
                // Get user_id first to delete from users table as well (cascading might handle
                // it but better be safe)
                // Actually if schema has ON DELETE CASCADE it's fine.
                // Let's just delete from users table which will cascade to students and
                // academic_details.
                String getUserIdSql = "SELECT user_id FROM students WHERE id = ?";
                long userId = -1;
                try (PreparedStatement stmt = conn.prepareStatement(getUserIdSql)) {
                    stmt.setLong(1, Long.parseLong(studentId));
                    var rs = stmt.executeQuery();
                    if (rs.next()) {
                        userId = rs.getLong("user_id");
                    }
                }

                if (userId != -1) {
                    String deleteSql = "DELETE FROM users WHERE id = ?";
                    try (PreparedStatement stmt = conn.prepareStatement(deleteSql)) {
                        stmt.setLong(1, userId);
                        stmt.executeUpdate();
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("AdminDashboardServlet");
    }
}
