package com.placementcell.controller;

import com.placementcell.dao.JobDAO;
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
import javax.servlet.http.Part;
import com.placementcell.util.DBConnection;

@WebServlet({ "/UpdateJobServlet", "/admin/UpdateJobServlet" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class UpdateJobServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardServlet");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String companyName = request.getParameter("companyName");
        String jobRole = request.getParameter("jobRole");
        String description = request.getParameter("description");
        String salary = request.getParameter("salary");
        String location = request.getParameter("location");
        String branch = request.getParameter("branch");
        String lastDate = request.getParameter("lastDate");
        String oldLogo = request.getParameter("oldLogo");

        Part filePart = request.getPart("companyLogo");
        String fileName = oldLogo;
        if (filePart != null && filePart.getSize() > 0) {
            String storagePath = getServletContext().getRealPath("/") + "uploads" + File.separator + "logos";
            File uploadDir = new File(storagePath);
            if (!uploadDir.exists())
                uploadDir.mkdirs();

            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            filePart.write(storagePath + File.separator + fileName);
            fileName = "uploads/logos/" + fileName;
        }

        String sql = "UPDATE jobs SET company_name=?, job_role=?, description=?, salary=?, location=?, branch=?, last_date=?, logo=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, companyName);
            pstmt.setString(2, jobRole);
            pstmt.setString(3, description);
            pstmt.setString(4, salary);
            pstmt.setString(5, location);
            pstmt.setString(6, branch);
            pstmt.setString(7, lastDate);
            pstmt.setString(8, fileName);
            pstmt.setInt(9, id);
            pstmt.executeUpdate();
            response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardServlet?msg=job_updated#manage-jobs-section");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardServlet?error=update_failed#manage-jobs-section");
        }
    }
}
