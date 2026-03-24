package com.placementcell.controller;

import com.placementcell.dao.StudentDAO;
import com.placementcell.model.Student;
import com.placementcell.model.User;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/UpdateResumeServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateResumeServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        Student student = (Student) session.getAttribute("student");
        if (student == null) {
            student = studentDAO.getStudentByUserId(user.getId());
        }

        if (student == null) {
            response.sendRedirect("DashboardServlet?error=student_not_found");
            return;
        }

        String description = request.getParameter("resumeDescription");
        Part filePart = request.getPart("resumeFile");

        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdir();

            String fileName = student.getRegisterNumber() + "_resume_updated_" + System.currentTimeMillis() + ".pdf";
            filePart.write(uploadPath + File.separator + fileName);

            try {
                studentDAO.updateResume(student.getId(), fileName, description);
                // Update session object
                student.setResumePath(fileName);
                student.setResumeDescription(description);
                session.setAttribute("student", student);
                response.sendRedirect("DashboardServlet?status=resume_updated");
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("DashboardServlet?error=db_error");
            }
        } else {
            response.sendRedirect("DashboardServlet?error=no_file");
        }
    }
}
