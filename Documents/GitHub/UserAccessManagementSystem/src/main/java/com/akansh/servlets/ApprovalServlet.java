package com.akansh.servlets;

import com.akansh.utils.DatabaseManager;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ApprovalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int requestId = Integer.parseInt(request.getParameter("requestId"));
        String action = request.getParameter("action");

        DatabaseManager dbManager = new DatabaseManager();
        try (Connection conn = dbManager.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "UPDATE requests SET status=? WHERE id=?");
            ps.setString(1, action.equalsIgnoreCase("approve") ? "Approved" : "Rejected");
            ps.setInt(2, requestId);
            ps.executeUpdate();
            response.sendRedirect("pendingRequests.jsp?success=Request updated successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("pendingRequests.jsp?error=Error updating request: " + e.getMessage());
        }
    }
}