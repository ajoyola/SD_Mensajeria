CREATE DATABASE  IF NOT EXISTS `mensajeria` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `mensajeria`;
-- MySQL dump 10.13  Distrib 5.5.50, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: mensajeria
-- ------------------------------------------------------
-- Server version	5.5.50-0+deb8u1

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
-- Table structure for table `activemq_acks`
--

DROP TABLE IF EXISTS `activemq_acks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activemq_acks` (
  `CONTAINER` varchar(250) NOT NULL,
  `SUB_DEST` varchar(250) DEFAULT NULL,
  `CLIENT_ID` varchar(250) NOT NULL,
  `SUB_NAME` varchar(250) NOT NULL,
  `SELECTOR` varchar(250) DEFAULT NULL,
  `LAST_ACKED_ID` bigint(20) DEFAULT NULL,
  `PRIORITY` bigint(20) NOT NULL DEFAULT '5',
  `XID` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`CONTAINER`,`CLIENT_ID`,`SUB_NAME`,`PRIORITY`),
  KEY `ACTIVEMQ_ACKS_XIDX` (`XID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activemq_acks`
--

LOCK TABLES `activemq_acks` WRITE;
/*!40000 ALTER TABLE `activemq_acks` DISABLE KEYS */;
/*!40000 ALTER TABLE `activemq_acks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activemq_lock`
--

DROP TABLE IF EXISTS `activemq_lock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activemq_lock` (
  `ID` bigint(20) NOT NULL,
  `TIME` bigint(20) DEFAULT NULL,
  `BROKER_NAME` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activemq_lock`
--

LOCK TABLES `activemq_lock` WRITE;
/*!40000 ALTER TABLE `activemq_lock` DISABLE KEYS */;
INSERT INTO `activemq_lock` VALUES (1,NULL,NULL);
/*!40000 ALTER TABLE `activemq_lock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activemq_msgs`
--

DROP TABLE IF EXISTS `activemq_msgs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activemq_msgs` (
  `ID` bigint(20) NOT NULL,
  `CONTAINER` varchar(250) DEFAULT NULL,
  `MSGID_PROD` varchar(250) DEFAULT NULL,
  `MSGID_SEQ` bigint(20) DEFAULT NULL,
  `EXPIRATION` bigint(20) DEFAULT NULL,
  `MSG` longblob,
  `PRIORITY` bigint(20) DEFAULT NULL,
  `XID` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ACTIVEMQ_MSGS_MIDX` (`MSGID_PROD`,`MSGID_SEQ`),
  KEY `ACTIVEMQ_MSGS_CIDX` (`CONTAINER`),
  KEY `ACTIVEMQ_MSGS_EIDX` (`EXPIRATION`),
  KEY `ACTIVEMQ_MSGS_PIDX` (`PRIORITY`),
  KEY `ACTIVEMQ_MSGS_XIDX` (`XID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activemq_msgs`
--

LOCK TABLES `activemq_msgs` WRITE;
/*!40000 ALTER TABLE `activemq_msgs` DISABLE KEYS */;
/*!40000 ALTER TABLE `activemq_msgs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contactos`
--

DROP TABLE IF EXISTS `contactos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contactos` (
  `idcontactos` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) NOT NULL,
  `conocidoDelUsuario` int(11) NOT NULL,
  PRIMARY KEY (`idcontactos`),
  KEY `usuario_ind` (`userID`),
  KEY `conocidoDelUsuario` (`conocidoDelUsuario`),
  CONSTRAINT `contactos_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `usuario` (`id`),
  CONSTRAINT `contactos_ibfk_2` FOREIGN KEY (`conocidoDelUsuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contactos`
--

LOCK TABLES `contactos` WRITE;
/*!40000 ALTER TABLE `contactos` DISABLE KEYS */;
INSERT INTO `contactos` VALUES (1,1,24),(2,1,5),(3,1,18),(4,1,30),(5,1,2),(6,1,15),(7,2,14),(8,2,19),(9,2,24),(10,2,22),(11,2,30),(12,4,14),(13,4,24),(14,4,20),(15,4,18),(16,5,17),(17,5,16),(18,5,14),(19,5,11),(20,5,10),(21,5,30),(22,5,27),(23,5,1),(24,6,4),(25,6,24),(26,6,14),(27,7,18),(28,7,23),(29,7,13),(30,8,22),(31,8,11),(32,8,1),(33,8,29),(34,9,27),(35,9,1),(36,9,4),(37,10,24),(38,10,2),(39,10,12),(40,10,1),(41,10,26),(42,11,1),(43,11,12),(44,11,30),(45,11,23),(46,12,27),(47,12,17),(48,12,25),(49,12,30),(50,13,2),(51,13,21),(52,13,12),(53,13,1),(54,13,28),(55,13,11),(56,14,7),(57,14,3),(58,14,23),(59,14,22),(60,15,11),(61,15,17),(62,15,19),(63,16,24),(64,16,17),(65,16,5),(66,16,3),(67,17,19),(68,17,11),(69,17,13),(70,17,15),(71,17,28),(72,18,12),(73,18,11),(74,19,3),(75,19,20),(76,19,28),(77,20,9),(78,20,18),(79,20,14),(80,20,23),(81,21,9),(82,21,2),(83,21,4),(84,22,7),(85,22,3),(86,22,30),(87,23,17),(88,23,1),(89,23,7),(90,23,5),(91,23,19),(92,24,12),(93,24,30),(94,24,6),(95,24,25),(96,24,1),(97,24,2),(98,25,30),(99,25,2),(100,25,3),(101,25,22),(102,25,14),(103,25,18),(104,26,22),(105,26,12),(106,26,17),(107,26,14),(108,27,14),(109,27,24),(110,27,4),(111,27,15),(112,27,25),(113,28,30),(114,28,1),(115,28,2),(116,28,14),(117,29,17),(118,29,22),(119,29,11),(120,29,16),(121,29,14),(122,29,2),(123,30,17),(124,30,2),(125,30,1),(126,30,16),(127,30,12),(128,30,28);
/*!40000 ALTER TABLE `contactos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID del Grupo',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombre del Grupo',
  `descripcion` varchar(200) DEFAULT NULL COMMENT 'Breve descripcion del grupo creado',
  `creador_id` int(11) NOT NULL COMMENT 'Id del usuario quien creo el grupo',
  PRIMARY KEY (`id`),
  KEY `creador_id` (`creador_id`),
  CONSTRAINT `grupo_ibfk_1` FOREIGN KEY (`creador_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE;
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */;
INSERT INTO `grupo` VALUES (1,'grupo-cole','chic@s de la cole',1),(2,'grupo-puchis','chic@s',2),(3,'grupo-trabajo','proyecto de la u',1),(4,'grupo-u','chic@s de la u',5),(5,'grupo-proyecto','chic@s de la u',1),(6,'grupo-u','chic@s de la u',9),(7,'sobrinas','sobrinas papa',1),(8,'Primas','grupo de las primas',1),(9,'curso-vacacional','curso amig@s',1),(10,'amig@s universidad','curso especial',1),(11,'chicas-eco','ecoamigables',1),(12,'dominicas','chicas cole',5),(13,'hadoop','apache',1),(14,'hadoop','apache',1);
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `integrantes`
--

DROP TABLE IF EXISTS `integrantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `integrantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `integranteID` int(11) NOT NULL COMMENT 'Id del usuario integrante del grupo',
  `grupoID` int(11) NOT NULL COMMENT 'Id del grupo',
  PRIMARY KEY (`id`),
  KEY `integranteID` (`integranteID`),
  KEY `grupoID` (`grupoID`),
  CONSTRAINT `integrantes_ibfk_1` FOREIGN KEY (`integranteID`) REFERENCES `usuario` (`id`),
  CONSTRAINT `integrantes_ibfk_2` FOREIGN KEY (`grupoID`) REFERENCES `grupo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `integrantes`
--

LOCK TABLES `integrantes` WRITE;
/*!40000 ALTER TABLE `integrantes` DISABLE KEYS */;
INSERT INTO `integrantes` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,5),(5,2,1),(6,6,2),(7,7,3),(8,8,5),(9,9,1),(10,10,2),(11,11,3),(12,12,5),(13,21,1),(14,22,2),(15,30,3),(16,17,5),(17,12,4),(18,13,4),(19,14,4),(20,15,4),(21,16,4),(22,22,4),(23,23,4),(24,24,4),(25,25,4),(26,26,4),(27,7,6),(28,9,6),(29,14,6),(30,15,6),(31,26,6),(32,11,6),(33,18,6),(34,16,6),(35,25,6),(36,30,6),(37,2,7),(38,5,7),(39,30,7),(40,14,8),(41,5,8),(42,13,8),(43,2,8),(44,1,8),(45,30,8),(46,1,9),(47,5,9),(48,2,9),(49,24,9),(50,15,9),(51,1,10),(52,24,10),(53,5,10),(54,15,10),(55,1,11),(56,30,11),(57,5,11),(58,5,12),(59,11,12),(60,10,12),(61,30,12),(62,1,12),(63,1,13);
/*!40000 ALTER TABLE `integrantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensaje`
--

DROP TABLE IF EXISTS `mensaje`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mensaje` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id del mensaje',
  `emisor_id` int(11) NOT NULL COMMENT 'Id del usuario que envÃÂÃÂÃÂÃÂ­a el mensaje',
  `destinatario_id` int(11) NOT NULL COMMENT 'Id del usuario que recibe el mensaje',
  `tipo` varchar(1) NOT NULL COMMENT 'G: Mensaje de Grupo, P: Mensaje entre un par de usuarios',
  `fecha` datetime DEFAULT NULL COMMENT 'Fecha de envÃÂÃÂÃÂÃÂ­o del mensaje',
  `texto` varchar(800) NOT NULL COMMENT 'Texto del mensaje ',
  `grupo_id` int(11) DEFAULT NULL COMMENT 'Id del grupo al cual pertenece el mensaje',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `emisor_fk_idx` (`emisor_id`),
  KEY `destinatario_fk_idx` (`destinatario_id`),
  KEY `grupo_fk_idx` (`grupo_id`),
  CONSTRAINT `destinatario_fk` FOREIGN KEY (`destinatario_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `emisor_fk` FOREIGN KEY (`emisor_id`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensaje`
--

LOCK TABLES `mensaje` WRITE;
/*!40000 ALTER TABLE `mensaje` DISABLE KEYS */;
INSERT INTO `mensaje` VALUES (1,7,6,'G','2016-06-26 23:13:12','Hola como estan?',6),(2,7,6,'G','2016-06-26 14:15:02','Hola como estan?',6),(3,6,24,'P','2016-07-08 20:30:12','Hola',NULL),(4,24,6,'P','2016-07-08 20:40:12','Hola, como sigues?',NULL),(5,6,24,'P','2016-07-08 20:50:12','mejor ya fui al doctor',NULL),(6,24,6,'P','2016-07-08 20:59:12','que bueno',NULL),(7,30,12,'P','2016-07-09 10:35:02','guardame puesto',NULL),(8,12,30,'P','2016-07-09 10:45:02','okas',NULL),(9,30,12,'P','2016-07-09 10:47:02','ya estoy cerca',NULL),(10,24,6,'P','2016-07-09 10:54:02','corre ya llego el profe!!',NULL),(11,2,3,'G','2016-07-09 22:23:12','Hola a todos',3),(12,2,3,'G','2016-07-09 22:23:12','Hola a todos',3),(13,1,1,'G','2016-07-10 10:30:12','Hola a todos',1),(14,21,1,'G','2016-07-10 10:30:12','Hola =)',1),(15,9,1,'G','2016-07-10 10:30:12','cual es la novedad?',1),(16,5,5,'G','2016-07-19 21:20:12','Que hay de deber',5),(17,5,5,'G','2016-07-19 21:20:12','Que hay de deber',5),(18,5,5,'G','2016-07-19 21:20:12','Que hay de deber',5),(19,2,14,'P','2016-07-20 14:15:02','Hola',NULL),(20,1,18,'P','2016-07-20 22:30:22','Hola',NULL),(21,2,19,'P','2016-07-21 18:10:22','Hola',NULL),(22,1,2,'G','2016-07-21 21:20:12','Hola donde estan',2),(23,1,2,'G','2016-07-21 21:20:12','Hola donde estan',2),(24,2,4,'G','2016-07-22 23:13:12','Hola donde estan',4),(25,2,4,'G','2016-07-22 23:13:12','Hola donde estan',4),(26,1,5,'P','2016-07-08 20:30:12','Hola',NULL),(27,5,1,'P','2016-07-08 20:40:12','Hola, como sigues?',NULL),(28,1,5,'P','2016-07-08 20:50:12','mejor ya fui al doctor',NULL),(29,5,1,'P','2016-07-08 20:59:12','que bueno',NULL),(30,1,5,'P','2016-07-08 21:10:12','que mas cuentas?',NULL),(31,5,1,'P','2016-07-08 21:13:12','no mucho y tu?',NULL),(32,1,5,'P','2016-07-08 21:15:12','fui al malecon',NULL),(33,5,1,'P','2016-07-08 21:29:12','viste una pelicula en el imax?',NULL),(34,30,1,'P','2016-07-09 12:59:12','hola, que tal?',NULL),(35,1,30,'P','2016-07-09 13:30:12','bien y tu?',NULL),(36,30,1,'P','2016-07-09 13:40:12','leyendo y tu?',NULL),(37,1,30,'P','2016-07-09 13:50:12','viendo pelis',NULL),(38,30,1,'P','2016-07-09 13:59:12','pelicula de terror?',NULL);
/*!40000 ALTER TABLE `mensaje` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id del usuario',
  `nombre` varchar(60) NOT NULL COMMENT 'Nombre del Usuario',
  `apellido` varchar(60) NOT NULL COMMENT 'Apellido del Usuario',
  `ciudad` varchar(60) NOT NULL COMMENT 'Ciudad del Usuario',
  `user` varchar(45) NOT NULL COMMENT 'Usuario para el login',
  `password` varchar(45) NOT NULL COMMENT 'Clave del usuario para el login',
  `estado_conexion` varchar(1) NOT NULL COMMENT 'C: Conectado, D: Desconectado',
  `fecha_ult_conexion` datetime DEFAULT NULL COMMENT 'Fecha de la ÃÂÃÂÃÂÃÂºltima conexiÃÂÃÂÃÂÃÂ³n',
  `foto` longblob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (2,'Katya','Desiderio','Guayaquil','katy_Desiderio','c38141a1f9c25a3fda236ed0885ee866e7c00db2','C','2016-07-20 20:30:12',NULL),(3,'Angely','Oyola','Guayaquil','angy_jazz','c38141a1f9c25a3fda236ed0885ee866e7c00db2','C','2016-07-21 22:10:02',NULL),(4,'Luis','Lucio','Guayaquil','luis_lucio','c38141a1f9c25a3fda236ed0885ee866e7c00db2','C','2016-07-12 14:00:32',NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'mensajeria'
--
/*!50003 DROP PROCEDURE IF EXISTS `buscar_contacto_porCiudad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_contacto_porCiudad`(in user_id int, in textoCiudad varchar(45))
BEGIN
	select concat(cont.nombre, " ",cont.apellido) as nombreCompleto, cont.ciudad from usuario cont
	where cont.id in (select conocidoDelUsuario
	from contactos c
	where c.userID=user_id) and cont.ciudad like concat("%",textoCiudad,"%");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_contacto_porUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_contacto_porUser`(in user_id int, in texto varchar(45))
BEGIN
	select concat(cont.nombre, " ",cont.apellido) as nombreCompleto, cont.user from usuario cont
	where cont.id in (select conocidoDelUsuario
	from contactos c
	where c.userID=user_id) and cont.user like concat("%",texto,"%");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `buscar_por_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `buscar_por_user`(in user_name char(45), in clave char(45))
BEGIN
	select id, nombre, apellido, foto from usuario
	where usuario.user=user_name and usuario.password=clave;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultar_chatsEnGrupo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_chatsEnGrupo`(in user_id int)
BEGIN
	select g.nombre from integrantes i, grupo g 
	where i.integranteID=user_id and i.grupoID=g.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultar_chatsPersonales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_chatsPersonales`(in user_id int)
BEGIN
	select concat(nombre," ",apellido) as nombreCompleto from usuario where id in (
	select destinatario_id as resultado1 
	from mensaje
	where tipo='P' and emisor_id=user_id
	group by destinatario_id
	union
	select emisor_id as resultado2 
	from mensaje 
	where tipo='P' and destinatario_id=user_id
	group by emisor_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultar_contactos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultar_contactos`(in user_name char(45), in user_id int)
BEGIN
	select cont.nombre, cont.apellido, cont.user from usuario cont
	where cont.id in (select conocidoDelUsuario
	from usuario u, contactos c
	where c.userID=user_id and u.user=user_name);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `historial_chatsEnGrupo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `historial_chatsEnGrupo`(in user_id int, in nombreGrupo varchar(60))
BEGIN
	select concat(u.nombre, " ",u.apellido) as nombreCompleto, m.texto, m.emisor_id
	from mensaje m, usuario u
	where m.tipo='G' and m.grupo_id in (select i.grupoID 
						from integrantes i, grupo g 
						where i.integranteID=user_id and g.nombre like nombreGrupo  and i.grupoID=g.id)
	and m.grupo_id = m.destinatario_id and m.emisor_id=u.id;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ingresarMensaje` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ingresarMensaje`(in emiID int, in destID int, in tipoGrupo varchar(1), in fechaMensaje datetime, in mensaje varchar(800), in gID int)
BEGIN
	INSERT INTO mensaje(emisor_id, destinatario_id, tipo,fecha,texto,grupo_id) VALUES 
		(emiID,destID,tipoGrupo,fechaMensaje,mensaje,gID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_gruposAdmin` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_gruposAdmin`(in usr_id int)
BEGIN
	SELECT * FROM grupo 
		WHERE creador_id = usr_id
        ORDER BY id;        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_historial_msj` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_historial_msj`(in usr_id int, in cont_id int)
BEGIN
select * from mensaje
	where (destinatario_id=usr_id or destinatario_id=cont_id) and (emisor_id=usr_id or emisor_id=cont_id) and tipo='P'
	order by fecha;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_info_contacto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_info_contacto`(in user_name char(45), in user_apellido char(45))
BEGIN
	select cnt.id, cnt.user, cnt.estado_conexion, cnt.fecha_ult_conexion, cnt.foto from usuario cnt
	where cnt.nombre=user_name and cnt.apellido=user_apellido;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_ultimosMsjs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_ultimosMsjs`(in usr_id int)
BEGIN
	SELECT * FROM mensaje 
		WHERE emisor_id = usr_id AND tipo='P'
        ORDER BY fecha DESC
        LIMIT 5;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_users_frecs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_users_frecs`(in usr_id int)
BEGIN
	SELECT *, count(destinatario_id) AS lalo FROM mensajeria.mensaje
    	where (emisor_id=usr_id) and tipo='P'
        group by destinatario_id
		order by lalo DESC
        LIMIT 5;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtener_usuario_porID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtener_usuario_porID`(in usr_id int)
BEGIN
	SELECT nombre, apellido, user FROM usuario
    WHERE id = usr_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrar_grupo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_grupo`(in nombre_grupo varchar(60), in descripcion_grupo varchar(200), in creadorID int, out grupo_ID int)
BEGIN
	INSERT INTO grupo(nombre, descripcion, creador_id) VALUES 
		(nombre_grupo, descripcion_grupo,creadorID);
	 
	select id 
	INTO grupo_ID
	from grupo g	
	where g.nombre=nombre_grupo and g.creador_id=creadorID and g.descripcion=descripcion_grupo;

	INSERT INTO integrantes(integranteID, grupoID) VALUES 
		(creadorID, grupo_ID) ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrar_integrante` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_integrante`(in nomb_apellido varchar(150), in creador_ID int, in grupo_ID int)
BEGIN
	DECLARE integrante_id int;
	
	set integrante_id = (select u.id
	from usuario u, contactos c
	where concat(u.nombre, " ",u.apellido) = nomb_apellido and c.userID=creador_ID and u.id=c.conocidoDelUsuario) ;

	INSERT INTO integrantes(integranteID, grupoID) VALUES 
		(integrante_id, grupo_ID) ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `registrar_usuario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `registrar_usuario`(
 in nombre char(60),
 in apellido char(60),
 in ciudad char(60),
 in user char(45), 
 in pass char(45), 
 in foto char(60))
BEGIN

    INSERT INTO usuario
         (
           nombre, apellido, ciudad, user, password, estado_conexion, fecha_ult_conexion, foto
         )
    VALUES 
         ( 
           nombre, apellido, ciudad, user, pass,'C', NULL , foto      
         ) ; 
END ;;
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

-- Dump completed on 2016-08-16  3:21:55