package com.akansh.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseManager {
    private static final String URL = "jdbc:postgresql://localhost:5432/yourdb"; // Update with your database URL
    private static final String USER = "yourusername"; // Update with your database username
    private static final String PASSWORD = "yourpassword"; // Update with your database password

    // Method to establish a connection to the database
    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Method to close the connection (optional)
    public void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}