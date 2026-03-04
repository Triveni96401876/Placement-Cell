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

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.html");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect("DashboardServlet");
            return;
        }

        // Filtering criteria
        String branch = request.getParameter("branch");
        String minCgpa = request.getParameter("minCgpa");
        String minSslc = request.getParameter("minSslc");
        String minPuc = request.getParameter("minPuc");
        String placementStatus = request.getParameter("placementStatus");
        String preference = request.getParameter("preference");
        String backlogs = request.getParameter("backlogs");
        String regNo = request.getParameter("regNo");
        String emailFilter = request.getParameter("email");

        List<Student> students = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT s.*, ad.*, u.email, r.sslc_path, r.diploma_path, r.resume_path, r.resume_description " +
                        "FROM students s " +
                        "JOIN users u ON s.user_id = u.id " +
                        "JOIN academic_details ad ON s.id = ad.student_id " +
                        "LEFT JOIN resumes r ON s.id = r.student_id " +
                        "WHERE 1=1 ");

        // Finalize query after all filters are added
        // (Wait, I need to append this at the end of the query string construction)

        if (branch != null && !branch.isEmpty()) {
            String bLow = branch.toLowerCase();
            if (bLow.contains("electrical") || bLow.contains("electronics") || bLow.contains("eee")) {
                sql.append(
                        " AND (LOWER(s.branch) LIKE '%electrical%' OR LOWER(s.branch) LIKE '%electronics%' OR LOWER(s.branch) LIKE '%eee%') ");
            } else {
                sql.append(" AND s.branch = ? ");
            }
        }
        if (minCgpa != null && !minCgpa.isEmpty())
            sql.append(" AND ad.cgpa >= ? ");
        if (minSslc != null && !minSslc.isEmpty())
            sql.append(" AND ad.sslc_percentage >= ? ");
        if (minPuc != null && !minPuc.isEmpty())
            sql.append(" AND ad.puc_percentage >= ? ");
        if (placementStatus != null && !placementStatus.isEmpty())
            sql.append(" AND s.placement_status = ? ");
        if (preference != null && !preference.isEmpty())
            sql.append(" AND s.preference = ? ");
        if (backlogs != null && !backlogs.isEmpty()) {
            if ("0".equals(backlogs)) {
                sql.append(" AND (ad.current_backlog_count = 0 OR ad.current_backlog_count IS NULL) ");
            } else {
                sql.append(" AND ad.current_backlog_count > 0 ");
            }
        }
        if (regNo != null && !regNo.isEmpty())
            sql.append(" AND s.register_number LIKE ? ");
        if (emailFilter != null && !emailFilter.isEmpty())
            sql.append(" AND u.email LIKE ? ");

        sql.append(" ORDER BY s.id DESC");

        try (Connection conn = DBConnection.getConnection()) {
            // 1. Fetch Dashboard Stats first (Independent of filters)
            int totalStudents = 0;
            int placedStudents = 0;
            int totalCirculars = 0;

            try (PreparedStatement statStmt = conn.prepareStatement("SELECT COUNT(*) FROM students")) {
                ResultSet res = statStmt.executeQuery();
                if (res.next())
                    totalStudents = res.getInt(1);
            } catch (Exception e) {
                System.err.println("Error fetching totalStudents: " + e.getMessage());
            }

            try (PreparedStatement statStmt = conn
                    .prepareStatement("SELECT COUNT(*) FROM students WHERE placement_status = 'PLACED'")) {
                ResultSet res = statStmt.executeQuery();
                if (res.next())
                    placedStudents = res.getInt(1);
            } catch (Exception e) {
                System.err.println("Error fetching placedStudents: " + e.getMessage());
            }

            try (PreparedStatement statStmt = conn
                    .prepareStatement("SELECT COUNT(*) FROM circulars WHERE is_active = TRUE")) {
                ResultSet res = statStmt.executeQuery();
                if (res.next())
                    totalCirculars = res.getInt(1);
            } catch (Exception e) {
                System.err.println("Error fetching totalCirculars: " + e.getMessage());
            }

            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("placedStudents", placedStudents);
            request.setAttribute("totalCirculars", totalCirculars);

            // 2. Fetch Student List (Affected by filters)
            try (PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
                int paramIndex = 1;
                if (branch != null && !branch.isEmpty()) {
                    String bLow = branch.toLowerCase();
                    if (!(bLow.contains("electrical") || bLow.contains("electronics") || bLow.contains("eee"))) {
                        stmt.setString(paramIndex++, branch);
                    }
                }
                if (minCgpa != null && !minCgpa.isEmpty())
                    stmt.setDouble(paramIndex++, Double.parseDouble(minCgpa));
                if (minSslc != null && !minSslc.isEmpty())
                    stmt.setDouble(paramIndex++, Double.parseDouble(minSslc));
                if (minPuc != null && !minPuc.isEmpty())
                    stmt.setDouble(paramIndex++, Double.parseDouble(minPuc));
                if (placementStatus != null && !placementStatus.isEmpty())
                    stmt.setString(paramIndex++, placementStatus);
                if (preference != null && !preference.isEmpty())
                    stmt.setString(paramIndex++, preference);
                if (regNo != null && !regNo.isEmpty())
                    stmt.setString(paramIndex++, "%" + regNo + "%");
                if (emailFilter != null && !emailFilter.isEmpty())
                    stmt.setString(paramIndex++, "%" + emailFilter + "%");

                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Student s = new Student();
                    s.setId(rs.getLong("id"));
                    s.setFullName(rs.getString("full_name"));
                    s.setRegisterNumber(rs.getString("register_number"));
                    s.setBranch(rs.getString("branch"));
                    s.setMobileNumber(rs.getString("mobile_number"));
                    s.setAlternativeMobileNumber(rs.getString("alternate_number"));
                    // Safe double/int retrieval
                    s.setCgpa(rs.getDouble("cgpa"));
                    s.setSslcPercentage(rs.getDouble("sslc_percentage"));
                    s.setPucPercentage(rs.getDouble("puc_percentage"));
                    s.setPlacementStatus(rs.getString("placement_status"));
                    s.setPlacedCompany(rs.getString("placed_company"));
                    s.setPreference(rs.getString("preference"));
                    s.setEmail(rs.getString("email"));
                    s.setAddress(rs.getString("address"));
                    s.setGender(rs.getString("gender"));
                    s.setDateOfBirth(rs.getDate("date_of_birth"));
                    s.setBacklogCount(rs.getInt("current_backlog_count"));
                    s.setBacklogHistory(rs.getString("history_of_backlogs"));
                    s.setSem1(rs.getDouble("sem1"));
                    s.setSem2(rs.getDouble("sem2"));
                    s.setSem3(rs.getDouble("sem3"));
                    s.setSem4(rs.getDouble("sem4"));
                    s.setSem5(rs.getDouble("sem5"));
                    s.setSem6(rs.getDouble("sem6"));
                    s.setInternship(rs.getString("internship"));
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
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }
}
