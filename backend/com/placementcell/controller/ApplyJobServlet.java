package com.placementcell.controller;

import com.placementcell.model.User;
import com.placementcell.util.DBConnection;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/ApplyJobServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ApplyJobServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads/job_photos";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.html");
            return;
        }

        User user = (User) session.getAttribute("user");
        String jobId = request.getParameter("jobId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String branch = request.getParameter("branch");
        String semester = request.getParameter("semester");
        String cgpa = request.getParameter("cgpa");
        String skills = request.getParameter("skills");
        String resumeLink = request.getParameter("resumeLink");

        // New fields
        String sem1 = request.getParameter("sem1");
        String sem2 = request.getParameter("sem2");
        String sem3 = request.getParameter("sem3");
        String sem4 = request.getParameter("sem4");
        String sem5 = request.getParameter("sem5");
        String sem6 = request.getParameter("sem6");
        String backlogs = request.getParameter("backlogs");
        String backlogHistory = request.getParameter("backlogHistory");

        System.out.println("ApplyJobServlet: Processing request for jobId: " + jobId);
        System.out.println("ApplyJobServlet: User ID: " + user.getId() + ", Name: " + name);

        // Handle Photo Upload
        String photoPath = "";
        try {
            Part photoPart = request.getPart("photo");
            if (photoPart != null && photoPart.getSize() > 0) {
                System.out.println("ApplyJobServlet: Photo received, size: " + photoPart.getSize());
                String submittedFileName = photoPart.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    String fileName = user.getId() + "_" + System.currentTimeMillis() + "_" + submittedFileName;
                    String realPath = getServletContext().getRealPath("");
                    if (realPath != null) {
                        String uploadPath = realPath + File.separator + UPLOAD_DIR;
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists())
                            uploadDir.mkdirs();

                        photoPart.write(uploadPath + File.separator + fileName);
                        photoPath = UPLOAD_DIR + "/" + fileName;
                        System.out.println("ApplyJobServlet: Photo saved to: " + photoPath);
                    }
                }
            } else {
                System.out.println("ApplyJobServlet: No photo uploaded or empty");
            }
        } catch (Exception e) {
            System.err.println("ApplyJobServlet Photo upload failed: " + e.getMessage());
            e.printStackTrace();
        }

        long studentId = -1;
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement("SELECT id FROM students WHERE user_id = ?")) {
            pstmt.setLong(1, user.getId());
            var rs = pstmt.executeQuery();
            if (rs.next()) {
                studentId = rs.getLong("id");
            }
        } catch (Exception e) {
            System.err.println("ApplyJobServlet: Database error fetching studentId");
            e.printStackTrace();
        }

        System.out.println("ApplyJobServlet: Found studentId: " + studentId);

        if (studentId == -1) {
            System.out.println("ApplyJobServlet: Student not found, redirecting...");
            response.sendRedirect("DashboardServlet?error=student_not_found");
            return;
        }

        // Check for existing registration
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn
                        .prepareStatement("SELECT id FROM job_registrations WHERE job_id = ? AND student_id = ?")) {
            pstmt.setLong(1, Long.parseLong(jobId));
            pstmt.setLong(2, studentId);
            if (pstmt.executeQuery().next()) {
                System.out.println("ApplyJobServlet: Already registered, redirecting...");
                response.sendRedirect("DashboardServlet?error=already_registered");
                return;
            }
        } catch (Exception e) {
            System.err.println("ApplyJobServlet: Database error checking existing registration");
            e.printStackTrace();
        }

        String sql = "INSERT INTO job_registrations (job_id, student_id, name, email, phone, branch, semester, cgpa, skills, resume_link, sem1, sem2, sem3, sem4, sem5, sem6, backlogs, backlog_history, photo_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        System.out.println("ApplyJobServlet: Inserting registration...");

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setLong(1, Long.parseLong(jobId));
            stmt.setLong(2, studentId);
            stmt.setString(3, name);
            stmt.setString(4, email);
            stmt.setString(5, phone);
            stmt.setString(6, branch);
            stmt.setString(7, semester);
            stmt.setDouble(8, (cgpa != null && !cgpa.isEmpty()) ? Double.parseDouble(cgpa) : 0.0);
            stmt.setString(9, skills);
            stmt.setString(10, resumeLink);

            // New fields
            stmt.setDouble(11, (sem1 != null && !sem1.isEmpty()) ? Double.parseDouble(sem1) : 0.0);
            stmt.setDouble(12, (sem2 != null && !sem2.isEmpty()) ? Double.parseDouble(sem2) : 0.0);
            stmt.setDouble(13, (sem3 != null && !sem3.isEmpty()) ? Double.parseDouble(sem3) : 0.0);
            stmt.setDouble(14, (sem4 != null && !sem4.isEmpty()) ? Double.parseDouble(sem4) : 0.0);
            stmt.setDouble(15, (sem5 != null && !sem5.isEmpty()) ? Double.parseDouble(sem5) : 0.0);
            stmt.setDouble(16, (sem6 != null && !sem6.isEmpty()) ? Double.parseDouble(sem6) : 0.0);
            stmt.setString(17, backlogs);
            stmt.setString(18, backlogHistory);
            stmt.setString(19, photoPath);

            int rows = stmt.executeUpdate();
            System.out.println("ApplyJobServlet: Insert result, rows: " + rows);
            if (rows > 0) {
                response.sendRedirect("DashboardServlet?status=applied");
            } else {
                response.sendRedirect("DashboardServlet?error=registration_failed");
            }

        } catch (Exception e) {
            System.err.println("ApplyJobServlet: SQL Insertion failed");
            e.printStackTrace();
            response.sendRedirect("DashboardServlet?error=server_error");
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}
