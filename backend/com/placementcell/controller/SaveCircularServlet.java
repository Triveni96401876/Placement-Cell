package com.placementcell.controller;

import com.placementcell.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
import java.io.File;

@WebServlet({ "/SaveCircularServlet", "/saveCircularServlet" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class SaveCircularServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String title = request.getParameter("title");
        String message = request.getParameter("message");
        String sendTo = request.getParameter("sendTo"); // Values: STUDENT, HOD, BOTH

        if (title == null || title.isEmpty() || message == null || message.trim().isEmpty()) {
            response.sendRedirect("admin-dashboard.jsp?status=error&msg=missing_fields");
            return;
        }

        String filePath = "";
        try {
            Part filePart = request.getPart("circularFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                if (fileName != null && !fileName.isEmpty()) {
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists())
                        uploadDir.mkdir();

                    String savedName = System.currentTimeMillis() + "_" + fileName;
                    filePart.write(uploadPath + File.separator + savedName);
                    filePath = "uploads/" + savedName;
                }
            }
        } catch (Exception e) {
            System.err.println("File upload error: " + e.getMessage());
        }

        // Translate BOTH to ALL for DAO
        String targetRole = "BOTH".equalsIgnoreCase(sendTo) ? "ALL" : sendTo;

        try {
            com.placementcell.dao.CircularDAO dao = new com.placementcell.dao.CircularDAO();
            dao.addCircular(title, message, targetRole, filePath);

            response.sendRedirect("admin-dashboard.jsp?status=success&msg=circular_posted");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-dashboard.jsp?status=error&msg=" + e.getMessage());
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
