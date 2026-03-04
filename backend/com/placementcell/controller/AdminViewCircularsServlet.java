package com.placementcell.controller;

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

@WebServlet("/AdminViewCircularsServlet")
public class AdminViewCircularsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.html");
            return;
        }

        List<String[]> circulars = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(
                        "SELECT id, title, message, send_to, file_path, created_at FROM circulars ORDER BY created_at DESC")) {
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                circulars.add(new String[] {
                        rs.getString("id"),
                        rs.getString("title"),
                        rs.getString("message"),
                        rs.getString("send_to"),
                        rs.getString("file_path"),
                        rs.getTimestamp("created_at").toString()
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("circulars", circulars);
        request.getRequestDispatcher("admin-view-circulars.jsp").forward(request, response);
    }
}
