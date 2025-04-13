<%@page import="app.classes.DbConnector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, app.classes.User, app.classes.Orders, java.util.List" %>
<%
    // Retrieve userId from session
    Integer userId = (Integer) session.getAttribute("userID");
    User user = null;
    List<Orders> ordersList = null;

    if (userId != null) {
        // Fetch user details using userId
        user = new User();
        user.setId(userId);
        user = user.getUserById(DbConnector.getConnection());

        // Fetch orders using userId
        ordersList = Orders.getOrdersByUserId(DbConnector.getConnection(), userId);

    } else {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link rel="logo" sizes="180x180" href="./images/logo.png">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <link rel="stylesheet" href="./styles.css">
    <style>
        .profile-card {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .profile-image {
            max-width: 250px;
            max-height: 300px;
            border-radius: 10px;
        }
    </style>
</head>

<body>
    <nav class=" navbar navbar-expand-lg navbar-light bg-light py-2 shadow-sm">
        <div class="container">
            <div>
                <a class="navbar-brand font-weight-bold" href="#"><span
                        class="text-primary">Epic</span>Reads</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>

            <div class="w-100 d-flex" id="navbarNav">
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ml-auto d-flex align-items-center">
                        <%
                            if (session.getAttribute("userID") != null) {

                        %>
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#explore">Shop</a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="bi bi-person-circle h3" ></i>
                            </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <a class="dropdown-item" href="user_profile.jsp">Profile</a>
                                <a class="dropdown-item" href="logout.jsp">Logout</a>
                            </div>
                        </li>
                        <% } else { %>
                        <li class="nav-item">
                            <a class="nav-link" href="#">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#explore">Shop</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#about">About</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-primary nav-link text-white px-3" href="login.jsp">Sign in</a>
                        </li>
                        <% }%>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2 class="mb-4">My Profile</h2>
        <div class="card profile-card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 text-center mb-3">
                        <img src="./images/profilePic.jpg" alt="profile pic" class="img-fluid profile-image" id="profileImage">
                        <h3 class="mt-3"><%= user != null ? user.getFirstname() + " " + user.getLastname() : "User" %></h3>
                    </div>
                    <div class="col-md-8 mt-5">
                        <form id="profileForm" action="updateUser.jsp" method="post">
                            <div class="mb-3 row">
                                <label class="col-sm-3 col-form-label">First Name</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="firstName" value="<%= user != null ? user.getFirstname() : "" %>" name="firstName" readonly>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label class="col-sm-3 col-form-label">Last Name</label>
                                <div class="col-sm-9">
                                    <input type="text" class="form-control" id="lastName" value="<%= user != null ? user.getLastname() : "" %>" name="lastName" readonly>
                                </div>
                            </div>
                            <div class="mb-3 row">
                                <label class="col-sm-3 col-form-label">Email:</label>
                                <div class="col-sm-9">
                                    <input type="email" class="form-control" id="email" value="<%= user != null ? user.getEmail() : "" %>" name="email" readonly>
                                </div>
                            </div>
                            <input type="hidden" name="userId" value="<%= userId %>">
                        </form>
                    </div>
                    
                    <div class="text-end">
                        <%
                            if (request.getParameter("s") != null) {
                                String message;
                                if (request.getParameter("s").equals("1")) {
                                    message = "<h6 class='text-success text-left'>Profile Updated Successfully</h6>";
                                } else {
                                    message = "<h6 class='text-danger text-center'>Error Occured. Please try again.</h6>";
                                }
                                out.println(message);
                            }
                        %>
                        <button id="editBtn" class="btn btn-warning btn-custom">Edit</button>
                        <button id="saveBtn" class="btn btn-primary btn-custom d-none">Save</button>
                        <button id="closeBtn" class="btn btn-secondary btn-custom d-none">Close</button>
                        <button id="viewOrdersBtn" class="btn btn-info btn-custom" data-bs-toggle="modal" data-bs-target="#ordersModal">View Orders</button>
                        <button id="changePasswordBtn" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#changePasswordModal">Change Password</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Orders Modal -->
    <div class="modal fade" id="ordersModal" tabindex="-1" aria-labelledby="ordersModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ordersModalLabel">Order Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th scope="col">Order ID</th>
                                <th scope="col">Ordered Date</th>
                                <th scope="col">Order Status</th>
                                <th scope="col">Shipping Address</th>
                                <th scope="col">Total Amount</th>
                                <th scope="col">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (ordersList != null) {
                                for (Orders order : ordersList) { %>
                                    <tr>
                                        <td><%= order.getOrderId() %></td>
                                        <td><%= order.getOrderDate() %></td>
                                        <td><%= order.getStatus() %></td>
                                        <td><%= order.getShippingAddress() %></td>
                                        <td>LKR <%= order.getTotalAmount() %></td>
                                        <td><button class="btn btn-danger btn-sm cancel-order-btn">Cancel</button></td>
                                    </tr>
                            <% } } else { %>
                                <tr>
                                    <td colspan="6" class="text-center">No orders found.</td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Change Password Modal -->
    <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="changePasswordModalLabel">Change Password</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="changePasswordForm" action="updatePassword.jsp" method="post">
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        </div>
                        <input type="hidden" name="userId" value="<%= userId %>">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Change Password</button>
                </div>
                    </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="./script/script.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const editBtn = document.getElementById('editBtn');
            const saveBtn = document.getElementById('saveBtn');
            const closeBtn = document.getElementById('closeBtn');
            const profileForm = document.getElementById('profileForm');

            editBtn.addEventListener('click', function () {
                profileForm.querySelectorAll('input').forEach(input => {
                    input.removeAttribute('readonly');
                });
                saveBtn.classList.remove('d-none');
                closeBtn.classList.remove('d-none');
                editBtn.classList.add('d-none');
            });

            saveBtn.addEventListener('click', function () {
                profileForm.submit();
            });

            closeBtn.addEventListener('click', function () {
                profileForm.querySelectorAll('input').forEach(input => {
                    input.setAttribute('readonly', 'readonly');
                });
                saveBtn.classList.add('d-none');
                closeBtn.classList.add('d-none');
                editBtn.classList.remove('d-none');
            });
        });
    </script>
</body>

</html>
