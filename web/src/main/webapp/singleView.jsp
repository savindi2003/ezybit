<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="lk.jiat.ee.core.model.Auctionproduct" %>
<%@ page import="lk.jiat.ee.core.model.BidEvent" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Savindi
  Date: 5/26/2025
  Time: 7:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Auctionproduct product = (Auctionproduct) request.getAttribute("product");
    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    DateTimeFormatter dtf2 = DateTimeFormatter.ofPattern("dd MMMM yyyy hh:mm a");
%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <title>Single View</title>
    <style>
        .countdown-wrapper {
            margin-top: 20px;
            font-family: sans-serif;
        }

        .countdown-box {
            display: flex;
            justify-content: center;
            gap: 40px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 16px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
        }

        .countdown-box div {
            text-align: center;
            min-width: 60px;
        }

        .count-num {
            font-size: 24px;
            font-weight: 700;
            color: #111;
        }
    </style>

</head>
<body>

<div class="col-12 d-flex justify-content-center align-items-center" style="height: 80px;">
    <img src="images/logo.png" class="img-fluid" style="height: 50px">
</div>

<ul class="bg-primary">
    <li><a class="active" href="/ezy-bit/home">Home</a></li>

</ul>

<div class="container py-5">


    <h2><%= product.getName() %></h2>
    <p class="text-muted">5,313 views</p>

    <div class="row mt-4">
        <!-- Left column: Product Image -->
        <div class="col-md-6">
            <img src="images/card1.png" alt="Headphones" class="product-image mb-3">

        </div>

        <!-- Right column: Auction Info -->
        <div class="col-md-6">

            <%
                boolean isClosed = "Closed".equalsIgnoreCase(product.getStatus());

                String currentUser = (String) session.getAttribute("user");
                boolean isWinner = "Closed".equalsIgnoreCase(product.getStatus()) &&
                        currentUser != null &&
                        currentUser.equalsIgnoreCase(product.getHighestBidder());
                boolean isLoser = isClosed &&
                        currentUser != null &&
                        !currentUser.equalsIgnoreCase(product.getHighestBidder());

            %>

            <% if (!"Closed".equalsIgnoreCase(product.getStatus())) { %>
            <div class="col-1 offset-11">
                <p class="active_badge">Active</p>
            </div>

            <% } else { %>
            <h4 class="text-danger fw-bold">Bid Auction Closed</h4>
            <% } %>

            <p class="text-muted">
                <%= product.getDescription() %>
            </p>
            <p><strong>Item condition:</strong> New</p>

            <!-- Countdown Timer Layout -->
            <div class="countdown-wrapper">
                <div class="countdown-box">
                    <div><span id="days" class="count-num">0</span><br>Days</div>
                    <div><span id="hours" class="count-num">0</span><br>Hours</div>
                    <div><span id="minutes" class="count-num">0</span><br>Minutes</div>
                    <div><span id="seconds" class="count-num">0</span><br>Seconds</div>
                </div>
            </div>

            <div id="countdown-data" data-end="<%= dtf.format(product.getEndTime()) %>"></div>

            <p id="demo" data-endtime="<%= dtf.format(product.getEndTime()) %>"></p>

            <p><strong>Auction starts:</strong> </b> <%= dtf2.format(product.getStartTime()) %></p>
            <p><strong>Auction ends:</strong> </b> <%= dtf2.format(product.getEndTime()) %></p>


            <p>
                In this type of auction all bidders simultaneously submit sealed bids so that no bidder knows the bid of any other participant.
                The highest bidder pays the price they submitted. If two bids with same value are placed, the one placed first wins the auction.
            </p>

            <script>
                const socket = new WebSocket("ws://localhost:8080/ezy-bit/bidsocket");

                socket.onmessage = function(event) {
                    const data = JSON.parse(event.data);
                    const element = document.getElementById("currentBid_" + data.productId);
                    const element_c = document.getElementById("counttBid_" + data.productId);

                    const user = data.bidder;

                    if (element) {
                        element.innerText = " Rs. " + data.bid;
                        element_c.innerText =  Math.round(data.bidCount);

                    }
                };

                socket.onerror = function(event) {
                    console.error("WebSocket error observed:", event);
                };
            </script>

            <%


                String userLastBidText = "You have not placed any bids yet.";

                if (product.getBids() != null && currentUser != null) {
                    List<BidEvent> bids = product.getBids();
                    for (int i = bids.size() - 1; i >= 0; i--) {
                        BidEvent b = bids.get(i);
                        if (currentUser.equals(b.getBidder())) {
                            userLastBidText = "Your last bid: Rs. " + b.getBidAmount();
                            break;
                        }
                    }
                }
            %>

            <p><strong>Minimum bid: Rs. </strong> <%= product.getStartingPrice() %>0</p>
            <p><%= userLastBidText %></p>

            <h4>Highest Bid :<b id="currentBid_<%= product.getId() %>"> Rs. <%= product.getCurrentBid() %> </b> </h4>


            <%
                String msg = (String) request.getAttribute("msg");
                String msgType = (String) request.getAttribute("msgType");

                if (msg != null) {
                    String toastClass = "toast-info";
                    if ("success".equalsIgnoreCase(msgType)) {
                        toastClass = "toast-success";
                    } else if ("error".equalsIgnoreCase(msgType)) {
                        toastClass = "toast-error";
                    }
            %>
            <div id="toast" class="toast-alert <%= toastClass %>">
                <%= msg %>
            </div>

            <script>
                // Auto-hide after 4 seconds
                setTimeout(function () {
                    const toast = document.getElementById("toast");
                    if (toast) {
                        toast.style.opacity = '0';
                        setTimeout(() => toast.remove(), 500); // remove from DOM after fade
                    }
                }, 4000);
            </script>
            <%
                }
            %>

            <!-- Bid input -->
            <form class="mb-3" style="width: 200px;" method="post" action="placeBid">

                <input type="hidden" name="productId" value="<%= product.getId() %>">

                <input type="number" class="form-control text-center" name="bidAmount" step="0.01" required>

                <button class="btn btn-primary me-2 mt-3" type="submit" <%= isClosed ? "disabled" : "" %>>Place Bid</button>

            </form>

<%--            winner show--%>
            <% if (isWinner) { %>
            <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin: 10px 0;">
                🎉 Congratulations <%= currentUser %>! You won this auction!
            </div>
            <% } else if (isLoser) { %>
            <div style="background-color: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin: 10px 0;">
                😔 Sorry <%= currentUser %>, you did not win this auction.
            </div>
            <% } %>
<%--            winner show--%>


            <p class="mt-3 mb-0" id="counttBid_<%= product.getId() %>">
                <strong>Bids: </strong> <%= String.format("%.0f", product.getBidCound()) %>
            </p>


            <p><strong>ID:</strong> <%= product.getId() %></p>

            <!-- Social share -->
            <div class="mt-3">
                <a href="#" class="btn btn-outline-primary btn-sm rounded-circle"><i class="bi bi-facebook"></i></a>
                <a href="#" class="btn btn-outline-success btn-sm rounded-circle"><i class="bi bi-whatsapp"></i></a>
                <a href="#" class="btn btn-outline-danger btn-sm rounded-circle"><i class="bi bi-pinterest"></i></a>
                <a href="#" class="btn btn-outline-info btn-sm rounded-circle"><i class="bi bi-linkedin"></i></a>
                <a href="#" class="btn btn-outline-primary btn-sm rounded-circle"><i class="bi bi-telegram"></i></a>
                <a href="#" class="btn btn-outline-danger btn-sm rounded-circle"><i class="bi bi-envelope-fill"></i></a>
            </div>
        </div>
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

<script>
    function startStyledCountdown() {
        const endTimeStr = document.getElementById("countdown-data").dataset.end;
        const countDownDate = new Date(endTimeStr.replace(" ", "T")).getTime();

        const timer = setInterval(() => {
            const now = new Date().getTime();
            const distance = countDownDate - now;

            if (distance < 0) {
                clearInterval(timer);
                document.querySelectorAll('.count-num').forEach(el => el.innerText = '0');



                return;
            }

            const days = Math.floor(distance / (1000 * 60 * 60 * 24));
            const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);

            document.getElementById("days").innerText = days;
            document.getElementById("hours").innerText = hours;
            document.getElementById("minutes").innerText = minutes;
            document.getElementById("seconds").innerText = seconds;
        }, 1000);
    }

    startStyledCountdown();
</script>







<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>



</body>
</html>
