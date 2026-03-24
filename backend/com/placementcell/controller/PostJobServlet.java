package com.placementcell.controller;

import com.placementcell.dao.JobDAO;
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

@WebServlet({ "/PostJobServlet", "/admin/PostJobServlet" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 10)
public class PostJobServlet extends HttpServlet {
    private JobDAO jobDAO = new JobDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/admin/admin-post-job.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/student/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/DashboardServlet");
            return;
        }

        String companyName = request.getParameter("companyName");
        String jobRole = request.getParameter("jobRole");
        String description = request.getParameter("description");
        String salary = request.getParameter("salary");
        String location = request.getParameter("location");
        String branch = request.getParameter("branch");
        String lastDate = request.getParameter("lastDate");
        String applyLink = request.getParameter("applyLink");

        Part filePart = request.getPart("companyLogo");
        String fileName = "";
        if (filePart != null && filePart.getSize() > 0) {
            String storagePath = getServletContext().getRealPath("/") + "uploads" + File.separator + "logos";
            File uploadDir = new File(storagePath);
            if (!uploadDir.exists())
                uploadDir.mkdirs();

            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            filePart.write(storagePath + File.separator + fileName);
            fileName = "uploads/logos/" + fileName;
        }

        boolean success = jobDAO.postJob(companyName, jobRole, description, salary, location, branch, lastDate,
                fileName);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardServlet?msg=job_posted#manage-jobs-section");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardServlet?error=post_failed#manage-jobs-section");
        }
    }
}
