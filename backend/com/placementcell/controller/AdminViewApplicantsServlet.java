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

@WebServlet({ "/AdminViewApplicantsServlet", "/admin/AdminViewApplicantsServlet" })
public class AdminViewApplicantsServlet extends HttpServlet {
    private JobDAO jobDAO = new JobDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/student/login.jsp");
            return;
        }

        String jobIdStr = request.getParameter("jobId");
        List<String[]> applicants;
        if (jobIdStr != null && !jobIdStr.isEmpty()) {
            int jobId = Integer.parseInt(jobIdStr);
            applicants = jobDAO.getApplicants(jobId);
        } else {
            applicants = jobDAO.getAllApplicants();
        }

        request.setAttribute("applicants", applicants);
        request.getRequestDispatcher("/admin/admin-view-applicants.jsp").forward(request, response);
    }
}
