<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration</title>
    <link rel="stylesheet" href="styles/main.css">
</head>
<body class="register">
<nav class="register-nav-main">
    <h1>User Access Management System</h1>
</nav>

<main class="login-main">
    <form action=SignUpServlet method="post">
        <div class="login-container"
             style=" background: linear-gradient(130deg, #3e0060, #380047); box-shadow: 0px 0px 46px 20px rgba(0,120,147,0.7); ">
            <h2>Register Here</h2>
            <%
                String errorMessage = request.getParameter("error");
                if (errorMessage != null) {
            %>
            <div style="color: red; text-align: center;">
                <%=errorMessage%>
            </div>
            <%
                }
            %>
            <div>
                <label for="username">Enter your Username:</label> <input
                    type="text" id="username" name="username" required>
            </div>
            <div>
                <label for="password">Enter your Password:</label>
                <input
                        type="password" id="password" name="password" required>
            </div>

            <input type="submit" value="Register"> <label>Already
            have account then <a href="login.jsp">Login</a>
        </label>
        </div>
    </form>
</main>
</body>

</html>
