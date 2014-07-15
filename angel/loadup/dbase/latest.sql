-- MySQL dump 10.13  Distrib 5.1.69, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: market
-- ------------------------------------------------------
-- Server version	5.1.69

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assetscustomer`
--

DROP TABLE IF EXISTS `assetscustomer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetscustomer` (
  `acId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'asset id',
  `acsId` int(11) NOT NULL COMMENT 'slot id',
  `aciId` int(11) NOT NULL COMMENT 'order item id',
  `acVal` varchar(2048) DEFAULT NULL COMMENT 'value of asset',
  `acMime` varchar(48) NOT NULL COMMENT 'mime type',
  `acStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`acId`)
) ENGINE=MyISAM AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetscustomer`
--

LOCK TABLES `assetscustomer` WRITE;
/*!40000 ALTER TABLE `assetscustomer` DISABLE KEYS */;
INSERT INTO `assetscustomer` VALUES (1,2,11,'/home/tegt/storefront/angel/loadup/web/assets/customer/inset-RA98C18E9O158AC0C8DBEBBE50012D3ADAD935D88C-1','image/jpeg; charset=binary','2013-06-03 22:38:44'),(2,2,14,'/home/tegt/storefront/angel/loadup/web/assets/customer/inset-RA98C18E9OED3C4AA990E152A1A3E1D8C35F298EFC-1','image/jpeg; charset=binary','2013-06-05 17:20:26'),(3,2,16,'/home/tegt/storefront/angel/loadup/web/assets/customer/inset-RA98C18E9O6598974B6B3EDA5F9A20A76797F34675-1','image/png; charset=binary','2013-06-06 17:39:56'),(50,2,23,'/home/tegt/storefront/angel/loadup/web/assets/customer/inset-RA98C18D5OB831A19628C591E6FA89BB1A5A2F286B-1','image/png; charset=binary','2013-06-07 18:25:48'),(60,2,27,'/home/tegt/storefront/angel/loadup/web/assets/customer/inset-RA98C18A9OE4280A285722360B183F85701BC29D28-1','image/jpeg; charset=binary','2013-06-07 18:42:45'),(72,2,102,'/home/tegt/storefront/angel/loadup/web/assets/customer/inset-RA98C183AO185E5594A58A14C2230EF17067193560-1','image/jpeg; charset=binary','2013-06-13 22:59:18'),(68,2,28,'/home/tegt/storefront/angel/loadup/web/assets/customer/inset-RA98C18A8OB1E1A362A6BF67C10CD8F29189380E7A-1','image/jpeg; charset=binary','2013-06-07 19:46:15'),(71,2,41,'/home/tegt/storefront/angel/loadup/web/assets/customer/inset-RA98C1887O4E88611F48FE66B4A0802F91AD90CE54-1','image/jpeg; charset=binary','2013-06-13 22:06:37'),(73,3,105,'/home/tegt/storefront/angel/loadup/web/assets/customer/image-RA98C183FO9A344BD3240816F31185D30A02D5F6DD-1','image/jpeg; charset=binary','2013-06-18 17:23:57'),(74,3,106,'/home/tegt/storefront/angel/loadup/web/assets/customer/image_RA98C1831OD81B63CCFD1FE916324DC18433C1016D_1','image/jpeg; charset=binary','2013-06-18 17:37:54'),(75,3,107,'/home/tegt/storefront/angel/loadup/web/assets/customer/image_RA98C1830O676908B0C517B06153D4B0F0E97061D0_1','image/jpeg; charset=binary','2013-06-18 17:39:55'),(76,3,108,'/home/tegt/storefront/angel/loadup/web/assets/customer/image_RA98C1833O347ECC08AFCE86E46BBF5B60FD9A520E_1','image/jpeg; charset=binary','2013-06-18 18:06:31'),(77,3,110,'/home/tegt/storefront/angel/loadup/web/assets/customer/image_RA98C1834O74CAFC301C2233CE1CE796A0AC749C0B_1','image/jpeg; charset=binary','2013-06-18 20:43:09'),(78,3,111,'/home/tegt/storefront/angel/loadup/web/assets/customer/image_RA98C1837O8E0CBFC2833BB9FB1F963D9967CE6029_1','image/jpeg; charset=binary','2013-06-18 20:59:01');
/*!40000 ALTER TABLE `assetscustomer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetspartner`
--

DROP TABLE IF EXISTS `assetspartner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetspartner` (
  `apId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'asset id',
  `apsId` int(11) NOT NULL COMMENT 'slot id',
  `apmId` int(11) NOT NULL DEFAULT '0' COMMENT 'model id',
  `appId` int(11) NOT NULL DEFAULT '0' COMMENT 'owning partner id',
  `apVal` varchar(2048) DEFAULT NULL COMMENT 'asset value',
  `apMime` varchar(48) NOT NULL COMMENT 'mime type',
  `apStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`apId`),
  UNIQUE KEY `apsId` (`apsId`,`apmId`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetspartner`
--

LOCK TABLES `assetspartner` WRITE;
/*!40000 ALTER TABLE `assetspartner` DISABLE KEYS */;
INSERT INTO `assetspartner` VALUES (2,1,0,0,'/home/tegt/storefront/angel/loadup/web/assets/partner/background-53','image/jpeg; charset=binary','2013-06-05 17:14:42'),(5,2,62,11,'/home/tegt/rpi.tegt.com/angel/loadup/web/assets/partner/inset-m62-p11','image/jpeg; charset=binary','2013-06-07 18:23:46'),(7,2,0,16,'/home/tegt/storefront/angel/loadup/web/assets/partner/inset-m63-p16','image/jpeg; charset=binary','2013-06-07 18:41:44'),(8,1,64,11,'/home/tegt/rpi.tegt.com/angel/loadup/web/assets/partner/background-m64-p11','image/jpeg; charset=binary','2013-06-10 00:10:14');
/*!40000 ALTER TABLE `assetspartner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `cId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'end customer id',
  `cpId` int(11) NOT NULL COMMENT 'owning partners id',
  `cPref` varchar(256) NOT NULL COMMENT 'partner reference data',
  `cName` varchar(256) NOT NULL COMMENT 'customer name',
  `cCompany` varchar(256) NOT NULL COMMENT 'company or care-of name',
  `cEmail` varchar(100) NOT NULL COMMENT 'email address',
  `cPhone` varchar(30) NOT NULL COMMENT 'phone number',
  `cAddr1` varchar(256) NOT NULL COMMENT 'address line 1',
  `cAddr2` varchar(256) NOT NULL COMMENT 'address line 2',
  `cCity` varchar(256) NOT NULL,
  `cState` varchar(256) NOT NULL,
  `cPostal` varchar(256) NOT NULL COMMENT 'zip or postal code',
  `cCountry` varchar(256) NOT NULL DEFAULT 'USA',
  `cStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cId`)
) ENGINE=MyISAM AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (2,11,'hand made customer','Johnny Appleseed','Motts','john@motts.com','3121121415','13 Mocking Bird Ln','% Sylivia','Chicago','IL','68118','USA','2013-06-04 21:47:28'),(4,11,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-05 22:31:08'),(5,11,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-06 18:37:07'),(6,11,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-06 19:02:13'),(7,11,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-06 21:04:44'),(8,11,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-06 21:32:57'),(9,11,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-06 21:44:04'),(10,11,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-06 21:45:02'),(11,0,'','','','','','','','','','','USA','2013-06-09 20:00:16'),(12,0,'','','','','','','','','','','USA','2013-06-09 20:00:55'),(13,0,'','','','','','','','','','','USA','2013-06-09 20:04:16'),(14,0,'','','','','','','','','','','USA','2013-06-09 20:06:07'),(15,0,'','','','','','','','','','','USA','2013-06-09 20:06:33'),(16,0,'','','','','','','','','','','USA','2013-06-09 20:07:49'),(17,0,'','','','','','','','','','','USA','2013-06-09 20:10:02'),(18,0,'','','','','','','','','','','USA','2013-06-09 20:26:32'),(19,0,'','','','','','','','','','','USA','2013-06-09 20:30:18'),(20,0,'','','','','','','','','','','USA','2013-06-09 20:37:11'),(21,0,'','','','','','','','','','','USA','2013-06-09 20:39:49'),(22,0,'','','','','','','','','','','USA','2013-06-09 20:40:31'),(23,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 20:47:48'),(24,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 20:49:15'),(25,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 20:52:51'),(26,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 20:56:19'),(27,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 20:56:54'),(28,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 20:57:34'),(29,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 20:58:36'),(30,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 21:00:11'),(31,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 21:01:21'),(32,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 21:07:27'),(33,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 21:31:00'),(34,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 21:31:55'),(35,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 21:32:49'),(36,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 21:33:08'),(37,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 22:41:06'),(38,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 22:42:19'),(39,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:09:34'),(40,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:10:55'),(41,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:13:27'),(42,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:17:10'),(43,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:20:26'),(44,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:23:30'),(45,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:26:46'),(46,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:30:24'),(47,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:30:43'),(48,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:34:46'),(49,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:39:40'),(50,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:41:12'),(51,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:44:57'),(52,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:47:37'),(53,0,'','Pete Haskel','','petehas@gmail.com','','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:50:42'),(54,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:51:36'),(55,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-09 23:52:01'),(56,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 00:14:14'),(57,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 16:43:10'),(58,0,'','','','','','','','','','','USA','2013-06-10 17:18:05'),(59,0,'','','','','','','','','','','USA','2013-06-10 17:20:50'),(60,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 17:21:53'),(61,0,'','','','','','','','','','','USA','2013-06-10 17:22:45'),(62,0,'','','','','','','','','','','USA','2013-06-10 17:23:26'),(63,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 17:23:37'),(64,0,'','','','','','','','','','','USA','2013-06-10 17:27:58'),(65,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 17:28:43'),(66,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 17:29:27'),(67,0,'','','','','','','','','','','USA','2013-06-10 17:43:55'),(68,0,'','','','','','','','','','','USA','2013-06-10 17:59:36'),(69,0,'','','','','','','','','','','USA','2013-06-10 18:02:03'),(70,0,'','','','','','','','','','','USA','2013-06-10 18:08:20'),(71,0,'','','','','','','','','','','USA','2013-06-10 18:08:48'),(72,0,'','','','','','','','','','','USA','2013-06-10 18:09:03'),(73,0,'','','','','','','','','','','USA','2013-06-10 18:09:22'),(74,0,'','','','','','','','','','','USA','2013-06-10 18:10:00'),(75,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 18:12:42'),(76,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 18:17:15'),(77,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 18:21:28'),(78,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 18:23:22'),(79,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 18:37:55'),(80,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 18:39:44'),(81,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 18:42:06'),(82,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 19:00:44'),(83,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:16:57'),(84,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:32:36'),(85,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:32:49'),(86,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:36:31'),(87,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:36:50'),(88,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:38:59'),(89,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:43:45'),(90,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:44:56'),(91,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:52:10'),(92,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:55:14'),(93,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:55:34'),(94,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:55:58'),(95,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:56:35'),(96,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 21:59:14'),(97,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-10 22:00:13'),(98,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-11 16:17:01'),(99,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-11 16:29:15'),(100,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-11 16:29:33'),(101,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-11 17:25:08'),(102,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-11 17:25:38'),(103,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-11 17:27:00'),(104,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-11 17:30:08'),(105,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-11 18:13:47'),(106,0,'','Pete Haskel','','petehas@gmail','42543339','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-11 18:15:47'),(107,0,'','','','','','','','','','','USA','2013-06-11 19:02:46'),(108,0,'','','','','','','','','','','USA','2013-06-11 19:05:06'),(109,0,'','','','','','','','','','','USA','2013-06-11 19:06:01'),(110,0,'','','','','','','','','','','USA','2013-06-11 19:06:29'),(111,0,'','','','','','','','','','','USA','2013-06-11 19:06:57'),(112,0,'','','','','','','','','','','USA','2013-06-11 19:08:56'),(113,0,'','','','','','','','','','','USA','2013-06-11 19:09:19'),(114,0,'','','','','','','','','','','USA','2013-06-11 19:10:17'),(115,0,'','','','','','','','','','','USA','2013-06-11 19:11:25'),(116,0,'','','','','','','','','','','USA','2013-06-11 19:11:32'),(117,0,'','','','','','','','','','','USA','2013-06-11 19:12:50'),(118,0,'','','','','','','','','','','USA','2013-06-11 19:15:02'),(119,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-11 19:18:21'),(120,0,'','','','','','','','','','','USA','2013-06-11 19:33:03'),(121,0,'','','','','','','','','','','USA','2013-06-11 19:35:02'),(122,0,'','','','','','','','','','','USA','2013-06-11 19:35:58'),(123,0,'','','','','','','','','','','USA','2013-06-11 20:16:00'),(124,0,'','','','','','','','','','','USA','2013-06-11 21:04:55'),(125,0,'','','','','','','','','','','USA','2013-06-11 21:46:17'),(126,0,'','','','','','','','','','','USA','2013-06-11 22:17:50'),(127,0,'','','','','','','','','','','USA','2013-06-11 22:20:36'),(128,0,'','','','','','','','','','','USA','2013-06-11 22:27:32'),(129,0,'','','','','','','','','','','USA','2013-06-11 22:29:02'),(130,0,'','','','','','','','','','','USA','2013-06-11 22:31:18'),(131,0,'','','','','','','','','','','USA','2013-06-11 22:36:50'),(132,0,'','','','','','','','','','','USA','2013-06-11 22:42:26'),(133,0,'','','','','','','','','','','USA','2013-06-11 22:46:24'),(134,0,'','','','','','','','','','','USA','2013-06-11 22:48:06'),(135,0,'','','','','','','','','','','USA','2013-06-11 22:48:20'),(136,0,'','','','','','','','','','','USA','2013-06-11 22:49:38'),(137,0,'','','','','','','','','','','USA','2013-06-11 22:49:52'),(138,0,'','','','','','','','','','','USA','2013-06-11 22:52:08'),(139,0,'','','','','','','','','','','USA','2013-06-11 22:52:53'),(140,0,'','','','','','','','','','','USA','2013-06-11 22:56:44'),(141,0,'','','','','','','','','','','USA','2013-06-11 22:56:53'),(142,0,'','','','','','','','','','','USA','2013-06-11 23:03:34'),(143,0,'','','','','','','','','','','USA','2013-06-12 00:06:53'),(144,0,'','','','','','','','','','','USA','2013-06-12 00:09:17'),(145,0,'','','','','','','','','','','USA','2013-06-12 00:11:22'),(146,0,'','','','','','','','','','','USA','2013-06-12 00:14:58'),(147,0,'','','','','','','','','','','USA','2013-06-12 00:16:19'),(148,0,'','','','','','','','','','','USA','2013-06-12 00:17:16'),(149,0,'','','','','','','','','','','USA','2013-06-12 00:17:43'),(150,0,'','','','','','','','','','','USA','2013-06-13 00:36:39'),(151,0,'','','','','','','','','','','USA','2013-06-13 20:22:13'),(152,0,'','','','','','','','','','','USA','2013-06-13 20:59:23'),(153,0,'','','','','','','','','','','USA','2013-06-13 20:59:37'),(154,0,'','','','','','','','','','','USA','2013-06-13 21:09:31'),(155,0,'','','','','','','','','','','USA','2013-06-13 21:10:29'),(156,0,'','','','','','','','','','','USA','2013-06-13 21:23:30'),(157,0,'','Pete Haskel','','petehas@gmail.com','4254333962','Fleetwood Apartments #1405','817 NE Mace St.','Irving','IL','68081','USA','2013-06-13 22:59:18'),(158,0,'','','','','','','','','','','USA','2013-06-18 17:35:44'),(159,0,'','','','','','','','','','','USA','2013-06-18 17:37:54'),(160,0,'','Grant Tegtmeier','','grant.tegtmeier@rpiprint.com','425-391-7637','Seattle Showroom','315 1st Avenue South, Suite 200','Seattle','WA','98104','USA','2013-06-18 17:39:55'),(161,0,'','Grant Tegtmeier','','grant.tegtmeier@rpiprint.com','425-391-7637','Seattle Showroom','315 1st Avenue South, Suite 200','Seattle','WA','98104','USA','2013-06-18 18:06:31'),(162,0,'','','','','','','','','','','USA','2013-06-18 20:21:45'),(163,0,'','','','','','','','','','','USA','2013-06-18 20:35:16'),(164,0,'','','','','','','','','','','USA','2013-06-18 20:43:09'),(165,0,'','','','','','','','','','','USA','2013-06-18 20:59:01');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files` (
  `fId` int(11) NOT NULL COMMENT 'file id',
  `fPath` varchar(256) NOT NULL COMMENT 'full server file path ',
  `fFrom` varchar(256) NOT NULL COMMENT 'original file name',
  `fMime` varchar(256) NOT NULL COMMENT 'mime type of file',
  `faId` int(11) NOT NULL COMMENT 'asset id file fills',
  `fiId` int(11) NOT NULL DEFAULT '0' COMMENT 'item id if order file',
  `tStamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`fId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `iId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'order item id',
  `iSeq` int(11) NOT NULL DEFAULT '1' COMMENT 'Sequence # of order item',
  `iPref` varchar(256) NOT NULL COMMENT 'partner reference data',
  `iNote` varchar(1024) NOT NULL COMMENT 'order item note',
  `iCopies` int(11) NOT NULL DEFAULT '1' COMMENT 'number of copies',
  `ioId` int(11) NOT NULL COMMENT 'this items order id',
  `imId` int(11) NOT NULL COMMENT 'template id',
  `iStatus` int(11) NOT NULL DEFAULT '1' COMMENT 'storefront state code',
  `iUosId` varchar(128) NOT NULL COMMENT 'UOS id if assigned',
  `iStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`iId`),
  KEY `ioId` (`ioId`)
) ENGINE=MyISAM AUTO_INCREMENT=112 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (19,1,'','Item modeled from \"up again\"',1,34,53,1,'','2013-06-06 19:51:14'),(18,1,'','Item modeled from \"newby\"',1,33,53,1,'','2013-06-06 19:50:57'),(17,1,'','Item modeled from \"renew\"',1,32,53,1,'','2013-06-06 19:50:06'),(16,1,'','Item modeled from \"iOS\"',1,27,57,1,'','2013-06-05 22:36:03'),(14,1,'','Item modeled from \"Sunset for Dad\"',1,25,53,1,'','2013-06-05 17:04:13'),(22,1,'','Item modeled from \"June sunset for me\"',1,59,58,1,'','2013-06-07 15:36:19'),(23,1,'','Item modeled from \"Gotta sunset\"',1,60,62,1,'','2013-06-07 15:42:52'),(24,1,'','Item modeled from \"Gotta sunset\"',1,61,62,1,'','2013-06-07 16:03:25'),(28,1,'','Item modeled from \"now a pink one\"',1,65,63,1,'','2013-06-07 18:42:31'),(27,1,'','Item modeled from \"fresh\"',1,64,63,1,'','2013-06-07 18:37:29'),(29,1,'','',1,97,0,1,'','2013-06-09 23:20:26'),(30,1,'','',1,98,42,1,'','2013-06-09 23:23:30'),(31,1,'','',1,99,42,1,'','2013-06-09 23:26:46'),(32,1,'','',1,101,42,1,'','2013-06-09 23:30:43'),(33,1,'','',1,102,62,1,'','2013-06-09 23:34:47'),(34,1,'','',1,103,62,1,'','2013-06-09 23:39:40'),(35,1,'','',1,104,62,1,'','2013-06-09 23:41:13'),(36,1,'','',1,105,62,1,'','2013-06-09 23:44:57'),(37,1,'','',1,106,62,1,'','2013-06-09 23:47:37'),(38,1,'','',1,107,62,1,'','2013-06-09 23:50:42'),(39,1,'','',1,108,62,1,'','2013-06-09 23:51:36'),(40,1,'','',1,109,62,1,'','2013-06-09 23:52:02'),(41,1,'','Item modeled from \"up rising\"',1,110,64,1,'','2013-06-10 00:09:47'),(47,1,'','',1,121,64,1,'','2013-06-10 17:29:27'),(102,1,'','',1,211,64,1,'','2013-06-13 22:59:18'),(111,1,'','',1,222,67,1,'','2013-06-18 20:59:01'),(110,1,'','',1,221,67,1,'','2013-06-18 20:43:09'),(109,1,'','',1,220,67,1,'','2013-06-18 20:35:16'),(108,1,'','',1,218,67,1,'','2013-06-18 18:06:31'),(107,1,'','',1,217,67,1,'','2013-06-18 17:39:55'),(106,1,'','',1,216,67,1,'','2013-06-18 17:37:54'),(105,1,'','Item modeled from \"fire up\"',1,214,67,1,'','2013-06-18 17:20:30'),(104,1,'','Item modeled from \"Bob one up\"',1,213,66,1,'','2013-06-18 17:12:13'),(103,1,'','Item modeled from \"white\"',1,212,63,1,'','2013-06-17 22:58:11'),(101,1,'','',1,175,64,1,'','2013-06-11 19:35:02');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keysmodel`
--

DROP TABLE IF EXISTS `keysmodel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keysmodel` (
  `kmKey` varchar(64) NOT NULL,
  `kmMId` int(11) NOT NULL,
  `kmNote` varchar(256) NOT NULL,
  `kmMsg` varchar(256) NOT NULL COMMENT 'Key msg ** disables',
  `kmStamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`kmKey`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keysmodel`
--

LOCK TABLES `keysmodel` WRITE;
/*!40000 ALTER TABLE `keysmodel` DISABLE KEYS */;
INSERT INTO `keysmodel` VALUES ('RA98C18D8MA9FF9ADEBE55AF491F2117C103CCBDED',49,'Ship with insert','','0000-00-00 00:00:00'),('RA98C18D9MC5F88218EBD54921BD52E29724769AE7',48,'Version 2.3 of seaview poster','','0000-00-00 00:00:00'),('RA98C18DAMFBB7CAE28B43B83ABBD871593494E9B9',51,'Version 1.0 release','','0000-00-00 00:00:00'),('RA98C18D7M972139897D843EEC02715121D9718C53',62,'Only on Android','','0000-00-00 00:00:00'),('RA98C18D1M68A115426ABCD9D5EE3F23BFB08E01FB',56,'First release','','0000-00-00 00:00:00'),('RA98C18D0M0A3D789547D19F37E120102B1B52F2F8',57,'iOs first release','','0000-00-00 00:00:00'),('RA98C18D7M7E8C642BED8BAB7C7513C6D08699B7C4',62,'On all sites','','0000-00-00 00:00:00'),('RA98C18A9ME93F04DDE4DF348EBE142008876BF5BD',64,'up mine','','0000-00-00 00:00:00'),('RA98C18ABMEFDFEAA707DA4F6DE69968CFF649C711',66,'Single image test','','0000-00-00 00:00:00'),('RA98C18A9M467C359015D5611E5B0998DF669436C3',64,'Single image poster','','0000-00-00 00:00:00'),('RA98C18AAM8F5535374933D0BB99395422E8590FBB',67,'Single image poster','','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `keysmodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keysorder`
--

DROP TABLE IF EXISTS `keysorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keysorder` (
  `koKey` varchar(64) NOT NULL,
  `koOId` int(11) NOT NULL,
  `koNote` varchar(256) NOT NULL,
  `koMst` varchar(256) NOT NULL COMMENT 'Key msg ** disables',
  `koStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`koKey`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keysorder`
--

LOCK TABLES `keysorder` WRITE;
/*!40000 ALTER TABLE `keysorder` DISABLE KEYS */;
INSERT INTO `keysorder` VALUES ('RA98C18D6OF44BE7067BB65935AD0A51C3A6097018',63,'auto key','','0000-00-00 00:00:00'),('RA98C18D7OBC2303BB02334177274994669915480B',62,'auto key','','0000-00-00 00:00:00'),('RA98C18D4O310E16C96EE2A2E32F1F588C9165D9B1',61,'auto key','','0000-00-00 00:00:00'),('RA98C18D5OB831A19628C591E6FA89BB1A5A2F286B',60,'auto key','','0000-00-00 00:00:00'),('RA98C18D2O9FDFBE93C6DCC5F2491B33C765A93B61',59,'auto key','','0000-00-00 00:00:00'),('RA98C18D3O4DEB18A9A052F050E5A02A7EB9CEA97D',58,'auto key','','0000-00-00 00:00:00'),('RA98C18D0O76236AD1A2809CECDE1FF01A5F601D15',57,'auto key','','0000-00-00 00:00:00'),('RA98C18D1O61EA515C0E15B14E91DF05580260B6E2',56,'','','0000-00-00 00:00:00'),('RA98C18DEO04EB5A37126A2A58EE65B54D4DDF4787',55,'','','0000-00-00 00:00:00'),('RA98C18DFOADFC47BAB7D5015A15E87B8CBF482F2F',54,'','','0000-00-00 00:00:00'),('RA98C18DCO59ACA0F588BC3EF0C51D4ED62CEED138',53,'','','0000-00-00 00:00:00'),('RA98C18DDOA25205F556C472A0EE401D3DF47B342A',52,'','','0000-00-00 00:00:00'),('RA98C18A9OE4280A285722360B183F85701BC29D28',64,'auto key','','0000-00-00 00:00:00'),('RA98C18A8OB1E1A362A6BF67C10CD8F29189380E7A',65,'auto key','','0000-00-00 00:00:00'),('RA98C18ABO5A21F5898842FF06A9FA2272EC42CE36',66,'','','0000-00-00 00:00:00'),('RA98C18AAO854CEE5ACFC547710171DFAD6B8511B9',67,'','','0000-00-00 00:00:00'),('RA98C18ADO9256E4E553EF86A248B43501661F7C23',68,'','','0000-00-00 00:00:00'),('RA98C18ACOE93564DA196E7B9710A616A5FDC8BD93',69,'','','0000-00-00 00:00:00'),('RA98C18AFO7A7FC51432CDD25CA22C725895B02C03',70,'','','0000-00-00 00:00:00'),('RA98C18AEO10A01C57978C7003DC521281F47DBBBC',71,'','','0000-00-00 00:00:00'),('RA98C18A1OCDCB46FB57A809E781E3A97AD9CB6771',72,'','','0000-00-00 00:00:00'),('RA98C18A0O6D85E67373E4B124FC6883EFCED2AF73',73,'','','0000-00-00 00:00:00'),('RA98C18A3O20D0FF69373C199D3DF4EA400F50A7CB',74,'','','0000-00-00 00:00:00'),('RA98C18A2O2084D47D352C07186AE0CC226CC4EB5D',75,'','','0000-00-00 00:00:00'),('RA98C18A5O9806EF0D3A472142F459BAFAFCCC210B',76,'','','0000-00-00 00:00:00'),('RA98C18A4OD200E15E2A683370D802C827F4722EA2',77,'','','0000-00-00 00:00:00'),('RA98C18A7OCF3EC4EB26764E22A24BC15708EBFA73',78,'','','0000-00-00 00:00:00'),('RA98C18A6OC29516F439596DCA09411D174691A592',79,'','','0000-00-00 00:00:00'),('RA98C18B9O67335967A724937755D3C163357E456F',80,'','','0000-00-00 00:00:00'),('RA98C18B8O569D2D39AC27C722F7F1EEE8BB6531A4',81,'','','0000-00-00 00:00:00'),('RA98C18BBO1FBB3FDF1B6FF89BA268CA66C30CF25D',82,'','','0000-00-00 00:00:00'),('RA98C18BAO2F77F22FD89B094A10B7DFDFAAD25F8C',83,'','','0000-00-00 00:00:00'),('RA98C18BDO2D42B43A4B4181C8851C0F3881E360CB',84,'','','0000-00-00 00:00:00'),('RA98C18BCO1F465CAFE655D00C872D0C6480E8311B',85,'','','0000-00-00 00:00:00'),('RA98C18BFOC62F43E3850E66340448168B5C8C7316',86,'','','0000-00-00 00:00:00'),('RA98C18BEOC05F700D56146BE74C183A4E8958F3B6',87,'','','0000-00-00 00:00:00'),('RA98C18B1OA220C30F1BAD4C2BED5F816C0E5C308D',88,'','','0000-00-00 00:00:00'),('RA98C18B0OC70706FBFAF5D6F40C5D85C702DBA416',89,'','','0000-00-00 00:00:00'),('RA98C18B3OE78436A635252213CD66E4A1FFE546FF',90,'','','0000-00-00 00:00:00'),('RA98C18B2OD9DF1199EAB38B3E1897DD363043B5B6',91,'','','0000-00-00 00:00:00'),('RA98C18B5O1D4F96193AEF38E54B2413C880A0B3A0',92,'','','0000-00-00 00:00:00'),('RA98C18B4O539643B482B7109270DB7EBAABA29AB2',93,'','','0000-00-00 00:00:00'),('RA98C18B7OA49134D208CB1BFC316211FC9B994AB1',94,'','','0000-00-00 00:00:00'),('RA98C18B6O303310AC814A6CC06817238FCDE5BCEC',95,'','','0000-00-00 00:00:00'),('RA98C1889O78302A06F621AABB96D49701A960AC52',96,'','','0000-00-00 00:00:00'),('RA98C1888O03F453470C81EF06A53489D4D24F1A00',97,'','','0000-00-00 00:00:00'),('RA98C188BO321A38C716B261F0F2C24537E84C32CC',98,'','','0000-00-00 00:00:00'),('RA98C188AOD030F49FA88F3181F43D79A25569D3DE',99,'','','0000-00-00 00:00:00'),('RA98C188DO62082A27303F92E264995D2C25212648',100,'','','0000-00-00 00:00:00'),('RA98C188COCFC7CEDC467EFD9C0838CB6197E80952',101,'','','0000-00-00 00:00:00'),('RA98C188FO4FE4E897346697A78388A7D0B2CB75C7',102,'','','0000-00-00 00:00:00'),('RA98C188EOF7D1BCC72A07796D2F2B0A916598F615',103,'','','0000-00-00 00:00:00'),('RA98C1881OD2BE9E67B81AB58A5E881561B26A8F49',104,'','','0000-00-00 00:00:00'),('RA98C1880O0A0F40C33010773F1764C3421C34C9D7',105,'','','0000-00-00 00:00:00'),('RA98C1883OFC0159BC470F5F0657661CA9F027A3A4',106,'','','0000-00-00 00:00:00'),('RA98C1882OE355669E755733322D792C462672C38B',107,'','','0000-00-00 00:00:00'),('RA98C1885O38CD8CDC182335630C13C8061BFD5D9E',108,'','','0000-00-00 00:00:00'),('RA98C1884ODDC8417BE2E3E5A9FE6D500C11F804FB',109,'','','0000-00-00 00:00:00'),('RA98C1887O4E88611F48FE66B4A0802F91AD90CE54',110,'auto key','','0000-00-00 00:00:00'),('RA98C1886O966DEA187B6D5229920F878634741577',111,'','','0000-00-00 00:00:00'),('RA98C1899OAFDEF0095150C79D1895548002E7493B',112,'','','0000-00-00 00:00:00'),('RA98C1898O35B49879D750DC6C5D63C6A158264039',113,'','','0000-00-00 00:00:00'),('RA98C189BOE7169378BAFB886822DBC1FF023D9A6F',114,'','','0000-00-00 00:00:00'),('RA98C189AOF7942B049EEC7832D484F54BCFE30745',115,'','','0000-00-00 00:00:00'),('RA98C189DOAF9F42D8EDE0C1345834AF8EF35D6D2C',116,'','','0000-00-00 00:00:00'),('RA98C189CO5E2E101E7EC7130952C8202552FAA476',117,'','','0000-00-00 00:00:00'),('RA98C189FO890F9C01B39BA43F0E2A7BEE0FD7D1F3',118,'','','0000-00-00 00:00:00'),('RA98C189EO5734344F812A79D0D15BF711EAB67826',119,'','','0000-00-00 00:00:00'),('RA98C1891OA581A7F3BFBF07A3CF084483E8F7006F',120,'','','0000-00-00 00:00:00'),('RA98C1890O60FE5BCE240073195A9BB634CC6F3C08',121,'','','0000-00-00 00:00:00'),('RA98C1893O82444886A89B1628B3B0A26DB078DF8E',122,'','','0000-00-00 00:00:00'),('RA98C1892O560FE5B3200F4C1108003C362FF58C77',123,'','','0000-00-00 00:00:00'),('RA98C1895OE641A77786B5996FA22F23E0FF2BBB88',124,'','','0000-00-00 00:00:00'),('RA98C1894O5B81E2AB05F0A001E56CA3A30D545B9D',125,'','','0000-00-00 00:00:00'),('RA98C1897O6AE517E2504FC38D89C2CAB74FDC2EE6',126,'','','0000-00-00 00:00:00'),('RA98C1896OFAE401187AD3D3C3B8047780D3CBC4B4',127,'','','0000-00-00 00:00:00'),('RA98C1869O552B09ECCFFBEBD146A3BBD04D13AC62',128,'','','0000-00-00 00:00:00'),('RA98C1868O552C202747686B1E7C6B540B815CE5A4',129,'','','0000-00-00 00:00:00'),('RA98C186BO200891621FE67D7F741964930645BC92',130,'','','0000-00-00 00:00:00'),('RA98C186AO19DD8566F05351CDA521A9EC35FB61EB',131,'','','0000-00-00 00:00:00'),('RA98C186DO41C5CBEC1F9C790934B73B690F5B5075',132,'','','0000-00-00 00:00:00'),('RA98C186COB245B50285FB4968D3F8B5F4BCFE529F',133,'','','0000-00-00 00:00:00'),('RA98C186FO15DF65F446A59822B8FA351CAEEBDC43',134,'','','0000-00-00 00:00:00'),('RA98C186EOA9AE6103207C93942EE926381C2A1D62',135,'','','0000-00-00 00:00:00'),('RA98C1861O49F443F6593D25BFF8F504BF8E3026ED',136,'','','0000-00-00 00:00:00'),('RA98C1860O28B48C6F4B8E320567FC461CF117D997',137,'','','0000-00-00 00:00:00'),('RA98C1863O4DA47FDDB866DF9D66A0B9379D86EA27',138,'','','0000-00-00 00:00:00'),('RA98C1862O71785A17ACB27920A5CAF65E1FBAFD00',139,'','','0000-00-00 00:00:00'),('RA98C1865OE22D208535125CC3AB862A23F2312C8B',140,'','','0000-00-00 00:00:00'),('RA98C1864O36E97C96B0332D6259F3268517B14CC1',141,'','','0000-00-00 00:00:00'),('RA98C1867ODB5BB3D629436FBE1DB1E5D94108609F',142,'','','0000-00-00 00:00:00'),('RA98C1866OBF742B24BEC5B1D734D4FAD8AFD70A3C',143,'','','0000-00-00 00:00:00'),('RA98C1879O6D8C9BBB7BAB59A5DA7913BAC151FED3',144,'','','0000-00-00 00:00:00'),('RA98C1878O2E26BFEA30874C46F652AFCC14570C0B',145,'','','0000-00-00 00:00:00'),('RA98C187BO8CE38899C45595E2061419C9D1C07177',146,'','','0000-00-00 00:00:00'),('RA98C187AOF4930DB6B5D4F9C073DC760DB0051914',147,'','','0000-00-00 00:00:00'),('RA98C187DO42031C03B3F8F89BE7986478D29BFF35',148,'','','0000-00-00 00:00:00'),('RA98C187COED88C6B78813EE4E3AD3BE4E16C60152',149,'','','0000-00-00 00:00:00'),('RA98C187FO565449C492465E44C4C4CBE43D2AEC8A',150,'','','0000-00-00 00:00:00'),('RA98C187EOB7FD5673ECD5260E4BDF0E560AD86292',151,'','','0000-00-00 00:00:00'),('RA98C1871OC6B1217A210EBF7E17B5312B57765524',152,'','','0000-00-00 00:00:00'),('RA98C1870O6778917D51725D25C9FFD40C12F3C5D7',153,'','','0000-00-00 00:00:00'),('RA98C1873O01F514CB6E77C58AF67368E5F2F5FD30',154,'','','0000-00-00 00:00:00'),('RA98C1872O135CC693631FC805F762B306F43AFA91',155,'','','0000-00-00 00:00:00'),('RA98C1875OB0B589EF1F04A86B00D2E611F66445A0',156,'','','0000-00-00 00:00:00'),('RA98C1874O2771D998B3F7348D67F9D7EB289C57B9',157,'','','0000-00-00 00:00:00'),('RA98C1877O0049DC24FA0BC9D0D0AB85A326158EB4',158,'','','0000-00-00 00:00:00'),('RA98C1876O8D170EA3296B215BB263CFADBA23AD12',159,'','','0000-00-00 00:00:00'),('RA98C1849O18E825A13536AFBB465944E5A0CC2FD4',160,'','','0000-00-00 00:00:00'),('RA98C1848O0E532A06D699ED3283A9CB696ED5F4C5',161,'','','0000-00-00 00:00:00'),('RA98C184BOA4CF433CB32AF6624684E6430912BD43',162,'','','0000-00-00 00:00:00'),('RA98C184AOE284CBDE9202AF28B22E03F30A16F7F3',163,'','','0000-00-00 00:00:00'),('RA98C184DO728381E85F54FBF803D5BCE2EA3ECF00',164,'','','0000-00-00 00:00:00'),('RA98C184COFFF8D6BAC65FD82A6DD5345B116425C5',165,'','','0000-00-00 00:00:00'),('RA98C184FOE3AA9A602476312702BCC2DBEE561FEA',166,'','','0000-00-00 00:00:00'),('RA98C184EO81FCFA7F1FE666E91793489DE62801B3',167,'','','0000-00-00 00:00:00'),('RA98C1841O5925FD80A14209DE340166A5FA308254',168,'','','0000-00-00 00:00:00'),('RA98C1840OB4CBA0B8A9A2C6D33E7B44FCF85331F5',169,'','','0000-00-00 00:00:00'),('RA98C1843OEA64383D07E4D310C50952000DBC0914',170,'','','0000-00-00 00:00:00'),('RA98C1842OFE8D25D6A272B4A4144B8FBBB7406740',171,'','','0000-00-00 00:00:00'),('RA98C1845OF048B6E1132FFDED51CA04D9668BF624',172,'','','0000-00-00 00:00:00'),('RA98C1844O23D7981A7D45D84ED4C7316A20A386E9',173,'','','0000-00-00 00:00:00'),('RA98C1847OC0E764C479CAAD43236E4B1642859959',174,'','','0000-00-00 00:00:00'),('RA98C1846O92E80672FD13D4B1501A636264477992',175,'','','0000-00-00 00:00:00'),('RA98C1859OC851CBD94C61F3962888D884DA8C61E7',176,'','','0000-00-00 00:00:00'),('RA98C1858O7215C89E62A4131F5C43B30BFEC511F3',177,'','','0000-00-00 00:00:00'),('RA98C185BO0AF8E522A7F8D0C48F300AA3C06C841F',178,'','','0000-00-00 00:00:00'),('RA98C185AO84CEBB727AC1E3CC9B3865F4BE901601',179,'','','0000-00-00 00:00:00'),('RA98C185DOF995F7EFB4A86D8A09A736D4D187865C',180,'','','0000-00-00 00:00:00'),('RA98C185CO22BA3856334EAF311963552A9604366B',181,'','','0000-00-00 00:00:00'),('RA98C185FO0E4D9334E2E28183E671E4887CF1C5CE',182,'','','0000-00-00 00:00:00'),('RA98C185EO72B15C7DCEA172149CF5A096C507C892',183,'','','0000-00-00 00:00:00'),('RA98C1851O1D2550055FB306814F330172B470CFE6',184,'','','0000-00-00 00:00:00'),('RA98C1850OEA79DCBD381F8F134BF9DBE4F6211043',185,'','','0000-00-00 00:00:00'),('RA98C1853OB64D6C5D8BD03A3BC362709913B6C5A4',186,'','','0000-00-00 00:00:00'),('RA98C1852O3913C58A9D99CB367498D54FF518350B',187,'','','0000-00-00 00:00:00'),('RA98C1855O8207C7A3BCD47C3500D27E3401D15338',188,'','','0000-00-00 00:00:00'),('RA98C1854O47234DB6997DEF0BD6537DD55C5A3B87',189,'','','0000-00-00 00:00:00'),('RA98C1857OAA4B114B39F9732D6409F7196FC199D0',190,'','','0000-00-00 00:00:00'),('RA98C1856OD2DA6CED3A37B7CE66B49AA07C1C46A7',191,'','','0000-00-00 00:00:00'),('RA98C1829OCDE187AAEB61389CEB53B080CBDFB102',192,'','','0000-00-00 00:00:00'),('RA98C1828OD7F6B5B5959468F9A079468550869A30',193,'','','0000-00-00 00:00:00'),('RA98C182BO67B8A681F75E5E8E59BCFCC66D904C2B',194,'','','0000-00-00 00:00:00'),('RA98C182AOB943BC907D36D42541FA6695F2870C71',195,'','','0000-00-00 00:00:00'),('RA98C182DO8E26EC711998CC3211BAAA21A969D3A4',196,'','','0000-00-00 00:00:00'),('RA98C182CO812E478302455549332B4572FA07F847',197,'','','0000-00-00 00:00:00'),('RA98C182FO2F75160BC1EBE1DE9EE0B11B2010EB6A',198,'','','0000-00-00 00:00:00'),('RA98C182EO1FD41A0CB6A7B7DB208337BA7647904A',199,'','','0000-00-00 00:00:00'),('RA98C1821O11414FDE7E572C284DF3432CB055BA5F',200,'','','0000-00-00 00:00:00'),('RA98C1820O09F7864904E7DA22B7AB7092FE509920',201,'','','0000-00-00 00:00:00'),('RA98C1823O0B475EDF91E18C436BB5B8DFD91624B0',202,'','','0000-00-00 00:00:00'),('RA98C1822O7374FAD6A4097768DF4DD26F78FFD4C1',203,'','','0000-00-00 00:00:00'),('RA98C1825OA3C400A462050D17B9FC8C4600A61B4D',204,'','','0000-00-00 00:00:00'),('RA98C1824O225A5FBD8AFAD08E87A1EAA7FDC4AD1C',205,'','','0000-00-00 00:00:00'),('RA98C1827OF821D0337C7DEDD5A516018AEA66CC13',206,'','','0000-00-00 00:00:00'),('RA98C1826ODC3F05B6171D14C33A0C4E217E15CC75',207,'','','0000-00-00 00:00:00'),('RA98C1839OEFBC6FBBC1900B2168DAFD11872635D0',208,'','','0000-00-00 00:00:00'),('RA98C1838OC9B34A0F4EB0B0FD7B91DCE4AA58643A',209,'','','0000-00-00 00:00:00'),('RA98C183BO814F69237DD7712484AEE72D053AF430',210,'','','0000-00-00 00:00:00'),('RA98C183AO185E5594A58A14C2230EF17067193560',211,'','','0000-00-00 00:00:00'),('RA98C183DO4F9E36927C7E41D5116922CB0162AE40',212,'auto key','','0000-00-00 00:00:00'),('RA98C183CO75C626251B0CBC563788269D912668D8',213,'auto key','','2013-06-18 17:12:13'),('RA98C183FO9A344BD3240816F31185D30A02D5F6DD',214,'auto key','','2013-06-18 17:20:30'),('RA98C183EOCF15728977823BE8292ACA5A72EBE219',215,'','','2013-06-18 17:35:44'),('RA98C1831OD81B63CCFD1FE916324DC18433C1016D',216,'','','2013-06-18 17:37:54'),('RA98C1830O676908B0C517B06153D4B0F0E97061D0',217,'','','2013-06-18 17:39:55'),('RA98C1833O347ECC08AFCE86E46BBF5B60FD9A520E',218,'','','2013-06-18 18:06:31'),('RA98C1832O7B0E991CAB6774CCB4D21FC914DC3E89',219,'','','2013-06-18 20:21:45'),('RA98C1835O99A8B924D5745769BE636B0C9F02F32A',220,'','','2013-06-18 20:35:16'),('RA98C1834O74CAFC301C2233CE1CE796A0AC749C0B',221,'','','2013-06-18 20:43:09'),('RA98C1837O8E0CBFC2833BB9FB1F963D9967CE6029',222,'','','2013-06-18 20:59:01');
/*!40000 ALTER TABLE `keysorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keyspartner`
--

DROP TABLE IF EXISTS `keyspartner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keyspartner` (
  `kpKey` varchar(64) NOT NULL,
  `kpPId` int(11) NOT NULL,
  `kpNote` varchar(256) NOT NULL,
  `kpMsg` varchar(256) NOT NULL COMMENT 'Key msg ** disables',
  `kpStamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`kpKey`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keyspartner`
--

LOCK TABLES `keyspartner` WRITE;
/*!40000 ALTER TABLE `keyspartner` DISABLE KEYS */;
INSERT INTO `keyspartner` VALUES ('RA98C18E2PE36D3C4B419C1190710045F5F1526D23',11,'2013 releases of poster sales','','0000-00-00 00:00:00'),('RA98C18E7P1BC5A7F08DEB7DCEA3C4A942DE5651DA',14,'Key for Android application','','0000-00-00 00:00:00'),('RA98C18E2P8BC1F7B79E0953550DB5B1B6E868E4FA',11,'Key for temp website','','0000-00-00 00:00:00'),('RA98C18E6P03D98E090EA13A53940C16E6964BE192',15,'Fist key','','0000-00-00 00:00:00'),('RA98C18F9P6CE5B2309CC09E7284C7DE9DE600C3AF',16,'Linux','','0000-00-00 00:00:00'),('RA98C18E9PACAE221C3CBE0F90965D62836C765373',16,'try','','0000-00-00 00:00:00'),('RA98C18E9PF0CFD395EFC4C5703F5A5A846C30B48F',16,'go','','0000-00-00 00:00:00'),('RA98C18E9PD60C048A8CC382DB50C774F002BF2C3F',16,'born broken','** Don\'t let is happen!!','2013-06-17 20:36:22');
/*!40000 ALTER TABLE `keyspartner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `models`
--

DROP TABLE IF EXISTS `models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `models` (
  `mId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'template (type) of product id',
  `mmId` int(11) NOT NULL DEFAULT '0' COMMENT 'Master Model Id',
  `mpId` int(11) NOT NULL COMMENT 'owning partner',
  `mName` varchar(256) NOT NULL COMMENT 'template name',
  `mPartNum` int(11) NOT NULL COMMENT 'Printflo/UOS partnum',
  `mPrintFloPart` varchar(256) NOT NULL COMMENT 'PrintFlo description field',
  `mStructure` varchar(2048) NOT NULL COMMENT 'structure of product in json',
  `mCost` int(11) NOT NULL COMMENT 'cost to partner (cents)',
  `mStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mId`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `models`
--

LOCK TABLES `models` WRITE;
/*!40000 ALTER TABLE `models` DISABLE KEYS */;
INSERT INTO `models` VALUES (42,0,13,'First Product',17,'Flo # 17','O:11:\"ModelStruct\":3:{s:7:\"version\";i:1;s:5:\"slots\";a:2:{s:5:\"inset\";s:26:\"image/jpeg; charset=binary\";s:10:\"background\";s:26:\"image/jpeg; charset=binary\";}s:3:\"sku\";s:13:\"SKU goes here\";}\r\n',50,'2013-06-18 17:00:56'),(51,42,14,'Cruise One with inset photo',17,'Flo # 17','O:11:\"ModelStruct\":3:{s:7:\"version\";i:1;s:5:\"slots\";a:2:{s:5:\"inset\";s:26:\"image/jpeg; charset=binary\";s:10:\"background\";s:26:\"image/jpeg; charset=binary\";}s:3:\"sku\";s:13:\"SKU goes here\";}\r\n',50,'2013-06-18 17:00:56'),(49,42,14,'Shipping out poster 26\"x44\"',17,'Flo # 17','O:11:\"ModelStruct\":3:{s:7:\"version\";i:1;s:5:\"slots\";a:2:{s:5:\"inset\";s:26:\"image/jpeg; charset=binary\";s:10:\"background\";s:26:\"image/jpeg; charset=binary\";}s:3:\"sku\";s:13:\"SKU goes here\";}\r\n',50,'2013-06-18 17:00:56'),(57,42,15,'Princess #1',17,'Flo # 17','O:11:\"ModelStruct\":3:{s:7:\"version\";i:1;s:5:\"slots\";a:2:{s:5:\"inset\";s:26:\"image/jpeg; charset=binary\";s:10:\"background\";s:26:\"image/jpeg; charset=binary\";}s:3:\"sku\";s:13:\"SKU goes here\";}\r\n',50,'2013-06-18 17:00:56'),(56,42,15,'Sun Rise Mtn',17,'Flo # 17','O:11:\"ModelStruct\":3:{s:7:\"version\";i:1;s:5:\"slots\";a:2:{s:5:\"inset\";s:26:\"image/jpeg; charset=binary\";s:10:\"background\";s:26:\"image/jpeg; charset=binary\";}s:3:\"sku\";s:13:\"SKU goes here\";}\r\n',50,'2013-06-18 17:00:56'),(63,42,16,'elephant',17,'Flo # 17','O:11:\"ModelStruct\":3:{s:7:\"version\";i:1;s:5:\"slots\";a:2:{s:5:\"inset\";s:26:\"image/jpeg; charset=binary\";s:10:\"background\";s:26:\"image/jpeg; charset=binary\";}s:3:\"sku\";s:13:\"SKU goes here\";}\r\n',50,'2013-06-18 17:00:56'),(65,0,13,'One Image Poster',17,'Flo # 17','O:11:\"ModelStruct\":3:{s:7:\"version\";i:1;s:5:\"slots\";a:1:{s:10:\"background\";s:26:\"image/jpeg; charset=binary\";}s:3:\"sku\";s:13:\"SKU goes here\";}',50,'2013-06-18 17:07:14'),(67,65,11,'Single 65',17,'Flo # 17','O:11:\"ModelStruct\":3:{s:7:\"version\";i:1;s:5:\"slots\";a:1:{s:10:\"background\";s:26:\"image/jpeg; charset=binary\";}s:3:\"sku\";s:13:\"SKU goes here\";}',50,'2013-06-18 17:19:26');
/*!40000 ALTER TABLE `models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `oId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'rpi storefront order number',
  `oPref` varchar(256) NOT NULL COMMENT 'partner reference data',
  `oNote` varchar(1024) NOT NULL DEFAULT '' COMMENT 'rpi storefront order note',
  `oShipping` varchar(256) NOT NULL COMMENT 'shipping request',
  `oState` int(11) NOT NULL DEFAULT '1' COMMENT 'status of order',
  `ocId` int(11) NOT NULL COMMENT 'customer id',
  `oStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last altered',
  PRIMARY KEY (`oId`),
  KEY `ocId` (`ocId`)
) ENGINE=MyISAM AUTO_INCREMENT=223 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (25,'','Sunset for Dad','',0,2,'2013-06-05 17:04:13'),(64,'','fresh','',0,0,'2013-06-07 18:37:29'),(61,'','Gotta sunset','',0,0,'2013-06-07 16:03:25'),(65,'','now a pink one','',0,0,'2013-06-07 18:42:31'),(59,'','June sunset for me','',0,0,'2013-06-07 15:36:19'),(60,'','Gotta sunset','',0,7,'2013-06-07 15:42:52'),(56,'Special offers at http://happypics.com/posters','Thanks for the memories, Ruth','UPS',0,10,'2013-06-06 21:45:02'),(55,'Special offers at http://happypics.com/posters','Thanks for the memories, Ruth','UPS',0,9,'2013-06-06 21:44:04'),(54,'Special offers at http://happypics.com/posters','Thanks for the memories, Ruth','UPS',0,8,'2013-06-06 21:32:57'),(53,'Special offers at http://happypics.com/posters','Thanks for the memories, Ruth','UPS',0,7,'2013-06-06 21:04:44'),(66,'','','',0,12,'2013-06-09 20:00:55'),(67,'','','',0,13,'2013-06-09 20:04:16'),(68,'','','',0,14,'2013-06-09 20:06:07'),(69,'','','',0,15,'2013-06-09 20:06:33'),(70,'','','',0,16,'2013-06-09 20:07:49'),(71,'','','',0,17,'2013-06-09 20:10:02'),(72,'','','',0,18,'2013-06-09 20:26:32'),(73,'','','',0,19,'2013-06-09 20:30:18'),(74,'','','',0,20,'2013-06-09 20:37:12'),(75,'','','',0,21,'2013-06-09 20:39:49'),(76,'','','',0,22,'2013-06-09 20:40:31'),(77,'','','',0,23,'2013-06-09 20:47:48'),(78,'','','',0,24,'2013-06-09 20:49:15'),(79,'','','',0,25,'2013-06-09 20:52:51'),(80,'','','',0,26,'2013-06-09 20:56:19'),(81,'','','',0,27,'2013-06-09 20:56:54'),(82,'','','',0,28,'2013-06-09 20:57:34'),(83,'','','',0,29,'2013-06-09 20:58:36'),(84,'','','',0,30,'2013-06-09 21:00:11'),(85,'','','',0,31,'2013-06-09 21:01:21'),(86,'','','',0,32,'2013-06-09 21:07:27'),(87,'','','',0,33,'2013-06-09 21:31:00'),(88,'','','',0,34,'2013-06-09 21:31:55'),(89,'','','',0,35,'2013-06-09 21:32:49'),(90,'','','',0,36,'2013-06-09 21:33:08'),(91,'','','',0,37,'2013-06-09 22:41:06'),(92,'','','',0,38,'2013-06-09 22:42:19'),(93,'','','',0,39,'2013-06-09 23:09:34'),(94,'','','',0,40,'2013-06-09 23:10:55'),(95,'','','',0,41,'2013-06-09 23:13:27'),(96,'','','',0,42,'2013-06-09 23:17:10'),(97,'','','',0,43,'2013-06-09 23:20:26'),(98,'','','',0,44,'2013-06-09 23:23:30'),(99,'','','',0,45,'2013-06-09 23:26:46'),(100,'','','',0,46,'2013-06-09 23:30:24'),(101,'','','',0,47,'2013-06-09 23:30:43'),(102,'','','',0,48,'2013-06-09 23:34:46'),(103,'','','',0,49,'2013-06-09 23:39:40'),(104,'','','',0,50,'2013-06-09 23:41:12'),(105,'','','',0,51,'2013-06-09 23:44:57'),(106,'','','',0,52,'2013-06-09 23:47:37'),(107,'','','',0,53,'2013-06-09 23:50:42'),(108,'','','',0,54,'2013-06-09 23:51:36'),(109,'','','',0,55,'2013-06-09 23:52:01'),(110,'','up rising','',0,0,'2013-06-10 00:09:47'),(113,'','','',0,0,'2013-06-10 17:18:05'),(114,'','','',0,0,'2013-06-10 17:20:50'),(116,'','','',0,0,'2013-06-10 17:22:45'),(117,'','','',0,0,'2013-06-10 17:23:26'),(119,'','','',0,0,'2013-06-10 17:27:58'),(121,'Special offers at http://happypics.com/posters','Thanks for the memories, Ruth','UPS',0,66,'2013-06-10 17:29:27'),(205,'','','',1,0,'2013-06-13 20:22:13'),(206,'','','',1,0,'2013-06-13 20:59:23'),(207,'','','',1,0,'2013-06-13 20:59:37'),(208,'','','',1,0,'2013-06-13 21:09:31'),(209,'','','',1,0,'2013-06-13 21:10:29'),(210,'','','',1,0,'2013-06-13 21:23:30'),(211,'Special offers at http://happypics.com/posters','Thanks for the memories, Ruth','UPS',2,157,'2013-06-13 22:59:18'),(212,'','white','',1,0,'2013-06-17 22:58:11'),(213,'','Bob one up','',1,0,'2013-06-18 17:12:13'),(214,'','fire up','',1,0,'2013-06-18 17:20:30'),(215,'Single poster single image','Wouldn\'t it be nice','UPS',1,0,'2013-06-18 17:35:44'),(216,'','','',1,159,'2013-06-18 17:37:54'),(217,'','','',2,160,'2013-06-18 17:39:55'),(218,'','','',2,161,'2013-06-18 18:06:31'),(219,'','','',1,0,'2013-06-18 20:21:45'),(220,'','','',1,0,'2013-06-18 20:35:16'),(221,'','','',1,0,'2013-06-18 20:43:09'),(222,'','','',1,0,'2013-06-18 20:59:01'),(175,'','Thanks for the memories, Ruth','',1,0,'2013-06-11 19:35:02'),(176,'','','',1,0,'2013-06-11 19:35:58'),(177,'','','',1,0,'2013-06-11 20:16:00'),(178,'','','',1,0,'2013-06-11 21:04:55'),(179,'','','',1,0,'2013-06-11 21:46:17'),(180,'','','',1,0,'2013-06-11 22:17:50'),(181,'','','',1,0,'2013-06-11 22:20:36'),(182,'','','',1,0,'2013-06-11 22:27:32'),(183,'','','',1,0,'2013-06-11 22:29:02'),(184,'','','',1,0,'2013-06-11 22:31:18'),(185,'','','',1,0,'2013-06-11 22:36:50'),(186,'','','',1,0,'2013-06-11 22:42:26'),(187,'','','',1,0,'2013-06-11 22:46:24'),(188,'','','',1,0,'2013-06-11 22:48:06'),(189,'','','',1,0,'2013-06-11 22:48:20'),(190,'','','',1,0,'2013-06-11 22:49:38'),(191,'','','',1,0,'2013-06-11 22:49:52'),(192,'','','',1,0,'2013-06-11 22:52:08'),(193,'','','',1,0,'2013-06-11 22:52:53'),(194,'','','',1,0,'2013-06-11 22:56:44'),(195,'','','',1,0,'2013-06-11 22:56:53'),(196,'','','',1,0,'2013-06-11 23:03:34'),(197,'','','',1,0,'2013-06-12 00:06:53'),(198,'','','',1,0,'2013-06-12 00:09:17'),(199,'','','',1,0,'2013-06-12 00:11:22'),(200,'','','',1,0,'2013-06-12 00:14:58'),(201,'','','',1,0,'2013-06-12 00:16:19'),(202,'','','',1,0,'2013-06-12 00:17:16'),(203,'','','',1,0,'2013-06-12 00:17:43'),(204,'','','',1,0,'2013-06-13 00:36:39');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_old`
--

DROP TABLE IF EXISTS `orders_old`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_old` (
  `oId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'rpi storefront order number',
  `oKey` varchar(48) NOT NULL COMMENT 'order key ',
  `oPref` varchar(256) NOT NULL COMMENT 'partner reference data',
  `oNote` varchar(1024) NOT NULL DEFAULT '' COMMENT 'rpi storefront order note',
  `oShipping` varchar(256) NOT NULL COMMENT 'shipping request',
  `oTestMsg` varchar(256) NOT NULL COMMENT 'If not "" order is a test for the reason',
  `ocId` int(11) NOT NULL COMMENT 'customer id',
  `oStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Last altered',
  PRIMARY KEY (`oId`),
  UNIQUE KEY `oKey` (`oKey`),
  KEY `ocId` (`ocId`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_old`
--

LOCK TABLES `orders_old` WRITE;
/*!40000 ALTER TABLE `orders_old` DISABLE KEYS */;
INSERT INTO `orders_old` VALUES (27,'RA98C18E9O6598974B6B3EDA5F9A20A76797F34675','','iOS','','',0,'2013-06-05 22:36:03'),(28,'','Special offers at http://happypics.com/posters','Thanks for the memories, Ruth','UPS','',0,'2013-06-06 19:18:58'),(25,'RA98C18E9OED3C4AA990E152A1A3E1D8C35F298EFC','','Sunset for Dad','','',2,'2013-06-05 17:04:13');
/*!40000 ALTER TABLE `orders_old` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partners`
--

DROP TABLE IF EXISTS `partners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partners` (
  `pId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'partner id',
  `pName` varchar(128) NOT NULL COMMENT 'contact person name or role',
  `pUsername` varchar(48) NOT NULL COMMENT 'Portal Username',
  `pCompany` varchar(256) NOT NULL COMMENT 'Company or care-of name',
  `pEmail` varchar(100) NOT NULL COMMENT 'email address',
  `pPhone` varchar(30) NOT NULL COMMENT 'phone number',
  `pLimit` int(11) NOT NULL DEFAULT '10000' COMMENT 'limit for outstanding (cents)',
  `pOutstanding` int(11) NOT NULL COMMENT 'Outstanding order value (cents)',
  `pAddr1` varchar(256) NOT NULL COMMENT 'address line 1',
  `pAddr2` varchar(256) NOT NULL COMMENT 'address line 2',
  `pCity` varchar(256) NOT NULL,
  `pState` varchar(256) NOT NULL,
  `pPostal` varchar(256) NOT NULL COMMENT 'zip or postal code',
  `pCountry` varchar(256) NOT NULL DEFAULT 'USA',
  `pStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pId`),
  UNIQUE KEY `pUsername` (`pUsername`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partners`
--

LOCK TABLES `partners` WRITE;
/*!40000 ALTER TABLE `partners` DISABLE KEYS */;
INSERT INTO `partners` VALUES (10,'','mastermodeler','RPI Master Modeler','','',0,0,'','','','','','USA','2013-05-28 22:06:00'),(11,'','brett','Test Company One','','',10000,0,'','','','','','USA','2013-05-28 22:08:00'),(14,'','somemore','some more','','',10000,0,'','','','','','USA','2013-05-29 18:58:47'),(15,'','lockwood','Bob Inc','','',10000,0,'','','','','','USA','2013-05-31 21:13:52'),(16,'','tegt','Tegt','','',10000,0,'','','','','','USA','2013-06-07 18:27:01');
/*!40000 ALTER TABLE `partners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slots`
--

DROP TABLE IF EXISTS `slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slots` (
  `sId` int(11) NOT NULL AUTO_INCREMENT,
  `smId` int(11) NOT NULL COMMENT 'owning model',
  `sName` varchar(64) NOT NULL COMMENT 'chunk name',
  `sType` enum('file','string','ord','int') NOT NULL DEFAULT 'file' COMMENT 'type for this asset',
  `sStamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`sId`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slots`
--

LOCK TABLES `slots` WRITE;
/*!40000 ALTER TABLE `slots` DISABLE KEYS */;
INSERT INTO `slots` VALUES (1,42,'background','file','2013-05-30 22:51:58'),(2,42,'inset','file','2013-05-30 22:51:58'),(3,65,'image','file','2013-06-18 17:21:22');
/*!40000 ALTER TABLE `slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work`
--

DROP TABLE IF EXISTS `work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `work` (
  `wId` int(11) NOT NULL AUTO_INCREMENT COMMENT 'work audit trail id',
  `wiId` int(11) NOT NULL DEFAULT '0' COMMENT 'item being tracked',
  `wOldStatus` int(11) NOT NULL DEFAULT '0' COMMENT 'state before this work',
  `wNewStatus` int(11) NOT NULL DEFAULT '0' COMMENT 'state after this work',
  `wMsg` varchar(4096) NOT NULL COMMENT 'message associated with work',
  `wStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`wId`),
  KEY `iId` (`wiId`)
) ENGINE=MyISAM AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work`
--

LOCK TABLES `work` WRITE;
/*!40000 ALTER TABLE `work` DISABLE KEYS */;
INSERT INTO `work` VALUES (69,0,0,0,'---+++\nfalse','2013-06-18 20:11:46'),(68,0,0,0,'---+++\nfalse','2013-06-18 20:10:46'),(67,0,0,0,'---+++\nfalse','2013-06-18 20:09:46'),(66,0,0,0,'---+++\nfalse','2013-06-18 20:08:46'),(65,0,0,0,'---+++\nfalse','2013-06-18 20:07:46'),(64,0,0,0,'---+++\nfalse','2013-06-18 20:06:46'),(63,0,0,0,'---+++\nfalse','2013-06-18 20:05:46'),(62,0,0,0,'---+++\nfalse','2013-06-18 20:04:46'),(61,0,0,0,'---+++\nfalse','2013-06-18 20:03:45'),(60,0,0,0,'---+++\nfalse','2013-06-18 20:02:45'),(59,0,0,0,'ttt---<?xml version=\"1.0\" encoding=\"utf-8\"?> 		   <Notification version=\"1.0\" 		     xmlns=\"http://uos.rpiprint.com/xml/RPIAckXML\" 		     xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" 		     xsi:schemaLocation=\"http://uos.rpiprint.com/xml/RPIAckXML 		       http://uos.rpiprint.com/xml/RPIAckXML-1-0.xsd\"> 		     <OrderID>Acme123</OrderID> 		     <AltOrderID>Web123</AltOrderID> 		     <Status>Accepted</Status> 		     <EventDate>2013-04-11T11:10:10-07:00</EventDate> 		   </Notification>+++\nSimpleXMLElement::__set_state(array(\n   \'@attributes\' => \n  array (\n    \'version\' => \'1.0\',\n  ),\n   \'OrderID\' => \'Acme123\',\n   \'AltOrderID\' => \'Web123\',\n   \'Status\' => \'Accepted\',\n   \'EventDate\' => \'2013-04-11T11:10:10-07:00\',\n))','2013-06-18 19:57:12'),(70,0,0,0,'---+++\nfalse','2013-06-18 20:12:46'),(71,0,0,0,'---+++\nfalse','2013-06-18 20:13:46'),(72,0,0,0,'---+++\nfalse','2013-06-18 20:14:46'),(73,0,0,0,'---+++\nfalse','2013-06-18 20:15:46'),(74,0,0,0,'---+++\nfalse','2013-06-18 20:16:46'),(75,0,0,0,'---+++\nfalse','2013-06-18 20:17:46'),(76,0,0,0,'---+++\nfalse','2013-06-18 20:18:47'),(77,0,0,0,'---+++\nfalse','2013-06-18 20:19:47'),(78,0,0,0,'---+++\nfalse','2013-06-18 20:20:47'),(79,0,0,0,'---+++\nfalse','2013-06-18 20:21:47'),(80,0,0,0,'---+++\nfalse','2013-06-18 20:22:47'),(81,0,0,0,'---+++\nfalse','2013-06-18 20:23:47'),(82,0,0,0,'---+++\nfalse','2013-06-18 20:24:47'),(83,0,0,0,'---+++\nfalse','2013-06-18 20:25:47'),(84,0,0,0,'---+++\nfalse','2013-06-18 20:26:47'),(85,0,0,0,'---+++\nfalse','2013-06-18 20:27:47'),(86,0,0,0,'---+++\nfalse','2013-06-18 20:28:47'),(87,0,0,0,'---+++\nfalse','2013-06-18 20:29:47'),(88,0,0,0,'---+++\nfalse','2013-06-18 20:30:47'),(89,0,0,0,'---+++\nfalse','2013-06-18 20:31:47'),(90,0,0,0,'---+++\nfalse','2013-06-18 20:32:47'),(91,0,0,0,'---+++\nfalse','2013-06-18 20:33:48'),(92,0,0,0,'---+++\nfalse','2013-06-18 20:34:48'),(93,0,0,0,'---+++\nfalse','2013-06-18 20:35:48'),(94,0,0,0,'---+++\nfalse','2013-06-18 20:36:48'),(95,0,0,0,'---+++\nfalse','2013-06-18 20:37:48'),(96,0,0,0,'---+++\nfalse','2013-06-18 20:38:48'),(97,0,0,0,'---+++\nfalse','2013-06-18 20:39:48'),(98,0,0,0,'---+++\nfalse','2013-06-18 20:40:48'),(99,0,0,0,'---+++\nfalse','2013-06-18 20:41:48'),(100,0,0,0,'---+++\nfalse','2013-06-18 20:42:48'),(101,0,0,0,'---+++\nfalse','2013-06-18 20:43:48'),(102,0,0,0,'---+++\nfalse','2013-06-18 20:44:48'),(103,0,0,0,'---+++\nfalse','2013-06-18 20:45:48'),(104,0,0,0,'---+++\nfalse','2013-06-18 20:46:48'),(105,0,0,0,'---+++\nfalse','2013-06-18 20:47:48'),(106,0,0,0,'---+++\nfalse','2013-06-18 20:48:48'),(107,0,0,0,'---+++\nfalse','2013-06-18 20:49:48'),(108,0,0,0,'---+++\nfalse','2013-06-18 20:50:48'),(109,0,0,0,'---+++\nfalse','2013-06-18 20:51:48'),(110,0,0,0,'---+++\nfalse','2013-06-18 20:52:48'),(111,0,0,0,'---+++\nfalse','2013-06-18 20:53:48'),(112,0,0,0,'---+++\nfalse','2013-06-18 20:54:48'),(113,0,0,0,'---+++\nfalse','2013-06-18 20:55:48'),(114,0,0,0,'---+++\nfalse','2013-06-18 20:56:48'),(115,0,0,0,'---+++\nfalse','2013-06-18 20:57:48'),(116,0,0,0,'---+++\nfalse','2013-06-18 20:58:49');
/*!40000 ALTER TABLE `work` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-06-18 13:59:15
