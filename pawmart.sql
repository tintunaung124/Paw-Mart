-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: pawmart
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustomerId` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CustomerId`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `uq_customer_email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Alex','alex@gmail.com','0812345678','Bangkok'),(2,'Maya','maya@gmail.com','0898765432','Chiang Mai');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `DeliveryId` int NOT NULL AUTO_INCREMENT,
  `DeliveryDate` date DEFAULT NULL,
  `DeliveryStatus` varchar(50) DEFAULT 'Pending',
  `DeliveryAddress` varchar(255) DEFAULT NULL,
  `OrderId` int DEFAULT NULL,
  PRIMARY KEY (`DeliveryId`),
  UNIQUE KEY `OrderId` (`OrderId`),
  UNIQUE KEY `uq_delivery_order` (`OrderId`),
  CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`OrderId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (1,'2026-02-03','Delivered','Bangkok',1),(2,'2026-02-05','In Transit','Chiang Mai',2);
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderitems`
--

DROP TABLE IF EXISTS `orderitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderitems` (
  `OrderItemID` int NOT NULL AUTO_INCREMENT,
  `Quantity` int NOT NULL,
  `SubTotal` decimal(10,2) NOT NULL,
  `OrderId` int NOT NULL,
  `ProductID` int NOT NULL,
  PRIMARY KEY (`OrderItemID`),
  KEY `OrderId` (`OrderId`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`OrderId`),
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductId`),
  CONSTRAINT `chk_quantity` CHECK ((`Quantity` > 0)),
  CONSTRAINT `chk_quantity_positive` CHECK ((`Quantity` >= 1)),
  CONSTRAINT `chk_subtotal_nonnegative` CHECK ((`SubTotal` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderitems`
--

LOCK TABLES `orderitems` WRITE;
/*!40000 ALTER TABLE `orderitems` DISABLE KEYS */;
INSERT INTO `orderitems` VALUES (1,2,58.00,1,1),(2,1,49.00,1,2),(3,1,99.00,2,3),(4,1,59.00,2,4);
/*!40000 ALTER TABLE `orderitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `OrderId` int NOT NULL AUTO_INCREMENT,
  `OrderDate` date DEFAULT NULL,
  `OrderStatus` varchar(50) DEFAULT 'Pending',
  `TotalAmount` varchar(50) DEFAULT NULL,
  `Schedule` date DEFAULT NULL,
  `CustomerId` int DEFAULT NULL,
  PRIMARY KEY (`OrderId`),
  KEY `CustomerId` (`CustomerId`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`CustomerId`) REFERENCES `customer` (`CustomerId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2026-02-01','Completed','78.00','2026-02-03',1),(2,'2026-02-02','Pending','158.00','2026-02-05',2),(3,'2026-02-03','Pending','78.00','2026-02-05',1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `paymentid` int NOT NULL AUTO_INCREMENT,
  `paymentmethod` varchar(50) NOT NULL DEFAULT 'Cash',
  `paymentdate` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `orderid` int NOT NULL,
  PRIMARY KEY (`paymentid`),
  UNIQUE KEY `orderid` (`orderid`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`orderid`) REFERENCES `orders` (`OrderId`),
  CONSTRAINT `chk_payment_amount` CHECK ((`amount` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'Cash','2026-02-01',107.00,1),(2,'Credit Card','2026-02-02',158.00,2);
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `ProductName` varchar(100) DEFAULT NULL,
  `Category` varchar(50) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `StockQuantity` int NOT NULL,
  `Image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ProductID`),
  UNIQUE KEY `uq_product_name` (`ProductName`),
  CONSTRAINT `chk_price_nonnegative` CHECK ((`StockQuantity` >= 0)),
  CONSTRAINT `chk_price_positive` CHECK ((`Price` > 0)),
  CONSTRAINT `chk_product_price` CHECK ((`Price` > 0)),
  CONSTRAINT `chk_stock_quantity` CHECK ((`StockQuantity` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Screeching Chicken Pet Toy','Toy',29.00,50,'chicken.png'),(2,'Cute Ocean Series Plush Cat Toy','Toy',49.00,40,'cat.png'),(3,'Indestructible Dog Chew Toy','Toy',99.00,30,'dog.png'),(4,'Bowtie Necktie Bowknot Wedding Accessory','Accessory',59.00,25,'bowtie.png'),(5,'Green Pet Carrier Bag Accessory','Accessory',129.00,20,'bag.png'),(6,'Adjustable Pet Bucket Hat Accessory','Accessory',58.00,35,'hat.png');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-12 18:19:38
