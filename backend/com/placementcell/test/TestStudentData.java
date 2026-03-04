package com.placementcell.test;

import com.placementcell.dao.StudentDAO;
import com.placementcell.model.Student;
import java.sql.*;

public class TestStudentData {
    public static void main(String[] args) {
        try {
            // Test direct database query
            String url = "jdbc:mysql://localhost:3306/placement_cell?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
            Connection conn = DriverManager.getConnection(url, "root", "triveni9100@");

            String sql = "SELECT s.id, s.register_number, s.full_name, r.sslc_path, r.diploma_path, r.resume_path " +
                    "FROM students s LEFT JOIN resumes r ON s.id = r.student_id LIMIT 5";

            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);

            System.out.println("=== DIRECT DATABASE QUERY ===");
            while (rs.next()) {
                System.out.println("ID: " + rs.getLong("id"));
                System.out.println("RegNo: " + rs.getString("register_number"));
                System.out.println("Name: " + rs.getString("full_name"));
                System.out.println("SSLC Path: " + rs.getString("sslc_path"));
                System.out.println("Diploma Path: " + rs.getString("diploma_path"));
                System.out.println("Resume Path: " + rs.getString("resume_path"));
                System.out.println("---");
            }

            rs.close();
            stmt.close();
            conn.close();

            // Test using DAO
            System.out.println("\n=== USING DAO ===");
            StudentDAO dao = new StudentDAO();
            Student student = dao.getStudentById(1L);

            if (student != null) {
                System.out.println("Student ID: " + student.getId());
                System.out.println("Name: " + student.getFullName());
                System.out.println("RegNo: " + student.getRegisterNumber());
                System.out.println("SSLC Path: " + student.getSslcCardPath());
                System.out.println("Diploma Path: " + student.getDiplomaCardPath());
                System.out.println("Resume Path: " + student.getResumePath());
            } else {
                System.out.println("Student not found!");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
