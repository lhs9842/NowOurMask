-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: wearmask
-- ------------------------------------------------------
-- Server version	5.7.34-log

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
-- Table structure for table `maskwarning`
--

DROP TABLE IF EXISTS `maskwarning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maskwarning` (
  `idx` int(11) NOT NULL,
  `bad_warning` tinyint(4) NOT NULL DEFAULT '0',
  `non_warning` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maskwarning`
--

LOCK TABLES `maskwarning` WRITE;
/*!40000 ALTER TABLE `maskwarning` DISABLE KEYS */;
INSERT INTO `maskwarning` VALUES (1,0,0),(2,0,0),(3,0,0),(4,0,0),(5,0,0),(6,0,0),(7,0,0),(8,0,0),(9,0,0),(10,0,0),(11,0,0),(12,0,0),(13,0,0),(14,0,0),(15,0,0),(16,0,0),(17,0,0),(18,0,0),(19,0,0),(20,0,0),(21,0,0),(22,0,0),(23,0,0),(24,0,0),(25,0,0),(26,0,0),(27,0,0),(28,0,0),(29,0,0),(30,0,0),(31,0,0),(32,0,0),(33,0,0),(34,0,0),(35,0,0),(36,0,0),(37,0,0),(38,0,0);
/*!40000 ALTER TABLE `maskwarning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentinfo`
--

DROP TABLE IF EXISTS `studentinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentinfo` (
  `idx` int(11) NOT NULL,
  `stdId` varchar(10) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idx`),
  UNIQUE KEY `stdid_UNIQUE` (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentinfo`
--

LOCK TABLES `studentinfo` WRITE;
/*!40000 ALTER TABLE `studentinfo` DISABLE KEYS */;
INSERT INTO `studentinfo` VALUES (1,'1726001','가나다'),(2,'1726002','홍길동'),(3,'1726003','김철수'),(4,'1726004','박영희'),(5,NULL,NULL),(6,NULL,NULL),(7,NULL,NULL),(8,NULL,NULL),(9,NULL,NULL),(10,NULL,NULL),(11,NULL,NULL),(12,NULL,NULL),(13,NULL,NULL),(14,NULL,NULL),(15,NULL,NULL),(16,NULL,NULL),(17,'1926001','나학생'),(18,'1926002','이길동'),(19,NULL,NULL),(20,NULL,NULL),(21,NULL,NULL),(22,NULL,NULL),(23,NULL,NULL),(24,NULL,NULL),(25,NULL,NULL),(26,NULL,NULL),(27,NULL,NULL),(28,NULL,NULL),(29,NULL,NULL),(30,NULL,NULL),(31,NULL,NULL),(32,NULL,NULL),(33,NULL,NULL),(34,NULL,NULL),(35,NULL,NULL),(36,NULL,NULL),(37,NULL,NULL),(38,NULL,NULL);
/*!40000 ALTER TABLE `studentinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentreport`
--

DROP TABLE IF EXISTS `studentreport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentreport` (
  `idx` int(11) NOT NULL,
  `attend` tinyint(4) NOT NULL DEFAULT '0',
  `maskminuspoint` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idx`),
  KEY `idx_idx` (`idx`),
  KEY `idx_idx1` (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentreport`
--

LOCK TABLES `studentreport` WRITE;
/*!40000 ALTER TABLE `studentreport` DISABLE KEYS */;
INSERT INTO `studentreport` VALUES (1,0,0),(2,0,0),(3,0,0),(4,0,0),(5,0,0),(6,0,0),(7,0,0),(8,0,0),(9,0,0),(10,0,0),(11,0,0),(12,0,0),(13,0,0),(14,0,0),(15,0,0),(16,0,0),(17,0,0),(18,0,0),(19,0,0),(20,0,0),(21,0,0),(22,0,0),(23,0,0),(24,0,0),(25,0,0),(26,0,0),(27,0,0),(28,0,0),(29,0,0),(30,0,0),(31,0,0),(32,0,0),(33,0,0),(34,0,0),(35,0,0),(36,0,0),(37,0,0),(38,0,0);
/*!40000 ALTER TABLE `studentreport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `studentstatus`
--

DROP TABLE IF EXISTS `studentstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `studentstatus` (
  `idx` int(11) NOT NULL,
  `attendTime` int(11) NOT NULL DEFAULT '0',
  `goodMaskTime` int(11) NOT NULL DEFAULT '0',
  `badMaskTime` int(11) NOT NULL DEFAULT '0',
  `nonMaskTime` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `studentstatus`
--

LOCK TABLES `studentstatus` WRITE;
/*!40000 ALTER TABLE `studentstatus` DISABLE KEYS */;
INSERT INTO `studentstatus` VALUES (1,0,0,0,0),(2,0,0,0,0),(3,0,0,0,0),(4,0,0,0,0),(5,0,0,0,0),(6,0,0,0,0),(7,0,0,0,0),(8,0,0,0,0),(9,0,0,0,0),(10,0,0,0,0),(11,0,0,0,0),(12,0,0,0,0),(13,0,0,0,0),(14,0,0,0,0),(15,0,0,0,0),(16,0,0,0,0),(17,0,0,0,0),(18,0,0,0,0),(19,0,0,0,0),(20,0,0,0,0),(21,0,0,0,0),(22,0,0,0,0),(23,0,0,0,0),(24,0,0,0,0),(25,0,0,0,0),(26,0,0,0,0),(27,0,0,0,0),(28,0,0,0,0),(29,0,0,0,0),(30,0,0,0,0),(31,0,0,0,0),(32,0,0,0,0),(33,0,0,0,0),(34,0,0,0,0),(35,0,0,0,0),(36,0,0,0,0),(37,0,0,0,0),(38,0,0,0,0);
/*!40000 ALTER TABLE `studentstatus` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-27 14:08:45
