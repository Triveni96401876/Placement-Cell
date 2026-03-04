package com.placementcell.controller;

import com.placementcell.model.User;
import com.placementcell.util.DBConnection;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * AdminEditStudentServlet
 * Handles POST from admin-edit-student.jsp
 * Updates all student fields across: students, academic_details, and users
 * tables.
 */
@WebServlet("/AdminEditStudentServlet")
public class AdminEditStudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // --- Security Check ---
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.html");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("AdminDashboardServlet");
            return;
        }

        // --- Parse parameters ---
        String studentIdStr = request.getParameter("studentId");
        if (studentIdStr == null || studentIdStr.isEmpty()) {
            response.sendRedirect("AdminDashboardServlet?error=invalid");
            return;
        }
        long studentId = Long.parseLong(studentIdStr);

        String regNo = nvl(request.getParameter("regNo"));
        String fullName = nvl(request.getParameter("fullName"));
        String gender = nvl(request.getParameter("gender"));
        String dob = nvl(request.getParameter("dob"));
        String mobile = nvl(request.getParameter("mobile"));
        String altMobile = nvl(request.getParameter("altMobile"));
        String email = nvl(request.getParameter("email"));
        String address = nvl(request.getParameter("address"));
        String preference = nvl(request.getParameter("preference"));
        String placedCompany = nvl(request.getParameter("placedCompany"));
        String backlogHistory = nvl(request.getParameter("backlogHistory"));
        String branch = nvl(request.getParameter("branch"));

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

        // Auto-calculate diploma aggregate if not provided
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

        String backlogStatus = backlogs > 0 ? "ACTIVE" : "CLEARED";
        double cgpa = diplomaPct > 0 ? Math.round((diplomaPct / 10.0) * 100.0) / 100.0 : 0;

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                // 1. Fetch user_id from students table
                long userId = -1;
                String getUserIdSql = "SELECT user_id FROM students WHERE id = ?";
                try (PreparedStatement ps = conn.prepareStatement(getUserIdSql)) {
                    ps.setLong(1, studentId);
                    ResultSet rs = ps.executeQuery();
                    if (rs.next())
                        userId = rs.getLong("user_id");
                }

                // 2. Update students table
                String sqlStudents = "UPDATE students SET register_number=?, full_name=?, date_of_birth=?, " +
                        "gender=?, mobile_number=?, alternate_number=?, address=?, placed_company=?, branch=? WHERE id=?";
                try (PreparedStatement ps = conn.prepareStatement(sqlStudents)) {
                    ps.setString(1, regNo);
                    ps.setString(2, fullName);
                    if (!dob.isEmpty())
                        ps.setDate(3, Date.valueOf(dob));
                    else
                        ps.setNull(3, Types.DATE);
                    ps.setString(4, gender);
                    ps.setString(5, mobile);
                    ps.setString(6, altMobile);
                    ps.setString(7, address);
                    ps.setString(8, placedCompany);
                    ps.setString(9, branch);
                    ps.setLong(10, studentId);
                    ps.executeUpdate();
                }

                // 3. Check if academic_details row exists
                boolean adExists = false;
                String checkAd = "SELECT student_id FROM academic_details WHERE student_id=?";
                try (PreparedStatement ps = conn.prepareStatement(checkAd)) {
                    ps.setLong(1, studentId);
                    adExists = ps.executeQuery().next();
                }

                if (adExists) {
                    // 4a. UPDATE academic_details
                    String sqlAcademic = "UPDATE academic_details SET " +
                            "sslc_percentage=?, sslc_year=?, puc_percentage=?, puc_year=?, " +
                            "iti_percentage=?, iti_year=?, diploma_percentage=?, " +
                            "sem1=?, sem2=?, sem3=?, sem4=?, " +
                            "current_backlog_count=?, history_of_backlogs=?, backlog_status=?, " +
                            "preference=?, cgpa=? WHERE student_id=?";
                    try (PreparedStatement ps = conn.prepareStatement(sqlAcademic)) {
                        ps.setDouble(1, sslcPct);
                        ps.setInt(2, sslcYear);
                        ps.setDouble(3, pucPct);
                        ps.setInt(4, pucYear);
                        ps.setDouble(5, itiPct);
                        ps.setInt(6, itiYear);
                        ps.setDouble(7, diplomaPct);
                        ps.setDouble(8, sem1);
                        ps.setDouble(9, sem2);
                        ps.setDouble(10, sem3);
                        ps.setDouble(11, sem4);
                        ps.setInt(12, backlogs);
                        ps.setString(13, backlogHistory);
                        ps.setString(14, backlogStatus);
                        ps.setString(15, preference);
                        ps.setDouble(16, cgpa);
                        ps.setLong(17, studentId);
                        ps.executeUpdate();
                    }
                } else {
                    // 4b. INSERT into academic_details
                    String sqlInsert = "INSERT INTO academic_details (student_id, sslc_percentage, sslc_year, " +
                            "puc_percentage, puc_year, iti_percentage, iti_year, diploma_percentage, " +
                            "sem1, sem2, sem3, sem4, current_backlog_count, history_of_backlogs, " +
                            "backlog_status, preference, cgpa) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                    try (PreparedStatement ps = conn.prepareStatement(sqlInsert)) {
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
                        ps.setString(14, backlogHistory);
                        ps.setString(15, backlogStatus);
                        ps.setString(16, preference);
                        ps.setDouble(17, cgpa);
                        ps.executeUpdate();
                    }
                }

                // 5. Update email in users table
                if (userId != -1 && !email.isEmpty()) {
                    String sqlEmail = "UPDATE users SET email=? WHERE id=?";
                    try (PreparedStatement ps = conn.prepareStatement(sqlEmail)) {
                        ps.setString(1, email);
                        ps.setLong(2, userId);
                        ps.executeUpdate();
                    }
                }

                conn.commit();
                response.sendRedirect("AdminDashboardServlet?msg=updated");

            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
                response.sendRedirect("admin-edit-student.jsp?id=" + studentId + "&error=1");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("AdminDashboardServlet?error=db");
        }
    }

    // Helper: null-safe string
    private String nvl(String val) {
        return val != null ? val.trim() : "";
    }

    // Helper: parse double safely
    private double parseDouble(String val) {
        try {
            return (val != null && !val.trim().isEmpty()) ? Double.parseDouble(val.trim()) : 0;
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    // Helper: parse int safely
    private int parseInt(String val) {
        try {
            return (val != null && !val.trim().isEmpty()) ? Integer.parseInt(val.trim()) : 0;
        } catch (NumberFormatException e) {
            return 0;
        }
    }
}
