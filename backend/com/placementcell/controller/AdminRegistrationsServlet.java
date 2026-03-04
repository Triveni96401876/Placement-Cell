package com.placementcell.controller;

import com.placementcell.model.User;
import com.placementcell.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet({ "/AdminRegistrationsServlet", "/adminRegistrationsServlet" })
public class AdminRegistrationsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.html");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("DashboardServlet");
            return;
        }

        String jobId = request.getParameter("jobId");
        List<String[]> registrations = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT jr.*, a.title as job_title FROM job_registrations jr ")
                .append("JOIN announcements a ON jr.job_id = a.id ");

        if (jobId != null && !jobId.trim().isEmpty()) {
            sql.append("WHERE jr.job_id = ? ");
        }

        sql.append("ORDER BY jr.registered_at DESC");

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            if (jobId != null && !jobId.trim().isEmpty()) {
                pstmt.setInt(1, Integer.parseInt(jobId));
            }

            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                registrations.add(new String[] {
                        rs.getString("job_title"), // 0
                        rs.getString("name"), // 1
                        rs.getString("email"), // 2
                        rs.getString("phone"), // 3
                        rs.getString("branch"), // 4
                        rs.getString("semester"), // 5
                        rs.getString("cgpa"), // 6
                        rs.getString("skills"), // 7
                        rs.getString("resume_link"), // 8
                        rs.getTimestamp("registered_at").toString(), // 9
                        rs.getString("sem1"), // 10
                        rs.getString("sem2"), // 11
                        rs.getString("sem3"), // 12
                        rs.getString("sem4"), // 13
                        rs.getString("sem5"), // 14
                        rs.getString("sem6"), // 15
                        rs.getString("backlogs"), // 16
                        rs.getString("backlog_history"), // 17
                        rs.getString("photo_path") // 18
                });
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        String filteredJobTitle = null;
        if (jobId != null && !jobId.trim().isEmpty()) {
            String titleSql = "SELECT title FROM announcements WHERE id = ?";
            try (Connection conn = DBConnection.getConnection();
                    PreparedStatement pstmt = conn.prepareStatement(titleSql)) {
                pstmt.setInt(1, Integer.parseInt(jobId));
                ResultSet titleRs = pstmt.executeQuery();
                if (titleRs.next()) {
                    filteredJobTitle = titleRs.getString("title");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("registrations", registrations);
        request.setAttribute("filteredJobTitle", filteredJobTitle);
        request.getRequestDispatcher("admin-view-registrations.jsp").forward(request, response);
    }
}
