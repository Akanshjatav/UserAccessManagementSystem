<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.akansh.web.Utils.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles/main.css">
    <title>Request Access</title>
    <script type="text/javascript">
        function showRequestForm(softwareId, softwareName) {
            document.getElementById('requestForm').style.display = 'block';
            document.getElementById('softwareList').style.display = 'none';
            document.getElementById('softwareId').value = softwareId;
            document.getElementById('softwareName').value = softwareName;
            document.getElementById('displaySoftwareName').innerText = softwareName;
        }

        function handleLogout() {
            window.location.href = 'login.jsp';
            alert("Logged out");
        }
    </script>
</head>
<body class="req">
<nav class="req-nav-main">
    <div class="req-nav-left">
        <h1> User Access Management System </h1>
    </div>
    <div class="req-nav-right">
        <button onclick="handleLogout()">Logout</button>
    </div>
</nav>

<main class="req-employee-main">
    <%
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String role = (String) session.getAttribute("role");
        String name = (String) session.getAttribute("name");
    %>

    <h1>Welcome <%= name %>
    </h1>
    <h2>Access Level: <%= role%>
    </h2>

    <div class="req-form-container">
        <div id="requestForm" style="display: none" class="req-employee-form">
            <form action="RequestServlet" method="post">
                <input type="hidden" id="softwareId" name="softwareId"> <input
                    type="hidden" id="softwareName" name="softwareName"> <input
                    type="hidden" id="userId" name="userId" value="<%=userId%>">
                <div>
                    <label>Software Name:</label> <span id="displaySoftwareName"></span>
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
                <div>
                    <label for="reason">Reason :</label>
                    <textarea id="reason" name="reason" required></textarea>

                </div>
                <input class="req-submit" type="submit" value="Request">
                <button class="req-button"
                        onclick="document.getElementById('requestForm').style.display='none';
						document.getElementById('softwareList').style.display='block';">back
                </button>

            </form>
        </div>
    </div>
    <div class="req-employee-container-list">
        <div id="softwareList" class="employee-list">
            <h2>Software List</h2>
            <table class="req-table" border="1">
                <tr class="req-tr">
                    <th class="req-th">Software Name</th>
                    <th class="req-th">Request</th>
                </tr>
                <%
                    Connection c = null;
                    PreparedStatement p = null;
                    ResultSet rs = null;

                    String sql = "SELECT s.id AS id, s.name AS name " + "FROM software s "
                            + "LEFT JOIN requests r ON r.software_id = s.id AND r.user_id = ? " + "WHERE r.id IS NULL;";

                    try {
                        c = DBConnection.getConnection();
                        p = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                        p.setInt(1, userId.intValue());
                        rs = p.executeQuery();

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String softwareName = rs.getString("name");
                %>
                <tr class="req-tr">
                    <td class="req-td"><%=softwareName%>
                    </td>

                    <td class="req-td">
                        <button class="req-button" onclick="showRequestForm(<%=id%>, '<%=softwareName%>')">Request
                            Software
                        </button>
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
    </div>

</main>
</body>
</html>
