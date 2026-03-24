package com.placementcell.controller;

import com.placementcell.dao.JobDAO;
import com.placementcell.util.DBConnection;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/JobPortalServlet")
public class JobPortalServlet extends HttpServlet {
    private JobDAO jobDAO = new JobDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<String[]> activeJobs = jobDAO.getAllJobs();
        request.setAttribute("activeJobs", activeJobs);
        request.getRequestDispatcher("/student/student-job-portal.jsp").forward(request, response);
    }
}
