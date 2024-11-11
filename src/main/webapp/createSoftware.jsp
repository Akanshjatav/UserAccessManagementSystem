<%--
  User: akans
  Date: 07/11/2024
  Time: 20:40
=--%>
<%@ page session="true" contentType="text/html;charset=UTF-8" language="java" %>
<%
  if (session.getAttribute("role") == null || !session.getAttribute("role").equals("Admin")) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Create Software</title>
  <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
<h2>Create Software</h2>
<form action="/SoftwareServlet" method="post">
  <label>Software Name:</label>
  <input type="text" name="name" required>
  <br>
  <label>Description:</label>
  <textarea name="description"></textarea>
  <br>
  <label>Access Levels:</label>
  <input type="checkbox" name="access_levels" value="Read"> Read
  <input type="checkbox" name="access_levels" value="Write"> Write
  <input type="checkbox" name="access_levels" value="Admin"> Admin
  <br>
  <button type="submit">Add Software</button>
</form>
<a href="login.jsp">Logout</a>
</body>
</html>
