package com.placementcell;

import com.placementcell.util.DBConnection;
import java.sql.*;

public class TestHODQuery {
    public static void main(String[] args) {
        String branch = "Computer Science";
        String sql = "SELECT s.id, s.register_number, s.full_name, ad.sem1, ad.sem2, ad.sem3, ad.sem4, ad.sem5, ad.sem6, ad.cgpa, ad.sslc_percentage, ad.puc_percentage, ad.diploma_percentage "
                +
                "FROM students s " +
                "LEFT JOIN academic_details ad ON s.id = ad.student_id " +
                "WHERE s.branch = ? " +
                "ORDER BY s.id DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, branch);
            System.out.println("Branch used: [" + branch + "]");

            ResultSet rs = stmt.executeQuery();
            int count = 0;
            while (rs.next()) {
                count++;
                if (count <= 10) {
                    System.out.println("Name: " + rs.getString("full_name"));
                    System.out.println("  Sem1: " + rs.getDouble("sem1") + (rs.wasNull() ? " (NULL)" : ""));
                    System.out.println("  Sem2: " + rs.getDouble("sem2") + (rs.wasNull() ? " (NULL)" : ""));
                    System.out.println("  CGPA: " + rs.getDouble("cgpa") + (rs.wasNull() ? " (NULL)" : ""));
                    System.out.println("--------------------------------");
                }
            }
            System.out.println("Total found: " + count);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
