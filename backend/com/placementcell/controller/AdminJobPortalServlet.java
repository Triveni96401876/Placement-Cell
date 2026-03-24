package com.placementcell.controller;

import com.placementcell.dao.JobDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet({ "/AdminJobPortalServlet", "/admin/AdminJobPortalServlet" })
public class AdminJobPortalServlet extends HttpServlet {
    private JobDAO jobDAO = new JobDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/student/login.jsp");
            return;
        }

        List<String[]> activeJobs = jobDAO.getAllJobs();
        request.setAttribute("activeJobs", activeJobs);
        request.getRequestDispatcher("/admin/admin-job-portal.jsp").forward(request, response);
    }
}
