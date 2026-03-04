package com.placementcell.controller;

import com.placementcell.dao.StudentDAO;
import com.placementcell.model.Student;
import com.placementcell.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/DocLockerDataServlet")
public class DocLockerDataServlet extends HttpServlet {
    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Access-Control-Allow-Origin", "http://localhost:1790");
        response.setHeader("Access-Control-Allow-Credentials", "true");
        response.setContentType("application/json;charset=UTF-8");

        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            out.print("{\"status\":\"error\",\"message\":\"Not logged in\"}");
            return;
        }

        User user = (User) session.getAttribute("user");
        Student student = studentDAO.getStudentByUserId(user.getId());

        if (student == null) {
            out.print("{\"status\":\"error\",\"message\":\"Student record not found\"}");
            return;
        }

        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"status\":\"success\",");
        sb.append("\"studentId\":").append(student.getId()).append(",");
        sb.append("\"documents\":{");
        sb.append("\"sslc\":").append(checkFile(student.getSslcCardPath())).append(",");
        sb.append("\"diploma\":").append(checkFile(student.getDiplomaCardPath())).append(",");
        sb.append("\"resume\":").append(checkFile(student.getResumePath()));
        sb.append("}");
        sb.append("}");

        out.print(sb.toString());
    }

    private String checkFile(String relativePath) {
        boolean dbRecord = (relativePath != null && !relativePath.isEmpty());
        boolean fileExists = false;
        if (dbRecord) {
            String storagePath = "C:" + File.separator + "placementcell_uploads" + File.separator + "documents";
            File file = new File(storagePath + File.separator + relativePath);
            fileExists = file.exists();
        }
        return String.format("{\"dbRecord\":%b,\"fileExists\":%b,\"path\":\"%s\"}",
                dbRecord, fileExists, (relativePath != null ? relativePath : ""));
    }
}
