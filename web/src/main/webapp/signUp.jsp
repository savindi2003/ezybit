<%--
  Created by IntelliJ IDEA.
  User: Savindi
  Date: 5/26/2025
  Time: 8:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign Up</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <style>
        body, html {
            height: 100%;
        }
        .centered-container {
            height: 100vh;
        }
        .form-side {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .image-side {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .image-side img {
            max-width: 100%;
            max-height: 100%;
        }
    </style>
</head>
<body>

<div class="container-fluid centered-container d-flex justify-content-center align-items-center">
    <div class="row w-75 shadow-lg rounded-4 overflow-hidden">

        <div class="col-12 d-flex justify-content-center align-items-center" style="height: 80px;">
            <img src="images/logo.png" class="img-fluid" style="height: 50px">
        </div>

        <!-- Left Image Side -->
        <div class="col-md-6 image-side bg-light">
            <img src="images/logo2.png" alt="Logo">
        </div>

        <!-- Right Form Side -->
        <div class="col-md-6 form-side bg-white p-5">

            <h3 class="mb-4">Sign Up</h3>
            <form method="post" action="signup">
                <div class="mb-3">
                    <label for="emailInput" class="form-label">Email</label>
                    <input type="email" name="username" class="form-control" id="emailInput" placeholder="name@example.com">
                </div>

                <div class="mb-3">
                    <label for="passwordInput" class="form-label">Password</label>
                    <input name="password" type="password" class="form-control" id="passwordInput" placeholder="••••••••">
                </div>

<%--                <button class="btn btn-primary w-100 mt-2">Sign Up</button>--%>
                <input type="submit" value="Register"/>

                <c:if test="${not empty msg}">
                    <p style="color:green">${msg}</p>
                </c:if>

                <div class="mb-3 col-12 text-center">
                    <span>Already have an Account?
                        <a href="signIn.jsp" class="text-primary"><b>Sign In</b></a>
                    </span>

                </div>

            </form>
        </div>

    </div>
</div>



</body>
</html>
