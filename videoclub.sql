CREATE DATABASE videoclub;
USE videoclub;

DROP TABLE IF EXISTS `alquiler`;

CREATE TABLE `alquiler` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pelicula` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_devolucion` date DEFAULT NULL,
  `estado` varchar(20) NOT NULL DEFAULT 'activo',
  `precio` decimal(5,2) DEFAULT 2.99,
  PRIMARY KEY (`id`),
  KEY `id_pelicula` (`id_pelicula`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_empleado` (`id_empleado`),
  CONSTRAINT `1` FOREIGN KEY (`id_pelicula`) REFERENCES `pelicula` (`id`),
  CONSTRAINT `2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`),
  CONSTRAINT `3` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;


LOCK TABLES `alquiler` WRITE;

INSERT INTO `alquiler` VALUES
(7,1,2,4,'2026-04-08','2026-04-24','devuelto',2.99),
(8,2,2,5,'2026-04-24','2026-05-02','activo',2.99);
/*!40000 ALTER TABLE `alquiler` ENABLE KEYS */;
UNLOCK TABLES;



DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES
(1,'Carlos','Garcia Lopez','carlos@email.com','612345678',1),
(2,'Maria','Martinez Ruiz','maria@email.com','698765432',1),
(5,'Francisco','Perez Cortés','Fcortes@email.com','654789098',1);
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empleado`
--

DROP TABLE IF EXISTS `empleado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `empleado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` varchar(20) NOT NULL DEFAULT 'empleado',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empleado`
--

LOCK TABLES `empleado` WRITE;
/*!40000 ALTER TABLE `empleado` DISABLE KEYS */;
INSERT INTO `empleado` VALUES
(4,'Héctor','González Sánchez','hector@videoclub.com','1234','admin'),
(5,'Admin',' ','admin@videoclub.com','1234','admin'),
(6,'Adrian','Blasco Gutierrez','Adri@videoclub.com','1234','empleado');
/*!40000 ALTER TABLE `empleado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pelicula`
--

DROP TABLE IF EXISTS `pelicula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `pelicula` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `genero` varchar(50) DEFAULT NULL,
  `anyo` int(11) DEFAULT NULL,
  `director` varchar(100) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `disponible` tinyint(1) DEFAULT 1,
  `stock` int(11) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pelicula`
--

LOCK TABLES `pelicula` WRITE;
/*!40000 ALTER TABLE `pelicula` DISABLE KEYS */;
INSERT INTO `pelicula` VALUES
(1,'El Padrino','Drama',1972,'Francis Ford Coppola','41WMFqes1iL._AC_.jpg',1,4),
(2,'Pulp Fiction','Thriller',1994,'Quentin Tarantino','81IOViIosKL._AC_SL1500_.jpg',1,4),
(3,'El Señor de los Anillos','Fantasia',2001,'Peter Jackson','6143TqGItiL._AC_SL1000_.jpg',1,6),
(4,'Matrix','Ciencia Ficción',1999,'Hermanos Wachowski','043449_af.jpg',1,3),
(7,'Interstellar','Ciencia Ficción',2014,'Christopher Nolan','91obuWzA3XL._AC_SL1500_.jpg',1,5);
/*!40000 ALTER TABLE `pelicula` ENABLE KEYS */;
UNLOCK TABLES;

SHOW TABLES;
SELECT * FROM pelicula;
SELECT * FROM cliente;
SELECT * FROM empleado;

