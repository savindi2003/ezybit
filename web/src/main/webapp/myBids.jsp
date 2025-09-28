<%--
  Created by IntelliJ IDEA.
  User: Savindi
  Date: 5/26/2025
  Time: 7:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>BID History</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .status-won {
            color: green;
            font-weight: bold;
        }
        .status-outbid {
            color: red;
            font-weight: bold;
        }
        .status-leading {
            color: orange;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="col-12 d-flex justify-content-center align-items-center" style="height: 80px;">
    <img src="images/logo.png" class="img-fluid" style="height: 50px">
</div>

<ul class="bg-primary">
    <li><a class="active" href="#home">Home</a></li>
    <li><a href="#news">News</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#about">About</a></li>
</ul>

<div class="container py-5">
    <h2 class="mb-4">My Bids</h2>

    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="table-light">
            <tr>
                <th scope="col">Auction Item</th>
                <th scope="col">Bid Amount</th>
                <th scope="col">Bid Time</th>
                <th scope="col">Status</th>
                <th scope="col">Action</th>
            </tr>
            </thead>
            <tbody>
            <!-- Example Row -->
            <tr>
                <td>
                    <div class="d-flex align-items-center">
                        <img src="images/card1.jpeg" class="rounded me-2" width="50" height="50" alt="item">
                        <div>
                            <strong>Wireless Headphones</strong><br>
                            <small class="text-muted">Ends: Oct 3, 2025</small>
                        </div>
                    </div>
                </td>
                <td>$120.00</td>
                <td>May 25, 2025 14:35</td>
                <td><span class="status-leading">Leading</span></td>
                <td><a href="#" class="btn btn-sm btn-outline-primary">View Auction</a></td>
            </tr>

            <tr>
                <td>
                    <div class="d-flex align-items-center">
                        <img src="images/card1.jpeg" class="rounded me-2" width="50" height="50" alt="item">
                        <div>
                            <strong>iPhone 14 Pro</strong><br>
                            <small class="text-muted">Ended: Apr 20, 2025</small>
                        </div>
                    </div>
                </td>
                <td>$1,050.00</td>
                <td>Apr 18, 2025 09:12</td>
                <td><span class="status-won">Won</span></td>
                <td><a href="#" class="btn btn-sm btn-outline-success">Checkout</a></td>
            </tr>

            <tr>
                <td>
                    <div class="d-flex align-items-center">
                        <img src="images/card1.jpeg" class="rounded me-2" width="50" height="50" alt="item">
                        <div>
                            <strong>Gaming Laptop</strong><br>
                            <small class="text-muted">Ended: Apr 15, 2025</small>
                        </div>
                    </div>
                </td>
                <td>$890.00</td>
                <td>Apr 10, 2025 19:55</td>
                <td><span class="status-outbid">Outbid</span></td>
                <td><a href="#" class="btn btn-sm btn-outline-secondary">View</a></td>
            </tr>

            <!-- More rows dynamically generated -->
            </tbody>
        </table>
    </div>
</div>

<footer class="bg-primary text-white pt-5 pb-4">
    <div class="container text-md-left">
        <div class="row text-md-left">

            <!-- Logo & Description -->
            <div class="col-md-3 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold text-black">AuctionZone</h5>
                <p>Buy and sell unique products with competitive bidding. Trusted by thousands of users.</p>
            </div>

            <!-- Quick Links -->
            <div class="col-md-2 col-lg-2 col-xl-2 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold text-black">Quick Links</h5>
                <p><a href="#" class="text-white text-decoration-none">Home</a></p>
                <p><a href="#" class="text-white text-decoration-none">Auctions</a></p>
                <p><a href="#" class="text-white text-decoration-none">How It Works</a></p>
                <p><a href="#" class="text-white text-decoration-none">FAQs</a></p>
            </div>

            <!-- Useful Links -->
            <div class="col-md-3 col-lg-2 col-xl-2 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold text-black">Resources</h5>
                <p><a href="#" class="text-white text-decoration-none">Your Account</a></p>
                <p><a href="#" class="text-white text-decoration-none">Terms & Conditions</a></p>
                <p><a href="#" class="text-white text-decoration-none">Privacy Policy</a></p>
                <p><a href="#" class="text-white text-decoration-none">Support</a></p>
            </div>

            <!-- Contact -->
            <div class="col-md-4 col-lg-3 col-xl-3 mx-auto mt-3">
                <h5 class="text-uppercase mb-4 font-weight-bold text-black">Contact</h5>
                <p><i class="fas fa-home me-2"></i> Colombo, Sri Lanka</p>
                <p><i class="fas fa-envelope me-2"></i> support@auctionzone.com</p>
                <p><i class="fas fa-phone me-2"></i> +94 71 234 5678</p>
                <p><i class="fas fa-clock me-2"></i> Mon - Fri: 9AM – 6PM</p>
            </div>
        </div>

        <!-- Footer Bottom -->
        <hr class="mb-4">
        <div class="row align-items-center">
            <div class="col-md-7 col-lg-8">
                <p>© 2025 AuctionZone. All rights reserved.</p>
            </div>
            <div class="col-md-5 col-lg-4">
                <div class="text-center text-md-end">
                    <a href="#" class="text-white me-4"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-white me-4"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="text-white me-4"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-linkedin"></i></a>
                </div>
            </div>
        </div>

    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>
