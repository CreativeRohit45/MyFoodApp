-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: foodapp
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `menuId` int NOT NULL,
  `resId` int DEFAULT NULL,
  `itemName` varchar(255) DEFAULT NULL,
  `description` text,
  `price` int DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `isAvailable` tinyint(1) DEFAULT NULL,
  `imgPath` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`menuId`),
  KEY `resId` (`resId`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`resId`) REFERENCES `restaurant` (`resId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,1,'Pepperoni','Classic pizza topped with pepperoni and melted mozzarella cheese.',399,4.5,1,'img/pepperoni_pizza.jpg'),(2,1,'Margherita','A simple pizza with fresh mozzarella, basil, and tomato sauce.',299,4.3,0,'img/margherita_pizza.jpg'),(3,1,'BBQ Chicken','Grilled chicken topped with barbecue sauce, onions, and cilantro.',499,4.7,1,'img/bbq_chicken_pizza.jpg'),(4,1,'Veggie Supreme','Loaded with bell peppers, onions, mushrooms, olives, and mozzarella cheese.',349,4.6,1,'img/veggie_supreme_pizza.jpg'),(5,1,'Cheese Burst','A cheesy pizza with a stuffed crust filled with extra cheese.',499,4.8,1,'img/cheese_burst_pizza.jpg'),(6,1,'Hawaiian','A tropical pizza topped with ham and pineapple.',399,4.2,1,'img/hawaiian_pizza.jpg'),(7,1,'ExtravaganZZa','A delicious mix of pepperoni, sausage, green peppers, onions, and mushrooms.',599,4.9,1,'img/extravaganza_pizza.jpg'),(8,1,'Chicken Tikka','Chicken tikka pieces, onions, and bell peppers on a spicy base.',549,4.6,1,'img/chicken_tikka_pizza.jpg');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-18 13:10:37
