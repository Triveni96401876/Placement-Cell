package com.placementcell.controller;

import com.placementcell.dao.JobDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({ "/EditJobServlet", "/admin/EditJobServlet" })
public class EditJobServlet extends HttpServlet {
    private JobDAO jobDAO = new JobDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            String[] job = jobDAO.getJobById(id);
            request.setAttribute("job", job);
            request.getRequestDispatcher("/admin/admin-edit-job.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/AdminJobPortalServlet");
        }
    }
}
