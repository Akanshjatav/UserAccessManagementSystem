package com.akansh.servlets;



import com.akansh.utils.DatabaseManager;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SoftwareServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String[] accessLevels = request.getParameterValues("accessLevels");

        DatabaseManager dbManager = new DatabaseManager();
        try (Connection conn = dbManager.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO software (name, description, access_levels) VALUES (?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, description);
            ps.setArray(3, conn.createArrayOf("text", accessLevels));
            ps.executeUpdate();
            response.sendRedirect("createSoftware.jsp?success=Software created successfully");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("createSoftware.jsp?error=Error creating software: " + e.getMessage());
        }
    }
}