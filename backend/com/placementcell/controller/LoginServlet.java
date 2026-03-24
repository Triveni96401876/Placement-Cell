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

public class LoginServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private StudentDAO studentDAO = new StudentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().println("LoginServlet is alive! Context Path: " + request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if ("admin".equalsIgnoreCase(role) && "nayeembashasir".equals(email)) {
            if ("nayeembashasir".equals(password)) {
                HttpSession session = request.getSession();
                User adminUser = new User();
                adminUser.setId(0L); // Set ID to 0 for admin pseudo-account
                adminUser.setEmail(email);
                adminUser.setRole("ADMIN");
                adminUser.setFullName("Nayeem Basha");
                session.setAttribute("user", adminUser);
                session.setAttribute("userRole", "ADMIN");
                response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
                return;
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/admin-login.jsp?error=invalid_credentials");
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
                    if (student != null) {
                        session.setAttribute("student", student);
                    }
                    response.sendRedirect(request.getContextPath() + "/DashboardServlet");
                } else if ("HOD".equals(user.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/HODDashboardServlet");
                } else {
                    response.sendRedirect(request.getContextPath() + "/AdminDashboardServlet");
                }
            } else {
                String errorUrl = "/student/login.jsp";
                if ("admin".equalsIgnoreCase(role)) errorUrl = "/admin/admin-login.jsp";
                else if ("HOD".equalsIgnoreCase(role)) errorUrl = "/hod/hod-login.jsp";
                response.sendRedirect(request.getContextPath() + errorUrl + "?error=invalid_credentials");
            }
        } catch (Exception e) {
            e.printStackTrace();
            String errorUrl = "/student/login.jsp";
            if ("admin".equalsIgnoreCase(role)) errorUrl = "/admin/admin-login.jsp";
            else if ("HOD".equalsIgnoreCase(role)) errorUrl = "/hod/hod-login.jsp";
            response.sendRedirect(request.getContextPath() + errorUrl + "?error=server_error");
        }
    }
}
