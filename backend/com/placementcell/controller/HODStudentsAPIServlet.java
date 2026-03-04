package com.placementcell.controller;

import com.placementcell.model.User;
import com.placementcell.util.DBConnection;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * HOD Students JSON API - returns live student data for AJAX polling
 * URL: /HODStudentsAPI?branch=Computer+Science
 */
@WebServlet("/HODStudentsAPI")
public class HODStudentsAPIServlet extends HttpServlet {

        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {

                // Security: only HOD can access
                HttpSession session = request.getSession(false);
                if (session == null || session.getAttribute("user") == null) {
                        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                        response.getWriter().write("{\"error\":\"Not authenticated\"}");
                        return;
                }
                User user = (User) session.getAttribute("user");
                if (!"HOD".equals(user.getRole()) && !"ADMIN".equals(user.getRole())) {
                        response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                        response.getWriter().write("{\"error\":\"Access denied\"}");
                        return;
                }

                response.setContentType("application/json;charset=UTF-8");
                response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

                String branch = request.getParameter("branch");
                if (branch != null)
                        branch = branch.trim();

                StringBuilder sql = new StringBuilder(
                                "SELECT s.id, s.register_number, s.full_name, s.branch, s.gender, s.date_of_birth, " +
                                                "s.mobile_number, s.alternate_number, s.address, " +
                                                "s.approval_status, s.placement_status, s.placed_company, s.internship, "
                                                +
                                                "u.email, " +
                                                "ad.sslc_percentage, ad.sslc_year, ad.puc_percentage, ad.puc_year, " +
                                                "ad.iti_percentage, ad.iti_year, ad.diploma_percentage, ad.diploma_year, "
                                                +
                                                "ad.sem1, ad.sem2, ad.sem3, ad.sem4, ad.sem5, ad.sem6, ad.cgpa, " +
                                                "ad.backlog_status, ad.current_backlog_count, ad.history_of_backlogs, ad.preference "
                                                +
                                                "FROM students s " +
                                                "JOIN users u ON s.user_id = u.id " +
                                                "LEFT JOIN academic_details ad ON s.id = ad.student_id " +
                                                "WHERE 1=1 ");

                if (branch != null && !branch.isEmpty()) {
                        String bLow = branch.toLowerCase();
                        if (bLow.contains("electrical") || bLow.contains("electronics") || bLow.contains("eee")) {
                                sql.append(" AND (LOWER(s.branch) LIKE '%electrical%' OR LOWER(s.branch) LIKE '%electronics%' OR LOWER(s.branch) LIKE '%eee%') ");
                        } else {
                                sql.append(" AND s.branch = ? ");
                        }
                }
                sql.append(" ORDER BY s.id DESC");

                PrintWriter out = response.getWriter();
                StringBuilder json = new StringBuilder();

                try (Connection conn = DBConnection.getConnection();
                                PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

                        if (branch != null && !branch.isEmpty()) {
                                String bLow = branch.toLowerCase();
                                if (!(bLow.contains("electrical") || bLow.contains("electronics")
                                                || bLow.contains("eee"))) {
                                        stmt.setString(1, branch);
                                }
                        }

                        ResultSet rs = stmt.executeQuery();
                        json.append("{\"students\":[");
                        boolean first = true;
                        int total = 0;

                        while (rs.next()) {
                                if (!first)
                                        json.append(",");
                                first = false;
                                total++;

                                String approvalStatus = rs.getString("approval_status");
                                if (approvalStatus == null)
                                        approvalStatus = "PENDING";

                                json.append("{");
                                json.append("\"id\":").append(rs.getLong("id")).append(",");
                                json.append("\"regNo\":\"").append(escJson(rs.getString("register_number")))
                                                .append("\",");
                                json.append("\"fullName\":\"").append(escJson(rs.getString("full_name"))).append("\",");
                                json.append("\"branch\":\"").append(escJson(rs.getString("branch"))).append("\",");
                                json.append("\"gender\":\"").append(escJson(rs.getString("gender"))).append("\",");
                                json.append("\"dob\":\"")
                                                .append(rs.getDate("date_of_birth") != null
                                                                ? rs.getDate("date_of_birth").toString()
                                                                : "")
                                                .append("\",");
                                json.append("\"mobile\":\"").append(escJson(rs.getString("mobile_number")))
                                                .append("\",");
                                json.append("\"alternateMobile\":\"").append(escJson(rs.getString("alternate_number")))
                                                .append("\",");
                                json.append("\"email\":\"").append(escJson(rs.getString("email"))).append("\",");
                                json.append("\"address\":\"").append(escJson(rs.getString("address"))).append("\",");
                                json.append("\"approvalStatus\":\"").append(escJson(approvalStatus)).append("\",");
                                json.append("\"placementStatus\":\"").append(escJson(rs.getString("placement_status")))
                                                .append("\",");
                                json.append("\"placedCompany\":\"").append(escJson(rs.getString("placed_company")))
                                                .append("\",");
                                json.append("\"internship\":\"").append(escJson(rs.getString("internship")))
                                                .append("\",");
                                json.append("\"preference\":\"").append(escJson(rs.getString("preference")))
                                                .append("\",");

                                // Academic details
                                json.append("\"sslc\":")
                                                .append(rs.getObject("sslc_percentage") != null
                                                                ? rs.getDouble("sslc_percentage")
                                                                : "null")
                                                .append(",");
                                json.append("\"sslcYear\":")
                                                .append(rs.getObject("sslc_year") != null ? rs.getInt("sslc_year")
                                                                : "null")
                                                .append(",");
                                json.append("\"puc\":")
                                                .append(rs.getObject("puc_percentage") != null
                                                                ? rs.getDouble("puc_percentage")
                                                                : "null")
                                                .append(",");
                                json.append("\"pucYear\":")
                                                .append(rs.getObject("puc_year") != null ? rs.getInt("puc_year")
                                                                : "null")
                                                .append(",");
                                json.append("\"iti\":")
                                                .append(rs.getObject("iti_percentage") != null
                                                                ? rs.getDouble("iti_percentage")
                                                                : "null")
                                                .append(",");
                                json.append("\"itiYear\":")
                                                .append(rs.getObject("iti_year") != null ? rs.getInt("iti_year")
                                                                : "null")
                                                .append(",");
                                json.append("\"diploma\":").append(
                                                rs.getObject("diploma_percentage") != null
                                                                ? rs.getDouble("diploma_percentage")
                                                                : "null")
                                                .append(",");
                                json.append("\"diplomaYear\":")
                                                .append(rs.getObject("diploma_year") != null ? rs.getInt("diploma_year")
                                                                : "null")
                                                .append(",");

                                json.append("\"sem1\":")
                                                .append(rs.getObject("sem1") != null ? rs.getDouble("sem1") : "null")
                                                .append(",");
                                json.append("\"sem2\":")
                                                .append(rs.getObject("sem2") != null ? rs.getDouble("sem2") : "null")
                                                .append(",");
                                json.append("\"sem3\":")
                                                .append(rs.getObject("sem3") != null ? rs.getDouble("sem3") : "null")
                                                .append(",");
                                json.append("\"sem4\":")
                                                .append(rs.getObject("sem4") != null ? rs.getDouble("sem4") : "null")
                                                .append(",");
                                json.append("\"sem5\":")
                                                .append(rs.getObject("sem5") != null ? rs.getDouble("sem5") : "null")
                                                .append(",");
                                json.append("\"sem6\":")
                                                .append(rs.getObject("sem6") != null ? rs.getDouble("sem6") : "null")
                                                .append(",");

                                double cgpa = rs.getDouble("cgpa");
                                json.append("\"cgpa\":")
                                                .append(rs.wasNull() ? "null"
                                                                : String.format(java.util.Locale.US, "%.2f", cgpa))
                                                .append(",");

                                json.append("\"backlogStatus\":\"").append(escJson(rs.getString("backlog_status")))
                                                .append("\",");
                                json.append("\"backlogs\":").append(
                                                rs.getObject("current_backlog_count") != null
                                                                ? rs.getInt("current_backlog_count")
                                                                : "null")
                                                .append(",");
                                json.append("\"backlogHistory\":\"")
                                                .append(escJson(rs.getString("history_of_backlogs"))).append("\"");

                                json.append("}");
                        }

                        json.append("],\"total\":").append(total).append(",\"branch\":\"")
                                        .append(branch != null ? escJson(branch) : "").append("\"}");

                } catch (Exception e) {
                        e.printStackTrace();
                        try {
                                response.getWriter()
                                                .write("{\"error\":\"" + escJson(e.getMessage())
                                                                + "\",\"students\":[],\"total\":0}");
                        } catch (IOException e1) {
                                e1.printStackTrace();
                        }
                        return;
                }

                out.write(json.toString());
        }

        private String escJson(String s) {
                if (s == null)
                        return "";
                return s.replace("\\", "\\\\").replace("\"", "\\\"")
                                .replace("\n", "\\n").replace("\r", "\\r").replace("\t", "\\t");
        }
}
