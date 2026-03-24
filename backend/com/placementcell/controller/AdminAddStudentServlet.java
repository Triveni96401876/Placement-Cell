package com.placementcell.controller;

import com.placementcell.util.DBConnection;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * AdminAddStudentServlet
 * Handles admin-created student records with all Civil Dept fields.
 * Inserts into users, students, and academic_details tables.
 */
@WebServlet({ "/AdminAddStudentServlet", "/admin/AdminAddStudentServlet" })
public class AdminAddStudentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/admin/admin-add-student.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ---- Personal Info ----
        String regNo = nvl(request.getParameter("regNo"));
        String fullName = nvl(request.getParameter("fullName"));
        String dob = nvl(request.getParameter("dob"));
        String gender = nvl(request.getParameter("gender"));
        String mobile = nvl(request.getParameter("mobile"));
        String altMobile = nvl(request.getParameter("altMobile"));
        String email = nvl(request.getParameter("email"));
        String address = nvl(request.getParameter("address"));
        String preference = nvl(request.getParameter("preference"));
        String placedCompany = nvl(request.getParameter("placedCompany"));
        String backlogHistory = nvl(request.getParameter("backlogHistory"));
        String branch = nvl(request.getParameter("branch"));

        // ---- Academic Info ----
        double sslcPct = parseDouble(request.getParameter("sslc"));
        int sslcYear = parseInt(request.getParameter("sslcYear"));
        double pucPct = parseDouble(request.getParameter("puc"));
        int pucYear = parseInt(request.getParameter("pucYear"));
        double itiPct = parseDouble(request.getParameter("iti"));
        int itiYear = parseInt(request.getParameter("itiYear"));
        double sem1 = parseDouble(request.getParameter("sem1"));
        double sem2 = parseDouble(request.getParameter("sem2"));
        double sem3 = parseDouble(request.getParameter("sem3"));
        double sem4 = parseDouble(request.getParameter("sem4"));
        double diplomaPct = parseDouble(request.getParameter("diploma"));
        int backlogs = parseInt(request.getParameter("backlogs"));

        // Auto-calculate diploma aggregate from semesters if not provided
        if (diplomaPct == 0 && (sem1 + sem2 + sem3 + sem4) > 0) {
            int cnt = 0;
            double sum = 0;
            if (sem1 > 0) {
                sum += sem1;
                cnt++;
            }
            if (sem2 > 0) {
                sum += sem2;
                cnt++;
            }
            if (sem3 > 0) {
                sum += sem3;
                cnt++;
            }
            if (sem4 > 0) {
                sum += sem4;
                cnt++;
            }
            if (cnt > 0)
                diplomaPct = Math.round((sum / cnt) * 100.0) / 100.0;
        }

        // Derived fields
        String backlogStatus = backlogs > 0 ? "ACTIVE" : "CLEARED";
        double cgpa = diplomaPct > 0 ? Math.round((diplomaPct / 10.0) * 100.0) / 100.0 : 0;

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // Step 1: Insert into users table
                String userSql = "INSERT INTO users (email, password, role) VALUES (?, ?, 'STUDENT')";
                long userId = -1;
                try (PreparedStatement ps = conn.prepareStatement(userSql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, email.isEmpty() ? regNo + "@sgp.edu.in" : email);
                    ps.setString(2, "Welcome@123"); // Default password
                    ps.executeUpdate();
                    ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next())
                        userId = rs.getLong(1);
                }

                if (userId == -1)
                    throw new Exception("Failed to create user account.");

                // Step 2: Insert into students table
                String studentSql = "INSERT INTO students " +
                        "(user_id, register_number, full_name, date_of_birth, gender, branch, " +
                        "mobile_number, alternate_number, address, placed_company) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                long studentId = -1;
                try (PreparedStatement ps = conn.prepareStatement(studentSql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setLong(1, userId);
                    ps.setString(2, regNo);
                    ps.setString(3, fullName);
                    if (!dob.isEmpty())
                        ps.setDate(4, Date.valueOf(dob));
                    else
                        ps.setNull(4, Types.DATE);
                    ps.setString(5, gender);
                    ps.setString(6, branch.isEmpty() ? "Civil Engg" : branch);
                    ps.setString(7, mobile);
                    ps.setString(8, altMobile);
                    ps.setString(9, address);
                    ps.setString(10, placedCompany.isEmpty() ? null : placedCompany);
                    ps.executeUpdate();
                    ResultSet rs = ps.getGeneratedKeys();
                    if (rs.next())
                        studentId = rs.getLong(1);
                }

                if (studentId == -1)
                    throw new Exception("Failed to create student record.");

                // Step 3: Insert into academic_details table
                String academicSql = "INSERT INTO academic_details " +
                        "(student_id, sslc_percentage, sslc_year, puc_percentage, puc_year, " +
                        "iti_percentage, iti_year, diploma_percentage, " +
                        "sem1, sem2, sem3, sem4, " +
                        "current_backlog_count, history_of_backlogs, backlog_status, " +
                        "preference, cgpa) " +
                        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = conn.prepareStatement(academicSql)) {
                    ps.setLong(1, studentId);
                    ps.setDouble(2, sslcPct);
                    ps.setInt(3, sslcYear);
                    ps.setDouble(4, pucPct);
                    ps.setInt(5, pucYear);
                    ps.setDouble(6, itiPct);
                    ps.setInt(7, itiYear);
                    ps.setDouble(8, diplomaPct);
                    ps.setDouble(9, sem1);
                    ps.setDouble(10, sem2);
                    ps.setDouble(11, sem3);
                    ps.setDouble(12, sem4);
                    ps.setInt(13, backlogs);
                    ps.setString(14, backlogHistory.isEmpty() ? "NO" : backlogHistory);
                    ps.setString(15, backlogStatus);
                    ps.setString(16, preference.isEmpty() ? "JOB" : preference);
                    ps.setDouble(17, cgpa);
                    ps.executeUpdate();
                }

                conn.commit();
                response.sendRedirect(request.getContextPath() + "/admin/AdminDashboardServlet?msg=added");

            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin/admin-add-student.jsp?error=1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/admin-add-student.jsp?error=db");
        }
    }

    private String nvl(String val) {
        return val != null ? val.trim() : "";
    }

    private double parseDouble(String val) {
        try {
            return (val != null && !val.trim().isEmpty()) ? Double.parseDouble(val.trim()) : 0;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    private int parseInt(String val) {
        try {
            return (val != null && !val.trim().isEmpty()) ? Integer.parseInt(val.trim()) : 0;
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
