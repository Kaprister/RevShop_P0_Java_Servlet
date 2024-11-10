<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banner & Newsletter Section</title>
    <!-- Add your CSS and icon links here -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>

    <!-- Small Banner Section -->
    <section id="sm-banner" class="section-p1">
        <div class="banner-box">
            <h4>crazy deals</h4>
            <h2>buy 1 get free</h2>
            <span>The best classic dress is on sale at cara</span>
            <a href="#" class="white">Learn More</a>
        </div>
        <div class="banner-box banner-box2">
            <h4>Spring/Summer</h4>
            <h2>Upcoming season</h2>
            <span>The best classic dress is on sale at cara</span>
            <a href="#" class="white">Collection</a>
        </div>
    </section>

    <!-- Banner 3 Section -->
    <section id="banner3">
        <div class="banner-box">
            <h2>Seasonal Sale</h2>
            <h3>Winter collection -50% off</h3>
        </div>
        <div class="banner-box banner-box2">
            <h2>Seasonal Sale</h2>
            <h3>Winter collection -50% off</h3>
        </div>
        <div class="banner-box banner-box3">
            <h2>Seasonal Sale</h2>
            <h3>Winter collection -50% off</h3>
        </div>
    </section>

    <!-- Newsletter Section -->
    <section id="newsletter" class="section-p1 section-m1">
        <div class="newsletter">
            <h4>Sign Up for Newsletters</h4>
            <p>Get E-mail updates about our latest shop and
                <span>special offers</span>
            </p>
        </div>
        <div class="form">
            <form action="" method="post">
                <input type="text" name="email" placeholder="Your email address">
                <button type="submit">Sign Up</button>
            </form>
        </div>
    </section>

    <!-- Include any additional JavaScript files if necessary -->
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>
