package com.placementcell.controller;

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

@WebServlet({ "/GetCircularServlet", "/getCircularServlet" })
public class GetCircularServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Get user role from session
        javax.servlet.http.HttpSession session = request.getSession(false);
        String userRole = "STUDENT"; // Default
        if (session != null && session.getAttribute("user") != null) {
            com.placementcell.model.User user = (com.placementcell.model.User) session.getAttribute("user");
            userRole = user.getRole();
        }

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT title, message, file_path, created_at FROM circulars " +
                    "WHERE is_active = TRUE AND (send_to = ? OR send_to = 'ALL') " +
                    "ORDER BY created_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userRole);
            ResultSet rs = stmt.executeQuery();

            StringBuilder json = new StringBuilder("{\"status\":\"success\", \"circulars\":[");
            boolean first = true;
            while (rs.next()) {
                if (!first)
                    json.append(",");
                first = false;

                String title = rs.getString("title") != null ? rs.getString("title") : "Important Update";
                String message = rs.getString("message") != null ? rs.getString("message") : "";
                String filePath = rs.getString("file_path") != null ? rs.getString("file_path") : "";
                String createdAt = rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toString() : "";

                // Escape for JSON
                title = title.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ");
                message = message.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n");
                filePath = filePath.replace("\\", "\\\\").replace("\"", "\\\"");

                json.append("{")
                        .append("\"title\":\"").append(title).append("\",")
                        .append("\"message\":\"").append(message).append("\",")
                        .append("\"filePath\":\"").append(filePath).append("\",")
                        .append("\"date\":\"").append(createdAt).append("\"")
                        .append("}");
            }
            json.append("]}");

            if (first) {
                out.print("{\"status\":\"none\"}");
            } else {
                out.print(json.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"status\":\"error\", \"message\":\"" + e.getMessage() + "\"}");
        } finally {
            if (conn != null)
                try {
                    conn.close();
                } catch (Exception e) {
                }
        }
    }
}
