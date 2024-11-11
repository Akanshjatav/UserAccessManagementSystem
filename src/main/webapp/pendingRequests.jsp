<%--
  User: akans
  Date: 07/11/2024
  Time: 20:42
--%>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("role") == null || !session.getAttribute("role").equals("Manager")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pending Requests</title>
    <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
<h2>Pending Access Requests</h2>
<table border="1">
    <tr>
        <th>Employee Name</th>
        <th>Software Name</th>
        <th>Access Type</th>
        <th>Reason</th>
        <th>Action</th>
    </tr>
    <!-- Example row; replace with dynamic data from the database -->
    <tr>
        <td>John Doe</td>
        <td>Software 1</td>
        <td>Read</td>
        <td>Testing the application</td>
        <td>
            <form action="/ApprovalServlet" method="post" style="display:inline">
                <input type="hidden" name="request_id" value="1">
                <button type="submit" name="action" value="approve">Approve</button>
            </form>
            <form action="/ApprovalServlet" method="post" style="display:inline">
                <input type="hidden" name="request_id" value="1">
                <button type="submit" name="action" value="reject">Reject</button>
            </form>
        </td>
    </tr>
</table>
<a href="login.jsp">Logout</a>
</body>
</html>
