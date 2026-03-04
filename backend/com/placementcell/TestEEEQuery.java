package com.placementcell;

import com.placementcell.util.DBConnection;
import java.sql.*;

public class TestEEEQuery {
    public static void main(String[] args) {
        String branch = "Electrical & Electronics";

        StringBuilder sql = new StringBuilder(
                "SELECT s.id, s.register_number, s.full_name, s.branch " +
                        "FROM students s " +
                        "JOIN users u ON s.user_id = u.id " +
                        "LEFT JOIN academic_details ad ON s.id = ad.student_id " +
                        "WHERE 1=1 ");

        if (branch != null && !branch.isEmpty()) {
            if (branch.equalsIgnoreCase("Electrical & Electronics") || branch.toLowerCase().contains("electrical")) {
                sql.append(" AND (LOWER(s.branch) LIKE '%electrical%' OR LOWER(s.branch) LIKE '%electronics%') ");
            } else {
                sql.append(" AND s.branch = ? ");
            }
        }
        sql.append(" ORDER BY s.id DESC");

        System.out.println("SQL: " + sql.toString());

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            if (branch != null && !branch.isEmpty()) {
                if (!(branch.equalsIgnoreCase("Electrical & Electronics")
                        || branch.toLowerCase().contains("electrical"))) {
                    stmt.setString(1, branch);
                }
            }

            ResultSet rs = stmt.executeQuery();
            int count = 0;
            while (rs.next()) {
                count++;
                if (count <= 10) {
                    System.out.println("ID: " + rs.getLong("id") + " Name: " + rs.getString("full_name") + " Branch: "
                            + rs.getString("branch"));
                }
            }
            System.out.println("Total found: " + count);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
