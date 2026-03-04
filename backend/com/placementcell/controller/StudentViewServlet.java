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

/**
 * Servlet to handle viewing specific student details.
 * Prevents 400 Bad Request by validating parameters.
 */
@WebServlet("/studentViewServlet")
public class StudentViewServlet extends HttpServlet {
    private StudentDAO studentDAO = new StudentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.html");
            return;
        }

        User user = (User) session.getAttribute("user");
        String idParam = request.getParameter("id");

        // 1. Validation to avoid HTTP 400 or NullPointerException
        if (idParam == null || idParam.trim().isEmpty()) {
            // If ID is missing, we default to the logged-in student's ID
            // unless the user is an admin without an ID param
            if ("ADMIN".equals(user.getRole())) {
                request.setAttribute("errorMessage", "Error: No student ID provided for viewing.");
                request.getRequestDispatcher("login-dashboard.jsp").forward(request, response);
                return;
            } else {
                // For students, fetch their own record if ID is omitted
                Student s = (Student) session.getAttribute("student");
                if (s == null) {
                    s = studentDAO.getStudentByUserId(user.getId());
                }
                request.setAttribute("studentData", s);
                request.getRequestDispatcher("view-details.jsp").forward(request, response);
                return;
            }
        }

        try {
            Long studentId = Long.parseLong(idParam);
            Student student = studentDAO.getStudentById(studentId);

            if (student != null) {
                // Security check: Only allow users to view their own profile OR allow Admins to
                // view anyone
                if ("ADMIN".equals(user.getRole()) || "HOD".equals(user.getRole())
                        || student.getUserId().equals(user.getId())) {
                    request.setAttribute("studentData", student);
                    request.getRequestDispatcher("view-details.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied to this student's profile.");
                }
            } else {
                request.setAttribute("errorMessage", "Student record not found in the database.");
                request.getRequestDispatcher("login-dashboard.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            // Robust error handling to prevent 400 Bad Request
            request.setAttribute("errorMessage", "Invalid Student ID format. Please provide a numeric ID.");
            request.getRequestDispatcher("login-dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An unexpected error occurred.");
        }
    }
}
