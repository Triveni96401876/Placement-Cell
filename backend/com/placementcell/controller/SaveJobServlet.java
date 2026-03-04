package com.placementcell.controller;

import com.placementcell.model.User;
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

@WebServlet("/saveJobServlet")
public class SaveJobServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String company = request.getParameter("company");
        String salary = request.getParameter("salary");
        String location = request.getParameter("location");
        String deadline = request.getParameter("deadline");
        String applyLink = request.getParameter("applyLink");

        // Combine details into description for better visibility
        String enrichedDescription = "<b>Company:</b> " + company + "<br>" +
                "<b>Location:</b> " + location + "<br>" +
                "<b>Salary:</b> " + salary + "<br>" +
                "<b>Deadline:</b> " + deadline + "<br><br>" +
                description.replace("\n", "<br>");

        String sql = "INSERT INTO announcements (title, description, company_link, announcement_type, created_by) VALUES (?, ?, ?, 'JOB', ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, title);
            stmt.setString(2, enrichedDescription);
            stmt.setString(3, applyLink);
            stmt.setLong(4, user.getId());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                response.sendRedirect("AdminDashboardServlet?status=job_posted");
            } else {
                response.sendRedirect("AdminDashboardServlet?error=job_post_failed");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("AdminDashboardServlet?error=server_error");
        }
    }
}
