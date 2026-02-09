package com.placementcell.controller;

import com.placementcell.model.Student;
import com.placementcell.model.User;
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

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

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

        // Filtering criteria
        String branch = request.getParameter("branch");
        String minCgpa = request.getParameter("minCgpa");
        String minSslc = request.getParameter("minSslc");
        String minPuc = request.getParameter("minPuc");

        List<Student> students = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT s.*, ad.*, r.sslc_path, r.diploma_path, r.resume_path, r.resume_description " +
                        "FROM students s " +
                        "JOIN academic_details ad ON s.id = ad.student_id " +
                        "LEFT JOIN resumes r ON s.id = r.student_id " +
                        "WHERE 1=1 ");

        if (branch != null && !branch.isEmpty())
            sql.append(" AND s.branch = ? ");
        if (minCgpa != null && !minCgpa.isEmpty())
            sql.append(" AND ad.cgpa >= ? ");
        if (minSslc != null && !minSslc.isEmpty())
            sql.append(" AND ad.sslc_percentage >= ? ");
        if (minPuc != null && !minPuc.isEmpty())
            sql.append(" AND ad.puc_percentage >= ? ");

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (branch != null && !branch.isEmpty())
                stmt.setString(paramIndex++, branch);
            if (minCgpa != null && !minCgpa.isEmpty())
                stmt.setDouble(paramIndex++, Double.parseDouble(minCgpa));
            if (minSslc != null && !minSslc.isEmpty())
                stmt.setDouble(paramIndex++, Double.parseDouble(minSslc));
            if (minPuc != null && !minPuc.isEmpty())
                stmt.setDouble(paramIndex++, Double.parseDouble(minPuc));

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Student s = new Student();
                s.setId(rs.getLong("id"));
                s.setFullName(rs.getString("full_name"));
                s.setRegisterNumber(rs.getString("register_number"));
                s.setBranch(rs.getString("branch"));
                s.setMobileNumber(rs.getString("mobile_number"));
                s.setCgpa(rs.getDouble("cgpa"));
                s.setSslcPercentage(rs.getDouble("sslc_percentage"));
                s.setPucPercentage(rs.getDouble("puc_percentage"));
                s.setSslcCardPath(rs.getString("sslc_path"));
                s.setDiplomaCardPath(rs.getString("diploma_path"));
                s.setResumePath(rs.getString("resume_path"));
                s.setResumeDescription(rs.getString("resume_description"));
                students.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("studentList", students);
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }
}
