package com.placementcell.controller;

import com.placementcell.dao.StudentDAO;
import com.placementcell.model.Student;
import com.placementcell.model.User;
import com.placementcell.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet({ "/JobRegistrationServlet", "/admin/JobRegistrationServlet", "/student/JobRegistrationServlet" })
public class JobRegistrationServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String jobId = request.getParameter("id");
        if (jobId == null || jobId.isEmpty()) {
            response.sendRedirect("DashboardServlet?error=missing_id");
            return;
        }

        User user = (User) session.getAttribute("user");
        Student student = studentDAO.getStudentByUserId(user.getId());

        String[] jobDetails = null;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(
                        "SELECT id, title, description, company_link FROM announcements WHERE id = ?")) {
            pstmt.setString(1, jobId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                jobDetails = new String[] {
                        rs.getString("id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("company_link")
                };
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (jobDetails == null) {
            response.sendRedirect("DashboardServlet?error=job_not_found");
            return;
        }

        request.setAttribute("job", jobDetails);
        request.setAttribute("student", student);
        request.getRequestDispatcher("/student/job-registration.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
