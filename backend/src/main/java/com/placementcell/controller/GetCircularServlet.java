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

@WebServlet("/GetCircularServlet")
public class GetCircularServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            // Get latest active circular
            String sql = "SELECT message FROM circulars WHERE is_active = TRUE ORDER BY created_at DESC LIMIT 1";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String message = rs.getString("message");
                // Escape quotes for simple JSON compliance manually to avoid dependency issues
                // if Gson fails
                if (message != null) {
                    message = message.replace("\"", "\\\"").replace("\n", " ").replace("\r", "");
                } else {
                    message = "";
                }
                out.print("{\"status\":\"success\", \"message\":\"" + message + "\"}");
            } else {
                out.print("{\"status\":\"none\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Fallback for safety
            out.print("{\"status\":\"error\", \"message\":\"Server Error\"}");
        } finally {
            if (conn != null)
                try {
                    conn.close();
                } catch (Exception e) {
                }
        }
    }
}
