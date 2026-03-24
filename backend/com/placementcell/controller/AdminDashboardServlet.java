package com.placementcell.controller;

import com.placementcell.model.Student;
import com.placementcell.model.User;
import com.placementcell.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet({ "/AdminDashboardServlet", "/admin/AdminDashboardServlet" })
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/admin-login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/DashboardServlet");
            return;
        }

        com.placementcell.dao.JobDAO jobDAO = new com.placementcell.dao.JobDAO();
        List<String[]> activeJobs = jobDAO.getAllJobs();
        request.setAttribute("activeJobs", activeJobs);
        request.setAttribute("totalJobsCount", activeJobs.size());

        // Filtering criteria
        String branch = request.getParameter("branch");
        String placementStatus = request.getParameter("placementStatus");
        String preference = request.getParameter("preference");
        String backlogs = request.getParameter("backlogs");
        String eligibility = request.getParameter("eligibility");
        String regNo = request.getParameter("regNo");

        List<Student> students = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT s.*, ad.*, u.email " +
                        "FROM students s " +
                        "JOIN users u ON s.user_id = u.id " +
                        "JOIN academic_details ad ON s.id = ad.student_id " +
                        "WHERE 1=1 ");

        if (branch != null && !branch.isEmpty()) {
            if ("Computer Science".equalsIgnoreCase(branch)) {
                sql.append(" AND s.branch = 'CSE' ");
            } else if ("Mechanical".equalsIgnoreCase(branch)) {
                sql.append(" AND s.branch = 'MECH' ");
            } else if ("Civil".equalsIgnoreCase(branch)) {
                sql.append(" AND s.branch = 'CIVIL' ");
            } else if ("Metallurgy".equalsIgnoreCase(branch)) {
                sql.append(" AND (s.branch = 'MT' OR s.branch = 'ECE' OR s.branch LIKE '%Metallurgy%') ");
            } else if (branch.toLowerCase().contains("electrical") || branch.toLowerCase().contains("eee")) {
                sql.append(" AND s.branch = 'EEE' ");
            } else {
                sql.append(" AND s.branch = ? ");
            }
        }

        if (placementStatus != null && !placementStatus.isEmpty()) {
            sql.append(" AND s.placement_status = ? ");
        }
        if (preference != null && !preference.isEmpty()) {
            sql.append(" AND s.preference = ? ");
        }
        if (backlogs != null && !backlogs.isEmpty()) {
            if ("0".equals(backlogs)) {
                sql.append(" AND (ad.current_backlog_count = 0 OR ad.current_backlog_count IS NULL) ");
            } else {
                sql.append(" AND ad.current_backlog_count > 0 ");
            }
        }
        if (eligibility != null && !eligibility.isEmpty()) {
            if ("eligible".equals(eligibility)) {
                sql.append(" AND ad.sslc_percentage >= 60 AND ad.diploma_percentage >= 60 ");
            } else if ("not_eligible".equals(eligibility)) {
                sql.append(
                        " AND (ad.sslc_percentage < 60 OR ad.diploma_percentage < 60 OR ad.sslc_percentage IS NULL OR ad.diploma_percentage IS NULL) ");
            }
        }
        if (regNo != null && !regNo.isEmpty()) {
            sql.append(" AND s.register_number LIKE ? ");
        }

        sql.append(" ORDER BY s.id DESC");

        try (Connection conn = DBConnection.getConnection()) {
            // Stats (Total, Placed, Circulars)
            int totalS = 0, placedS = 0, totalC = 0;
            try (PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM students")) {
                ResultSet rs = ps.executeQuery();
                if (rs.next())
                    totalS = rs.getInt(1);
            }
            try (PreparedStatement ps = conn
                    .prepareStatement("SELECT COUNT(*) FROM students WHERE placement_status = 'PLACED'")) {
                ResultSet rs = ps.executeQuery();
                if (rs.next())
                    placedS = rs.getInt(1);
            }
            try (PreparedStatement ps = conn
                    .prepareStatement("SELECT COUNT(*) FROM circulars WHERE is_active = TRUE")) {
                ResultSet rs = ps.executeQuery();
                if (rs.next())
                    totalC = rs.getInt(1);
            }
            request.setAttribute("totalStudents", totalS);
            request.setAttribute("placedStudents", placedS);
            request.setAttribute("totalCirculars", totalC);

            // 2. Fetch Student List (Affected by filters)
            System.out.println("DEBUG: Executing Admin SQL: " + sql.toString());
            try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
                int paramIndex = 1;
                if (branch != null && !branch.isEmpty()) {
                    boolean isPreDefined = branch.equalsIgnoreCase("Computer Science") ||
                            branch.equalsIgnoreCase("Mechanical") ||
                            branch.equalsIgnoreCase("Civil") ||
                            branch.equalsIgnoreCase("Metallurgy") ||
                            branch.toLowerCase().contains("electrical") ||
                            branch.toLowerCase().contains("eee");
                    if (!isPreDefined) {
                        stmt.setString(paramIndex++, branch);
                    }
                }
                if (placementStatus != null && !placementStatus.isEmpty())
                    stmt.setString(paramIndex++, placementStatus);
                if (preference != null && !preference.isEmpty())
                    stmt.setString(paramIndex++, preference);
                if (regNo != null && !regNo.isEmpty())
                    stmt.setString(paramIndex++, "%" + regNo + "%");

                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Student s = new Student();
                    s.setId(rs.getLong("id"));
                    s.setFullName(rs.getString("full_name"));
                    s.setRegisterNumber(rs.getString("register_number"));
                    s.setBranch(rs.getString("branch"));
                    s.setGender(rs.getString("gender"));
                    s.setDateOfBirth(rs.getDate("date_of_birth"));
                    s.setMobileNumber(rs.getString("mobile_number"));
                    s.setAlternativeMobileNumber(rs.getString("alternate_number"));
                    s.setAddress(rs.getString("address"));
                    s.setEmail(rs.getString("email"));
                    s.setPlacementStatus(rs.getString("placement_status"));
                    s.setPlacedCompany(rs.getString("placed_company"));
                    s.setInternship(rs.getString("internship"));
                    s.setPreference(rs.getString("preference"));

                    // Academic details
                    s.setSslcPercentage(
                            rs.getObject("sslc_percentage") != null ? rs.getDouble("sslc_percentage") : null);
                    s.setSslcYear(rs.getObject("sslc_year") != null ? rs.getInt("sslc_year") : null);
                    s.setPucPercentage(rs.getObject("puc_percentage") != null ? rs.getDouble("puc_percentage") : null);
                    s.setPucYear(rs.getObject("puc_year") != null ? rs.getInt("puc_year") : null);
                    s.setItiPercentage(rs.getObject("iti_percentage") != null ? rs.getDouble("iti_percentage") : null);
                    s.setItiYear(rs.getObject("iti_year") != null ? rs.getInt("iti_year") : null);
                    s.setDiplomaPercentage(
                            rs.getObject("diploma_percentage") != null ? rs.getDouble("diploma_percentage") : null);
                    s.setDiplomaYear(rs.getObject("diploma_year") != null ? rs.getInt("diploma_year") : null);
                    s.setSem1(rs.getObject("sem1") != null ? rs.getDouble("sem1") : 0.0);
                    s.setSem2(rs.getObject("sem2") != null ? rs.getDouble("sem2") : 0.0);
                    s.setSem3(rs.getObject("sem3") != null ? rs.getDouble("sem3") : 0.0);
                    s.setSem4(rs.getObject("sem4") != null ? rs.getDouble("sem4") : 0.0);
                    s.setSem5(rs.getObject("sem5") != null ? rs.getDouble("sem5") : 0.0);
                    s.setSem6(rs.getObject("sem6") != null ? rs.getDouble("sem6") : 0.0);
                    s.setCgpa(rs.getObject("cgpa") != null ? rs.getDouble("cgpa") : null);
                    s.setBacklogCount(
                            rs.getObject("current_backlog_count") != null ? rs.getInt("current_backlog_count") : null);
                    s.setBacklogHistory(rs.getString("history_of_backlogs"));
                    students.add(s);
                }
            } catch (SQLException e) {
                System.err.println("Error fetching student list: " + e.getMessage());
                e.printStackTrace();
            }

        } catch (SQLException e) {
            System.err.println("Fatal Database Error: " + e.getMessage());
            e.printStackTrace();
        }

        request.setAttribute("studentList", students);
        request.getRequestDispatcher("/admin/admin-dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
