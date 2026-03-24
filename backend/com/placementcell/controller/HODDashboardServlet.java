package com.placementcell.controller;

import com.placementcell.model.Student;
import com.placementcell.model.User;
import com.placementcell.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet({ "/HODDashboardServlet", "/hodDashboardServlet" })
public class HODDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/hod/hod-login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"HOD".equals(user.getRole()) && !"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String branch = request.getParameter("branch");
        if (branch != null) {
            branch = branch.trim();
        }

        // Enforce branch filtering for HODs
        if ("HOD".equals(user.getRole())) {
            if (user.getBranch() != null && !user.getBranch().isEmpty()) {
                // HOD can only see their own branch
                branch = user.getBranch();
            }
        }

        // Normalize branch to match DB codes
        branch = normalizeBranch(branch);

        String statusFilter = request.getParameter("status");
        List<Student> students = new ArrayList<>();
        String name = request.getParameter("name");

        // Stats
        int totalReg = 0, approved = 0, pending = 0, rejected = 0, placed = 0;
        double totalCgpa = 0;
        int studentsWithCgpa = 0;

        // NOTE: students table uses "alternate_number" (not
        // "alternative_mobile_number")
        StringBuilder sql = new StringBuilder(
                "SELECT s.id, s.user_id, s.register_number, s.full_name, s.date_of_birth, " +
                        "s.gender, s.branch, s.mobile_number, s.alternate_number, s.address, " +
                        "s.approval_status, s.placement_status, s.placed_company, s.internship, " +
                        "u.email as user_email, " +
                        "ad.sslc_percentage, ad.sslc_year, ad.puc_percentage, ad.puc_year, " +
                        "ad.iti_percentage, ad.iti_year, ad.diploma_percentage, ad.diploma_year, " +
                        "ad.sem1, ad.sem2, ad.sem3, ad.sem4, ad.sem5, ad.sem6, " +
                        "ad.cgpa, ad.backlog_status, ad.current_backlog_count, ad.history_of_backlogs, ad.preference, "
                        +
                        "r.sslc_path, r.diploma_path, r.resume_path " +
                        "FROM students s " +
                        "JOIN users u ON s.user_id = u.id " +
                        "LEFT JOIN academic_details ad ON s.id = ad.student_id " +
                        "LEFT JOIN resumes r ON s.id = r.student_id " +
                        "WHERE 1=1 ");

        if (branch != null && !branch.isEmpty()) {
            sql.append(" AND s.branch = ? ");
        }

        if (name != null && !name.isEmpty()) {
            sql.append(" AND (LOWER(s.full_name) LIKE ? OR LOWER(s.register_number) LIKE ?) ");
        }

        sql.append(" ORDER BY s.id DESC");

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (branch != null && !branch.isEmpty()) {
                stmt.setString(paramIndex++, branch);
            }
            if (name != null && !name.isEmpty()) {
                String searchPattern = "%" + name.toLowerCase() + "%";
                stmt.setString(paramIndex++, searchPattern);
                stmt.setString(paramIndex++, searchPattern);
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Student s = new Student();
                String sStatus = rs.getString("approval_status");
                if (sStatus == null)
                    sStatus = "PENDING";

                s.setId(rs.getLong("id"));
                s.setFullName(rs.getString("full_name"));
                s.setRegisterNumber(rs.getString("register_number"));
                s.setBranch(rs.getString("branch"));
                s.setGender(rs.getString("gender"));
                s.setDateOfBirth(rs.getDate("date_of_birth"));
                s.setMobileNumber(rs.getString("mobile_number"));
                s.setAlternativeMobileNumber(rs.getString("alternate_number")); // correct column
                s.setAddress(rs.getString("address"));
                s.setEmail(rs.getString("user_email"));
                s.setApprovalStatus(sStatus);
                s.setPlacementStatus(rs.getString("placement_status"));
                s.setPlacedCompany(rs.getString("placed_company"));
                s.setInternship(rs.getString("internship"));

                // Academic details (may be NULL if not filled yet)
                double sslcVal = rs.getDouble("sslc_percentage");
                s.setSslcPercentage(rs.wasNull() ? null : sslcVal);

                double pucVal = rs.getDouble("puc_percentage");
                s.setPucPercentage(rs.wasNull() ? null : pucVal);

                double diplomaVal = rs.getDouble("diploma_percentage");
                s.setDiplomaPercentage(rs.wasNull() ? null : diplomaVal);

                double itiVal = rs.getDouble("iti_percentage");
                s.setItiPercentage(rs.wasNull() ? null : itiVal);

                s.setSem1(rs.wasNull() ? 0.0 : rs.getDouble("sem1"));
                rs.getDouble("sem1"); // read again for wasNull check workaround
                s.setSem2(rs.getDouble("sem2"));
                s.setSem3(rs.getDouble("sem3"));
                s.setSem4(rs.getDouble("sem4"));
                s.setSem5(rs.getDouble("sem5"));
                s.setSem6(rs.getDouble("sem6"));

                double cgpa = rs.getDouble("cgpa");
                if (!rs.wasNull() && cgpa > 0) {
                    s.setCgpa(cgpa);
                    totalCgpa += cgpa;
                    studentsWithCgpa++;
                }

                s.setBacklogStatus(rs.getString("backlog_status"));
                int backlogCount = rs.getInt("current_backlog_count");
                s.setBacklogCount(rs.wasNull() ? null : backlogCount);
                s.setBacklogHistory(rs.getString("history_of_backlogs"));
                s.setPreference(rs.getString("preference"));

                s.setSslcCardPath(rs.getString("sslc_path"));
                s.setDiplomaCardPath(rs.getString("diploma_path"));
                s.setResumePath(rs.getString("resume_path"));

                // Stats counting
                totalReg++;
                if ("APPROVED".equalsIgnoreCase(sStatus))
                    approved++;
                else if ("REJECTED".equalsIgnoreCase(sStatus))
                    rejected++;
                else
                    pending++;

                if ("PLACED".equalsIgnoreCase(rs.getString("placement_status")))
                    placed++;

                if (statusFilter == null || "TOTAL".equalsIgnoreCase(statusFilter)
                        || statusFilter.equalsIgnoreCase(sStatus)) {
                    students.add(s);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("dbError", e.getMessage());
        }

        double avgCgpa = studentsWithCgpa > 0 ? totalCgpa / studentsWithCgpa : 0.0;
        avgCgpa = Math.round(avgCgpa * 10.0) / 10.0;

        // Fetch Active Jobs count
        int activeJobsCount = 0;
        List<String[]> announcementsList = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            try (Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM announcements")) {
                if (rs.next())
                    activeJobsCount = rs.getInt(1);
            }
            try (Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(
                            "SELECT title, created_at FROM announcements ORDER BY created_at DESC LIMIT 10")) {
                while (rs.next()) {
                    announcementsList.add(new String[] {
                            rs.getString("title"),
                            rs.getTimestamp("created_at").toString()
                    });
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Fetch Job Applications
        com.placementcell.dao.JobDAO jobDAO = new com.placementcell.dao.JobDAO();
        List<String[]> jobApplicationsList;
        if (branch != null && !branch.isEmpty()) {
            jobApplicationsList = jobDAO.getApplicantsByBranch(branch);
        } else if (user.getBranch() != null && !user.getBranch().isEmpty()) {
            jobApplicationsList = jobDAO.getApplicantsByBranch(user.getBranch());
        } else {
            jobApplicationsList = jobDAO.getAllApplicants();
        }

        // Fetch circulars
        com.placementcell.dao.CircularDAO circularDAO = new com.placementcell.dao.CircularDAO();
        List<String[]> circularsList = circularDAO.getActiveCirculars("HOD");

        // Set attributes
        request.setAttribute("jobApplicationsList", jobApplicationsList);
        request.setAttribute("circularsList", circularsList);
        request.setAttribute("circularsCount", circularsList.size());
        request.setAttribute("totalReg", totalReg);
        request.setAttribute("approvedCount", approved);
        request.setAttribute("pendingCount", pending);
        request.setAttribute("rejectedCount", rejected);
        request.setAttribute("placedCount", placed);
        request.setAttribute("avgCgpa", avgCgpa);
        request.setAttribute("activeJobsCount", activeJobsCount);
        request.setAttribute("userName", user.getFullName() != null ? user.getFullName() : "HOD");
        request.setAttribute("userBranch", user.getBranch() != null ? user.getBranch() : "ALL");
        request.setAttribute("announcementsList", announcementsList);
        request.setAttribute("studentList", students);
        request.setAttribute("selectedBranch", branch != null ? branch : "");
        request.getRequestDispatcher("/hod/hod_dashboard.jsp").forward(request, response);
    }

    private String normalizeBranch(String branch) {
        if (branch == null || branch.isEmpty())
            return branch;
        String b = branch.toUpperCase().trim();
        if (b.contains("COMPUTER") || b.equals("CSE"))
            return "CSE";
        if (b.contains("MECHANICAL") || b.equals("MECH"))
            return "MECH";
        if (b.contains("CIVIL"))
            return "CIVIL";
        if (b.contains("METALLURGY") || b.equals("MT"))
            return "MT";
        if (b.contains("ELECTRICAL") || b.equals("EEE") || (b.contains("ELECTRONICS") && b.contains("ELECTRICAL")))
            return "EEE";
        if (b.contains("INFORMATION") || b.equals("IT"))
            return "IT";
        return branch;
    }
}
