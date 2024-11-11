package com.akansh.servlets;


import com.akansh.utils.DatabaseManager;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RequestServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId")); // Get user ID from session or parameter
        int softwareId = Integer.parseInt(request.getParameter("softwareId"));
        String accessType = request.getParameter("accessType");
        String reason = request.getParameter("reason");

        DatabaseManager dbManager = new DatabaseManager();
        try (Connection conn = dbManager.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES (?, ?, ?, ?, 'Pending')");
            ps.setInt(1, userId);
            ps.setInt(2, softwareId);
            ps.setString(3, accessType);
            ps.setString(4, reason);
            ps.executeUpdate();
            response.sendRedirect("requestAccess.jsp?success=Request submitted successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("requestAccess.jsp?error=Error submitting request: " + e.getMessage());
        }
    }
}