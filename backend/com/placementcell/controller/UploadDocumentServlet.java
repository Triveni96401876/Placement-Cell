package com.placementcell.controller;

import com.placementcell.dao.StudentDAO;
import com.placementcell.model.Student;
import com.placementcell.model.User;

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

@WebServlet("/UploadDocumentServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UploadDocumentServlet extends HttpServlet {
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

        String documentType = request.getParameter("documentType");
        Part filePart = request.getPart("documentFile");

        if (filePart != null && filePart.getSize() > 0) {
            // Absolute path outside webapp for persistence
            String storagePath = "C:" + File.separator + "placementcell_uploads" + File.separator + "documents";
            File uploadDir = new File(storagePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Generate filename: {registerNumber}_{docType}_{timestamp}.ext
            String originalFileName = filePart.getSubmittedFileName();
            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String fileName = student.getRegisterNumber() + "_" + documentType + "_" + System.currentTimeMillis()
                    + extension;

            String filePath = storagePath + File.separator + fileName;

            // Save file
            filePart.write(filePath);

            // Update database based on document type
            boolean updated = false;
            try {
                if ("sslc".equals(documentType)) {
                    updated = studentDAO.updateDocumentPath(student.getId(), "sslc_path", fileName);
                    if (updated) {
                        student.setSslcCardPath(fileName);
                    }
                } else if ("diploma".equals(documentType)) {
                    updated = studentDAO.updateDocumentPath(student.getId(), "diploma_path", fileName);
                    if (updated) {
                        student.setDiplomaCardPath(fileName);
                    }
                } else if ("resume".equals(documentType)) {
                    updated = studentDAO.updateDocumentPath(student.getId(), "resume_path", fileName);
                    if (updated) {
                        student.setResumePath(fileName);
                    }
                }

                if (updated) {
                    session.setAttribute("student", student);
                    response.sendRedirect("DigiLockerServlet?status=upload_success");
                } else {
                    response.sendRedirect("DigiLockerServlet?error=upload_failed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("DigiLockerServlet?error=db_error");
            }
        } else {
            response.sendRedirect("DigiLockerServlet?error=no_file");
        }
    }

}
