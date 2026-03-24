package com.placementcell.controller;

import com.placementcell.dao.StudentDAO;
import com.placementcell.model.Student;
import com.placementcell.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/student/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        Student student = studentDAO.getStudentByUserId(user.getId());
        if (student != null) {
            session.setAttribute("student", student);
        }

        request.setAttribute("studentData", student);
        request.getRequestDispatcher("/student/login-dashboard.jsp").forward(request, response);
    }
}
