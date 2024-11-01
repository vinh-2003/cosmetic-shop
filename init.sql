-- MySQL dump 10.13  Distrib 8.0.35, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cosmetic_shop
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.25-MariaDB

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
-- Table structure for table `authorities`
--
DROP DATABASE IF EXISTS cosmetic_shop;
CREATE DATABASE cosmetic_shop;
USE cosmetic_shop;

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authorities` (
  `authority_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `authority` varchar(255) NOT NULL,
  PRIMARY KEY (`authority_id`),
  UNIQUE KEY `username` (`username`,`authority`),
  CONSTRAINT `authorities_ibfk_1` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` VALUES (1,'admin','ROLE_ADMIN'),(3,'admin','ROLE_CUSTOMER'),(22,'tien','ROLE_CUSTOMER'),(20,'vinh','ROLE_CUSTOMER'),(21,'vu','ROLE_CUSTOMER');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner` (
  `banner_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `start_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`banner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
INSERT INTO `banner` VALUES (1,'/images/banners/banner1.png','#','2024-09-26 08:58:00','2024-09-26 10:05:00','2024-09-26 08:58:43'),(4,'/images/banners/banner3.jpg','#','2024-09-26 09:15:00','2024-09-26 09:16:00','2024-09-26 09:12:15'),(5,'/images/banners/banner6.png','#','2024-10-08 07:30:00','2024-10-08 07:31:00','2024-10-08 07:30:28'),(6,'/images/banners/banner2.png','#','2024-10-15 05:16:00','2024-10-15 05:20:00','2024-10-15 16:15:19');
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cart_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`cart_id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (5,28,'2024-10-08 08:59:42'),(6,29,'2024-10-12 08:30:40'),(7,30,'2024-10-15 16:16:36'),(8,1,'2024-10-17 07:52:08');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item` (
  `cart_item_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cart_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`cart_item_id`),
  KEY `cart_id` (`cart_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `cart_item_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`),
  CONSTRAINT `cart_item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
INSERT INTO `cart_item` VALUES (98,6,12,1,116000.00);
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `image_url` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Tẩy trang','Tẩy trang','/images/categories/taytrang.png','2024-09-22 18:30:02'),(2,'Rửa mặt','Rửa mặt','/images/categories/ruamat.png','2024-09-25 16:12:38'),(3,'Dung dịch dưỡng','Dung dịch dưỡng','/images/categories/dungdichduong.png','2024-09-25 16:12:38'),(4,'Tinh chất/ Serum','Tinh chất/ Serum','/images/categories/serum.png','2024-09-26 07:29:18'),(5,'Kem dưỡng/ Sữa dưỡng','Kem dưỡng/ Sữa dưỡng','/images/categories/kemduong.png','2024-10-08 07:42:19'),(6,'Mặt nạ','Mặt nạ','/images/categories/matna.png','2024-10-08 07:42:19'),(7,'Dưỡng ẩm','Dưỡng ẩm','/images/categories/duongam.jpeg','2024-10-08 07:42:19'),(8,'Dưỡng trắng mờ thâm sạm','Dưỡng trắng mờ thâm sạm','/images/categories/duongtrang.png','2024-10-08 07:42:19'),(9,'Chống lão hoá','Chống lão hoá','/images/categories/chonglaohoa.png','2024-10-08 07:42:19'),(10,'Chăm sóc da mụn','Chăm sóc da mụn','/images/categories/chamsocdamun.png','2024-10-08 07:42:19'),(11,'Nâng cấp dưỡng da','Nâng cấp dưỡng da','/images/categories/nangcapduongda.png','2024-10-08 07:42:19');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_item` (
  `order_item_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (78,49,18,3,95000.00),(79,49,20,1,93000.00),(80,50,19,1,75000.00),(81,50,13,1,135000.00),(82,50,14,1,129000.00),(83,51,16,1,315000.00),(84,52,12,3,130500.00),(85,52,17,1,97000.00),(86,53,12,3,130500.00),(87,53,17,1,97000.00),(88,53,34,1,220000.00),(89,53,35,1,330000.00),(90,54,20,1,93000.00),(91,55,21,1,195000.00),(92,56,25,1,159000.00),(93,56,24,1,159000.00),(94,57,21,1,195000.00),(95,57,26,1,270000.00),(96,57,27,1,55000.00),(97,57,29,1,130000.00),(98,58,21,1,195000.00),(99,58,26,1,270000.00),(100,58,27,1,55000.00),(101,58,29,1,130000.00),(102,59,21,1,195000.00),(103,59,26,1,270000.00),(104,59,27,1,55000.00),(105,59,29,1,130000.00),(106,60,20,1,93000.00),(107,60,21,1,195000.00),(108,61,20,1,93000.00),(109,61,21,1,195000.00),(110,62,20,1,93000.00),(111,62,21,1,195000.00),(112,63,20,1,93000.00),(113,63,21,1,195000.00),(114,64,20,1,93000.00),(115,64,21,1,195000.00),(116,65,20,1,93000.00),(117,65,21,1,195000.00),(118,66,20,1,93000.00),(119,66,21,1,195000.00),(120,67,20,1,93000.00),(121,67,21,1,195000.00),(122,68,20,1,93000.00),(123,68,21,1,195000.00),(124,69,20,1,93000.00),(125,69,21,1,195000.00),(126,70,20,1,93000.00),(127,70,21,1,195000.00),(128,71,20,1,93000.00),(129,71,21,1,195000.00),(130,72,20,1,93000.00),(131,72,21,1,195000.00),(132,73,20,1,93000.00),(133,73,21,1,195000.00),(134,74,20,1,93000.00),(135,74,21,1,195000.00),(136,75,20,1,93000.00),(137,75,21,1,195000.00),(138,76,20,1,93000.00),(139,76,21,1,195000.00),(140,77,20,1,93000.00),(141,77,21,1,195000.00),(142,78,20,1,93000.00),(143,78,21,1,195000.00),(144,79,20,1,93000.00),(145,79,21,1,195000.00),(146,80,20,1,93000.00),(147,80,21,1,195000.00),(148,81,20,1,93000.00),(149,81,21,1,195000.00),(150,82,20,1,93000.00),(151,82,21,1,195000.00),(152,83,20,1,93000.00),(153,83,21,1,195000.00),(154,84,20,1,93000.00),(155,84,21,1,195000.00),(156,85,20,1,93000.00),(157,85,21,1,195000.00),(158,86,20,1,93000.00),(159,86,21,1,195000.00),(160,87,20,1,93000.00),(161,87,21,1,195000.00),(162,88,20,1,93000.00),(163,88,21,1,195000.00),(164,89,20,1,93000.00),(165,89,21,1,195000.00),(166,90,20,1,93000.00),(167,90,21,1,195000.00),(168,91,20,1,93000.00),(169,91,21,1,195000.00),(170,92,20,1,93000.00),(171,92,21,1,195000.00),(172,93,20,1,93000.00),(173,93,21,1,195000.00),(174,94,20,1,93000.00),(175,94,21,1,195000.00),(176,95,20,1,93000.00),(177,95,21,1,195000.00),(178,96,20,1,93000.00),(179,96,21,1,195000.00),(180,97,20,1,93000.00),(181,97,21,1,195000.00),(182,98,20,1,93000.00),(183,98,21,1,195000.00),(184,99,20,1,93000.00),(185,99,21,1,195000.00),(186,100,20,1,93000.00),(187,100,21,1,195000.00),(188,101,20,1,93000.00),(189,101,21,1,195000.00),(190,102,20,1,93000.00),(191,102,21,1,195000.00),(192,103,20,1,93000.00),(193,103,21,1,195000.00),(194,104,20,1,93000.00),(195,104,21,1,195000.00),(196,105,20,1,93000.00),(197,105,21,1,195000.00),(198,106,20,1,93000.00),(199,106,21,1,195000.00),(200,107,20,1,93000.00),(201,107,21,1,195000.00),(202,108,20,1,93000.00),(203,108,21,1,195000.00),(204,109,20,1,93000.00),(205,109,21,1,195000.00),(206,110,20,1,93000.00),(207,110,21,1,195000.00),(208,111,20,1,93000.00),(209,111,21,1,195000.00),(210,112,12,1,130500.00),(211,113,12,1,130500.00),(212,114,12,1,130500.00),(213,115,12,1,130500.00),(214,116,12,1,130500.00),(215,117,12,1,130500.00),(216,118,12,1,130500.00),(217,119,12,1,130500.00),(218,120,12,1,130500.00),(219,121,12,1,130500.00),(220,122,12,1,130500.00),(221,123,13,1,135000.00),(222,124,13,1,135000.00),(223,125,13,1,135000.00),(224,126,13,1,135000.00),(225,127,14,1,129000.00),(226,128,20,1,93000.00),(227,129,26,1,270000.00),(228,130,17,1,97000.00),(229,131,19,1,75000.00),(230,132,15,1,242000.00),(231,133,16,1,315000.00),(232,134,23,1,290000.00),(233,135,16,1,315000.00),(234,136,16,1,315000.00),(235,137,16,1,315000.00),(236,138,16,1,315000.00),(237,139,16,1,315000.00),(238,140,16,1,315000.00),(239,141,16,1,315000.00),(240,142,16,1,315000.00),(241,143,16,1,315000.00),(242,144,18,1,95000.00),(243,145,18,1,95000.00),(244,146,18,1,95000.00),(245,147,18,1,95000.00),(248,150,18,1,95000.00),(249,150,17,1,97000.00),(252,153,16,3,315000.00),(256,157,23,1,290000.00),(261,160,21,1,195000.00),(262,160,22,2,130000.00),(264,162,13,1,135000.00),(265,163,12,5,116000.00),(266,163,13,2,149000.00),(279,170,13,1,149000.00),(280,170,12,2,116000.00),(284,172,12,2,116000.00),(285,172,13,2,149000.00),(286,172,17,1,87300.00),(290,174,12,2,116000.00),(291,174,13,3,149000.00),(292,174,14,4,129000.00),(295,176,23,3,290000.00),(296,176,24,2,159000.00),(297,177,23,3,290000.00),(298,177,24,2,159000.00),(299,178,23,3,290000.00),(300,178,24,2,159000.00),(301,179,23,3,290000.00),(302,179,24,2,159000.00),(303,180,23,3,290000.00),(304,180,24,2,159000.00),(305,181,23,3,290000.00),(306,181,24,2,159000.00),(307,182,23,3,290000.00),(308,182,24,2,159000.00),(312,184,23,3,290000.00),(313,184,24,2,159000.00),(314,184,12,1,116000.00),(315,185,23,3,290000.00),(316,185,24,2,159000.00),(317,185,12,1,116000.00),(318,186,23,3,290000.00),(319,186,24,2,159000.00),(320,186,12,1,116000.00),(321,187,23,3,290000.00),(322,187,24,2,159000.00),(323,187,12,1,116000.00),(324,188,23,3,290000.00),(325,188,24,2,159000.00),(326,188,12,1,116000.00),(327,189,23,3,290000.00),(328,189,24,2,159000.00),(329,189,12,1,116000.00),(330,190,23,3,290000.00),(331,190,24,2,159000.00),(332,190,12,1,116000.00),(334,192,12,1,116000.00),(335,193,13,1,149000.00),(336,194,13,1,149000.00),(339,196,12,1,116000.00),(340,196,13,2,149000.00),(343,198,12,3,116000.00),(344,198,17,4,87300.00);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_status`
--

DROP TABLE IF EXISTS `order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_status` (
  `status_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `changed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`status_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `order_status_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_status`
--

LOCK TABLES `order_status` WRITE;
/*!40000 ALTER TABLE `order_status` DISABLE KEYS */;
INSERT INTO `order_status` VALUES (78,49,'Đang tạo','2024-10-11 08:07:42'),(79,49,'Chờ xử lý','2024-10-11 08:07:43'),(80,50,'Đang tạo','2024-10-11 08:08:06'),(81,50,'Chờ xử lý','2024-10-11 08:08:07'),(82,51,'Đang tạo','2024-10-11 08:08:23'),(83,51,'Chờ xử lý','2024-10-11 08:08:24'),(84,51,'Đang giao','2024-10-11 08:59:44'),(85,52,'Đang tạo','2024-10-12 07:17:35'),(86,53,'Đang tạo','2024-10-12 07:22:14'),(87,53,'Chờ xử lý','2024-10-12 07:22:14'),(88,54,'Đang tạo','2024-10-12 07:34:40'),(89,54,'Chờ xử lý','2024-10-12 07:34:40'),(90,55,'Đang tạo','2024-10-12 07:35:31'),(91,55,'Chờ xử lý','2024-10-12 07:35:31'),(92,56,'Đang tạo','2024-10-12 08:04:06'),(93,56,'Chờ xử lý','2024-10-12 08:05:18'),(94,57,'Đang tạo','2024-10-12 08:19:32'),(95,57,'Chờ xử lý','2024-10-12 08:19:40'),(96,58,'Đang tạo','2024-10-12 08:23:04'),(97,58,'Chờ xử lý','2024-10-12 08:23:10'),(98,59,'Đang tạo','2024-10-12 08:30:13'),(99,59,'Chờ xử lý','2024-10-12 08:30:14'),(100,60,'Đang tạo','2024-10-12 08:48:07'),(101,61,'Đang tạo','2024-10-12 09:06:15'),(102,62,'Đang tạo','2024-10-12 09:16:07'),(103,63,'Đang tạo','2024-10-12 09:17:27'),(104,64,'Đang tạo','2024-10-12 09:29:23'),(105,65,'Đang tạo','2024-10-12 09:31:36'),(106,66,'Đang tạo','2024-10-12 09:34:10'),(107,67,'Đang tạo','2024-10-12 09:36:30'),(108,68,'Đang tạo','2024-10-12 09:38:29'),(109,69,'Đang tạo','2024-10-12 09:42:37'),(110,70,'Đang tạo','2024-10-12 09:43:23'),(111,71,'Đang tạo','2024-10-12 09:44:40'),(112,72,'Đang tạo','2024-10-12 09:46:28'),(113,73,'Đang tạo','2024-10-12 09:48:59'),(114,74,'Đang tạo','2024-10-12 09:50:27'),(115,75,'Đang tạo','2024-10-12 09:52:02'),(116,76,'Đang tạo','2024-10-12 09:53:14'),(117,77,'Đang tạo','2024-10-12 09:54:14'),(118,78,'Đang tạo','2024-10-12 09:54:49'),(119,79,'Đang tạo','2024-10-12 09:56:08'),(120,80,'Đang tạo','2024-10-12 09:59:00'),(121,81,'Đang tạo','2024-10-12 10:00:06'),(122,82,'Đang tạo','2024-10-12 10:02:34'),(123,83,'Đang tạo','2024-10-12 10:04:02'),(124,84,'Đang tạo','2024-10-12 10:07:57'),(125,85,'Đang tạo','2024-10-12 10:09:07'),(126,86,'Đang tạo','2024-10-12 10:10:05'),(127,87,'Đang tạo','2024-10-12 10:22:34'),(128,88,'Đang tạo','2024-10-12 10:23:49'),(129,89,'Đang tạo','2024-10-12 10:26:27'),(130,90,'Đang tạo','2024-10-12 10:29:26'),(131,91,'Đang tạo','2024-10-12 10:34:53'),(132,92,'Đang tạo','2024-10-12 10:35:37'),(133,93,'Đang tạo','2024-10-12 10:36:50'),(134,94,'Đang tạo','2024-10-12 10:39:22'),(135,95,'Đang tạo','2024-10-12 10:40:15'),(136,96,'Đang tạo','2024-10-12 10:41:12'),(137,97,'Đang tạo','2024-10-12 10:42:38'),(138,98,'Đang tạo','2024-10-12 10:45:07'),(139,99,'Đang tạo','2024-10-12 10:45:49'),(140,100,'Đang tạo','2024-10-12 10:47:32'),(141,101,'Đang tạo','2024-10-12 10:49:54'),(142,102,'Đang tạo','2024-10-12 10:51:55'),(143,103,'Đang tạo','2024-10-12 10:54:29'),(144,104,'Đang tạo','2024-10-12 10:56:51'),(145,105,'Đang tạo','2024-10-12 10:59:27'),(146,106,'Đang tạo','2024-10-12 11:00:38'),(147,107,'Đang tạo','2024-10-12 11:01:56'),(148,108,'Đang tạo','2024-10-12 11:02:41'),(149,109,'Đang tạo','2024-10-12 11:03:20'),(150,110,'Đang tạo','2024-10-12 11:06:36'),(151,111,'Đang tạo','2024-10-12 11:07:40'),(152,111,'Chờ xử lý','2024-10-12 11:07:56'),(153,112,'Đang tạo','2024-10-12 16:02:53'),(154,113,'Đang tạo','2024-10-12 16:14:56'),(155,114,'Đang tạo','2024-10-12 16:24:39'),(156,115,'Đang tạo','2024-10-12 16:28:56'),(157,116,'Đang tạo','2024-10-12 16:36:47'),(158,117,'Đang tạo','2024-10-12 16:40:49'),(159,118,'Đang tạo','2024-10-12 16:41:48'),(160,119,'Đang tạo','2024-10-12 16:42:26'),(161,120,'Đang tạo','2024-10-12 16:44:09'),(162,121,'Đang tạo','2024-10-12 16:45:31'),(164,122,'Đang tạo','2024-10-12 16:46:58'),(165,122,'Chờ xử lý','2024-10-12 16:47:10'),(166,123,'Đang tạo','2024-10-12 16:47:27'),(167,124,'Đang tạo','2024-10-12 17:21:44'),(168,125,'Đang tạo','2024-10-12 17:28:24'),(169,125,'Chờ xử lý','2024-10-12 17:28:26'),(173,126,'Đang tạo','2024-10-12 17:30:16'),(174,126,'Chờ xử lý','2024-10-12 17:30:18'),(175,127,'Đang tạo','2024-10-12 17:32:10'),(176,127,'Chờ xử lý','2024-10-12 17:32:13'),(177,128,'Đang tạo','2024-10-12 17:34:19'),(178,128,'Chờ xử lý','2024-10-12 17:34:21'),(179,129,'Đang tạo','2024-10-12 17:37:26'),(180,129,'Chờ xử lý','2024-10-12 17:37:29'),(181,130,'Đang tạo','2024-10-12 17:39:38'),(182,130,'Chờ xử lý','2024-10-12 17:39:40'),(183,131,'Đang tạo','2024-10-12 17:40:48'),(184,131,'Chờ xử lý','2024-10-12 17:40:49'),(185,132,'Đang tạo','2024-10-12 17:42:37'),(186,132,'Chờ xử lý','2024-10-12 17:42:38'),(187,133,'Đang tạo','2024-10-12 17:44:10'),(188,133,'Chờ xử lý','2024-10-12 17:44:12'),(189,134,'Đang tạo','2024-10-12 17:47:55'),(190,134,'Chờ xử lý','2024-10-12 17:47:57'),(191,135,'Đang tạo','2024-10-12 17:48:40'),(192,136,'Đang tạo','2024-10-12 17:53:42'),(193,137,'Đang tạo','2024-10-12 17:54:55'),(194,138,'Đang tạo','2024-10-12 17:55:53'),(195,139,'Đang tạo','2024-10-12 17:58:10'),(196,140,'Đang tạo','2024-10-12 17:59:05'),(197,141,'Đang tạo','2024-10-12 18:01:08'),(198,142,'Đang tạo','2024-10-12 18:03:07'),(199,143,'Đang tạo','2024-10-12 18:03:46'),(200,143,'Chờ xử lý','2024-10-12 18:05:09'),(201,144,'Đang tạo','2024-10-12 18:06:17'),(202,145,'Đang tạo','2024-10-12 18:25:23'),(203,146,'Đang tạo','2024-10-12 18:27:38'),(204,147,'Đang tạo','2024-10-12 18:33:04'),(208,150,'Đang tạo','2024-10-12 18:42:17'),(209,150,'Chờ xử lý','2024-10-12 18:42:19'),(214,153,'Đang tạo','2024-10-12 18:51:28'),(215,153,'Chờ xử lý','2024-10-12 18:51:32'),(221,157,'Đang tạo','2024-10-12 19:01:43'),(222,157,'Chờ xử lý','2024-10-12 19:01:45'),(225,160,'Đang tạo','2024-10-12 19:06:26'),(226,160,'Chờ xử lý','2024-10-12 19:06:33'),(228,162,'Đang tạo','2024-10-13 04:55:26'),(229,162,'Chờ xử lý','2024-10-13 04:55:29'),(230,163,'Đang tạo','2024-10-13 06:15:23'),(231,163,'Chờ xử lý','2024-10-13 06:17:05'),(238,170,'Đang tạo','2024-10-13 09:53:32'),(239,170,'Chờ xử lý','2024-10-13 09:53:38'),(241,172,'Đang tạo','2024-10-15 15:58:16'),(242,172,'Chờ xử lý','2024-10-15 15:58:17'),(244,174,'Đang tạo','2024-10-16 14:57:50'),(245,174,'Chờ xử lý','2024-10-16 14:58:11'),(247,176,'Đang tạo','2024-10-17 04:44:47'),(248,177,'Đang tạo','2024-10-17 04:51:13'),(249,178,'Đang tạo','2024-10-17 04:52:40'),(250,179,'Đang tạo','2024-10-17 04:53:06'),(251,180,'Đang tạo','2024-10-17 04:55:30'),(252,181,'Đang tạo','2024-10-17 04:56:49'),(253,182,'Đang tạo','2024-10-17 04:59:13'),(255,184,'Đang tạo','2024-10-17 05:48:15'),(256,185,'Đang tạo','2024-10-17 05:51:55'),(257,186,'Đang tạo','2024-10-17 05:58:05'),(258,187,'Đang tạo','2024-10-17 05:59:00'),(259,188,'Đang tạo','2024-10-17 06:02:53'),(260,189,'Đang tạo','2024-10-17 06:04:24'),(261,190,'Đang tạo','2024-10-17 06:05:05'),(262,190,'Chờ xử lý','2024-10-17 06:06:30'),(264,192,'Đang tạo','2024-10-17 06:58:04'),(265,192,'Chờ xử lý','2024-10-17 06:58:08'),(266,193,'Đang tạo','2024-10-17 06:58:34'),(267,194,'Đang tạo','2024-10-17 07:06:31'),(268,194,'Chờ xử lý','2024-10-17 07:06:41'),(270,196,'Đang tạo','2024-10-17 09:32:32'),(271,196,'Chờ xử lý','2024-10-17 09:32:36'),(273,198,'Đang tạo','2024-10-17 09:35:43'),(274,198,'Chờ xử lý','2024-10-17 09:35:45');
/*!40000 ALTER TABLE `order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `address_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `user_id` (`user_id`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`address_id`) REFERENCES `shipping_address` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (49,28,378000.00,'2024-10-11 08:07:21',1),(50,28,339000.00,'2024-10-11 08:08:00',5),(51,28,315000.00,'2024-10-11 08:08:18',2),(52,28,488500.00,'2024-10-12 07:17:35',1),(53,28,1038500.00,'2024-10-12 07:22:08',1),(54,28,93000.00,'2024-10-12 07:34:31',2),(55,28,195000.00,'2024-10-12 07:35:12',1),(56,28,318000.00,'2024-10-12 08:03:23',5),(57,28,650000.00,'2024-10-12 08:19:32',1),(58,28,650000.00,'2024-10-12 08:23:04',1),(59,28,650000.00,'2024-10-12 08:30:10',5),(60,28,288000.00,'2024-10-12 08:48:07',1),(61,28,288000.00,'2024-10-12 09:06:15',1),(62,28,288000.00,'2024-10-12 09:16:07',1),(63,28,288000.00,'2024-10-12 09:17:27',1),(64,28,288000.00,'2024-10-12 09:29:23',1),(65,28,288000.00,'2024-10-12 09:31:36',1),(66,28,288000.00,'2024-10-12 09:34:10',1),(67,28,288000.00,'2024-10-12 09:36:30',1),(68,28,288000.00,'2024-10-12 09:38:29',1),(69,28,288000.00,'2024-10-12 09:42:37',1),(70,28,288000.00,'2024-10-12 09:43:23',1),(71,28,288000.00,'2024-10-12 09:44:40',1),(72,28,288000.00,'2024-10-12 09:46:28',1),(73,28,288000.00,'2024-10-12 09:48:59',1),(74,28,288000.00,'2024-10-12 09:50:27',1),(75,28,288000.00,'2024-10-12 09:52:01',1),(76,28,288000.00,'2024-10-12 09:53:14',1),(77,28,288000.00,'2024-10-12 09:54:14',1),(78,28,288000.00,'2024-10-12 09:54:49',1),(79,28,288000.00,'2024-10-12 09:56:08',1),(80,28,288000.00,'2024-10-12 09:59:00',1),(81,28,288000.00,'2024-10-12 10:00:06',1),(82,28,288000.00,'2024-10-12 10:02:34',1),(83,28,288000.00,'2024-10-12 10:04:02',1),(84,28,288000.00,'2024-10-12 10:07:57',1),(85,28,288000.00,'2024-10-12 10:09:07',1),(86,28,288000.00,'2024-10-12 10:10:05',1),(87,28,288000.00,'2024-10-12 10:22:34',1),(88,28,288000.00,'2024-10-12 10:23:49',1),(89,28,288000.00,'2024-10-12 10:26:27',1),(90,28,288000.00,'2024-10-12 10:29:10',2),(91,28,288000.00,'2024-10-12 10:34:53',2),(92,28,288000.00,'2024-10-12 10:35:37',2),(93,28,288000.00,'2024-10-12 10:36:50',1),(94,28,288000.00,'2024-10-12 10:39:22',1),(95,28,288000.00,'2024-10-12 10:40:15',1),(96,28,288000.00,'2024-10-12 10:41:12',1),(97,28,288000.00,'2024-10-12 10:42:38',1),(98,28,288000.00,'2024-10-12 10:45:07',1),(99,28,288000.00,'2024-10-12 10:45:49',1),(100,28,288000.00,'2024-10-12 10:47:32',1),(101,28,288000.00,'2024-10-12 10:49:54',1),(102,28,288000.00,'2024-10-12 10:51:55',1),(103,28,288000.00,'2024-10-12 10:54:29',1),(104,28,288000.00,'2024-10-12 10:56:51',1),(105,28,288000.00,'2024-10-12 10:59:27',1),(106,28,288000.00,'2024-10-12 11:00:38',1),(107,28,288000.00,'2024-10-12 11:01:56',1),(108,28,288000.00,'2024-10-12 11:02:41',1),(109,28,288000.00,'2024-10-12 11:03:20',1),(110,28,288000.00,'2024-10-12 11:06:36',1),(111,28,288000.00,'2024-10-12 11:07:40',1),(112,28,130500.00,'2024-10-12 16:02:53',1),(113,28,130500.00,'2024-10-12 16:14:56',1),(114,28,130500.00,'2024-10-12 16:24:39',1),(115,28,130500.00,'2024-10-12 16:28:56',1),(116,28,130500.00,'2024-10-12 16:36:47',1),(117,28,130500.00,'2024-10-12 16:40:49',1),(118,28,130500.00,'2024-10-12 16:41:48',1),(119,28,130500.00,'2024-10-12 16:42:26',1),(120,28,130500.00,'2024-10-12 16:44:09',1),(121,28,130500.00,'2024-10-12 16:45:31',1),(122,28,130500.00,'2024-10-12 16:46:58',1),(123,28,135000.00,'2024-10-12 16:47:27',1),(124,28,135000.00,'2024-10-12 17:21:29',5),(125,28,135000.00,'2024-10-12 17:28:24',1),(126,28,135000.00,'2024-10-12 17:30:16',1),(127,28,129000.00,'2024-10-12 17:32:10',1),(128,28,93000.00,'2024-10-12 17:34:19',1),(129,28,270000.00,'2024-10-12 17:37:26',1),(130,28,97000.00,'2024-10-12 17:39:38',1),(131,28,75000.00,'2024-10-12 17:40:48',1),(132,28,242000.00,'2024-10-12 17:42:37',1),(133,28,315000.00,'2024-10-12 17:44:10',1),(134,28,290000.00,'2024-10-12 17:47:55',1),(135,28,315000.00,'2024-10-12 17:48:40',1),(136,28,315000.00,'2024-10-12 17:53:42',1),(137,28,315000.00,'2024-10-12 17:54:55',1),(138,28,315000.00,'2024-10-12 17:55:53',1),(139,28,315000.00,'2024-10-12 17:58:10',1),(140,28,315000.00,'2024-10-12 17:59:05',1),(141,28,315000.00,'2024-10-12 18:01:08',1),(142,28,315000.00,'2024-10-12 18:03:07',1),(143,28,315000.00,'2024-10-12 18:03:46',1),(144,28,95000.00,'2024-10-12 18:06:17',1),(145,28,95000.00,'2024-10-12 18:25:05',5),(146,28,95000.00,'2024-10-12 18:27:38',1),(147,28,95000.00,'2024-10-12 18:33:04',1),(150,28,192000.00,'2024-10-12 18:42:17',1),(153,28,945000.00,'2024-10-12 18:51:28',1),(157,28,290000.00,'2024-10-12 19:01:43',1),(160,28,455000.00,'2024-10-12 19:06:09',5),(162,28,135000.00,'2024-10-13 04:55:20',5),(163,28,878000.00,'2024-10-13 06:15:23',5),(170,28,381000.00,'2024-10-13 09:53:32',5),(172,28,617300.00,'2024-10-15 15:58:16',1),(174,28,1195000.00,'2024-10-16 14:57:50',5),(176,28,1188000.00,'2024-10-17 04:44:47',1),(177,28,1188000.00,'2024-10-17 04:51:13',1),(178,28,1188000.00,'2024-10-17 04:52:40',1),(179,28,1188000.00,'2024-10-17 04:53:06',1),(180,28,1188000.00,'2024-10-17 04:55:30',1),(181,28,1188000.00,'2024-10-17 04:56:49',1),(182,28,1188000.00,'2024-10-17 04:59:13',1),(184,28,1304000.00,'2024-10-17 05:48:15',1),(185,28,1304000.00,'2024-10-17 05:51:55',1),(186,28,1304000.00,'2024-10-17 05:58:05',1),(187,28,1304000.00,'2024-10-17 05:58:59',1),(188,28,1304000.00,'2024-10-17 06:02:53',1),(189,28,1304000.00,'2024-10-17 06:04:24',1),(190,28,1304000.00,'2024-10-17 06:05:05',1),(192,28,116000.00,'2024-10-17 06:58:04',1),(193,28,149000.00,'2024-10-17 06:58:34',1),(194,28,149000.00,'2024-10-17 07:06:31',2),(196,28,414000.00,'2024-10-17 09:32:32',1),(198,28,697200.00,'2024-10-17 09:35:43',1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  `brand` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `discount_percentage` decimal(5,2) DEFAULT 0.00,
  `average_rating` decimal(3,2) DEFAULT 0.00,
  `tag_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (12,'Nước tẩy trang sạch sâu cho da mụn, nhạy cảm','Công nghệ Micelle Complex nhẹ nhàng làm sạch sâu 99% lớp trang điểm lâu trôi, kem chống nắng và bụi mịn PM2.5\r\n\r\n\r\nCông nghệ Microbiome giúp cải thiện hàng rào vi sinh có lợi và bảo vệ da trước tác nhân gây mụn\r\n\r\n\r\nHệ thực vật (Chiết xuất Diếp cá, Ý Dĩ, Cúc La Mã) giúp giảm dầu thừa, cải thiện và ngừa mụn hiệu quả\r\n\r\n\r\nDipotassium Glycyrrhizate kháng khuẩn, làm dịu da tức thì\r\n\r\n\r\nHệ dưỡng ẩm 3X HA (HA, Super HA, Nano HA) cung cấp độ ẩm tối ưu, làm giảm tình trạng mất nước và tăng cường độ ẩm cho da\r\n\r\n\r\nCông thức dịu nhẹ không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, không Paraben và pH cân bằng\r\n\r\n\r\nPhù hợp cho da mụn, nhạy cảm',145000.00,79,'/images/products/nuoc_tay_trang_sach_sau_cho_da_mun_nhay_cam.png',1,'Hada Labo','2024-10-08 08:01:05',20.00,0.00,1),(13,'Nước tẩy trang sạch sâu dưỡng trắng','Công nghệ Micelle Complex nhẹ nhàng làm sạch sâu 99% lớp trang điểm lâu trôi, kem chống nắng và bụi mịn PM2.5.\r\n\r\n\r\nChiết xuất mật ong lên men giúp giảm hắc sắc tố melanin, cải thiện đốm nâu và làm sáng da.\r\n\r\n\r\nHệ Vitamin (B3, C, E) giúp tăng cường khả năng chống oxy hóa, dưỡng sáng, cải thiện và làm đều màu da.\r\n\r\n\r\nHệ dưỡng ẩm sâu HA (HA, Super HA, Nano HA) với tỉ lệ kết hợp hoàn hảo giúp cung cấp độ ẩm tối ưu, tăng cường độ đàn hồi, duy trì độ ẩm cho da.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: Công thức dịu nhẹ không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, không Paraben và pH cân bằng.\r\n\r\n\r\nPhù hợp với mọi loại da.',149000.00,85,'/images/products/nuoctaytrangsachsauduongtrang.png',1,'Hada Labo','2024-10-08 08:04:25',0.00,0.00,1),(14,'Nước tẩy trang sạch sâu dưỡng ẩm','Công nghệ Micelle Complex nhẹ nhàng làm sạch sâu 99% lớp trang điểm lâu trôi, kem chống nắng và bụi mịn PM2.5.\r\n\r\n\r\nHA lên men tự nhiên giúp giảm tình trạng mất nước, củng cố màng ẩm tự nhiên bảo vệ da.\r\n\r\n\r\nHệ dưỡng ẩm sâu HA (HA, Super HA, Nano HA) với tỉ lệ kết hợp hoàn hảo giúp cung cấp độ ẩm tối ưu, tăng cường độ đàn hồi, duy trì và tăng cường độ ẩm da đến 1.5 lần.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: Công thức dịu nhẹ không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, không Paraben và pH cân bằng.\r\n\r\n\r\nPhù hợp với mọi loại da.',129000.00,94,'/images/products/nuoctaytrangsachsauduongam.png',1,'Hada Labo','2024-10-08 08:05:24',0.00,0.00,1),(15,'Dầu tẩy trang dưỡng ẩm','Dầu Ô liu và Jojoba tự nhiên nhẹ nhàng làm sạch sâu bụi bẩn, bã nhờn, kem chống nắng, lớp trang điểm lâu trôi, kể cả son lì và mascara chống nước.\r\n\r\n\r\nLần đầu tiên trên thế giới, Hyaluronic Acid lên men tự nhiên (Fermented HA) kết hợp hệ dưỡng ẩm sâu HA đặc trưng (HA, Super HA, Nano HA) giúp giảm tình trạng mất nước, củng cố màng ẩm tự nhiên bảo vệ da.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: công thức dịu nhẹ với pH cân bằng, không cồn, không hệ xà phòng, không Sulfate, không Paraben, không hương liệu, không chất tạo màu, không dầu khoáng.',242000.00,99,'/images/products/dautaytrangduongam.png',1,'Hada Labo','2024-10-08 08:06:16',0.00,0.00,1),(16,'Dầu tẩy trang sạch sâu dưỡng ẩm','Dầu Ô liu tinh khiết nhẹ nhàng làm sạch sâu bụi bẩn, bã nhờn, kem chống nắng, lớp trang điểm lâu trôi, kể cả son lì và mascara chống nước.\r\n\r\n\r\nHệ dưỡng ẩm sâu HA gồm HA và Super HA giúp duy trì và cấp ẩm tối ưu, giữ cho làn da ẩm mượt ngay cả khi rửa mặt.\r\n\r\n\r\nCông thức làm sạch dịu nhẹ không Paraben, không cồn, không hương liệu, không chất tạo màu, không dầu khoáng.',315000.00,94,'/images/products/dautaytrangsachsauduongam.png',1,'Hada Labo','2024-10-08 08:07:16',0.00,0.00,1),(17,'Kem rửa mặt cải thiện dấu hiệu lão hóa Hada Labo','Bọt kem mềm mịn chứa thành phần làm sạch có nguồn gốc tự nhiên lấy sạch bụi bẩn, bã nhờn trong lỗ chân lông và tế bào chết trên da\r\n\r\n\r\nRetinol kết hợp Niacinamide (B3) và Collagen giúp làm mờ nếp nhăn, cải thiện độ đàn hồi, dưỡng sáng các vùng da sạm màu, cho da trông tươi trẻ và săn chắc sau 7 ngày\r\n\r\n\r\nHệ dưỡng ẩm sâu HA đặc trưng (HA, Nano HA, Super HA) kết hợp với 3X Ceramide & Dầu hạt Chia giúp giữ nước, cấp ẩm chuyên sâu và giảm khô ráp tức thì. Hàng rào bảo vệ da được cải thiện và tăng độ ẩm đến 1,6 lần.\r\n\r\n\r\nCông nghệ Retinol Carnauba Wax Capsule đưa dưỡng chất thấm sâu vào lớp biểu bì giúp da hấp thụ tối đa & hạn chế kích ứng.\r\n\r\n\r\nCông thức dịu nhẹ với pH cân bằng, không cồn, không hệ xà phòng, không Paraben, không hương liệu, không chất tạo màu, không dầu khoáng',97000.00,92,'/images/products/kemruamatcaithiendauhieulaohoa.png',2,'Hada Labo','2024-10-08 08:08:26',10.00,0.00,1),(18,'Kem rửa mặt cho da mụn, nhạy cảm','Bọt kem mềm mịn chứa thành phần làm sạch gốc tự nhiên lấy sạch bụi bẩn, bã nhờn ẩn sâu trong lỗ chân lông, nguyên nhân chính gây mụn.\r\n\r\n\r\nTranexamic Acid kết hợp với hệ thực vật gồm chiết xuất Hạt Ý Dĩ, Rau Diếp Cá và Cúc La Mã giúp kháng khuẩn và giảm mụn hiệu quả, bảo vệ da trước tác nhân gây mụn.\r\n\r\n\r\nHệ dưỡng ẩm sâu HA cùng Squalane cung cấp độ ẩm tối ưu, ngăn ngừa tình trạng khô da và giúp giảm dầu thừa, nuôi dưỡng làn da sáng khỏe.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: công thức dịu nhẹ với pH cân bằng, không cồn, không hệ xà phòng, không Sulfate, không Paraben, không hương liệu, không chất tạo màu, không dầu khoáng.',95000.00,96,'/images/products/kemruamatchodamunnhaycam.png',2,'Hada Labo','2024-10-08 08:09:14',0.00,0.00,1),(19,'Kem rửa mặt dưỡng ẩm','Bọt kem mềm mịn chứa thành phần làm sạch gốc tự nhiên lấy sạch bụi bẩn, bã nhờn ẩn sâu trong lỗ chân lông và làm sạch tế bào chết trên da.\r\n\r\n\r\nLần đầu tiên trên thế giới, Hyaluronic Acid lên men tự nhiên (Fermented HA) kết hợp hệ dưỡng ẩm sâu HA đặc trưng (HA, Super HA, Nano HA) giúp giảm tình trạng mất nước, củng cố màng ẩm tự nhiên bảo vệ da.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: công thức dịu nhẹ với pH cân bằng, không cồn, không hệ xà phòng, không Sulfate, không Paraben, không hương liệu, không chất tạo màu, không dầu khoáng.',75000.00,98,'/images/products/kemruamatduongam.png',2,'Hada Labo','2024-10-08 08:10:09',0.00,0.00,1),(20,'Kem rửa mặt dưỡng trắng Hada Labo','Bọt kem mềm mịn với công nghệ Amino Acid có nguồn gốc tự nhiên lấy sạch bụi bẩn, bã nhờn trong lỗ chân lông và tế bào chết trên da.\r\n\r\n\r\nTranexamic Acid kết hợp Vitamin C và E giúp mờ thâm sạm, dưỡng da sáng khỏe sau 7 ngày.\r\n\r\n\r\nHệ dưỡng ẩm HA (HA & Nano HA) kết hợp chiết xuất Hạt Ý Dĩ lên men tự nhiên giúp cấp ẩm chuyên sâu, dưỡng da ẩm mịn.\r\n\r\n\r\nCông thức dịu nhẹ với pH cân bằng, không cồn, không hệ xà phòng, không Sulfate, không Paraben, không hương liệu, không chất tạo màu, không dầu khoáng.',93000.00,96,'/images/products/kemruamatduongtrang.png',2,'Hada Labo','2024-10-08 08:12:30',0.00,0.00,1),(21,'Bọt rửa mặt dưỡng ẩm','Công nghệ Amino Acid với Bọt bông mềm mịn nhẹ nhàng lấy đi bụi bẩn, bã nhờn ẩn sâu trong lỗ chân lông và làm sạch tế bào chết trên da.\r\n\r\n\r\nHệ dưỡng ẩm sâu HA gồm HA và Super HA giúp duy trì và cấp ẩm tối ưu, giữ cho làn da ẩm mượt ngay cả khi rửa mặt.\r\n\r\n\r\nCông thức làm sạch dịu nhẹ không chứa hệ xà phòng, không cồn, không Sulfate, không Paraben, không hương liệu, không chất tạo màu.',195000.00,94,'/images/products/botruamatduongam.png',2,'Hada Labo','2024-10-08 08:13:14',0.00,0.00,1),(22,' Bọt rửa mặt dưỡng ẩm (Túi Refill)','Công nghệ Amino Acid với Bọt bông mềm mịn nhẹ nhàng lấy đi bụi bẩn, bã nhờn ẩn sâu trong lỗ chân lông và làm sạch tế bào chết trên da.\r\n\r\n\r\nHệ dưỡng ẩm sâu HA gồm HA và Super HA giúp duy trì và cấp ẩm tối ưu, giữ cho làn da ẩm mượt ngay cả khi rửa mặt.\r\n\r\n\r\nCông thức làm sạch dịu nhẹ không chứa hệ xà phòng, không cồn, không Sulfate, không Paraben, không hương liệu, không chất tạo màu.',130000.00,98,'/images/products/botruamatduongtamtuirefill.png',2,'Hada Labo','2024-10-08 08:14:12',0.00,0.00,1),(23,'Dung dịch dưỡng cải thiện dấu hiệu lão hóa Hada Labo','Retinol kết hợp 2% Niacinamide (B3) và Collagen giúp làm mờ nếp nhăn, cải thiện độ đàn hồi, dưỡng sáng các vùng da sạm màu, cho da trông tươi trẻ và săn chắc sau 7 ngày\r\n\r\n\r\nHệ dưỡng ẩm sâu HA đặc trưng (HA, Nano HA, Super HA) kết hợp với 3X Ceramide & Dầu hạt Chia giúp giữ nước, cấp ẩm chuyên sâu và giảm khô ráp tức thì. Hàng rào bảo vệ da được cải thiện và tăng độ ẩm đến 1,6 lần\r\n\r\n\r\nCông nghệ Retinol Carnauba Wax Capsule đưa dưỡng chất thấm sâu vào lớp biểu bì giúp da hấp thụ tối đa & hạn chế kích ứng.\r\n\r\n\r\nKhông Paraben, không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, pH cân bằng.',290000.00,95,'/images/products/dungdichduongcaithiendauhieulaohoa.png',3,'Hada Labo','2024-10-08 08:19:51',0.00,0.00,1),(24,'Túi refill dung dịch dưỡng ẩm (Da dầu)','Lần đầu tiên trên thế giới, Hyaluronic Acid lên men tự nhiên (Fermented HA) giúp giảm tình trạng mất nước, củng cố màng ẩm tự nhiên bảo vệ da.\r\n\r\n\r\nKết hợp hệ dưỡng ẩm sâu HA đặc trưng (HA, Super HA, Nano HA) giúp cung cấp độ ẩm tối ưu, duy trì làn da ẩm mượt suốt 36 giờ.\r\n\r\n\r\nCông thức dịu nhẹ không Paraben, không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, pH cân bằng.',159000.00,97,'/images/products/tuirefilldungdichduongamdadau.png',3,'Hada Labo','2024-10-08 08:21:29',0.00,0.00,1),(25,' Túi refill dung dịch dưỡng ẩm (Da thường, Da khô)','Lần đầu tiên trên thế giới, Hyaluronic Acid lên men tự nhiên (Fermented HA) giúp giảm tình trạng mất nước, củng cố màng ẩm tự nhiên bảo vệ da.\r\n\r\n\r\nKết hợp hệ dưỡng ẩm sâu HA đặc trưng (HA, Super HA, Nano HA) giúp cung cấp độ ẩm tối ưu, duy trì làn da ẩm mượt suốt 36 giờ.\r\n\r\n\r\nCông thức dịu nhẹ không Paraben, không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, pH cân bằng.',159000.00,99,'/images/products/tuirefilldungdichduongamdathuongdakho.png',3,'Hada Labo','2024-10-08 08:22:34',0.00,0.00,1),(26,' Dung dịch dưỡng ẩm cho da mụn, nhạy cảm','Tranexamic Acid 0,5% kết hợp với hệ thực vật gồm chiết xuất Hạt Ý Dĩ, Rau Diếp Cá và Cúc La Mã giúp kháng khuẩn và giảm mụn hiệu quả, bảo vệ da trước tác nhân gây mụn.\r\n\r\n\r\nHệ dưỡng ẩm sâu HA cùng Squalane cung cấp độ ẩm tối ưu, ngăn ngừa tình trạng khô da và giúp giảm dầu thừa, nuôi dưỡng làn da sáng khỏe.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: công thức dịu nhẹ với pH cân bằng, không cồn, không Sulfate, không Paraben, không hương liệu, không chất tạo màu, không dầu khoáng.',270000.00,96,'/images/products/dungdichduongamchodamunnhaycam.png',3,'Hada Labo','2024-10-08 08:23:17',0.00,0.00,1),(27,'Dung dịch dưỡng ẩm (Da thường, Da khô)','Lần đầu tiên trên thế giới, Hyaluronic Acid lên men tự nhiên (Fermented HA) giúp giảm tình trạng mất nước, củng cố màng ẩm tự nhiên bảo vệ da.\r\n\r\n\r\nKết hợp hệ dưỡng ẩm sâu HA đặc trưng (HA, Super HA, Nano HA) giúp cung cấp độ ẩm tối ưu, duy trì làn da ẩm mượt suốt 36 giờ.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: công thức dịu nhẹ không Paraben, không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, pH cân bằng.',55000.00,97,'/images/products/dungdichduongamdathuongdakho.png',3,'Hada Labo','2024-10-08 08:35:18',0.00,0.00,1),(28,'Dung dịch dưỡng ẩm (Da thường, da khô)','Lần đầu tiên trên thế giới, Hyaluronic Acid lên men tự nhiên (Fermented HA) giúp giảm tình trạng mất nước, củng cố màng ẩm tự nhiên bảo vệ da.\r\n\r\n\r\nKết hợp hệ dưỡng ẩm sâu HA đặc trưng (HA, Super HA, Nano HA) giúp cung cấp độ ẩm tối ưu, duy trì làn da ẩm mượt suốt 36 giờ.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: công thức dịu nhẹ không Paraben, không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, pH cân bằng.',190000.00,100,'/images/products/dungdichduongamdathuongdakhoto.png',3,'Hada Labo','2024-10-08 08:36:06',0.00,0.00,1),(29,'Dung dịch dưỡng ẩm (Da thường, da khô)','\r\nLần đầu tiên trên thế giới, Hyaluronic Acid lên men tự nhiên (Fermented HA) giúp giảm tình trạng mất nước, củng cố màng ẩm tự nhiên bảo vệ da.\r\n\r\n\r\nKết hợp hệ dưỡng ẩm sâu HA đặc trưng (HA, Super HA, Nano HA) giúp cung cấp độ ẩm tối ưu, duy trì làn da ẩm mượt suốt 36 giờ.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: công thức dịu nhẹ không Paraben, không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, pH cân bằng.',130000.00,97,'/images/products/dungdichduongamdathuongdakho100ml.png',3,'Hada Labo','2024-10-08 08:36:58',0.00,0.00,1),(30,' Dung dịch dưỡng ẩm (Da dầu)','Lần đầu tiên trên thế giới, Hyaluronic Acid lên men tự nhiên (Fermented HA) giúp giảm tình trạng mất nước, củng cố màng ẩm tự nhiên bảo vệ da.\r\n\r\n\r\nKết hợp hệ dưỡng ẩm sâu HA đặc trưng (HA, Super HA, Nano HA) giúp cung cấp độ ẩm tối ưu, duy trì làn da ẩm mượt suốt 36 giờ.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: công thức dịu nhẹ không Paraben, không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, pH cân bằng.',190000.00,100,'/images/products/dungdichduongamdadau170ml.png',3,'Hada Labo','2024-10-08 08:37:40',0.00,0.00,1),(31,' Dung dịch dưỡng ẩm (Da dầu)','Lần đầu tiên trên thế giới, Hyaluronic Acid lên men tự nhiên (Fermented HA) giúp giảm tình trạng mất nước, củng cố màng ẩm tự nhiên bảo vệ da.\r\n\r\n\r\nKết hợp hệ dưỡng ẩm sâu HA đặc trưng (HA, Super HA, Nano HA) giúp cung cấp độ ẩm tối ưu, duy trì làn da ẩm mượt suốt 36 giờ.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: công thức dịu nhẹ không Paraben, không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, pH cân bằng.',130000.00,100,'/images/products/dungdichduongamdadau100ml.png',3,'Hada Labo','2024-10-08 08:38:12',0.00,0.00,1),(32,'Bộ Kit du lịch','Lần đầu tiên trên thế giới, Hyaluronic Acid lên men tự nhiên (Fermented HA) giúp giảm tình trạng mất nước, củng cố màng ẩm tự nhiên bảo vệ da.\r\n\r\n\r\nKết hợp hệ dưỡng ẩm sâu HA đặc trưng (HA, Super HA, Nano HA) giúp cung cấp độ ẩm tối ưu, duy trì làn da ẩm mượt suốt 36 giờ.\r\n\r\n\r\nĐã kiểm nghiệm dịu nhẹ, an toàn cho da: công thức dịu nhẹ không Paraben, không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, pH cân bằng.',85000.00,100,'/images/products/bokitdulich.png',3,'Hada Labo','2024-10-08 08:39:11',0.00,0.00,1),(33,' Dung dịch dưỡng trắng Hada Labo','1% Tranexamic Acid, Niacinamide kết hợp Vitamin C và E giúp mờ thâm sạm, dưỡng da sáng khỏe, rạng rỡ sau 7 ngày.\r\n\r\n\r\nHệ dưỡng ẩm HA (HA & Nano HA) kết hợp chiết xuất Hạt Ý Dĩ lên men tự nhiên giúp cấp ẩm chuyên sâu, dưỡng da ẩm mịn.\r\n\r\n\r\nKhông cồn, không Sulfate, không Paraben, không hương liệu, không chất tạo màu, không dầu khoáng.',260000.00,100,'/images/products/dungdichduongtrang.png',3,'Hada Labo','2024-10-08 08:39:52',0.00,0.00,1),(34,'Dung dịch dưỡng chuyên biệt Hada Labo','Công nghệ Elastin lift (Elastin, Collagen & 3D HA) tạo màng lưới nâng cơ, giúp làm mờ & hạn chế nếp nhăn.\r\n\r\n\r\nRetinol thúc đẩy quá trình loại bỏ tế bào chết, ức chế sự hình thành hắc tố melanin, cải thiện thâm, nám hiệu quả.\r\n\r\n\r\nHA, SHA & Nano HA dưỡng ẩm sâu, tái tạo cấu trúc đàn hồi, khắc phục tình trạng khô sạm da.',220000.00,99,'/images/products/dungdichduongchuyenbiet.png',3,'Hada Labo','2024-10-08 08:40:33',0.00,0.00,1),(35,'Dung dịch dưỡng trắng cao cấp','Tranexamic Acid kết hợp Vitamin C và E giúp dưỡng trắng và ức chế sản sinh melanin, cải thiện thâm nám, tàn nhang hiệu quả.\r\n\r\n\r\nHệ dưỡng ẩm HA (HA & Nano HA) giúp cấp ẩm chuyên sâu cho da ẩm mịn, đàn hồi.\r\n\r\n\r\nDipotassium Glycyrrhizate giúp kháng viêm và làm dịu da thô ráp, cháy nắng tức thì.\r\n\r\n\r\nCông thức dịu nhẹ với pH cân bằng, không cồn, không Paraben, không hương liệu, không chất tạo màu, không dầu khoáng.',330000.00,99,'/images/products/dungdichduongtrangcaocap.png',3,'Hada Labo','2024-10-08 08:41:10',0.00,0.00,1),(36,' Dung dịch dưỡng ẩm cao cấp','Hệ dưỡng ẩm toàn diện 7 loại HA (HA, Super HA, Nano HA, Binding HA, 3D HA, Fermented HA, Penetrating HA) đóng vai trò như một dạng tinh chất cấp ẩm chuyên sâu, nuôi dưỡng và phục hồi màng ẩm tự nhiên, tăng cường độ đàn hồi.\r\n\r\n\r\nCông thức dịu nhẹ không Paraben, không cồn, không hương liệu, không chất tạo màu, không dầu khoáng, pH cân bằng.',294000.00,100,'/images/products/dungdichduongamcaocap.png',3,'Hada Labo','2024-10-08 08:41:49',0.00,0.00,1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `review_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`review_id`),
  KEY `product_id` (`product_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_address`
--

DROP TABLE IF EXISTS `shipping_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_address` (
  `address_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `recipient_name` varchar(255) NOT NULL,
  `recipient_phone` varchar(15) NOT NULL,
  `address_line` varchar(255) NOT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`address_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `shipping_address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_address`
--

LOCK TABLES `shipping_address` WRITE;
/*!40000 ALTER TABLE `shipping_address` DISABLE KEYS */;
INSERT INTO `shipping_address` VALUES (1,28,'Phạm Văn Vinh','0327871942','Thanh Oai- Hà Nội',0),(2,28,'Nguyễn Thị Hải','0399133782','ha noi 22222',0),(3,29,'pham van vu 2','0379828791','Ha tay',0),(4,29,'pham van vinh 22','0327871942','Ha tay',0),(5,28,'Nguyễn Hoàng Tiến','0363636363','Hoằng Hoá- Thanh Hoá',0);
/*!40000 ALTER TABLE `shipping_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag` (
  `tag_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

LOCK TABLES `tag` WRITE;
/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag` VALUES (2,'Best Seller'),(1,'New');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `enabled` tinyint(4) DEFAULT 1,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2a$10$/6v/SOqeB2dL2wkbpjABO.9JoEdlovSsTnAUygZQpHMPmqaN1hzQ.','admin@gmail.com',NULL,1),(28,'vinh','$2a$10$XqSAZpWnJAW6gVb0a0RiwOWgvk1SDKJc5DizhIXWnYCIcKJImAy9W','vinh9a72003@gmail.com','0327871942',1),(29,'vu','$2a$10$wWxKoNgOxxjhl1dBcAb3v.bUIqTCo95yKoaGi1ubGiJ37TEboyy0S','vu@gmail.com','0379828791',1),(30,'tien','$2a$10$zeyb9ueMQbujK63LmlexU.uvsHxRQYko8WMWQ.CcXsyKAOAHFionG','tien@gmail.com','0363636362',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher`
--

DROP TABLE IF EXISTS `voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher` (
  `voucher_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `discount` int(11) NOT NULL,
  `start_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `end_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `min_purchase` decimal(10,2) DEFAULT 0.00,
  `usage_limit` int(11) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`voucher_id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher`
--

LOCK TABLES `voucher` WRITE;
/*!40000 ALTER TABLE `voucher` DISABLE KEYS */;
/*!40000 ALTER TABLE `voucher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-17 18:25:51
