package com.akansh.web.Servlets;

import com.akansh.web.Utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/ApprovalServlet")
public class ApprovalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int reqId = Integer.parseInt(request.getParameter("reqId"));
        String status = request.getParameter("action");
        System.out.println(reqId + "   " + status);
        Connection c = null;
        PreparedStatement p = null;
        ResultSet rs = null;
        String sql = "UPDATE requests SET status = ? WHERE id = ?";
        try {
            c = DBConnection.getConnection();
            p = c.prepareStatement(sql);
            p.setString(1, status);
            p.setInt(2, reqId);
            int flag = p.executeUpdate();
            if (flag > 0) {

                response.sendRedirect("pendingRequests.jsp");

            } else {
                response.sendRedirect("pendingRequests.jsp?error=Error while changing statusc");
            }


        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database access error", e);
        } finally {
            try {
                if (rs != null) rs.close();
                if (p != null) p.close();
                if (c != null) c.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }

}
