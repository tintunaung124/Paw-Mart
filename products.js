<?php
include("database.php");

/* get filter values*/

$category = $_GET['category'] ?? '';
$search   = $_GET['search'] ?? '';


/* build sql */

$sql = "SELECT * FROM Product WHERE 1";
$params = [];
$types  = "";

/* category filter */
if ($category !== '') {
    $sql .= " AND Category = ?";
    $params[] = $category;
    $types .= "s";
}

/* search filter */
if ($search !== '') {
    $sql .= " AND ProductName LIKE ?";
    $params[] = "%$search%";
    $types .= "s";
}

$stmt = $conn->prepare($sql);

if (!empty($params)) {
    $stmt->bind_param($types, ...$params);
}

$stmt->execute();
$result = $stmt->get_result();
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products - Paw Store</title>

    <!-- GLOBAL -->
    <link rel="stylesheet" href="mainstyling.css">

    <!-- PAGE -->
    <link rel="stylesheet" href="products.css">
</head>

<body>


<!-- navbar -->
<header>
    <nav>

        <div class="logo">
            <a href="index.php">
                <img src="img/logo.png" alt="Logo">
            </a>
        </div>

        <ul class="nav-links">
            <li><a href="index.php">Home</a></li>

            <li class="dropdown">
                <a href="#">Products ▾</a>
                <ul class="dropdown-menu">
                    <li><a href="products.php">All</a></li>
                    <li><a href="products.php?category=Toy">Toy</a></li>
                    <li><a href="products.php?category=Accessory">Accessory</a></li>  
                </ul>
            </li>
        </ul>

        <div class="search-bar">
            <form action="products.php" method="GET">
                <input type="text" name="search" placeholder="Search products...">
            </form>
        </div>

    </nav>
</header>



<!-- products grid -->

<div class="products-container">

    <h2 class="products-title">
        <?php
            if ($category) echo "Category: $category";
            elseif ($search) echo "Search: $search";
            else echo "All Products";
        ?>
    </h2>


    <div class="grid">

        <?php if ($result->num_rows > 0): ?>

            <?php while($row = $result->fetch_assoc()): ?>

                <div class="card">

                    <!-- product image -->
                    <img 
                        src="img/products/<?php echo htmlspecialchars($row['Image']); ?>" 
                        class="product-img"
                        alt="<?php echo htmlspecialchars($row['ProductName']); ?>"
                    >

                    <!-- name -->
                    <h4>
                        <?php echo htmlspecialchars($row['ProductName']); ?>
                    </h4>

                    <!-- price -->
                    <div class="price">
                        ฿<?php echo number_format($row['Price'], 2); ?>
                    </div>

                    <!-- stock -->
                    <div class="stock">
                        Stock: <?php echo $row['StockQuantity']; ?>
                    </div>

                    <!-- button -->
                    <button class="btn">Add to Cart</button>

                </div>

            <?php endwhile; ?>

        <?php else: ?>

            <p>No products found.</p>

        <?php endif; ?>

    </div>

</div>
</body>
</html>
