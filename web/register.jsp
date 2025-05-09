<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - EpicReads</title>
        <link rel="logo" sizes="180x180" href="./images/logo.png">
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light py-2 fixed-top shadow-sm">
            <div class="container">
                <div>
                    <a class="navbar-brand font-weight-bold" href="index.jsp"><span class="text-primary">Epic</span>Reads</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </div>
                <div class="w-100 d-flex" id="navbarNav">
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ml-auto d-flex align-items-center">
                            
                            <li class="nav-item">
                                <a class="nav-link" href="index.jsp">Home</a>
                            </li>
                   
                            <li class="nav-item">
                                <a class="btn btn-outline-primary nav-link text-white px-3" href="login.jsp">Sign in</a>
                            </li>

                        </ul>
                    </div>
                </div>
            </div>

        </nav>
        <div class="container">
            <div class="row no-gutters">
                <div class="d-flex flex-column justify-content-center col-md-5">
                    <img src="images/book1.png" class="img-fluid" alt="Illustration">
                </div>
                <div class="col-md-7">
                    <div class="d-flex align-items-center min-vh-100">
                        <div class="w-75 mx-auto px-4">
                            <h2 class="text-left mb-4">Sign-Up</h2>
                            <%
                                if (request.getParameter("s") != null) {
                                    String message;
                                    if (request.getParameter("s").equals("1")) {
                                        message = "<h6 class='text-success text-left'>You have successfully registered</h6>";
                                    } else {
                                        message = "<h6 class='text-danger text-center'>Error Occured. Please try again.</h6>";
                                    }
                                    out.println(message);
                                }
                            %>
                            <form action="registerProcess.jsp" method="post">
                                <div class="form-group">
                                    <label for="fname">First Name</label>
                                    <input type="text" class="form-control" id="name" name="fname" placeholder="Enter First name" required>
                                </div>
                                <div class="form-group">
                                    <label for="lname">Last Name</label>
                                    <input type="text" class="form-control" id="name" name="lname" placeholder="Enter Lastname" required>
                                </div>
                                <div class="form-group">
                                    <label for="email">Email address</label>
                                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter email" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="pwd" placeholder="Password" required>
                                </div>
                                <button type="submit" class="btn btn-primary btn-block font-weight-bold">Register</button>
                            </form>
                            <div class="text-center mt-3">
                                Already have an account? <a href="login.jsp">Login here</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
