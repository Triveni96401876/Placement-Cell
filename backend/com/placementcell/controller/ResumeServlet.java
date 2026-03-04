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

@WebServlet("/ResumeServlet")
public class ResumeServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || (session.getAttribute("user") == null && session.getAttribute("student") == null)) {
            response.sendRedirect("login.html");
            return;
        }

        User user = (User) session.getAttribute("user");
        Student student = null;

        String studentIdParam = request.getParameter("id");
        if (studentIdParam != null && "ADMIN".equals(user.getRole())) {
            // Admin is viewing a specific student by Student ID
            student = studentDAO.getStudentById(Long.parseLong(studentIdParam));
        } else {
            // Default: View own profile
            student = (Student) session.getAttribute("student");
            if (student == null && user != null) {
                student = studentDAO.getStudentByUserId(user.getId());
            }
        }

        if (student != null) {
            request.setAttribute("studentResume", student);
            request.getRequestDispatcher("resume-view.jsp").forward(request, response);
        } else {
            response.sendRedirect("DashboardServlet?error=student_not_found");
        }
    }
}
