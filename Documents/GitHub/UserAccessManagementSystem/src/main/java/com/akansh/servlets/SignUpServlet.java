package com.akansh.servlets;




import com.akansh.utils.DatabaseManager;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SignUpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = "Employee"; // Default role

        DatabaseManager dbManager = new DatabaseManager();
        try (Connection conn = dbManager.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO users (username, password, role) VALUES (?, ?, ?)");
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);
            ps.executeUpdate();
            response.sendRedirect("login.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("signup.jsp?error=Registration failed");
        }
    }
}