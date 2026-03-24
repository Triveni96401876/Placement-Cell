package com.placementcell.controller;

import com.placementcell.dao.JobDAO;
import com.placementcell.dao.StudentDAO;
import com.placementcell.model.Student;
import com.placementcell.model.User;
import com.placementcell.util.DBConnection;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/ApplyJobServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 20)
public class ApplyJobServlet extends HttpServlet {
    private JobDAO jobDAO = new JobDAO();
    private StudentDAO studentDAO = new StudentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/JobPortalServlet");
    }

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

        // Job Details
        int jobId = Integer.parseInt(request.getParameter("jobId"));
        String companyName = request.getParameter("companyName");
        String jobRole = request.getParameter("jobRole");

        // Handle Resume Upload
        Part filePart = request.getPart("resumeFile");
        String resumeName = "";
        if (filePart != null && filePart.getSize() > 0) {
            String storagePath = getServletContext().getRealPath("/") + "uploads" + File.separator + "resumes";
            File uploadDir = new File(storagePath);
            if (!uploadDir.exists())
                uploadDir.mkdirs();

            resumeName = student.getRegisterNumber() + "_" + System.currentTimeMillis() + "_"
                    + filePart.getSubmittedFileName();
            filePart.write(storagePath + File.separator + resumeName);
            resumeName = "uploads/resumes/" + resumeName;
        } else {
            // Fallback to student's profile resume if not provided
            resumeName = student.getResumePath();
        }

        boolean success = jobDAO.applyJob(
                student.getFullName(),
                student.getRegisterNumber(),
                student.getBranch(),
                user.getEmail(),
                student.getMobileNumber(),
                jobId,
                companyName,
                jobRole,
                resumeName);

        if (success) {
            response.sendRedirect("JobPortalServlet?msg=apply_success");
        } else {
            response.sendRedirect("JobPortalServlet?error=apply_failed");
        }
    }
}
