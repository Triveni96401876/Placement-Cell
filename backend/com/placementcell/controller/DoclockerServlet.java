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

@WebServlet("/DoclockerServlet")
public class DoclockerServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        Student student = (Student) session.getAttribute("student");

        if (student == null) {
            student = studentDAO.getStudentByUserId(user.getId());
        }

        if (student != null) {
            // Load document paths from resumes table
            loadDocumentPaths(student);

            System.out.println("DoclockerServlet - Student ID: " + student.getId() +
                    ", Name: " + student.getFullName() +
                    ", RegNo: " + student.getRegisterNumber());
            System.out.println("SSLC Path: " + student.getSslcCardPath());
            System.out.println("Diploma Path: " + student.getDiplomaCardPath());
            System.out.println("Resume Path: " + student.getResumePath());

            request.setAttribute("studentData", student);
            request.getRequestDispatcher("/doclocker.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/DashboardServlet?error=student_not_found");
        }
    }

    /**
     * Load document file paths from the resumes table
     */
    private void loadDocumentPaths(Student student) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT sslc_path, diploma_path, resume_path FROM resumes WHERE student_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setLong(1, student.getId());
            rs = stmt.executeQuery();

            if (rs.next()) {
                student.setSslcCardPath(rs.getString("sslc_path"));
                student.setDiplomaCardPath(rs.getString("diploma_path"));
                student.setResumePath(rs.getString("resume_path"));
            }
        } catch (Exception e) {
            System.err.println("Error loading document paths: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null)
                    rs.close();
                if (stmt != null)
                    stmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
