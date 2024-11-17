<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.akansh.web.Utils.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Software Creation</title>
    <link rel="stylesheet" href="styles/main.css">
    <script type="text/javascript">
        function handleLogout() {
            window.location.href = 'login.jsp';
            alert("Logged out");
        }
    </script>
</head>
<body class="sof">
<nav class="soft-nav-main">
    <div class="req-nav-left">
        <h1 >User Access Management System</h1>
    </div>
    <div class="req-nav-right">
        <button class="soft-admin-create" onclick=handleLogout()>Logout</button>
    </div>
</nav>

<main class="soft-admin-main">

    <%

        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String name = (String) session.getAttribute("name");
        String role = (String) session.getAttribute("role");

    %>

    <h1 class="soft-h1">Welcome <%= name %>
    </h1>
    <h2 class="soft-h2">Access Level: <%= role%>
    </h2>
    <div class="soft-button-container">
        <button class="soft-admin-create"
                onclick="document.getElementById('createForm').style.display='block';
                 document.getElementById('softwareList').style.display='none';">
            Create Software
        </button>
    </div>

    <%
        String errorMessage = request.getParameter("error");
        if (errorMessage != null) {
    %>
    <div style="color: red;">
       <h2><%=errorMessage%></h2>
    </div>
    <%
        }
    %>
    <div id="createForm" style="display: none;" class="soft-admin-form">

        <form action="SoftwareServlet" method="post">

            <div>
                <div>
                    <label for="softwareName">Enter your Software Name:</label> <input
                        type="text" id="softwareName" name="softwareName" required>
                </div>
                <div>
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" required></textarea>

                </div>
                <div>
                    <label for="levels">Choose Access level:</label> <input
                        type="radio" id="level_read" name="level" value="Read" checked>
                    <label for="level_read">Read</label> <input type="radio"
                                                                id="level_write" name="level" value="Write"> <label
                        for="level_write">Write</label> <input type="radio"
                                                               id="level_admin" name="level" value="Admin"> <label
                        for="level_admin">Admin</label>
                </div>

                <input class="soft-admin-create" type="submit" value="Create">

                <button class="soft-admin-create"
                        onclick="document.getElementById('createForm').style.display='none';
						document.getElementById('softwareList').style.display='block';">back
                </button>
            </div>
        </form>
    </div>

    <div id="softwareList" class="soft-admin-list">
        <h2>Software List</h2>
        <table class="soft-table" border="1">
            <tr class="soft-tr">
                <th class="soft-th">Software Name</th>
                <th class="soft-th">Description</th>
                <th class="soft-th">Access Level</th>
            </tr>
            <%
                Connection c = null;
                PreparedStatement p = null;
                ResultSet rs = null;
                String sql = "SELECT name , description , access_levels FROM software ";

                try {
                    c = DBConnection.getConnection();
                    p = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    rs = p.executeQuery();
                    while (rs.next()) {
                        String softwareName = rs.getString("name");
                        String description = rs.getString("description");
                        String level = rs.getString("access_levels");
            %>
            <tr class="soft-tr">
                <td class="soft-td"><%=softwareName%>
                </td>
                <td class="soft-td"><%=description%>
                </td>
                <td class="soft-td"><%=level%>
                </td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null)
                        try {
                            rs.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    if (p != null)
                        try {
                            p.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    if (c != null)
                        try {
                            c.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                }
            %>
        </table>


    </div>
</main>
</body>
</html>