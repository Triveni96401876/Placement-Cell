package com.placementcell.controller;

import com.placementcell.dao.StudentDAO;
import com.placementcell.dao.UserDAO;
import com.placementcell.model.Student;
import com.placementcell.model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private StudentDAO studentDAO = new StudentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if ("admin".equalsIgnoreCase(role)) {
            if ("nayeembashasir".equals(email) && "nayeembashasir".equals(password)) {
                HttpSession session = request.getSession();
                User adminUser = new User();
                adminUser.setId(0L); // Set ID to 0 for admin pseudo-account
                adminUser.setEmail(email);
                adminUser.setRole("ADMIN");
                adminUser.setFullName("Nayeem Basha");
                session.setAttribute("user", adminUser);
                session.setAttribute("userRole", "ADMIN");
                response.sendRedirect("AdminDashboardServlet");
                return;
            } else {
                response.sendRedirect("login.html?error=invalid_admin");
                return;
            }
        }

        try {
            User user = userDAO.authenticate(email, password);

            if (user != null) {
                // Log the login details
                String ipAddress = request.getRemoteAddr();
                userDAO.logLogin(user.getId(), user.getRole(), ipAddress);

                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("loginIp", ipAddress);
                session.setAttribute("loginTime", new java.util.Date().toString());

                if ("STUDENT".equals(user.getRole())) {
                    Student student = studentDAO.getStudentByUserId(user.getId());
                    session.setAttribute("student", student);
                    response.sendRedirect("DashboardServlet");
                } else if ("HOD".equals(user.getRole())) {
                    response.sendRedirect("HODDashboardServlet");
                } else {
                    response.sendRedirect("AdminDashboardServlet");
                }
            } else {
                response.sendRedirect("login.html?error=invalid_credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.html?error=server_error");
        }
    }
}
