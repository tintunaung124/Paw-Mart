<?php
include("database.php");
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Paw Mart</title>
    <link rel="stylesheet" href="mainstyling.css">
</head>

<body>

<header>
    <nav>

        <!-- LOGO -->
        <div class="logo">
            <img src="img/logo.png" alt="Logo">
        </div>

        <!-- LINKS -->
        <ul class="nav-links">

            <li><a href="#">Home</a></li>

            <li class="dropdown">
                <a href="#">Products ▾</a>
                <ul class="dropdown-menu">
                    <li><a href="products.php">All</a></li>
                    <li><a href="products.php?category=Toy">Toy</a></li>
                    <li><a href="products.php?category=Accessory">Accessory</a></li>
                </ul>
            </li>

        </ul>

        <!-- SEARCH -->
        <div class="search-bar">
            <form action="products.php" method="GET">
                <input type="text" name="search" placeholder="Search products...">
            </form>
        </div>

    </nav>
</header>


<!-- HERO SECTION -->
<section class="hero">

    <div class="text-container">
        <h1>Everything Your Pet Needs,</h1>
        <h1><strong>All in One Place</strong></h1>

        <p class="subtitle">
            Food, toys, and accessories your pets will love delivered with care 💕
        </p>

        <img src="img/paw.png" class="paw-img" alt="paw">
    </div>

    <div class="hero-image">
        <img src="img/homepic.png" alt="Cute Pet">
    </div>

</section>

</body>
</html>
