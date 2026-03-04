package com.placementcell.controller;

import com.placementcell.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminJobPortalServlet")
public class AdminJobPortalServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.html");
            return;
        }

        List<String[]> activeJobs = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(
                        "SELECT id, title, description, company_link, announcement_type, created_at FROM announcements WHERE announcement_type = 'JOB' ORDER BY created_at DESC")) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                activeJobs.add(new String[] {
                        rs.getString("id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("announcement_type"),
                        rs.getTimestamp("created_at").toString(),
                        rs.getString("company_link")
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("activeJobs", activeJobs);
        request.getRequestDispatcher("admin-job-portal.jsp").forward(request, response);
    }
}
