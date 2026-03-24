package com.placementcell.controller;

import com.placementcell.dao.JobDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({ "/DeleteJobServlet", "/admin/DeleteJobServlet" })
public class DeleteJobServlet extends HttpServlet {
    private JobDAO jobDAO = new JobDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            jobDAO.deleteJob(id);
        }
        response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardServlet?msg=deleted#manage-jobs-section");
    }
}
