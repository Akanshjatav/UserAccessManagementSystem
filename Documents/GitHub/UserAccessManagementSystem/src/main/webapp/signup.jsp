<%--
  User: akans
  Date: 07/11/2024
  Time: 20:40
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Sign Up</title>
  <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
<h2>Sign Up</h2>
<form action="SignUpServlet" method="post">
  <label>Username:</label>
  <input type="text" name="username" required>
  <br>
  <label>Password:</label>
  <input type="password" name="password" required>
  <br>
  <button type="submit">Sign Up</button>
</form>
<p>Already have an account? <a href="login.jsp">Log in here</a></p>
</body>
</html>

