-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ipl3
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auction` (
  `auction_id` int NOT NULL AUTO_INCREMENT,
  `player_id` int DEFAULT NULL,
  `player_name` varchar(20) DEFAULT NULL,
  `initial_bid` varchar(10) DEFAULT NULL,
  `sold_for` int DEFAULT NULL,
  `bought_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`auction_id`),
  KEY `Auction_ibfk_1` (`player_id`),
  CONSTRAINT `Auction_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player` (`player_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
INSERT INTO `auction` (`auction_id`, `player_id`, `player_name`, `initial_bid`, `sold_for`, `bought_by`) VALUES (1,70,'Pat cummins','2 cr',155000000,'RCB'),(2,145,'chris lynn','2 cr',20000000,'MI'),(3,77,'Eoin Morgan','h1.5 cr',52500000,'KKR'),(4,5,'Robin Uthappa','1.5 cr',30000000,'RR'),(5,162,'Jason Roy','1.5 cr',15000000,'DC'),(6,89,'Aaron Finch','1 cr',44000000,'RCB'),(7,66,'Rahul Tripathi','20 lakh',6000000,'KKR'),(8,164,'Virat Singh','20 lakh',19000000,'SRH'),(9,165,'Priyam Garg','20 lakh',19000000,'SRH'),(10,167,'Shimron Hetmyer','50 lakh',75000000,'DC'),(11,6,'David Miller','75 lakh',7500000,'RR'),(12,168,'Saurabh Tiwary','50 lakh',5000000,'MI'),(13,69,'Tom Banton','1 cr',10000000,'KKR'),(14,11,'Jaydev Unadkat','1 cr',30000000,'RR'),(15,169,'Nathan Coulter-nile','1 cr',80000000,'MI'),(16,50,'Sheldon Cotrell','50 lakh',5000000,'KXIP'),(17,170,'Piyush Chawla','1 cr',67500000,'CSK'),(18,13,'Akash Singh','20 lakh',13000000,'RR'),(19,12,'Kartik Tyagi','20 lakh',154000000,'RR'),(20,64,'Ishan Porel','20 lakh',2000000,'KXIP'),(21,171,'M Siddharth','20 lakh',2000000,'KKR'),(22,65,'Ravi Bishnoi','20 lakh',20000000,'KXIP'),(23,172,'Josh Hazlewood','2 cr',20000000,'CSK'),(24,173,'Mohsin Khan','20 lakh',2000000,'MI'),(25,105,'Kane Richardson','1.5 cr',40000000,'RCB'),(26,14,'Oshane Thomas','50 lakh',5000000,'RR'),(27,88,'Parvin Tambe','20 lakh',2000000,'KKR'),(28,174,'Mohit Sharma','20 lakh',2000000,'DC'),(29,42,'Tushar Deshpande','20 lakh',2000000,'DC'),(30,175,'R sai Kishore','20 lakh',2000000,'CSK'),(31,104,'Dale steyn','2 cr',20000000,'RCB'),(32,15,'Andrew Tye','1 cr',10000000,'RR'),(33,178,'Alex carey','50 lakh',24000000,'DC'),(34,24,'Anuj Rawat','20 lakh',8000000,'RR'),(35,176,'Joshua Phillipe','20 lakh',2000000,'RCB'),(36,177,'Prabhsimran Singh','20 lakh',5500000,'KXIP'),(37,98,'Shahbaz Ahmad','20 lakh',2000000,'RCB'),(38,79,'Nikhil Naik','20 lakh',2000000,'KKR'),(39,58,'Glenn Maxwell','2 cr',107500000,'KXIP'),(40,163,'Chris Woakes','1.5 cr',15000000,'DC'),(48,2,'Manan Vohra','50 lakh',8000000,'GL');
/*!40000 ALTER TABLE `auction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS auction_add_player */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`DBMS`@`localhost`*/ /*!50003 TRIGGER `auction_add_player` AFTER INSERT ON `auction` FOR EACH ROW BEGIN
       DECLARE newTeamID INT;
       DECLARE oldTeamID INT;
        SELECT team_id FROM Team WHERE team_name = new.bought_by INTO newTeamID;
        SELECT team_id FROM player WHERE player_id = new.player_id INTO oldTeamID;

       UPDATE Team T
       SET T.no_of_players = T.no_of_players + 1
       WHERE T.team_name = new.bought_by;

      UPDATE Team T
       SET T.no_of_players = T.no_of_players - 1
       WHERE T.team_id = oldTeamID;

       UPDATE Player P
       SET P.team_id = newTeamID,
           P.team_name = new.bought_by,
           P.date_joined = curdate()
       WHERE P.player_id = new.player_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS auction_change_team */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`DBMS`@`localhost`*/ /*!50003 TRIGGER `auction_change_team` AFTER UPDATE ON `auction` FOR EACH ROW BEGIN
        DECLARE newTeamID INT;
        SELECT team_id FROM Team WHERE team_name = new.bought_by INTO newTeamID;

        UPDATE Team T
        SET T.no_of_players = T.no_of_players - 1
        WHERE T.team_name = old.bought_by;

        UPDATE Team T
        SET T.no_of_players = T.no_of_players + 1
        WHERE T.team_name = new.bought_by;

        UPDATE Player P
        SET P.team_id = newTeamID,
            P.team_name = new.bought_by,
            P.date_joined = curdate()
        WHERE P.player_id = new.player_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `broadcastchannel`
--

DROP TABLE IF EXISTS `broadcastchannel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `broadcastchannel` (
  `channel_id` int NOT NULL AUTO_INCREMENT,
  `channel_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`channel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `broadcastchannel`
--

LOCK TABLES `broadcastchannel` WRITE;
/*!40000 ALTER TABLE `broadcastchannel` DISABLE KEYS */;
INSERT INTO `broadcastchannel` (`channel_id`, `channel_name`) VALUES (1,'Star Sports 1'),(2,'Star Sports 2'),(3,'Star Sports 3'),(4,'Star Sports 1 HD'),(5,'Star Sports 2 HD'),(6,'Hotstar');
/*!40000 ALTER TABLE `broadcastchannel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coach`
--

DROP TABLE IF EXISTS `coach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coach` (
  `Coach_id` int NOT NULL AUTO_INCREMENT,
  `Coach_name` varchar(50) DEFAULT NULL,
  `team_id` int DEFAULT NULL,
  `salary` int DEFAULT NULL,
  PRIMARY KEY (`Coach_id`),
  KEY `Coach_ibfk_1` (`team_id`),
  CONSTRAINT `Coach_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coach`
--

LOCK TABLES `coach` WRITE;
/*!40000 ALTER TABLE `coach` DISABLE KEYS */;
INSERT INTO `coach` (`Coach_id`, `Coach_name`, `team_id`, `salary`) VALUES (1,'Anil Kumble',1,200000),(2,'Yuvraj Singh',2,150000),(3,'Sachin Tendulkar',3,350000),(4,'Virender Shewag',4,250000),(5,'Saurav Ganguly',5,175000),(6,'Irfan Pathan',6,200000),(7,'Ms Dhoni',7,450000),(8,'Sohaib Akhtar',8,550000),(9,'Steve Smith',9,200000),(10,'Malinga',10,200000),(11,'Vijay Shankar',11,650000),(12,'Kapil Dev',12,200000),(13,'Ishant Sharma',13,200000);
/*!40000 ALTER TABLE `coach` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentators`
--

DROP TABLE IF EXISTS `commentators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentators` (
  `commentator_id` int NOT NULL AUTO_INCREMENT,
  `commentator_name` varchar(50) DEFAULT NULL,
  `available` tinyint(1) DEFAULT NULL,
  `current_channel` int DEFAULT NULL,
  PRIMARY KEY (`commentator_id`),
  KEY `Commentators_ibfk_1` (`current_channel`),
  CONSTRAINT `Commentators_ibfk_1` FOREIGN KEY (`current_channel`) REFERENCES `broadcastchannel` (`channel_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentators`
--

LOCK TABLES `commentators` WRITE;
/*!40000 ALTER TABLE `commentators` DISABLE KEYS */;
INSERT INTO `commentators` (`commentator_id`, `commentator_name`, `available`, `current_channel`) VALUES (1,'Cody',1,3),(2,'Marco',1,1),(3,'Gregorius',1,2),(4,'Buddy',1,2),(5,'Lauritz',0,5),(6,'Kissiah',0,5),(7,'Tabbi',0,4),(8,'Tatum',0,1),(9,'Arther',0,2),(10,'Candis',0,2),(11,'Darb',1,3),(12,'Parker',1,4),(13,'Karyn',0,4),(14,'Row',0,5),(15,'Arielle',1,1);
/*!40000 ALTER TABLE `commentators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentatorsformatches`
--

DROP TABLE IF EXISTS `commentatorsformatches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commentatorsformatches` (
  `match_id` int NOT NULL,
  `channel_id` int NOT NULL,
  `commentator_id` int NOT NULL,
  PRIMARY KEY (`match_id`,`channel_id`),
  KEY `channel_id` (`channel_id`),
  KEY `commentator_id` (`commentator_id`),
  CONSTRAINT `CommentatorsForMatches_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `broadcastchannel` (`channel_id`),
  CONSTRAINT `CommentatorsForMatches_ibfk_2` FOREIGN KEY (`match_id`) REFERENCES `matches` (`match_no`),
  CONSTRAINT `CommentatorsForMatches_ibfk_3` FOREIGN KEY (`commentator_id`) REFERENCES `commentators` (`commentator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentatorsformatches`
--

LOCK TABLES `commentatorsformatches` WRITE;
/*!40000 ALTER TABLE `commentatorsformatches` DISABLE KEYS */;
INSERT INTO `commentatorsformatches` (`match_id`, `channel_id`, `commentator_id`) VALUES (2,2,1),(5,5,1),(6,1,1),(7,5,1),(8,1,1),(9,1,1),(9,2,1),(11,4,1),(14,2,1),(16,4,1),(19,4,1),(29,5,1),(31,1,1),(32,1,1),(33,1,1),(37,3,1),(40,3,1),(49,1,1),(49,3,1),(57,2,1),(2,4,2),(4,5,2),(10,3,2),(11,3,2),(18,1,2),(18,4,2),(21,5,2),(25,1,2),(28,5,2),(34,2,2),(34,4,2),(42,3,2),(42,4,2),(45,4,2),(50,3,2),(51,5,2),(55,1,2),(57,3,2),(13,2,3),(30,1,3),(31,4,3),(33,4,3),(38,3,3),(41,5,3),(46,2,3),(48,1,3),(48,5,3),(50,4,3),(52,3,3),(54,5,3),(4,2,4),(8,2,4),(12,3,4),(15,1,4),(17,2,4),(22,2,4),(22,3,4),(22,4,4),(22,5,4),(25,2,4),(32,4,4),(33,3,4),(37,5,4),(39,2,4),(39,4,4),(41,4,4),(43,2,4),(44,5,4),(45,2,4),(56,4,4),(6,3,5),(7,1,5),(10,2,5),(13,3,5),(16,3,5),(17,1,5),(17,4,5),(21,3,5),(27,3,5),(27,5,5),(29,3,5),(30,4,5),(35,1,5),(36,1,5),(36,5,5),(38,5,5),(39,1,5),(43,3,5),(44,4,5),(46,3,5),(48,4,5),(55,5,5),(56,1,5),(56,3,5),(58,2,5),(58,5,5),(1,1,6),(1,4,6),(2,1,6),(3,5,6),(4,3,6),(9,3,6),(12,1,6),(13,4,6),(23,2,6),(27,1,6),(27,2,6),(36,2,6),(37,1,6),(41,1,6),(41,3,6),(43,5,6),(51,2,6),(52,5,6),(53,3,6),(54,1,6),(56,5,6),(57,5,6),(7,2,7),(8,5,7),(10,5,7),(14,1,7),(14,4,7),(16,2,7),(19,3,7),(20,1,7),(20,3,7),(23,1,7),(26,4,7),(28,4,7),(29,1,7),(36,4,7),(40,2,7),(47,2,7),(50,1,7),(52,4,7),(54,3,7),(54,4,7),(57,4,7),(58,4,7),(2,5,8),(7,3,8),(8,4,8),(9,5,8),(11,5,8),(13,1,8),(14,5,8),(19,2,8),(21,4,8),(23,4,8),(26,5,8),(27,4,8),(28,3,8),(30,2,8),(33,5,8),(35,2,8),(35,3,8),(41,2,8),(44,1,8),(44,2,8),(49,2,8),(52,2,8),(53,1,8),(56,2,8),(57,1,8),(1,2,9),(2,3,9),(3,1,9),(6,2,9),(6,5,9),(19,1,9),(19,5,9),(22,1,9),(23,3,9),(25,3,9),(26,3,9),(30,5,9),(35,5,9),(36,3,9),(45,3,9),(47,1,9),(50,5,9),(54,2,9),(58,1,9),(1,3,10),(3,4,10),(12,5,10),(16,5,10),(17,3,10),(17,5,10),(18,2,10),(20,4,10),(21,2,10),(28,2,10),(34,1,10),(34,3,10),(43,1,10),(46,1,10),(4,4,11),(5,4,11),(9,4,11),(10,4,11),(11,1,11),(12,2,11),(15,3,11),(15,4,11),(24,1,11),(25,5,11),(29,2,11),(29,4,11),(30,3,11),(32,2,11),(37,4,11),(38,1,11),(38,2,11),(39,3,11),(42,1,11),(47,4,11),(48,2,11),(3,2,12),(3,3,12),(4,1,12),(5,1,12),(6,4,12),(7,4,12),(10,1,12),(13,5,12),(18,3,12),(24,2,12),(24,3,12),(25,4,12),(26,2,12),(32,5,12),(33,2,12),(38,4,12),(40,4,12),(46,5,12),(47,3,12),(48,3,12),(49,5,12),(51,3,12),(51,4,12),(52,1,12),(55,3,12),(5,2,13),(8,3,13),(11,2,13),(18,5,13),(28,1,13),(34,5,13),(39,5,13),(42,2,13),(42,5,13),(44,3,13),(45,1,13),(53,5,13),(55,4,13),(1,5,14),(5,3,14),(12,4,14),(14,3,14),(20,5,14),(21,1,14),(23,5,14),(26,1,14),(31,3,14),(40,1,14),(40,5,14),(43,4,14),(46,4,14),(47,5,14),(50,2,14),(51,1,14),(53,2,14),(53,4,14),(15,2,15),(15,5,15),(16,1,15),(20,2,15),(24,4,15),(24,5,15),(31,2,15),(31,5,15),(32,3,15),(35,4,15),(37,2,15),(45,5,15),(49,4,15),(55,2,15),(58,3,15);
/*!40000 ALTER TABLE `commentatorsformatches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cricketgrounds`
--

DROP TABLE IF EXISTS `cricketgrounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cricketgrounds` (
  `ground_id` int NOT NULL AUTO_INCREMENT,
  `Ground_name` varchar(40) DEFAULT NULL,
  `place` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ground_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cricketgrounds`
--

LOCK TABLES `cricketgrounds` WRITE;
/*!40000 ALTER TABLE `cricketgrounds` DISABLE KEYS */;
INSERT INTO `cricketgrounds` (`ground_id`, `Ground_name`, `place`) VALUES (1,'Wankhede Stadium','Mumbai'),(2,'IS Bindra Stadium','Mohali'),(3,'Eden Gardens','Kolkata'),(4,'Rajiv Gandhi Intl. Cricket Stadium','Hyderabad'),(5,'M. A. Chidambaram Stadium','Chennai'),(6,'Sawai Mansingh Stadium','Jaipur'),(7,'M. Chinnaswamy Stadium','Bengaluru'),(8,'Feroz Shah Kotla Ground','Delhi'),(9,'Holkar Cricket Stadium','Indore');
/*!40000 ALTER TABLE `cricketgrounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `homeground`
--

DROP TABLE IF EXISTS `homeground`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `homeground` (
  `team_id` int NOT NULL,
  `ground_id` int NOT NULL,
  PRIMARY KEY (`ground_id`,`team_id`),
  KEY `homeground_ibfk_1` (`team_id`),
  CONSTRAINT `Homeground_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE,
  CONSTRAINT `Homeground_ibfk_2` FOREIGN KEY (`ground_id`) REFERENCES `cricketgrounds` (`ground_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `homeground`
--

LOCK TABLES `homeground` WRITE;
/*!40000 ALTER TABLE `homeground` DISABLE KEYS */;
INSERT INTO `homeground` (`team_id`, `ground_id`) VALUES (1,3),(2,8),(3,1),(4,6),(5,1),(6,2),(7,9),(8,3),(9,3),(10,1),(11,2),(12,1),(13,8);
/*!40000 ALTER TABLE `homeground` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matches`
--

DROP TABLE IF EXISTS `matches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matches` (
  `match_no` int NOT NULL AUTO_INCREMENT,
  `team1` varchar(30) DEFAULT NULL,
  `team2` varchar(30) DEFAULT NULL,
  `stadium_id` int DEFAULT '1',
  `date` date DEFAULT NULL,
  PRIMARY KEY (`match_no`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matches`
--

LOCK TABLES `matches` WRITE;
/*!40000 ALTER TABLE `matches` DISABLE KEYS */;
INSERT INTO `matches` (`match_no`, `team1`, `team2`, `stadium_id`, `date`) VALUES (1,'MI','CSK',4,'2020-03-29'),(2,'KKR','SRH',4,'2020-03-29'),(3,'MI','DD',1,'2020-03-30'),(4,'RR','KXIP',2,'2020-03-29'),(5,'DD','CSK',3,'2020-04-01'),(6,'KKR','KXIP',2,'2020-04-02'),(7,'RCB','MI',5,'2020-04-03'),(8,'SRH','RR',6,'2020-04-04'),(9,'KXIP','DD',7,'2020-04-04'),(10,'DD','KKR',4,'2020-04-05'),(11,'SRH','RCB',1,'2020-04-05'),(12,'CSK','RR',6,'2020-04-06'),(13,'KXIP','DD',4,'2020-04-07'),(14,'RR','RCB',7,'2020-04-08'),(15,'MI','CSK',3,'2020-04-09'),(16,'DD','SRH',1,'2020-04-10'),(17,'RCB','KKR',5,'2020-04-11'),(18,'KKR','KXIP',8,'2020-04-11'),(19,'RCB','DD',7,'2020-04-12'),(20,'SRH','CSK',10,'2020-04-12'),(21,'RR','MI',2,'2020-04-13'),(22,'DD','KXIP',3,'2020-04-14'),(23,'MI','SRH',5,'2020-04-15'),(24,'RCB','CSK',6,'2020-04-16'),(25,'SRH','KXIP',7,'2020-04-17'),(26,'DD','KKR',5,'2020-04-18'),(27,'CSK','MI',4,'2020-04-18'),(28,'RR','SRH',8,'2020-04-19'),(29,'RCB','KKR',3,'2020-04-19'),(30,'CSK','DD',5,'2020-04-20'),(31,'RCB','MI',8,'2020-04-21'),(32,'DD','RR',5,'2020-04-22'),(33,'KKR','CSK',8,'2020-04-23'),(34,'KXIP','MI',5,'2020-04-24'),(35,'CSK','RCB',4,'2020-04-25'),(36,'SRH','DD',2,'2020-04-25'),(37,'MI','KKR',7,'2020-04-26'),(38,'KXIP','RR',8,'2020-04-26'),(39,'SRH','RCB',6,'2020-04-27'),(40,'RR','KXIP',6,'2020-04-28'),(41,'KKR','MI',7,'2020-04-29'),(42,'DD','SRG',6,'2020-04-30'),(43,'RR','CSK',3,'2020-05-01'),(44,'KXIP','KKR',2,'2020-05-02'),(45,'DD','RR',10,'2020-05-02'),(46,'KXIP','RCB',9,'2020-05-03'),(47,'MI','RR',7,'2020-05-03'),(48,'KKR','SRH',6,'2020-05-04'),(49,'CSK','MI',8,'2020-05-05'),(50,'KKR','RR',2,'2020-05-06'),(51,'MI','KXIP',5,'2020-05-07'),(52,'RCB','RR',4,'2020-05-08'),(53,'DD','CSK',3,'2020-05-09'),(54,'RCB','SRH',2,'2020-05-09'),(55,'MI','KKR',3,'2020-05-10'),(56,'RR','RCB',5,'2020-05-10'),(57,'DD','CSK',4,'2020-05-11'),(58,'MI','KXIP',1,'2020-05-12');
/*!40000 ALTER TABLE `matches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `officials`
--

DROP TABLE IF EXISTS `officials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `officials` (
  `official_id` int NOT NULL AUTO_INCREMENT,
  `official_name` varchar(20) DEFAULT NULL,
  `designation` int DEFAULT NULL,
  `date_joined` date DEFAULT NULL,
  `salary_per_match` float DEFAULT NULL,
  PRIMARY KEY (`official_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `officials`
--

LOCK TABLES `officials` WRITE;
/*!40000 ALTER TABLE `officials` DISABLE KEYS */;
INSERT INTO `officials` (`official_id`, `official_name`, `designation`, `date_joined`, `salary_per_match`) VALUES (1,'Margi Cuckoo',2,'2007-09-22',8601.57),(2,'Rosella Skouling',1,'2013-05-03',2650.6),(3,'Valaria O\'Rafferty',4,'2016-08-23',4489.49),(4,'Bathsheba Salamon',3,'2006-02-17',7379.24),(5,'Adorne Caveau',2,'2008-10-17',8012.36),(6,'Napoleon Kobera',1,'2014-03-29',9493.52),(7,'Leslie Tromans',4,'2018-01-13',6536.37),(8,'Nester Broske',2,'2010-07-04',6914.51),(9,'Athena Sabatier',1,'2005-12-04',2648.88),(10,'Floris Ledley',3,'2016-08-04',6003.67);
/*!40000 ALTER TABLE `officials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `officialsformatch`
--

DROP TABLE IF EXISTS `officialsformatch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `officialsformatch` (
  `match_no` int NOT NULL,
  `official_id` int NOT NULL,
  PRIMARY KEY (`match_no`,`official_id`),
  KEY `official_id` (`official_id`),
  CONSTRAINT `OfficialsForMatch_ibfk_1` FOREIGN KEY (`match_no`) REFERENCES `matches` (`match_no`),
  CONSTRAINT `OfficialsForMatch_ibfk_2` FOREIGN KEY (`official_id`) REFERENCES `officials` (`official_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `officialsformatch`
--

LOCK TABLES `officialsformatch` WRITE;
/*!40000 ALTER TABLE `officialsformatch` DISABLE KEYS */;
INSERT INTO `officialsformatch` (`match_no`, `official_id`) VALUES (1,1),(4,1),(9,1),(10,1),(11,1),(15,1),(16,1),(18,1),(20,1),(22,1),(23,1),(30,1),(32,1),(35,1),(36,1),(38,1),(39,1),(40,1),(41,1),(43,1),(45,1),(48,1),(49,1),(52,1),(56,1),(57,1),(2,2),(8,2),(11,2),(12,2),(13,2),(14,2),(15,2),(19,2),(20,2),(21,2),(24,2),(26,2),(28,2),(31,2),(33,2),(36,2),(38,2),(40,2),(43,2),(44,2),(58,2),(2,3),(4,3),(5,3),(7,3),(8,3),(9,3),(14,3),(15,3),(16,3),(17,3),(18,3),(21,3),(24,3),(26,3),(27,3),(30,3),(31,3),(33,3),(35,3),(39,3),(42,3),(43,3),(46,3),(47,3),(50,3),(51,3),(53,3),(55,3),(57,3),(1,4),(4,4),(6,4),(12,4),(17,4),(18,4),(19,4),(23,4),(24,4),(25,4),(28,4),(29,4),(30,4),(31,4),(34,4),(35,4),(37,4),(40,4),(43,4),(46,4),(50,4),(2,5),(3,5),(5,5),(8,5),(10,5),(13,5),(17,5),(19,5),(23,5),(24,5),(25,5),(27,5),(29,5),(33,5),(34,5),(36,5),(37,5),(40,5),(41,5),(42,5),(44,5),(45,5),(47,5),(48,5),(49,5),(50,5),(54,5),(55,5),(58,5),(1,6),(3,6),(5,6),(6,6),(7,6),(11,6),(13,6),(16,6),(20,6),(21,6),(22,6),(27,6),(31,6),(32,6),(37,6),(38,6),(39,6),(46,6),(47,6),(48,6),(49,6),(51,6),(54,6),(55,6),(56,6),(2,7),(3,7),(6,7),(7,7),(9,7),(10,7),(12,7),(14,7),(15,7),(18,7),(21,7),(25,7),(26,7),(28,7),(29,7),(32,7),(38,7),(41,7),(42,7),(44,7),(45,7),(46,7),(47,7),(48,7),(49,7),(51,7),(52,7),(53,7),(56,7),(58,7),(1,8),(3,8),(4,8),(5,8),(7,8),(13,8),(16,8),(19,8),(20,8),(22,8),(23,8),(26,8),(30,8),(32,8),(34,8),(35,8),(39,8),(41,8),(45,8),(50,8),(52,8),(53,8),(54,8),(57,8),(58,8),(6,9),(8,9),(9,9),(10,9),(11,9),(12,9),(14,9),(17,9),(22,9),(25,9),(27,9),(28,9),(29,9),(33,9),(34,9),(36,9),(37,9),(42,9),(44,9),(51,9),(52,9),(53,9),(54,9),(55,9),(56,9),(57,9);
/*!40000 ALTER TABLE `officialsformatch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orangecap`
--

DROP TABLE IF EXISTS `orangecap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orangecap` (
  `player_id` int DEFAULT NULL,
  `player_name` varchar(20) DEFAULT NULL,
  `runs` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orangecap`
--

LOCK TABLES `orangecap` WRITE;
/*!40000 ALTER TABLE `orangecap` DISABLE KEYS */;
INSERT INTO `orangecap` (`player_id`, `player_name`, `runs`) VALUES (2,'Manan Vohra',100000),(146,'Shikhar Dhawan',121635),(128,'Rohit Sharma',102321),(2,'Manan Vohra',100000),(11,'Jaydev Unadkat',99900),(51,'Chris Gayle',96504);
/*!40000 ALTER TABLE `orangecap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owners`
--

DROP TABLE IF EXISTS `owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owners` (
  `owner_id` int NOT NULL AUTO_INCREMENT,
  `owner_name` varchar(20) NOT NULL,
  `team_name` varchar(30) DEFAULT NULL,
  `ownership_stake` double NOT NULL,
  `date_joined` date DEFAULT NULL,
  PRIMARY KEY (`owner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owners`
--

LOCK TABLES `owners` WRITE;
/*!40000 ALTER TABLE `owners` DISABLE KEYS */;
INSERT INTO `owners` (`owner_id`, `owner_name`, `team_name`, `ownership_stake`, `date_joined`) VALUES (1,'Jeanna Fannin','KKR',69,'2020-04-28'),(2,'Dominique Darrington','RCB',57,'2020-04-28'),(3,'Johnath Agiolfinger','CSK',22,'2020-04-28'),(4,'Golda Garry','KXIP',59,'2020-04-28'),(5,'Alma Castilla','RR',64,'2020-04-28'),(6,'Robena Haddleton','DD',24,'2020-04-28'),(7,'Dominica McCay','MI',66,'2020-04-28'),(8,'Bernetta Harwin','DC',85,'2020-04-28'),(9,'Merry Lemerie','KTR',34,'2020-04-28'),(10,'Myrtie Callcott','PW',20,'2020-04-28'),(11,'Verla Longcaster','SRH',80,'2020-04-28'),(12,'Hillary Hickin','RPS',95,'2020-04-28'),(13,'Vinita Ramel',NULL,21,NULL),(14,'Samay Juneja',NULL,44,NULL),(15,'Rohan Bahl',NULL,43,NULL),(16,'John Lay',NULL,54,NULL),(17,'Drake Ron',NULL,33,NULL),(18,'Keshav Kapadia',NULL,34,NULL),(19,'Daniel Matt',NULL,67,NULL),(20,'Mohan Kumar','GL',32,'2020-04-28');
/*!40000 ALTER TABLE `owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player`
--

DROP TABLE IF EXISTS `player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `player` (
  `player_id` int NOT NULL AUTO_INCREMENT,
  `player_name` varchar(50) DEFAULT NULL,
  `date_joined` date DEFAULT NULL,
  `salary_per_match` float DEFAULT NULL,
  `team_name` varchar(50) DEFAULT NULL,
  `total_runs` int DEFAULT NULL,
  `total_wickets` int DEFAULT NULL,
  `team_id` int DEFAULT NULL,
  `Nationality` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`player_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player`
--

LOCK TABLES `player` WRITE;
/*!40000 ALTER TABLE `player` DISABLE KEYS */;
INSERT INTO `player` (`player_id`, `player_name`, `date_joined`, `salary_per_match`, `team_name`, `total_runs`, `total_wickets`, `team_id`, `Nationality`) VALUES (1,'Michael Angelo','2020-04-28',50000,'GL',55500,0,13,'India'),(2,'Manan Vohra','2020-04-28',68000,'GL',100000,3,13,'India'),(3,'Riyan Parag','2020-03-25',72000,'RR',20250,16,5,'Afghanistan'),(4,'Steve Smith','2020-01-01',91000,'RR',40450,4,5,'Bangladesh'),(5,'Robin Uthappa','2020-04-27',104000,'RR',30450,2,5,'India'),(6,'David Miller','2020-04-27',60000,'RR',40120,1,5,'Sri Lanka'),(7,'Ankit Rajpoot','2020-01-12',45000,'RR',50045,3,5,'India'),(8,'Mayank Markande','2020-02-11',55000,'RR',66000,1,5,'India'),(9,'Jofra Archer','2020-03-09',75000,'RR',70500,1,5,'Sri Lanka'),(10,'Varun Aaron','2020-03-08',91000,'RR',80070,1,5,'India'),(11,'Jaydev Unadkat','2020-04-27',95000,'RR',99900,9,5,'India'),(12,'Kartik Tyagi','2020-04-27',65000,'RR',1500,3,5,'India'),(13,'Akash Singh','2020-04-27',60000,'RR',20500,5,5,'India'),(14,'Oshane Thomas','2020-04-27',40000,'RR',30100,4,5,'New Zeland'),(15,'Andrew Tye','2020-04-27',300000,'RR',40000,2,5,'New Zeland'),(16,'Ben Stokes','2020-01-01',100000,'RR',50700,3,5,'Austrailia'),(17,'Rahul Tewatia','2020-02-24',95000,'RR',60300,6,5,'India'),(18,'Shashank Singh','2020-01-01',25000,'RR',70900,1,5,'India'),(19,'Yashasvi Jaiswal','2020-01-24',100000,'RR',80800,7,5,'India'),(20,'Anirudha Joshi','2020-01-01',50000,'RR',10100,3,5,'India'),(21,'Tom Curran','2020-01-01',1000,'RR',21100,2,5,'Bangladesh'),(22,'Jos Buttler','2020-01-01',1000,'RR',33300,0,5,'Afghanistan'),(23,'Sanju Samson','2020-01-01',1000,'RR',47700,6,5,'India'),(24,'Anuj Rawat','2020-04-27',1000,'RR',5990,0,5,'India'),(25,'Shreyas Iyer','2020-01-01',1000,'DD',50000,13,6,'India'),(26,'Prithvi Shaw','2020-01-01',1000,'DD',50000,5,6,'India'),(27,'Ajinkya Rahane','2020-01-01',1000,'DD',550,12,6,'India'),(28,'Shikhar Dhawan','2020-01-01',1000,'DD',45000,0,6,'India'),(29,'Jason Roy','2020-01-01',1000,'DD',0,14,6,'Sri Lanka'),(30,'Ishant Sharma','2020-01-01',1000,'DD',0,1,6,'India'),(31,'Amit Mishra','2020-01-01',1000,'DD',0,5,6,'India'),(32,'Avesh Khan','2020-01-01',1000,'DD',4567,3,6,'India'),(33,'Sandeep Lamichhane','2020-01-01',1000,'DD',45672,0,6,'India'),(34,'Kagiso Rabada','2020-01-01',1000,'DD',89526,7,6,'South Africa'),(35,'Keemo Rabada','2020-01-01',1000,'DD',56861,0,6,'Bangladesh'),(36,'Mohit Sharma','2020-01-01',1000,'DD',10012,4,6,'India'),(37,'Lalit Yadav','2020-01-01',1000,'DD',4567,1,6,'India'),(38,'Harshal Patel','2020-01-01',1000,'DD',68741,6,6,'India'),(39,'R Ashwin','2020-01-01',1000,'DD',12348,3,6,'India'),(40,'Chris Woakers','2020-01-01',1000,'DD',54564,0,6,'South Africa'),(41,'Rishabh Pant','2020-01-01',1000,'DD',44567,0,6,'India'),(42,'Tushar Deshpande','2020-04-27',1000,'DC',45657,2,8,'India'),(43,'Alex Carey','2020-01-01',1000,'DD',45654,0,6,'South Africa'),(44,'Marcus Stoinis','2020-01-01',1000,'DD',13546,0,6,'New Zeland'),(45,'Mayank Aggarwal','2019-02-02',56000,'KXIP',60000,24,4,'India'),(46,'Hardus Viljoen','2012-01-01',96500,'KXIP',10024,26,4,'India'),(47,'Mayank Aggarwal','2019-10-09',66000,'KXIP',15045,23,4,'India'),(48,'Arshdeep Singh','2019-02-10',60000,'KXIP',54016,12,4,'India'),(49,'Murugan Ashwin','2018-09-12',40000,'KXIP',6050,32,4,'India'),(50,'Sheldon Cottrell','2020-04-27',160000,'KXIP',960,12,4,'England'),(51,'Chris Gayle','2018-02-02',100000,'KXIP',96504,2,4,'Austrailia'),(52,'Krishnappa Gowtham','2019-12-04',50000,'KXIP',60000,2,4,'New Zeland'),(53,'Harpreet Brar','2017-06-02',95000,'KXIP',60000,6,4,'India'),(54,'Deepak Hooda','2019-07-07',86000,'KXIP',47850,8,4,'India'),(55,'Chris Jordan','2020-09-05',54000,'KXIP',45621,7,4,'Afghanistan'),(56,'Sarfaraz Khan','2020-12-02',59000,'KXIP',4570,11,4,'New Zeland'),(57,'Mandeep Singh','2019-01-02',46000,'KXIP',9450,16,4,'India'),(58,'Glenn Maxwell','2020-04-27',196000,'KXIP',74150,2,4,'Austrailia'),(59,'Mohammed Shami','2019-04-02',166000,'KXIP',45792,18,4,'India'),(60,'Mujeeb Ur Rahaman','2020-05-02',26000,'KXIP',64540,6,4,'Afghanistan'),(61,'karun Nair','2020-10-02',56000,'KXIP',48481,2,4,'India'),(62,'JAmes Neesham','2020-11-02',96000,'KXIP',48411,1,4,'India'),(63,'Nicholas Pooran','2020-12-02',95000,'KXIP',48450,0,4,'Sri Lanka'),(64,'Ishan Porel','2020-04-27',85000,'KXIP',7812,1,4,'India'),(65,'RAvi Bishnoi','2020-04-27',65000,'KXIP',1016,9,4,'India'),(66,'Simar Singh','2020-04-27',45000,'KKR',6784,7,1,'India'),(67,'Jagadeesha Suchith','2019-03-02',41000,'KXIP',5471,11,4,'India'),(68,'Tajinder Singh','2019-03-02',30000,'KXIP',3154,5,4,'India'),(69,'Tom Banton','2020-04-27',100000,'KKR',65478,6,1,'Sri Lanka'),(70,'Pat cummins','2020-04-27',50000,'RCB',4564,12,2,'Sri Lanka'),(71,'Lockie Ferguson','2020-01-11',45000,'KKR',45679,10,1,'South Africa'),(72,'Chris Green','2019-11-07',40000,'KKR',10234,8,1,'England'),(73,'Harry Gurney','2020-03-08',150000,'KKR',51511,9,1,'England'),(74,'Dinesh Kartik','2019-09-09',60000,'KKR',65468,16,1,'India'),(75,'Kuldeep Yadav','2019-10-10',70000,'KKR',12345,20,1,'India'),(76,'Siddhesh Lad','2020-01-11',95000,'KKR',65489,2,1,'India'),(77,'Eoin Morgan','2020-04-27',150000,'KKR',12348,3,1,'Sri Lanka'),(78,'Kamlesh NAgarkoti','2019-03-11',160000,'KKR',45632,6,1,'Austrailia'),(79,'Nikhil Naik','2020-04-27',48000,'KKR',3021,5,1,'India'),(80,'Sunil Naraine','2019-05-09',15000,'KKR',9654,1,1,'Bangladesh'),(81,'Prasidh Krishna','2020-03-08',95000,'KKR',13024,0,1,'India'),(82,'Nitish Rana','2020-03-07',80000,'KKR',26547,4,1,'India'),(83,'Andre Russell','2020-03-06',70000,'KKR',35697,7,1,'New Zeland'),(84,'Sandeep Warrier','2020-04-05',75000,'KKR',12347,6,1,'India'),(85,'Shivam Mavi','2020-01-04',99000,'KKR',9874,7,1,'India'),(86,'Shubham Gill','2019-11-08',200000,'KKR',6546,9,1,'India'),(87,'Rinku SIngh','2019-12-11',20000,'KKR',61234,10,1,'India'),(88,'Pravin Tambe','2020-04-27',66000,'KKR',65400,11,1,'New Zeland'),(89,'Aaron Finch','2020-04-27',220000,'RCB',78965,8,2,'Afghanistan'),(90,'Devdutt Padikkal','2019-12-12',25000,'RCB',82145,6,2,'Austrailia'),(91,'Virat Kohli','2020-01-11',35500,'RCB',65478,5,2,'India'),(92,'Chris Morris','2020-01-10',45000,'RCB',36411,11,2,'India'),(93,'Gurkeerat singh Maan','2017-03-09',55000,'RCB',9541,16,2,'India'),(94,'Isuru Udana','2019-12-08',40500,'RCB',36547,15,2,'West Indies'),(95,'Moeen Ali','2020-04-07',60500,'RCB',21456,14,2,'South Africa'),(96,'Pavan Deshpande','2019-12-06',79000,'RCB',11341,11,2,'England'),(97,'Pawan Negi','2019-12-05',105000,'RCB',12065,1,2,'Bangladesh'),(98,'Shahbaz Ahmed','2020-04-27',90000,'RCB',45685,3,2,'South Africa'),(99,'Shivam Dube','2019-12-03',96000,'RCB',1234,6,2,'New Zeland'),(100,'Washington Sundar','2019-12-02',19500,'RCB',3641,7,2,'West Indies'),(101,'AB de Villers','2019-04-01',12000,'RCB',3215,9,2,'Afghanistan'),(102,'Josh Phillippe','2019-12-11',36000,'RCB',2012,16,2,'Austrailia'),(103,'Parthiv PAtel','2019-12-12',65000,'RCB',3647,15,2,'India'),(104,'Dale Steyn','2020-04-27',45000,'RCB',25467,14,2,'South Africa'),(105,'Kane RichardSon','2020-04-27',35000,'RCB',10214,13,2,'Afghanistan'),(106,'Mohammed Siraj','2017-04-06',40000,'RCB',4167,8,2,'Afghanistan'),(107,'Navdeep Saini','2020-03-12',16000,'RCB',3269,0,2,'Austrailia'),(108,'Umesh Yadav','2020-01-09',19000,'RCB',6060,13,2,'India'),(109,'Yuzvendra chahal','2018-03-03',20000,'RCB',56788,19,2,'Sri Lanka'),(110,'Ms Dhoni','2015-01-01',400000,'CSK',56321,2,3,'India'),(111,'Suresh Raina','2018-04-09',65000,'CSK',95421,5,3,'India'),(112,'Ambati Rayudu','2017-03-12',40000,'CSK',74521,11,3,'India'),(113,'Shane Watson','2020-02-11',30000,'CSK',34621,22,3,'England'),(114,'Fafdu Plessis','2020-02-04',100000,'CSK',45671,16,3,'England'),(115,'Murali Vijay','2018-06-05',95000,'CSK',36510,17,3,'India'),(116,'Kedar Jadhav','2019-09-06',74000,'CSK',22010,26,3,'India'),(117,'Ravindra Jadeja','2016-06-07',36000,'CSK',9000,36,3,'Afghanistan'),(118,'Rituraj Gaikwad','2020-03-08',45000,'CSK',3600,42,3,'Afghanistan'),(119,'Dwayne Bravo','2019-02-09',38000,'CSK',36542,19,3,'Austrailia'),(120,'Karn Sharma','2020-02-10',62000,'CSK',12345,11,3,'West Indies'),(121,'Imran Tahir','2020-02-11',65000,'CSK',15646,21,3,'Sri Lanka'),(122,'Harbhajan Singh','2020-04-11',100000,'CSK',25600,13,3,'England'),(123,'Mitchell Santner','2020-04-11',69000,'CSK',45632,23,3,'Bangladesh'),(124,'Shardul Thakur','2020-04-11',91000,'CSK',6548,24,3,'Austrailia'),(125,'KM Asif','2020-04-11',36000,'CSK',4567,26,3,'New Zeland'),(126,'Deepak Chahar','2020-04-11',34000,'CSK',65848,9,3,'India'),(127,'Monu Singh','2020-04-11',54100,'CSK',12556,6,3,'Sri Lanka'),(128,'Rohit Sharma','2015-01-01',260000,'MI',102321,6,7,'India'),(129,'Hardik Pandya','2018-04-09',140000,'MI',69121,6,7,'India'),(130,'Jasprit Bumrah','2017-03-12',160000,'MI',7521,49,7,'India'),(131,'Krunal Pandya','2020-02-11',90000,'MI',44621,25,7,'India'),(132,'Ishan Kishan','2020-02-04',100000,'MI',46671,16,7,'West Indies'),(133,'Surya Kumar Yadav','2018-06-05',95000,'MI',95510,17,7,'South Africa'),(134,'Rahul Chahar','2019-09-06',74000,'MI',11010,26,7,'Afghanistan'),(135,'Anmolpreet singh','2016-06-07',36000,'MI',6300,36,7,'England'),(136,'Jayant Yadav','2020-03-08',40000,'MI',5640,42,7,'New Zeland'),(137,'Aditya Tare','2019-02-09',30000,'MI',36542,19,7,'New Zeland'),(138,'Anukul Roy','2020-02-10',26000,'MI',12345,11,7,'South Africa'),(139,'Dhawal Kulkarni','2020-02-11',31000,'MI',15646,6,7,'New Zeland'),(140,'Quinton de Kock','2020-04-11',51000,'MI',25600,12,7,'West Indies'),(141,'Kieron Pollard','2020-04-11',60000,'MI',45632,20,7,'England'),(142,'Sherfane Rutherford','2020-04-11',90000,'MI',6548,24,7,'South Africa'),(143,'KAsith Malinga','2020-04-11',44000,'MI',4567,16,7,'Sri Lanka'),(144,'Trent Boult','2020-04-11',34000,'MI',65848,17,7,'Sri Lanka'),(145,'chris lynn','2020-04-27',54100,'MI',12556,12,7,'South Africa'),(146,'Shikhar Dhawan','2016-01-01',220000,'DC',121635,6,8,'India'),(147,'Prithvi Shaw','2018-04-09',110000,'DC',54311,6,8,'India'),(148,'Shreyas Iyer','2017-03-12',115000,'DC',27521,23,8,'India'),(149,'Rishabh Pant','2020-02-11',78000,'DC',34621,25,8,'India'),(150,'Axar Patel','2020-02-04',87000,'DC',66671,16,8,'India'),(151,'Amit Mishra','2018-06-05',46000,'DC',65510,17,8,'India'),(152,'IShant Sharma','2019-09-06',47000,'DC',21010,29,8,'India'),(153,'Amit Mishra','2016-06-07',55000,'DC',6300,35,8,'Afghanistan'),(154,'Ishant Sharma','2020-03-08',40000,'DC',5640,40,8,'Bangladesh'),(155,'Harshal Patel','2019-02-09',30000,'DC',36542,16,8,'Afghanistan'),(156,'Avesh Khan','2020-02-10',26000,'DC',12345,11,8,'Sri Lanka'),(157,'R Ashwin','2020-02-11',31000,'DC',15646,6,8,'South Africa'),(158,'Ajinkya Rahane','2020-04-11',51000,'DC',25600,12,8,'India'),(159,'Kagiso Rabada','2020-04-11',60000,'DC',45632,20,8,'Afghanistan'),(160,'Keemo PAul','2020-04-11',90000,'DC',6548,24,8,'South Africa'),(161,'Sandeep LAmichhane','2020-04-11',44000,'DC',4567,16,8,'Sri Lanka'),(162,'Jason Roy','2020-04-27',34000,'DC',65848,17,8,'India'),(163,'Chris Woakes','2020-04-27',54100,'DC',12556,12,8,'West Indies'),(164,'Virat Singh ','2020-04-27',22000,'SRH',12345,6,11,'Bangladesh'),(165,'Priyam Garg','2020-04-27',34000,'SRH',13648,4,11,'South Africa'),(166,'Rahul Tripathi','2019-04-05',44500,'KKR',36548,13,1,'New Zeland'),(167,'Shimron Hetmyer','2020-04-27',49500,'DC',36548,13,8,'Austrailia'),(168,'Shimron Hetmyer','2020-04-27',63200,'MI',65412,9,7,'Austrailia'),(169,'Nathan Coulter-nile','2020-04-27',100000,'MI',46671,16,7,'Afghanistan'),(170,'Piyush Chawla','2020-04-27',36000,'CSK',45167,16,3,'Afghanistan'),(171,'M Siddharth','2020-04-27',56000,'KKR',14564,16,1,'Bangladesh'),(172,'Josh Haylewood','2020-04-27',36100,'CSK',9100,19,3,'Bangladesh'),(173,'Moshin Khan','2020-04-27',60000,'MI',45632,20,7,'South Africa'),(174,'Mohit Sharma','2020-04-27',51000,'DC',11646,9,8,'West Indies'),(175,'R sai Kishore','2020-04-27',90000,'CSK',16548,14,3,'Bangladesh'),(176,'Jasua Phillippe','2020-04-27',41500,'RCB',30540,12,2,'England'),(177,'Prabhsimran Singh','2020-04-27',99000,'KXIP',47000,6,4,'England'),(178,'Alex Carey','2020-04-27',66000,'DC',6515,21,8,'England');
/*!40000 ALTER TABLE `player` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS addPlayer */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`DBMS`@`localhost`*/ /*!50003 TRIGGER `addPlayer` AFTER INSERT ON `player` FOR EACH ROW BEGIN
       UPDATE Team T
       SET T.no_of_players = T.no_of_players + 1
       WHERE T.team_id = new.team_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS deletePlayer */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`DBMS`@`localhost`*/ /*!50003 TRIGGER `deletePlayer` AFTER DELETE ON `player` FOR EACH ROW BEGIN

       UPDATE Team T
       SET T.no_of_players = T.no_of_players - 1
       WHERE T.team_id = old.team_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `purplecap`
--

DROP TABLE IF EXISTS `purplecap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purplecap` (
  `player_id` int DEFAULT NULL,
  `player_name` varchar(20) DEFAULT NULL,
  `wickets` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purplecap`
--

LOCK TABLES `purplecap` WRITE;
/*!40000 ALTER TABLE `purplecap` DISABLE KEYS */;
/*!40000 ALTER TABLE `purplecap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsors`
--

DROP TABLE IF EXISTS `sponsors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sponsors` (
  `sponsor_id` int NOT NULL AUTO_INCREMENT,
  `sponsor_name` varchar(50) DEFAULT NULL,
  `team_id` int DEFAULT NULL,
  `sponsorship_scale` float DEFAULT NULL,
  PRIMARY KEY (`sponsor_id`),
  KEY `Sponsors_Team_team_id_fk` (`team_id`),
  CONSTRAINT `Sponsors_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsors`
--

LOCK TABLES `sponsors` WRITE;
/*!40000 ALTER TABLE `sponsors` DISABLE KEYS */;
INSERT INTO `sponsors` (`sponsor_id`, `sponsor_name`, `team_id`, `sponsorship_scale`) VALUES (1,'DLF',1,30),(2,'Pepsi',1,50),(3,'DLF',2,30),(4,'Pepsi',2,50),(5,'DLF',3,30),(6,'Pepsi',3,50),(7,'DLF',4,30),(8,'Pepsi',4,50),(9,'DLF',5,30),(10,'Pepsi',5,50),(11,'DLF',6,30),(12,'Pepsi',6,50),(13,'DLF',7,30),(14,'Pepsi',7,50),(15,'DLF',8,30),(16,'Pepsi',8,50),(17,'Haier',1,30),(18,'KFC',4,30),(19,'Sprite',2,30),(20,'Dairy Milk',3,30),(21,'Lays',8,30),(22,'TCL',7,30),(23,'UltraTech',4,30),(24,'Samsung',5,30),(25,'Maruti Suzuki',4,30),(26,'Aditya Birla Group',3,30),(27,'Vodafone',1,30),(28,'Gillete',2,30),(29,'Duracell',6,30),(30,'Nikon',8,30),(31,'Idea',6,30),(32,'Gulf',7,30),(33,'Royal Stag',2,30),(34,'JIO',3,30),(35,'Surya LED',7,30),(36,'Amul',1,30),(37,'King Fisher',5,30),(38,'Hero',4,30);
/*!40000 ALTER TABLE `sponsors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `team_id` int NOT NULL AUTO_INCREMENT,
  `team_name` varchar(30) DEFAULT NULL,
  `no_of_players` int DEFAULT NULL,
  `no_of_overseas_player` int DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `captain_id` int DEFAULT NULL,
  `matches_won` int DEFAULT NULL,
  `matches_lost` int DEFAULT NULL,
  `matches_draw` int DEFAULT NULL,
  `points_tournament` int DEFAULT NULL,
  `points_fairplay` int DEFAULT NULL,
  PRIMARY KEY (`team_id`),
  KEY `Team_Owners_owner_id_fk` (`owner_id`),
  CONSTRAINT `Team_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `owners` (`owner_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` (`team_id`, `team_name`, `no_of_players`, `no_of_overseas_player`, `owner_id`, `captain_id`, `matches_won`, `matches_lost`, `matches_draw`, `points_tournament`, `points_fairplay`) VALUES (1,'KKR',22,2,1,74,4,5,0,8,0),(2,'RCB',22,2,2,91,3,6,1,6,0),(3,'CSK',21,5,3,110,5,4,0,10,0),(4,'KXIP',25,5,4,45,7,2,0,14,0),(5,'RR',23,2,5,2,8,1,0,16,0),(6,'DD',20,5,6,31,1,8,0,2,0),(7,'MI',21,4,7,128,9,0,0,18,0),(8,'DC',21,6,8,146,4,5,0,8,0),(9,'KTR',20,6,9,151,6,3,0,12,0),(10,'PW',18,3,10,154,8,2,0,16,0),(11,'SRH',18,4,11,164,9,0,0,18,0),(12,'RPS',18,3,12,159,3,6,0,6,0),(13,'GL',20,5,20,173,2,7,0,4,0);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS addTeam */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`DBMS`@`localhost`*/ /*!50003 TRIGGER `addTeam` AFTER INSERT ON `team` FOR EACH ROW BEGIN
       UPDATE Owners
       SET team_name = NEW.team_name, date_joined = curdate()
       WHERE owner_id = NEW.owner_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS updateTeam */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`DBMS`@`localhost`*/ /*!50003 TRIGGER `updateTeam` AFTER UPDATE ON `team` FOR EACH ROW BEGIN

      UPDATE Owners
       SET team_name = NULL, date_joined = NULL
       WHERE owner_id = OLD.owner_id;

       UPDATE Owners
       SET team_name = NEW.team_name, date_joined = curdate()
       WHERE owner_id = NEW.owner_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
/*!50032 DROP TRIGGER IF EXISTS deleteTeam */;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`DBMS`@`localhost`*/ /*!50003 TRIGGER `deleteTeam` AFTER DELETE ON `team` FOR EACH ROW BEGIN

       UPDATE Owners
       SET team_name = NULL, date_joined = NULL
       WHERE team_name = old.team_name;

       UPDATE Player
       SET team_name = NULL, team_id = NULL, date_joined = NULL
       WHERE team_id = old.team_id;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-28 18:15:24
