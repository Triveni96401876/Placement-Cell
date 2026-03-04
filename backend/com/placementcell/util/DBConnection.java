package com.placementcell.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // Database credentials
    private static final String URL = "jdbc:mysql://localhost:3306/placement_cell?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    // TODO: UPDATE THIS PASSWORD TO MATCH YOUR MYSQL INSTALLATION
    private static final String PASSWORD = "triveni9100@";

    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.err.println("MySQL JDBC Driver not found!");
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
