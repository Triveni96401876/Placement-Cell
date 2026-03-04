package com.placementcell.controller;

import com.placementcell.dao.StudentDAO;
import com.placementcell.dao.UserDAO;
import com.placementcell.model.Student;
import com.placementcell.model.User;
import com.placementcell.util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SimpleRegisterServlet")
public class SimpleRegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private StudentDAO studentDAO = new StudentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName") != null ? request.getParameter("fullName").trim() : "";
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
        String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : "";
        String branch = request.getParameter("branch") != null ? request.getParameter("branch").trim() : "";
        String password = request.getParameter("password") != null ? request.getParameter("password").trim() : "";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // 1. Create User
            User user = new User();
            user.setEmail(email);
            user.setPassword(password);
            user.setRole("STUDENT");
            Long userId = userDAO.registerUser(user);

            if (userId != null) {
                // 2. Create Student
                Student student = new Student();
                student.setUserId(userId);
                student.setFullName(fullName);
                student.setMobileNumber(phone);
                student.setBranch(branch);
                // Set default/dummy values for required DB fields not in simple form
                student.setRegisterNumber("TEMP-" + System.currentTimeMillis());
                student.setDateOfBirth(Date.valueOf("2000-01-01"));
                student.setGender("Other");

                studentDAO.registerStudent(student);
                conn.commit();

                // 3. Set session for auto-login (used after redirect)
                user.setId(userId);
                request.getSession().setAttribute("user", user);

                // Success redirect to registration page to show green success card
                response.sendRedirect("student-registration.jsp?status=success");
            } else {
                response.sendRedirect("student-registration.jsp?error=failed");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("student-registration.jsp?error=exception");
        }
    }
}
