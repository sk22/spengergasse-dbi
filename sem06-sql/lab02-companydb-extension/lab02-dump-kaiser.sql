-- MySQL dump 10.13  Distrib 5.7.21, for Win64 (x86_64)
--
-- Host: localhost    Database: companydb_new
-- ------------------------------------------------------
-- Server version	5.7.21-log

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
-- Table structure for table `d_dept`
--

DROP TABLE IF EXISTS `d_dept`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `d_dept` (
  `d_deptno` decimal(10,0) NOT NULL,
  `d_dname` char(20) DEFAULT NULL,
  `d_loc` char(20) DEFAULT NULL,
  PRIMARY KEY (`d_deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `d_dept`
--

LOCK TABLES `d_dept` WRITE;
/*!40000 ALTER TABLE `d_dept` DISABLE KEYS */;
INSERT INTO `d_dept` VALUES (10,'accounting','new york'),(20,'research','dallas'),(30,'sales','chicago'),(40,'operations','boston');
/*!40000 ALTER TABLE `d_dept` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `e_emp`
--

DROP TABLE IF EXISTS `e_emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `e_emp` (
  `e_empno` decimal(10,0) NOT NULL,
  `e_ename` char(20) DEFAULT NULL,
  `e_job` char(20) DEFAULT NULL,
  `e_e_mgr` decimal(10,0) DEFAULT NULL,
  `e_hiredate` date DEFAULT NULL,
  `e_sal` decimal(10,0) DEFAULT NULL,
  `e_comm` decimal(5,0) DEFAULT NULL,
  `e_d_deptno` decimal(10,0) NOT NULL,
  `e_p_projno` int(11) DEFAULT NULL,
  PRIMARY KEY (`e_empno`),
  KEY `e_e_mgr` (`e_e_mgr`),
  KEY `e_p_projno` (`e_p_projno`),
  KEY `e_d_deptno` (`e_d_deptno`),
  CONSTRAINT `e_emp_ibfk_1` FOREIGN KEY (`e_e_mgr`) REFERENCES `e_emp` (`e_empno`) ON UPDATE CASCADE,
  CONSTRAINT `e_emp_ibfk_2` FOREIGN KEY (`e_p_projno`) REFERENCES `p_projects` (`p_projno`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `e_emp_ibfk_3` FOREIGN KEY (`e_d_deptno`) REFERENCES `d_dept` (`d_deptno`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `e_emp`
--

LOCK TABLES `e_emp` WRITE;
/*!40000 ALTER TABLE `e_emp` DISABLE KEYS */;
INSERT INTO `e_emp` VALUES (7369,'smith','clerk',7902,'1980-12-17',800,NULL,20,101),(7499,'allen','salesman',7698,'1981-02-20',1600,300,30,103),(7521,'ward','salesman',7698,'1981-02-22',1250,500,30,103),(7566,'jones','manager',7839,'1981-04-02',2975,NULL,20,101),(7654,'martin','salesman',7698,'1981-09-28',1250,1400,30,103),(7698,'blake','manager',7839,'1981-05-01',2850,NULL,30,101),(7782,'clark','manager',7839,'1981-06-09',2450,NULL,10,101),(7788,'scott','analyst',7566,'1982-12-19',3000,NULL,20,101),(7839,'king','president',NULL,'1981-11-17',5000,NULL,10,102),(7844,'turner','salesman',7698,'1981-09-08',1500,NULL,30,102),(7876,'adams','clerk',7788,'1983-01-12',1100,NULL,20,101),(7900,'james','clerk',7698,'1981-12-03',950,NULL,30,102),(7902,'ford','analyst',7566,'1981-12-03',3000,NULL,20,101),(7934,'miller','clerk',7782,'1982-01-23',1300,NULL,10,102);
/*!40000 ALTER TABLE `e_emp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `p_projects`
--

DROP TABLE IF EXISTS `p_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `p_projects` (
  `p_projno` int(11) NOT NULL,
  `p_name` varchar(20) DEFAULT NULL,
  `p_budget` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`p_projno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `p_projects`
--

LOCK TABLES `p_projects` WRITE;
/*!40000 ALTER TABLE `p_projects` DISABLE KEYS */;
INSERT INTO `p_projects` VALUES (101,'ALPHA',250.00),(102,'BETA',175.00),(103,'GAMMA',95.00);
/*!40000 ALTER TABLE `p_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `s_salgrade`
--

DROP TABLE IF EXISTS `s_salgrade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `s_salgrade` (
  `s_grade` decimal(2,0) NOT NULL,
  `s_losal` decimal(10,0) DEFAULT NULL,
  `s_hisal` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`s_grade`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `s_salgrade`
--

LOCK TABLES `s_salgrade` WRITE;
/*!40000 ALTER TABLE `s_salgrade` DISABLE KEYS */;
INSERT INTO `s_salgrade` VALUES (1,700,1200),(2,1201,1400),(3,1401,2000),(4,2001,3000),(5,3001,9000);
/*!40000 ALTER TABLE `s_salgrade` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-27 16:54:02
