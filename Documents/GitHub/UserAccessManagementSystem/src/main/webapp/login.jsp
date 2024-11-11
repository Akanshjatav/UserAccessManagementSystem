
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <link rel="stylesheet" href="assets/css/styles.css">
</head>
<body>
<h2>Login</h2>
<form action="/LoginServlet" method="post">
  <label>Username:</label>
  <input type="text" name="username" required>
  <br>
  <label>Password:</label>
  <input type="password" name="password" required>
  <br>
  <button type="submit">Login</button>
</form>
<%
  String error = request.getParameter("error");
  if (error != null) {
    out.println("<p style='color:red;'>" + error + "</p>");
  }
%>
<p>Don't have an account? <a href="signup.jsp">Sign up here</a></p>


</body>
</html>
