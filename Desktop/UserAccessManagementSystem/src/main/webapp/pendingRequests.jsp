<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.akansh.web.Utils.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manager</title>
    <link rel="stylesheet" href="styles/main.css">
    <script type="text/javascript">
        function handleLogout() {
            window.location.href = 'login.jsp';
            alert("Logged out");
        }
    </script>
</head>

<body class="pend">
<nav class="pend-nav-main">
    <div class="req-nav-left">
        <h1> User Access Management System </h1>
    </div>

    <div class="req-nav-right">
        <button onclick=handleLogout()>Logout</button>
    </div>
</nav>
<main class="pend-manager-main">
    <%
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String name = (String) session.getAttribute("name");
        String role = (String) session.getAttribute("role");

    %>

    <h1>Hello <%= name %>
    </h1>
    <h2>Access Level: <%= role%>
    </h2>

    <div>
        <h2>Pending Requests List</h2>
        <%
            Connection c = null;
            PreparedStatement p = null;
            ResultSet rs = null;
            String sql = "SELECT r.id AS reqId, "
                    + "u.username AS employee_name, "
                    + "s.name AS software_name, "
                    + "r.access_type AS access_levels, "
                    + "r.reason AS reason "
                    + "FROM requests r "
                    + "JOIN users u ON r.user_id = u.id "
                    + "JOIN software s ON r.software_id = s.id "
                    + "WHERE r.status = 'Pending'";

            try {
                c = DBConnection.getConnection();
                p = c.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                rs = p.executeQuery();
                boolean hasNext = rs.next();
                if (!hasNext) {
        %>
        <h1 style="color:#010836; text-align: center;">No Pending requests</h1>
        <%
        } else {
        %>
        <table class="pend-table">
            <tr class="pend-tr">
                <th class="pend-th">Employee Name</th>
                <th class="pend-th">Software Name</th>
                <th class="pend-th">Access Type</th>
                <th class="pend-th">Reason</th>
                <th class="pend-th">Approve</th>
                <th class="pend-th">Reject</th>
            </tr>
            <%
                int count = 0;
                do {
                    count++;
                    int reqId = rs.getInt("reqId");
                    String employeeName = rs.getString("employee_name");
                    String softwareName = rs.getString("software_name");
                    String reason = rs.getString("reason");
                    String level = rs.getString("access_levels");
            %>
            <tr class="pend-tr">
                <td class="pend-td"><%=employeeName%>
                </td>
                <td class="pend-td"><%=softwareName%>
                </td>
                <td class="pend-td"><%=level%>
                </td>
                <td class="pend-td"><%=reason%>
                </td>
                <td class="pend-td">
                    <form action="ApprovalServlet" method="post">
                        <input type="hidden" name="reqId" value="<%=reqId%>">
                        <input type="hidden" name="action" value="Approved">
                        <button type="submit">Approve</button>
                    </form>
                </td>
                <td class="pend-td">
                    <form action="ApprovalServlet" method="post">
                        <input type="hidden" name="reqId" value="<%=reqId%>">
                        <input type="hidden" name="action" value="Rejected">
                        <button type="submit">Reject</button>
                    </form>
                </td>
            </tr>
            <%
                } while (rs.next());
            %>
        </table>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (p != null) try {
                    p.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (c != null) try {
                    c.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>

</main>

</body>
</html>