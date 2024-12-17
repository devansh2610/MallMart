-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: mallmart
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_id` int NOT NULL,
  `admin_user` varchar(45) NOT NULL,
  `admin_pass` varchar(45) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,'root','root');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `customer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`product_id`,`customer_id`),
  KEY `cust_id_idx` (`customer_id`),
  KEY `product_ki_id_idx` (`product_id`),
  CONSTRAINT `cust_id` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `product_ki_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1008,2003,3),(1010,2005,1),(1010,2007,4),(1009,2008,7),(1002,2010,4);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1001,'Electronics'),(1002,'Clothing'),(1003,'Home & Kitchen'),(1004,'Books'),(1005,'Body & Personal Care'),(1006,'Sports & Outdoors'),(1007,'Toys & Games'),(1008,'Auotomotive'),(1009,'Health & Household'),(1010,'Grocery & Gourmet Food');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupons`
--

DROP TABLE IF EXISTS `coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupons` (
  `coupon_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `start_time` timestamp NOT NULL,
  `end_time` timestamp NOT NULL,
  PRIMARY KEY (`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupons`
--

LOCK TABLES `coupons` WRITE;
/*!40000 ALTER TABLE `coupons` DISABLE KEYS */;
INSERT INTO `coupons` VALUES (5001,'FEB2024SALE','2024-01-31 18:30:00','2024-02-15 18:29:59'),(5002,'FREEDELIVERY','2024-02-09 18:30:00','2024-02-28 18:29:59'),(5003,'SPRINGSALE10','2024-02-29 18:30:00','2024-03-15 18:29:59'),(5004,'MEMORIALDAY20','2024-05-19 18:30:00','2024-05-31 18:29:59');
/*!40000 ALTER TABLE `coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `street_name` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `zip` varchar(45) NOT NULL,
  `dob` date NOT NULL,
  `phone` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1001,'Aarav','Sharma','Rajpur Road','Dehradun','Uttarakhand','248001','1988-03-10','+91 98765 43210','aarav.sharma@example.com'),(1002,'Aisha','Khan','MG Road','Bangalore','Karnataka','560001','1995-10-05','+91 87654 32109','aisha.khan@example.com'),(1003,'Vikram','Singh','Civil Lines','Allahabad','Uttar Pradesh','211001','1980-01-20','+91 76543 21098','vikram.singh@example.com'),(1004,'Priya','Patel','Station Road','Surat','Gujarat','395001','1992-05-15','+91 98765 67890','priya.patel@example.com'),(1005,'Arjun','Reddy','Jubilee Hills','Hyderabad','Telangana','500001','1986-11-08','+91 87654 32109','arjun.reddy@example.com'),(1006,'Nisha','Gupta','Civil Lines','Jaipur','Rajasthan','302001','1990-04-25','+91 76543 21098','nisha.gupta@example.com'),(1007,'Rohan','Malhotra','MG Road','Delhi','Delhi','110001','1983-09-30','+91 98765 67890','rohan.malhotra@example.com'),(1008,'Ananya','Desai','Ashram Road','Ahmedabad','Gujarat','380001','1993-02-12','+91 87654 32109','ananya.desai@example.com'),(1009,'Siddharth','Iyer','Kamaraj Road','Chennai','Tamil Nadu','600001','1984-07-17','+91 76543 21098','siddharth.iyer@example.com'),(1010,'Meera','Menon','MG Road','Kochi','Kerala','682001','1989-12-03','+91 98765 67890','meera.menon@example.com'),(1011,'Dev','Sharma','Nehru Nagar','Indore','Madhya Pradesh','452001','1987-03-22','+91 87654 32109','dev.sharma@example.com'),(1012,'Ritu','Verma','Lalbagh Road','Lucknow','Uttar Pradesh','226001','1991-10-10','+91 76543 21098','ritu.verma@example.com'),(1013,'Ajay','Dubey','Station Road','Patna','Bihar','800001','1982-01-05','+91 98765 67890','ajay.dubey@example.com'),(1014,'Shreya','Choudhury','Bistupur Main Road','Jamshedpur','Jharkhand','831001','1986-08-12','+91 87654 32109','shreya.choudhury@example.com');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `person_id` int NOT NULL,
  `status` varchar(45) NOT NULL,
  `payment_method` varchar(45) NOT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`person_id`),
  KEY `delivery_order_idx` (`order_id`),
  CONSTRAINT `delivery_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (8001,'Delivering','Cash on Delivery',7001),(8002,'Delivered','Online Payment',7002),(8003,'Out for Delivery','Cash on Delivery',7003),(8004,'Delivering','Online Payment',7004),(8005,'Delivered','Cash on Delivery',7005);
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL,
  `stars` int NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`feedback_id`),
  KEY `order_ki_id_idx` (`order_id`),
  CONSTRAINT `order_linked_id` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (9001,5,'Excellent service! Highly recommended.',7001),(9002,4,'Good product quality. Will buy again.',7002),(9003,3,'Average quality. Could be better.',7003),(9004,5,'Fast delivery and great quality of packaging!',7004),(9005,2,'Product was damaged upon arrival.',7005);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `customer_order_idx` (`customer_id`),
  KEY `prod_id_idx` (`product_id`),
  CONSTRAINT `customer_order` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  CONSTRAINT `prod_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7009 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (7001,1001,2003,3),(7002,1002,2007,2),(7003,1003,2002,5),(7004,1004,2006,6),(7005,1005,2001,3),(7006,1006,2001,3),(7007,1001,2007,3),(7008,1001,2007,3);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `category_id` int NOT NULL,
  `vendor_id` int NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `cat_id_idx` (`category_id`),
  KEY `vend_id_idx` (`vendor_id`),
  CONSTRAINT `cat_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`),
  CONSTRAINT `vend_id` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (2001,'Wireless Bluetooth Headphones',50,1001,6001),(2002,'Men\'s T-Shirt',20,1002,6001),(2003,'Stainless Steel Cookware Set',130,1003,6003),(2004,'The Great Gatsby - Paperback',10,1004,6002),(2005,'Moisturizer',30,1005,6005),(2006,'Yoga Mat',25,1006,6004),(2007,'LEGO Classic Set',40,1007,6004),(2008,'Car Windshield Wiper Blades',15,1008,6002),(2009,'Multivitamin Supplement Tablets',20,1009,6003),(2010,'Olive Oil',13,1010,6003),(2011,'Novel',27,1004,6002);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `transaction_id` int NOT NULL,
  `transaction_date` varchar(45) NOT NULL,
  `payment_mode` varchar(45) NOT NULL,
  `amount` float NOT NULL,
  `order_id` int NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `cart_transaction_idx` (`order_id`),
  CONSTRAINT `cart_transaction` FOREIGN KEY (`order_id`) REFERENCES `order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (10001,'2024-02-12','Credit Card',390,7001),(10002,'2024-02-12','Online Banking',80,7002),(10003,'2024-02-12','Cash on Delivery',100,7003),(10004,'2024-02-12','Credit Card',150,7004),(10005,'2024-02-12','Online Banking',150,7005);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vendor`
--

DROP TABLE IF EXISTS `vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vendor` (
  `vendor_id` int NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `gender` varchar(45) NOT NULL,
  `street_number` varchar(45) NOT NULL,
  `street_name` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `zip` int NOT NULL,
  `age` int NOT NULL,
  PRIMARY KEY (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vendor`
--

LOCK TABLES `vendor` WRITE;
/*!40000 ALTER TABLE `vendor` DISABLE KEYS */;
INSERT INTO `vendor` VALUES (6001,'Rahul','Sharma','rahul.sharma@example.com','+91 98765 43210','Male','123','Gandhi Road','Mumbai','Maharashtra',400001,40),(6002,'Priya','Patel','priya.patel@example.com','+91 87654 32109','Female','456','Sardar Patel Marg','Bangalore','Karnataka',560001,35),(6003,'Amit','Kumar','amit.kumar@example.com','+91 76543 21098','Male','789','Jawaharlal Nehru Street','Delhi','Delhi',110001,43),(6004,'Neha','Singh','neha.singh@example.com','+91 65432 10987','Female','101','Indira Gandhi Road','Chennai','Tamil Nadu',600001,38),(6005,'Vikram','Gupta','vikram.gupta@example.com','+91 54321 98765','Male','222','Rajiv Chowk','Kolkata','West Bengal',700001,41);
/*!40000 ALTER TABLE `vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse` (
  `warehouse_id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `street_name` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `zip` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `vendor_id` int NOT NULL,
  PRIMARY KEY (`warehouse_id`),
  KEY `vendor_warehouse_idx` (`vendor_id`),
  CONSTRAINT `vendor_warehouse` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES (3001,'Main Warehouse','Warehouse Street','Mumbai','Maharashtra','400001','+91 98765 43210',6001),(3002,'Central Warehouse','Supply Street','Delhi','Delhi','110001','+91 87654 32109',6002),(3003,'Northern Warehouse','Logistics Avenue','Kolkata','West Bengal','700001','+91 76543 21098',6003),(3004,'Southern Warehouse','Inventory Road','Chennai','Tamil Nadu','600001','+91 65432 10987',6004),(3005,'Eastern Warehouse','Dispatch Lane','Bangalore','Karnataka','560001','+91 54321 98765',6005);
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-31 22:16:20
