<%--
  User: akans
  Date: 07/11/2024
  Time: 20:42
--%>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%
  if (session.getAttribute("role") == null || !session.getAttribute("role").equals("Employee")) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Request Access</title>
  <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
<h2>Request Access to Software</h2>
<form action="RequestServlet" method="post">
  <label>Software Name:</label>
  <select name="software_id" required>
    <!-- Populate with software options from database -->
    <option value="1">Software 1</option>
    <option value="2">Software 2</option>
  </select>
  <br>
  <label>Access Type:</label>
  <select name="access_type" required>
    <option value="Read">Read</option>
    <option value="Write">Write</option>
    <option value="Admin">Admin</option>
  </select>
  <br>
  <label>Reason for Request:</label>
  <textarea name="reason" required></textarea>
  <br>
  <button type="submit">Request Access</button>
</form>
<a href="login.jsp">Logout</a>
</body>
</html>
