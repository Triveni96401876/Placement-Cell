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

@WebServlet({ "/DigiLockerServlet", "/digiLockerServlet" })
public class DigiLockerServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/student/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        Student student = (Student) session.getAttribute("student");

        if (student == null) {
            student = studentDAO.getStudentByUserId(user.getId());
        }

        if (student != null) {
            loadDocumentPaths(student);
            request.setAttribute("studentData", student);
            request.getRequestDispatcher("/student/digi-locker.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/DashboardServlet?error=student_not_found");
        }
    }

    private void loadDocumentPaths(Student student) {
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(
                        "SELECT sslc_path, diploma_path, resume_path FROM resumes WHERE student_id = ?")) {
            stmt.setLong(1, student.getId());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    student.setSslcCardPath(rs.getString("sslc_path"));
                    student.setDiplomaCardPath(rs.getString("diploma_path"));
                    student.setResumePath(rs.getString("resume_path"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
