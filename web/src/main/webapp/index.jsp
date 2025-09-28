<%@ page import="lk.jiat.ee.core.model.Auctionproduct" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %><%--
  Created by IntelliJ IDEA.
  User: Savindi
  Date: 5/26/2025
  Time: 3:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">

    <title>Home</title>
</head>
<body>

<div class="col-12" style="height: 50px">
    <div class="row">
        
        <div class="col-12 d-flex justify-content-center align-items-center" style="height: 80px;">
            <img src="images/logo.png" class="img-fluid" style="height: 50px">
        </div>

        <ul class="bg-primary">
            <li><a class="active" href="#home">Home</a></li>
            <li><a href="#news">News</a></li>
            <li><a href="#contact">Contact</a></li>
            <li><a href="#about">About</a></li>
        </ul>

        <%
            String user = (String) session.getAttribute("user");
            if(user == null){
                response.sendRedirect("signUp.jsp");
            }
        %>

        <div class="col-12 text-end" style="margin-right: 10px">
            <p>Hello <b><%= user %></b> </p>
        </div>

        <div class="col-12 mt-5 mb-5 d-flex justify-content-center align-items-center">
            <img src="images/logo8.png" class="img-fluid">
        </div>

        <div class="col-10 offset-1 d-flex justify-content-center align-items-center">
            <div class="row text-center">
                <div class="col-md-3 col-6 feature-box">
                    <img src="images/callcenter.png" class="feature-icon">
                    <h5 class="mt-2">Call Center</h5>
                    <p class="text-muted">Completely synergize</p>
                </div>
                <div class="col-md-3 col-6 feature-box">
                    <img src="images/tracking.png" class="feature-icon">
                    <h5 class="mt-2">Order Tracking</h5>
                    <p class="text-muted">Objectively empowered</p>
                </div>
                <div class="col-md-3 col-6 feature-box">
                    <img src="images/quick.png" class="feature-icon">
                    <h5 class="mt-2">Fastest Delivery</h5>
                    <p class="text-muted">Efficiently unleash media</p>
                </div>
                <div class="col-md-3 col-6 feature-box">
                    <img src="images/purchase.png" class="feature-icon">
                    <h5 class="mt-2">Instant Buying</h5>
                    <p class="text-muted">Podcasting operational</p>
                </div>
            </div>

        </div>

        <div class="col-10 offset-1 mb-4">
            <div class="row justify-content-center gap-4">

                <%
                    List<Auctionproduct> auctionproducts = (List<Auctionproduct>) request.getAttribute("products");
                    DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss a");

                    if(auctionproducts != null && !auctionproducts.isEmpty()){

                        for(Auctionproduct product : auctionproducts){

                            %>

                <div class="col-2 card">
                    <div class="col-12">
                        <img src="images/legal.png" style="height: 32px;width: 32px" class="mt-2 mb-1 bid-hover">
<%--                        <img src="images/search.png" style="height: 32px;width: 32px;margin-left: 3px" class="mt-2 mb-1 bid-hover">--%>
                        <a href="auctionDetails?id=<%= product.getId() %>">
                            <img src="images/search.png" style="height: 32px; width: 32px; margin-left: 3px" class="mt-2 mb-1 bid-hover">
                        </a>

                    </div>
                    <img src="images/card1.png" alt="Avatar" style="width:100%" class="mt-2">

                    <script>
                        const socket = new WebSocket("ws://localhost:8080/ezy-bit/bidsocket");

                        socket.onmessage = function(event) {
                            const data = JSON.parse(event.data);
                            const element = document.getElementById("currentBid_" + data.productId);
                            if (element) {
                                element.innerText = "Rs. " + data.bid;
                            }
                        };

                        socket.onerror = function(event) {
                            console.error("WebSocket error observed:", event);
                        };
                    </script>





                    <div class="mt-2">
                        <h5><b><%= product.getName()%></b></h5>
                        <p id="currentBid_<%= product.getId() %>">Rs. <%= product.getCurrentBid() %></p>

                        <div class="col-5 offset-7">
                            <% if (!"Closed".equalsIgnoreCase(product.getStatus())) { %>
                            <p class="active_badge">Active</p>
                            <% } else { %>
                            <p class="close_badge">Closed</p>
                            <% } %>
                        </div>

                        <p>End At : <br/><b><%= dateTimeFormatter.format(product.getEndTime()) %></b></p>

                    </div>
                </div>



                <%
                        }

                    }

                %>



            </div>
        </div>

<%--        footer--%>
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



    </div>
</div>



</body>
</html>
