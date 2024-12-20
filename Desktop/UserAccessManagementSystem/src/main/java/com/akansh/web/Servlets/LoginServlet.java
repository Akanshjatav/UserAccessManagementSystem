package com.akansh.web.Servlets;

import com.akansh.web.Utils.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = request.getParameter("username");
        String password = request.getParameter("password");
        Connection c = null;
        PreparedStatement p = null;
        ResultSet rs = null;
        String sql = "SELECT id, username, role  FROM users WHERE username=? AND password=?";

        try {
            c = DBConnection.getConnection();
            p = c.prepareStatement(sql);
            p.setString(1, userName);
            p.setString(2, password);
            rs = p.executeQuery();

            if (rs.next()) {
                int uid = rs.getInt("id");
                String role = rs.getString("role");
                String name = rs.getString("username");
                if (role != null) {
                    HttpSession session = request.getSession();
                    session.setAttribute("userId", uid);
                    session.setAttribute("name", name);
                    session.setAttribute("role", role);
                    if (role.equals("Employee")) {
                        response.sendRedirect("requestAccess.jsp");
                    } else if (role.equals("Manager")) {

                        response.sendRedirect("pendingRequests.jsp");
                    } else if (role.equals("Admin")) {

                        response.sendRedirect("createSoftware.jsp");
                    }

                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid username or password");
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
