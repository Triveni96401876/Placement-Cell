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
            // Get latest active circular for this role or ALL
            String sql = "SELECT title, message, file_path FROM circulars " +
                    "WHERE is_active = TRUE AND (send_to = ? OR send_to = 'ALL') " +
                    "ORDER BY created_at DESC LIMIT 1";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, userRole);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String title = rs.getString("title");
                String message = rs.getString("message");
                String filePath = rs.getString("file_path");

                // Basic cleaning for JSON
                if (title == null)
                    title = "Important Update";
                if (message == null)
                    message = "";
                if (filePath == null)
                    filePath = "";

                // Escape for JSON
                title = title.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ").replace("\r", "");
                message = message.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
                filePath = filePath.replace("\\", "\\\\").replace("\"", "\\\"");

                out.print("{\"status\":\"success\", \"title\":\"" + title + "\", \"message\":\"" + message
                        + "\", \"filePath\":\"" + filePath + "\"}");
            } else {
                out.print("{\"status\":\"none\"}");
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
