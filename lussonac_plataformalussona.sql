-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 06-01-2023 a las 20:02:52
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 8.0.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lussonac_plataformalussona`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `lussona` ()   BEGIN
    select id,reserved_by,schedule_remarks,datetime_start,datetime_end,periodo,costo from schedule_list;
        
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ValidateReservesForYear` (IN `userid` INT, IN `datefrom` VARCHAR(20))   BEGIN
    DECLARE startdate VARCHAR(10); 
    DECLARE enddate VARCHAR(10);
    DECLARE startday VARCHAR(20);
    DECLARE countdays VARCHAR(20);
    DECLARE message VARCHAR(20);
    SET
        startdate = (SELECT CONCAT(CONVERT(YEAR(datefrom), varchar(4)), '/01/01'));
    SET
        enddate = (SELECT CONCAT(CONVERT(YEAR(datefrom), varchar(4)), '/12/31'));
    SET
        startday = DAYNAME(datefrom);
    SET
    	message = 'NotValid';
        IF (startday = 'Thursday' || startday = 'Sunday') THEN
        	SET countdays = (SELECT
    			COUNT(id)
			FROM
    			schedule_list sl
			WHERE
    			sl.reserved_by = userid 
    			AND sl.datetime_start >= startdate 
    			AND sl.datetime_end <= enddate
    			AND DAYNAME(sl.datetime_start) = startday);
               
         		IF (countdays <= 3) THEN
                	SET message = 'Valido';
                ELSE
                	SET message = 'LimitReserves';
            	end if;
         ELSE
         	SET message = 'DayNotAllow';
         end if;
      SELECT message;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `id` int(11) NOT NULL,
  `room_name` varchar(250) NOT NULL,
  `location` text NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `usuario_id` int(10) DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`id`, `room_name`, `location`, `description`, `status`, `usuario_id`, `date_created`, `date_updated`) VALUES
(6, '100', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 1, '2022-02-13 12:09:02', '2022-03-04 11:51:44'),
(18, '100', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 29, '2022-02-13 12:09:02', '2022-03-04 11:51:21'),
(19, '100', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 30, '2022-02-13 12:09:02', '2022-03-04 11:51:24'),
(20, '102', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 31, '2022-04-07 16:07:59', NULL),
(21, '102', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 32, '2022-04-07 16:08:33', NULL),
(22, '102', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 33, '2022-04-07 16:08:59', NULL),
(23, '102', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 34, '2022-04-07 16:09:12', NULL),
(24, '102', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 35, '2022-04-07 16:09:22', NULL),
(25, '102', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 36, '2022-04-07 16:09:35', NULL),
(26, '102', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 37, '2022-04-07 16:09:46', NULL),
(27, '102', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 38, '2022-04-07 16:10:07', NULL),
(28, '102', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 39, '2022-04-07 16:10:24', NULL),
(29, '102', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 40, '2022-04-07 16:10:36', NULL),
(30, '103', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 41, '2022-04-07 16:10:49', NULL),
(31, '103', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 42, '2022-04-07 16:11:04', NULL),
(32, '103', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 43, '2022-04-07 16:11:19', NULL),
(33, '103', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 44, '2022-04-07 16:11:33', NULL),
(34, '104', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 45, '2022-04-07 16:11:46', NULL),
(35, '104', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 46, '2022-04-07 16:12:05', NULL),
(36, '104', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 47, '2022-04-07 16:12:27', NULL),
(37, '106', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 48, '2022-04-07 16:12:45', '2022-04-07 16:13:34'),
(38, '106', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 49, '2022-04-07 16:13:08', NULL),
(39, '201', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 50, '2022-04-07 16:14:11', NULL),
(40, '201', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 51, '2022-04-07 16:14:27', NULL),
(41, '201', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 53, '2022-04-07 16:14:44', NULL),
(42, '201', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 54, '2022-04-07 16:15:03', NULL),
(43, '201', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 55, '2022-04-07 16:15:17', NULL),
(44, '201', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 56, '2022-04-07 16:15:39', NULL),
(45, '201', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 57, '2022-04-07 16:15:53', NULL),
(46, '201', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 58, '2022-04-07 16:16:04', NULL),
(47, '201', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 59, '2022-04-07 16:16:20', NULL),
(48, '202', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 62, '2022-04-07 16:17:41', NULL),
(49, '202', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 63, '2022-04-07 16:17:59', NULL),
(50, '202', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 64, '2022-04-07 16:19:44', NULL),
(51, '202', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 65, '2022-04-07 16:20:23', NULL),
(52, '202', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 66, '2022-04-07 16:20:55', NULL),
(53, '202', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 67, '2022-04-07 16:21:22', NULL),
(54, '202', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 68, '2022-04-07 16:22:04', NULL),
(55, '203', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 70, '2022-04-07 16:22:38', NULL),
(56, '203', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 71, '2022-04-07 16:23:00', NULL),
(57, '203', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 72, '2022-04-07 16:23:13', NULL),
(58, '203', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 73, '2022-04-07 16:23:33', NULL),
(59, '203', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 74, '2022-04-07 16:23:56', NULL),
(60, '203', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 75, '2022-04-07 16:24:08', NULL),
(61, '203', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 76, '2022-04-07 16:24:30', NULL),
(62, '203', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 77, '2022-04-07 16:25:09', NULL),
(63, '206', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 79, '2022-04-07 16:25:28', NULL),
(64, '207', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 80, '2022-04-07 16:25:43', NULL),
(65, '207', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 81, '2022-04-07 16:26:09', NULL),
(66, '104', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 83, '2022-04-07 16:29:27', NULL),
(67, '104', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 84, '2022-04-07 16:29:43', NULL),
(68, '106', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 85, '2022-04-07 16:30:08', NULL),
(69, '206', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 86, '2022-04-07 16:31:30', NULL),
(70, '206', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 87, '2022-04-07 16:31:43', NULL),
(71, '207', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 88, '2022-04-07 16:31:57', NULL),
(72, 'Ruben', '3 de mayo', 'Departamento de lujo', 0, 95, '2022-05-03 13:39:54', '2022-05-03 13:47:04'),
(73, '106', 'tequesquitengo,Morelos', 'Departamento de lujo Lussona', 1, 105, '2022-05-04 09:33:51', NULL),
(74, '103', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 107, '2022-05-18 13:53:59', NULL),
(75, '103', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 108, '2022-05-18 13:59:41', NULL),
(76, '103', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 109, '2022-05-18 14:03:33', NULL),
(77, '207', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 111, '2022-05-18 14:08:43', NULL),
(78, '207', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 113, '2022-05-18 14:12:06', NULL),
(79, '203', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 114, '2022-05-18 14:18:35', NULL),
(80, '207', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 115, '2022-05-18 14:23:05', NULL),
(81, '103', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 116, '2022-05-18 14:33:34', NULL),
(82, '101', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 123, '2022-07-07 15:06:01', NULL),
(83, '103', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 117, '2022-07-07 15:07:09', NULL),
(84, '103', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 118, '2022-07-07 15:08:18', NULL),
(85, '206', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 119, '2022-07-07 15:09:06', NULL),
(86, '206', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 120, '2022-07-07 15:10:01', NULL),
(87, '206', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 121, '2022-07-07 15:10:50', NULL),
(88, '206', 'Tequesquitengo, Morelo', 'Departamento de lujo Lussona', 1, 122, '2022-07-07 15:11:34', NULL),
(89, '104', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 82, '2022-07-08 10:34:02', NULL),
(90, '202', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 90, '2022-07-08 10:40:48', NULL),
(91, '202', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 91, '2022-07-08 10:46:30', NULL),
(92, '202', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 89, '2022-07-08 10:52:06', NULL),
(93, '203', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 92, '2022-07-08 10:58:08', NULL),
(94, '206', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 93, '2022-07-08 11:03:35', NULL),
(95, '201', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 124, '2022-07-08 12:19:05', NULL),
(96, '104', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 125, '2022-07-29 13:49:24', NULL),
(97, '101', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 126, '2022-08-12 16:47:55', NULL),
(98, '207', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 127, '2022-08-29 09:31:18', NULL),
(99, '206', 'Tequesquitengo, Morelos', 'Departamento de lujo Lussona', 1, 128, '2022-09-26 11:16:13', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permiso`
--

CREATE TABLE `permiso` (
  `idpermiso` int(11) NOT NULL,
  `nombre` varchar(30) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `permiso`
--

INSERT INTO `permiso` (`idpermiso`, `nombre`) VALUES
(1, 'listar-usuarios'),
(2, 'crear-reservas'),
(3, 'listar-reservas'),
(5, 'listar-departamentos'),
(6, 'reservas-usuarios'),
(7, 'listar-servicios'),
(8, 'crear-servicio'),
(9, 'editar-reserva');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `schedule_list`
--

CREATE TABLE `schedule_list` (
  `id` int(11) NOT NULL,
  `reserved_by` int(11) NOT NULL,
  `schedule_remarks` varchar(255) NOT NULL,
  `datetime_start` datetime DEFAULT NULL,
  `datetime_end` datetime DEFAULT NULL,
  `periodo` varchar(20) NOT NULL,
  `costo` decimal(8,2) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `schedule_list`
--

INSERT INTO `schedule_list` (`id`, `reserved_by`, `schedule_remarks`, `datetime_start`, `datetime_end`, `periodo`, `costo`, `status`, `date_created`, `date_updated`) VALUES
(299, 1, '', '2023-01-05 15:00:00', '2023-01-08 12:00:00', 'Semana', NULL, 1, '2022-12-20 20:52:44', NULL),
(300, 1, '', '2023-01-08 15:00:00', '2023-01-12 12:00:00', 'Semana', NULL, 1, '2022-12-20 20:58:11', NULL),
(301, 1, '', '2023-01-15 15:00:00', '2023-01-19 12:00:00', 'Semana', NULL, 1, '2022-12-20 20:59:05', NULL),
(302, 1, '', '2023-01-12 15:00:00', '2023-01-15 12:00:00', 'Semana', NULL, 1, '2022-12-20 21:10:40', NULL),
(303, 1, '', '2022-12-22 15:00:00', '2022-12-25 12:00:00', 'Semana', NULL, 1, '2022-12-20 21:12:09', NULL),
(304, 1, 'con servicio', '2022-12-25 15:00:00', '2022-12-29 12:00:00', 'Semana', NULL, 1, '2022-12-21 08:52:38', NULL),
(305, 1, '', '2023-01-19 15:00:00', '2023-01-22 12:00:00', 'Semana', NULL, 1, '2023-01-04 11:33:34', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `costehora` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id`, `nombre`, `descripcion`, `costehora`, `created_at`, `updated_at`, `status`) VALUES
(1, 'Moto Matutino', 'Servicio especial de motos', 4, '2022-02-18 21:50:27', '2022-03-01 22:20:10', 1),
(2, 'Lancha Matutino', 'Servicio especial de lancha', 4, '2022-02-18 21:53:56', '2022-03-01 22:20:16', 1),
(10, 'Moto Vespertino ', 'Servicio especial de motos', 4, '2022-02-18 21:50:27', '2022-03-01 20:22:00', 1),
(11, 'Lancha Vespertino ', 'Servicio especial de lancha', 4, '2022-02-18 21:53:56', '2022-03-01 20:21:47', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio_reserva`
--

CREATE TABLE `servicio_reserva` (
  `id` int(11) NOT NULL,
  `reserva_id` int(11) NOT NULL,
  `servicio_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `servicio_reserva`
--

INSERT INTO `servicio_reserva` (`id`, `reserva_id`, `servicio_id`) VALUES
(325, 304, 2),
(326, 304, 11),
(327, 305, 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `system_info`
--

CREATE TABLE `system_info` (
  `id` int(11) NOT NULL,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `system_info`
--

INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
(1, 'name', 'Sistema de Reserva de Salas en PHP y MySQL'),
(6, 'short_name', 'SRS'),
(11, 'logo', 'uploads/1632105900_sistema reservas php y mysql.png'),
(13, 'user_avatar', 'uploads/user_avatar.jpg'),
(14, 'cover', 'uploads/1628211420_1.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_documento` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `num_documento` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(70) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `cargo` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `clave` varchar(64) COLLATE utf8_spanish_ci NOT NULL,
  `imagen` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `login` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `cargo`, `clave`, `imagen`, `login`, `condicion`) VALUES
(1, 'Administrador Lussona', 'Fraccion', '1', 'Tequesquitengo', '7223944626', 'admin@lussona.com.mx', 'admin', 'ddc439681396fd3f6d13f61ce41a28c4dd0fabd03760a116abf7bfe4e91bc341', '1646166971.jpeg', 'admin', 1),
(29, 'Hector Olivos Osorno', 'Fraccion', '2', 'Tequesquitengo', '7223944626', 'hectorovs12@gmail.com', 'admin', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '1646412447.png', 'olivos_lussona', 1),
(30, 'Iliana García', 'Fraccion', '1', 'Tequesquitengo', '1234567891', 'iliana@prueba.com', 'usuario', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '1646171930.jpeg', 'iliana_lussona', 1),
(31, 'Karla Cristina Esquerra Olivas', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'prueba1@prueba.com', 'usuario', '453cfa539cd9f510ef10879f492309a6417dabfd10eab2c02e433ba78926f6ac', '', 'karlaesq_lussona', 1),
(32, 'Claudia Herrera Arriaga', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'psicclaudiaherrera@gmail.com', 'usuario', 'c352769286db5d406f1870031397bc5d1f3aa2d98ddde76b33e385b56ae7af4f', '', 'claudiaher_lussona', 1),
(33, 'Victor Manuel Mejía Escamilla', 'Fraccion', '3', 'Tequesquitengo, Morelos', '', 'ing.victormejia@gmail.com', 'usuario', 'a11630eca82d443ad3a24f3215b4ba31c8717ef16586766f41daaf11f944d92a', '', 'victorme_lussona', 1),
(34, 'Marisol Fernandez', 'Fraccion', '4', 'Tequesquitengo, Morelos', '', 'macfisz@hotmail.com', 'usuario', '93dbbdc8a6049f1ece80ab19ebf5d51a561a43ec00982d75b5d41757707b18d3', '', 'marisolfer_lussona', 1),
(35, 'Hilaria Cardenas Pereda', 'Fraccion', '5', 'Tequesquitengo, Morelos', '', 'hilari34@hotmail.com', 'usuario', 'd1a36e597a6cdc2b2df068b520dce807f64bc815476ed5e05a25f8275e68919b', '', 'hilaricar_lussona', 1),
(36, 'Ana Catalina Pamanes Mendoza', 'Fraccion', '6', 'Tequesquitengo, Morelos', '', 'acpamanes@gmail.com', 'usuario', '43513387487ec9a3feae664374a1486729d33658632a458c2f2a6b36827e5f2d', '', 'anapa_lussona', 1),
(37, 'Antonio Vargas Guevara', 'Fraccion', '7', 'Tequesquitengo, Morelos', '', 'avargas@grupodtp.com.mx', 'usuario', '76a8eb64c8d89a6a65d8fbfbfebdaf2e871e889c38ea7b51a39531be03b16170', '', 'antoniovar_lussona', 1),
(38, 'Erika Granados Aguilar', 'Fraccion', '8', 'Tequesquitengo, Morelos', '', 'granados_aguilar@yahoo.com.mx', 'usuario', '051c8757ad17f5e8c05b1a7078e65c82c007b0541d1f2707f69e632f2b6ded52', '', 'erikagra_lussona', 1),
(39, 'Andrea Patricia Stamatio Rivera', 'Fraccion', '9', 'Tequesquitengo, Morelos', '', 'astamatio@gmail.com', 'usuario', 'f5230b6003e7fbb47ea7cf6497f4d4dbbe1a867efd35e00e08522a52f939cb0b', '', 'andreasta_lussona', 1),
(40, 'Jose Manuel Hernandez Olavarria', 'Fraccion', '10', 'Tequesquitengo, Morelos', '', 'jose_man_2009@hotmail.com', 'usuario', 'a1c4685fc8b853d7aafc82b8d532ecada80d9957921c8580bcb0e94f30a92a81', '', 'joseher_lussona', 1),
(41, 'Christian Alejandro Hernández Morales', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'recepcion@hmabogados.mx', 'usuario', '330fbd4d102127f87f6023a40df4c621267afd0952c89bc8df118fbec7d8ccd2', '', 'alejandro_lussona', 1),
(42, 'Miriam Resendiz Diaz', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'prueba2@prueba.com', 'usuario', '4fe17040d7ca6bec1f15e42fdfba80bcad2d6a78a73d907bb7009569c40da677', '', 'miriam_lussona', 1),
(43, 'Alma Delia Carrillo Zazueta', 'Fraccion', '3', 'Tequesquitengo, Morelos', '', 'prueba3@gmail.com', 'usuario', '354e3aee6a34930a23c81bafe1faa250eb199037584ea1e0d296f5d213a1d76c', '', 'almacar_lussona', 1),
(44, 'Jose Luis Camacho Aparicio', 'Fraccion', '4', 'Tequesquitengo, Morelos', '', 'jlc@adspace.com.mx', 'usuario', 'a7b0f018fb62c0ab673ac0924d4cf1a13f02230db1d85eeaf1124e0bbd1a34fd', '', 'josecam_lussona', 1),
(45, 'Hugo Flores Rodriguez', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'hugofloro@hotmail.com', 'usuario', '1e2b6d0b3a75dcd1a5320a9f9fed4659a462d2346c0469ce8bc97a75e77cd6b2', '', 'hugoflo_lussona', 1),
(46, 'Diana Orozco Rosas', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'pruebalussona@prueba.com', 'usuario', 'c9a5a8aa5ce3c2cd02929312829444fd49a2d6d6342c478c92735a28e0398d28', '', 'dianaoro_lussona', 1),
(47, 'Maria de Lourdes Andrade Maldonado', 'Fraccion', '3', 'Tequesquitengo, Morelos', '', 'pruebalussona2@prueba.com', 'usuario', '61ff6fa323bdde89482fa0f9f79a2b8c0a2616429ffe3e172aeb9c10bee4c0c2', '', 'maria_lussona', 1),
(48, 'Erick Noel Pozas Hernandez', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'erelcalidad@hotmail.com', 'usuario', '8c7265c88957c56cad7bcdae65c8811e7339a09f62df539a20d0ef90d1115595', '', 'erickpoz_lussona', 1),
(49, 'Edgar Javier Reyes Andrade', 'Fraccion', '2-7', 'Tequesquitengo, Morelos', '', 'edgarjavier@gmail.com', 'usuario', '9f427409a953a0fa21d8f5fc3b89d4b111a09eb4a33dd8c4ff01f053459d72d9', '', 'edgarrey_lussona', 1),
(50, 'Felipe Rivas Jiménez', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'contacto@quimicaunida.com', 'usuario', '1dacf36e349366cda47806e09372bce1f241c34dd97e849dadd7921be0eae637', '', 'feliperiv_lussona', 1),
(51, 'Victor Hugo Velasco Tagle', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'victortagle33@hotmail.com', 'usuario', 'b4d70131855ce5dda685498cc9c1baf53030d11a15d59cad050232669d41161f', '', 'victorvel_lussona', 1),
(53, 'Sergio Ruben Ancira Avila', 'Fraccion', '4', 'Tequesquitengo, Morelos', '', 'ingancira@hotmail.com', 'usuario', 'f6a71c23b864af4ac462ae1b6d0ad618c6f26777f034d9780486de6f1383a179', '', 'sergiorub_lussona', 1),
(54, 'Daniela Buentello Sotelo', 'Fraccion', '5', 'Tequesquitengo, Morelos', '', 'dbs.serviciosintegrales@gmail.com', 'usuario', 'be1e863ed154376830767cb99bfd0bf0e530f4b045d52723790a547379b67b62', '', 'danielabue_lussona', 1),
(55, 'Mariana Romero Rohous', 'Fraccion', '6', 'Tequesquitengo, Morelos', '', 'mrohous@hotmail.com', 'usuario', '2e453225cf31698a69605a369687c6483d5b067133f62caca0b2715531e0320e', '', 'marianarom_lussona', 1),
(56, 'Miguel Angel Zetune García', 'Fraccion', '7', 'Tequesquitengo, Morelos', '', 'agenciazhr1@hotmail.com', 'usuario', 'ace7461fe2e606d27b8782d687f4f5dbec1c5d5e36a344323471537dfa6cd6cd', '', 'miguelzet_lussona', 1),
(57, 'Sandra García Soto', 'Fraccion', '8', 'Tequesquitengo, Morelos', '', 'pruebalussona3@prueba.com', 'usuario', '40f9154ecd28f72af6abcb963b6f05f132ab575aac1519ee2aca27455775074a', '', 'sandragar_lussona', 1),
(58, 'Israel Cantú González', 'Fraccion', '9', 'Tequesquitengo, Morelos', '', 'iscantug@gmail.com', 'usuario', 'dac01ea8de974ff4eabdbcdf80f49ab72bfc427c440ffff194aa0846547923d2', '', 'israelcan_lussona', 1),
(59, 'Francisco Javier Copia Perez', 'Fraccion', '10', 'Tequesquitengo, Morelos', '', 'frankkar@hotmail.com', 'usuario', '1b149407294ff0537d72e68af71919ef753fec1fc9dae4b542a8bb34bb566280', '', 'franciscocop_lussona', 1),
(60, 'Maria de Lourdes Andrade Maldonado', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'pruebalussona4@prueba.com', 'usuario', '0b82ec8c2d4e3a0e0ba97c48bf9b09bd36b64e5a0b311a9648a2f7dd1fd85f47', '', 'mlandrade_lussona', 0),
(62, 'Fidel Antonio Chimal Mejia', 'Fraccion', '3', 'Tequesquitengo, Morelos', '', 'achimalm.met@ipefh.edu.mx', 'usuario', '7f08b51e666a21a24fa88e1fcfd536d07c7c057705b17273349b39fb19d0d9d4', '', 'fidelchi_lussona', 1),
(63, 'Álvaro Cervantes Díaz', 'Fraccion', '4', 'Tequesquitengo, Morelos', '', 'alvaroswork@hotmail.com', 'usuario', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '', 'alvaro202_lussona', 1),
(64, 'Emmanuel Moctezuma Peña', 'Fraccion', '6', 'Tequesquitengo, Morelos', '', 'emmanuelmp.86@gmail.com', 'usuario', '318a36aea1a04f73520fbe3cb80d63479c3818e0e65695cc663091add40ee014', '', 'emmanuelmoc_lussona', 1),
(65, 'Jorge Arturo Zetune García', 'Fraccion', '7', 'Tequesquitengo, Morelos', '', 'gameklinik@hotmail.com', 'usuario', 'd1d4fada3a6cdb4f62eef71679d96b1617e64d2d974f968f4af2d29ed01aa9d6', '', 'jorgezet_lussona', 1),
(66, 'Genesis Alejandra Elizalde', 'Fraccion', '8', 'Tequesquitengo, Morelos', '', 'pruebalussona5@prueba.com', 'usuario', 'f04f2cf16b3528314a9ce962439f9483b23f15c5e4eca348fc09a8f31a6f1b6e', '', 'genesiseli_lussona', 1),
(67, 'Pamela García Riveroll Bobadilla', 'Fraccion', '9', 'Tequesquitengo, Morelos', '', 'pamela.griveroll@yahoo.com', 'usuario', 'caeef7aca4eb8f08247f944c3f018f23c7e994ba3fb82d8b307e12a93b9632ee', '', 'pamelariv_lussona', 1),
(68, 'Marco Antonio Gonzalez Muñoz', 'Fraccion', '10', 'Tequesquitengo, Morelos', '', 'marco_cinetics@hotmail.com', 'usuario', '0f4347c1a7641c173cb270ddd21d8b0dbd67ed26c7d38ab085eec39e6d9c1dd8', '', 'marcogon_lussona', 1),
(69, 'Álvaro Cervantes Díaz', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'alvaroswork@hotmail.com.mx', 'usuario', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '', 'acervantes_lussona', 1),
(70, 'Manuel Valentín Bravo Rodríguez', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'bravovalentin19@hotmail.com', 'usuario', '6463818be47f1b51cac7d98d6420a988697e9075753f663440b4141d3dbb2fea', '', 'manuelbra_lussona', 1),
(71, 'Mario Alberto Monroy Cruz', 'Fraccion', '3', 'Tequesquitengo, Morelos', '', 'monroymam@hotmail.com', 'usuario', 'f3cba7b9ef704acc76cac428e8e6fa5999ec765d10a901a791a3ee0cd1af5c2b', '', 'mariomon_lussona', 1),
(72, 'Luis Dionisio Cardenas Zagal', 'Fraccion', '4', 'Tequesquitengo, Morelos', '', 'luiscardenascentral@gmail.com', 'usuario', '96b74f6402c2044f9554e672af454966e3d0bf2cf796e398fa2f8f349165e8cf', '', 'luiscar_lussona', 1),
(73, 'Jesus Eulogio Vega Mancilla', 'Fraccion', '5', 'Tequesquitengo, Morelos', '', 'vegaj1963@hotmail.com', 'usuario', '9274544882c3a6098027cf4ca34b0e168690506365ad2cbc4e50867cd11cbdb5', '', 'jesusveg_lussona', 1),
(74, 'Diana Marroquin Flores', 'Fraccion', '6', 'Tequesquitengo, Morelos', '', 'dianamarroquin@spelt.com.mx', 'usuario', '48e4e0f4970cef014351a58f495aeedf2b61c992e624a3fde0570ff36dd1c2f9', '', 'dianamar_lussona', 1),
(75, 'Antonio Amajud Hernandez Montoya', 'Fraccion', '7', 'Tequesquitengo, Morelos', '', 'amajud@hotmail.com', 'usuario', '67ddc246c5703a364d96ab6252365d2a548f192866357c81457401c81d096814', '', 'antonioher_lussona', 1),
(76, 'Monserrat Avilés Hernández', 'Fraccion', '8', 'Tequesquitengo, Morelos', '', 'mavilesh@hotmail.com', 'usuario', 'e8ecb3347c3ccd8c223593239003864a080b433ca8d2961144f9f68686bd71dd', '', 'monserratavi_lussona', 1),
(77, 'Juan José Sordo Peña', 'Fraccion', '9', 'Tequesquitengo, Morelos', '', 'soyjuansordo@gmail.com', 'usuario', 'b90e50efd70988a963d3abfe2917dfd8e67a82f7807147438d5da51176f6343f', '', 'josesor_lussona', 1),
(79, 'Cesar Eduardo Amezcua Archundía', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'cesar@elixircreativo.com', 'usuario', 'f21551d0b42dadb2488956aa08e65a540cb490d74648efc9523da6451cf4445f', '', 'cesarame_lussona', 1),
(80, 'Adriana Alcantara Ibarra', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'pruebalussona7@prueba.com', 'usuario', '50da82c7ddbbf3e40e2dedcd4739153f094ea7fb53b4d043ed92dfb0e2ac5edb', '', 'adrianaalc_lussona', 1),
(81, 'Carlos Terrazas Salas', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'carlos.terrazas@cydsa.com', 'usuario', 'f624063a7fd034dabb3cefb6ae13b94e5413b7a76fc495f65650fec98dde23ee', '', 'carloster_lussona', 1),
(82, 'César Sánchez Torres', 'Fraccion', '4', 'Tequesquitengo, Morelos', '', 'cdtorressa@gmail.com', 'usuario', 'ac3e72f8f4dc91a27f6d0736c7b1ce7ff64b4c9ec6f9ad8e856ba6331ca5052f', '', 'cesarst_lussona', 1),
(83, 'Rosa Angela Florido Guadarrama', 'Fraccion', '5', 'Tequesquitengo, Morelos', '', 'rosaflorido68@hotmail.com', 'usuario', 'd4b5a1e09021b8f2d8b47c977be4e476613d4a1e84d9f7816427f6c0fe3732db', '', 'rosaafg_lussona', 1),
(84, 'David Alejandro Gutiérrez Aguilar', 'Fraccion', '6', 'Tequesquitengo, Morelos', '', 'dav.ag@hotmail.com', 'usuario', '4958d3bf131c25955e468dc8239673303dc88b803b0ab6bf24e7dfb79ae03de5', '', 'davidaga_lussona', 1),
(85, 'Julio Alberto Pecero Mariscurrena', 'Fraccion', '3', 'Tequesquitengo, Morelos', '', 'julio.pecero@gmail.com', 'usuario', '19e4a228aaa83361e34bdd50c4dcaa9784735ecac5d1b68e43d111418972b6a8', '', 'julioapm_lussona', 1),
(86, 'Jesús Alejandro Villaseñor Yeo', 'Fraccion', '3', 'Tequesquitengo, Morelos', '', 'alex@price-is.com', '', '286ac29c6bc755618502c8c96a4f2f5909ff148553950b215f5e3fa0555afaa9', '', 'jesusavy_lussona', 1),
(87, 'Rene Pérez', 'Fraccion', '4', 'Tequesquitengo, Morelos', '', 'arq_reneperez@live.com.mx', 'usuario', '2de20c2d01d87962a924cada5bcc1b5d8136c900553e06939109219b75d92514', '', 'renep_lussona', 1),
(88, 'Silvana Carolina Barrionuevo', 'Fraccion', '4', 'Tequesquitengo, Morelos', '', '9878theboss@gmail.com', 'usuario', '83ae1b3e506e67cec5bc8d14e468d94ed7c96686da8f701c60278ad300ff495b', '', 'silvanacb_lussona', 1),
(89, 'Edgar Javier Reyes Andrade', 'Fraccion', '5', 'Tequesquitengo, Morelos', '', 'Edgarjavier@lussona.com', 'usuario', '646329b0db94693e4098be58bcd509d52968f02ddf9db81be091694c3da58eb4', '', 'edgar202_lussona', 1),
(90, 'Maria de Lourdes Andrade Maldonado', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'MariadeLourdes@lussona.com', 'usuario', '0b82ec8c2d4e3a0e0ba97c48bf9b09bd36b64e5a0b311a9648a2f7dd1fd85f47', '', 'maria202_lussona', 1),
(91, 'Felipe Rivas Jiménez', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'feliperivas@lussona.com', 'usuario', '1b1a7240a44c67cc1f0c3455db86c19cdacfb8ffe86b2f5a6723d6163365923e', '', 'felipe202_lussona', 1),
(92, 'Alvaro Cervantes  Díaz', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'alvaroswork@lussona.com', 'usuario', 'e089f329b4f2fd577ff39d8badebdcb9fec486ffc46694cf989f7ca170109015', '', 'alvaro203_lussona', 1),
(93, 'Hugo Flores  Rodriguez', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'hugofloro@lussona.com', 'usuario', 'd0abfde67d6b56b23a685bb7d792a965ea5f820a710338342e1c95816692e99f', '', 'hugo206_lussona', 1),
(94, 'Carlos Temahuaya Sanchez', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'arsenal.cts@gmail.com', 'admin', 'ddc439681396fd3f6d13f61ce41a28c4dd0fabd03760a116abf7bfe4e91bc341', '', 'sanchez', 1),
(95, 'Ruben', 'Fraccion', '1', '3 de mayo', '', '', 'Recidente', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '', 'ruben', 1),
(105, 'Carlos Temahuaya', 'Fraccion', '2', 'san francisco', '', 'arsenal_cts@hotmail.com', 'admin', 'ddc439681396fd3f6d13f61ce41a28c4dd0fabd03760a116abf7bfe4e91bc341', '', 'admin2', 1),
(106, 'Valentin Salazar', 'Fraccion', '8', 'Almoloya de juarez', '', 'blue_cts@hotmail.com', 'usuario', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '', 'valentin', 1),
(107, 'Julio César Hernández Ramirez', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'lioju_bart@hotmail.com', 'usuario', '93a4a5ac90885e78dac3f93256c073ffb16ddada9cfc05558d291350c92974fa', '', 'juliocésarhr_lussona', 1),
(108, 'Josefina Castro Rodríguez', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'ragde_70@yahoo.com.mx', 'usuario', 'c5e2ba2a518ef4b3d663b073bdccc8441be201bdc6a600e54c990edb687ee69c', '', 'josefina_lussona', 1),
(109, 'Abraham Adrec', 'Fraccion', '3', 'Tequesquitengo, Morelos', '', 'adrec@cbb-11.com', 'usuario', '68eca0956288c7e438458afeea755a3e254e44968820ea48761d03b0a62c306c', '', 'abrahamad_lussona', 1),
(111, 'Martha Edith Lopez García', 'Fraccion', '7', 'Tequesquitengo, Morelos', '', 'elopez@franser.mx', 'usuario', '0c93ca2cd444ce5fc41ab414bbc70a41f2a72fa570ac1027e27a47bffe225f35', '', 'marthaed_lussona', 1),
(113, 'Carlos David Ramirez', 'Fraccion', '7', 'Tequesquitengo, Morelos', '', 'direccionlonasymas@gmail.com', 'usuario', '100de0a5a25b4daaee6ac079321dfcbac24deb89f53dfda925ef9308ad1e3b38', '', 'carldavidr_lussona', 1),
(114, 'Andrea Bahena  Arce', 'Fraccion', '3', 'Tequesquitengo, Morelos', '', 'sin_correo@gmail.com', 'usuario', '98a5e8d669cc56ad1da17f319e8e23309be8b8d0662e1f41e133dde5cf0653d2', '', 'andreaba_lussona', 1),
(115, 'Leticia García Rosales', 'Fraccion', '7', 'Tequesquitengo, Morelos', '', 'sn_email.@hotmail.com', 'usuario', 'a0fcde0d47b163a640baa94ef046643852ad4fff29eda74c06b5e8e36d81eaa9', '', 'leticiaga_lussona', 1),
(116, 'Diana Maricela Martínez Coronel', 'Fraccion', '3', 'Tequesquitengo, Morelos', '', 'secutec.mx@gmail.com', 'usuario', 'c2a0d76b950580ca50841811e8f8b26c367608b83ca98902334df32f213ecdd6', '', 'maricelama_lussona', 1),
(117, 'Reyes Hinojosa Escobedo', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'REYES@hotmail.com', 'usuario', '5e3eb57f621ccbd255eb23529adf111af7989404382b7ae900aff65338f95b84', '', 'Reyes_lussona', 1),
(118, 'Erzain Lizaola Gonzalez', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'ERZAIN@hotmail.com', 'usuario', '65685d9cd7cba92dea07aba45732af2e8158524efab99f121720eaa30339d204', '', 'erzain_lussona', 1),
(119, 'Ricardo André Urrutia Vallarta', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'ricardo@gmail.com', 'usuario', '76182cfe4268d1a5f3ab568edd58d6e76a583bedb746a5a316e0470cf342760d', '', 'Andre_Lussona', 1),
(120, 'Ricardo Casarin Barrientos', 'Fraccion', '2-6', 'Tequesquitengo, Morelos', '', 'Casarin@gmail.com', 'usuario', '99c789cd22fa8f03d1d45d8447a4e9f77efe18ab8ef185bb76f2d04ca813790f', '', 'casarin_lussona', 1),
(121, 'Alba Berenize  Flores', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'Alba@gmail.com', 'usuario', '5c2586c4a66d2c8390510b248dc77d69867ddde0cc7958f0c45b3fa57b174b0e', '', 'Alba_lussona', 1),
(122, 'Norma Garcia Alvarado', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'Norma@gmail.com', 'usuario', '270d0ddd9e8a14bfa48725f1cc340b6c70b1ba43265bc27e37077e84310ddf8d', '', 'norma_lussona', 1),
(123, 'Mario Eduardo Alvarez Hernandez', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'Mario@gmail.com', 'usuario', '35f16a6d372206db23b5910952e0aa73ff47567ff9de9f65f78b08391574e7da', '', 'mario_lussona', 1),
(124, 'Edgar Javier Reyes Andrade', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'edgarjavier@hotmail.com', 'usuario', 'a6aa774b84e09ce7ab4a96d9a41deaff673fe4bfe613d515ebd801bcd8ac34b5', '', 'edgar201_lussona', 1),
(125, 'Hilda Maria Montppellier Ochoa', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'Hilda.@hotmail.com.mx', 'usuario', '79df7926d40390d48628cb3b4709e13ba536d1775dcd953e95253fa3fe5c60ea', '', 'Hildam_lussona', 1),
(126, 'Gabriel Uribe Padilla', 'Fraccion', '2', 'Tequesquitengo', '', 'Gabriel@lussona.com', 'usuario', '6ddcdcc729177ccc1926408cf5eca1d015e22ea387a11c9d43917d6132d1f23a', '', 'Gabrielu_lussona', 1),
(127, 'Ana Luisa Moreno Sotelo', 'Fraccion', '2', 'Tequesquitengo, Morelos', '', 'Ana_ms@gmail.com', 'usuario', '64f827f75bdd6259a2e127cf7c9bb5147cf2621b970372fa49f4e3c83d381303', '', 'Anam_lussona', 1),
(128, 'Oscar Caudillo Almaraz', 'Fraccion', '1', 'Tequesquitengo, Morelos', '', 'Caudillo@hotmail.com', 'usuario', '891c40d1964c5fb681a442fd60ca08721e86889f785c2da0df763e77a3f11eaa', '', 'Oscarca_lussona', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_permiso`
--

CREATE TABLE `usuario_permiso` (
  `idusuario_permiso` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idpermiso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario_permiso`
--

INSERT INTO `usuario_permiso` (`idusuario_permiso`, `idusuario`, `idpermiso`) VALUES
(159, 30, 2),
(160, 30, 3),
(185, 31, 2),
(186, 31, 3),
(187, 32, 2),
(188, 32, 3),
(189, 33, 2),
(190, 33, 3),
(195, 36, 2),
(196, 36, 3),
(197, 37, 2),
(198, 37, 3),
(199, 34, 2),
(200, 34, 3),
(201, 38, 2),
(202, 38, 3),
(203, 39, 2),
(204, 39, 3),
(211, 43, 2),
(212, 43, 3),
(215, 45, 2),
(216, 45, 3),
(219, 47, 2),
(220, 47, 3),
(221, 48, 2),
(222, 48, 3),
(225, 50, 2),
(226, 50, 3),
(227, 51, 2),
(228, 51, 3),
(231, 53, 2),
(232, 53, 3),
(235, 55, 2),
(236, 55, 3),
(239, 57, 2),
(240, 57, 3),
(243, 59, 2),
(244, 59, 3),
(245, 60, 2),
(246, 60, 3),
(249, 62, 2),
(250, 62, 3),
(253, 64, 2),
(254, 64, 3),
(255, 65, 2),
(256, 65, 3),
(257, 66, 2),
(258, 66, 3),
(259, 67, 2),
(260, 67, 3),
(261, 68, 2),
(262, 68, 3),
(269, 72, 2),
(270, 72, 3),
(271, 73, 2),
(272, 73, 3),
(273, 74, 2),
(274, 74, 3),
(275, 75, 2),
(276, 75, 3),
(277, 76, 2),
(278, 76, 3),
(283, 79, 2),
(284, 79, 3),
(287, 81, 2),
(288, 81, 3),
(289, 82, 2),
(290, 82, 3),
(297, 86, 2),
(298, 86, 3),
(299, 87, 2),
(300, 87, 3),
(301, 88, 2),
(302, 88, 3),
(368, 1, 1),
(369, 1, 2),
(370, 1, 3),
(371, 1, 5),
(372, 1, 6),
(373, 1, 7),
(374, 1, 8),
(375, 1, 9),
(432, 106, 2),
(433, 106, 3),
(454, 35, 2),
(455, 35, 3),
(458, 70, 2),
(459, 70, 3),
(478, 109, 2),
(479, 109, 3),
(480, 111, 2),
(481, 111, 3),
(486, 115, 2),
(487, 115, 3),
(488, 116, 2),
(489, 116, 3),
(490, 83, 2),
(491, 83, 3),
(494, 107, 2),
(495, 107, 3),
(502, 113, 2),
(503, 113, 3),
(512, 85, 2),
(513, 85, 3),
(516, 58, 2),
(517, 58, 3),
(520, 108, 2),
(521, 108, 3),
(522, 71, 2),
(523, 71, 3),
(526, 54, 2),
(527, 54, 3),
(534, 120, 2),
(535, 120, 3),
(538, 122, 2),
(539, 122, 3),
(540, 123, 2),
(541, 123, 3),
(542, 117, 2),
(543, 117, 3),
(544, 118, 2),
(545, 118, 3),
(548, 40, 2),
(549, 40, 3),
(560, 90, 2),
(561, 90, 3),
(564, 91, 2),
(565, 91, 3),
(568, 89, 2),
(569, 89, 3),
(572, 92, 2),
(573, 92, 3),
(576, 93, 2),
(577, 93, 3),
(582, 42, 2),
(583, 42, 3),
(590, 46, 2),
(591, 46, 3),
(592, 84, 2),
(593, 84, 3),
(600, 49, 2),
(601, 49, 3),
(602, 56, 2),
(603, 56, 3),
(606, 69, 2),
(607, 69, 3),
(610, 77, 2),
(611, 77, 3),
(612, 114, 2),
(613, 114, 3),
(614, 80, 2),
(615, 80, 3),
(618, 41, 2),
(619, 41, 3),
(624, 124, 2),
(625, 124, 3),
(626, 119, 2),
(627, 119, 3),
(630, 125, 2),
(631, 125, 3),
(632, 105, 1),
(633, 105, 2),
(634, 105, 3),
(635, 105, 5),
(636, 105, 6),
(637, 105, 7),
(638, 105, 8),
(639, 105, 9),
(640, 121, 2),
(641, 121, 3),
(646, 127, 2),
(647, 127, 3),
(648, 95, 2),
(649, 95, 3),
(650, 29, 1),
(651, 29, 2),
(652, 29, 3),
(653, 29, 5),
(654, 29, 6),
(655, 29, 7),
(656, 29, 8),
(657, 29, 9),
(660, 94, 2),
(661, 94, 3),
(666, 126, 2),
(667, 126, 3),
(668, 128, 2),
(669, 128, 3),
(670, 44, 2),
(671, 44, 3),
(672, 63, 2),
(673, 63, 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ref_usuario` (`usuario_id`);

--
-- Indices de la tabla `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`idpermiso`);

--
-- Indices de la tabla `schedule_list`
--
ALTER TABLE `schedule_list`
  ADD PRIMARY KEY (`id`),
  ADD KEY `refusuario` (`reserved_by`) USING BTREE;

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `servicio_reserva`
--
ALTER TABLE `servicio_reserva`
  ADD PRIMARY KEY (`id`),
  ADD KEY `REF_SERVICIO` (`reserva_id`),
  ADD KEY `REF_RESERVA` (`servicio_id`);

--
-- Indices de la tabla `system_info`
--
ALTER TABLE `system_info`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `email_unique` (`email`),
  ADD UNIQUE KEY `login_unico` (`login`);

--
-- Indices de la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD PRIMARY KEY (`idusuario_permiso`),
  ADD KEY `fk_usuario_permiso_permiso_idx` (`idpermiso`),
  ADD KEY `fk_usuario_permiso_usuario_idx` (`idusuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT de la tabla `permiso`
--
ALTER TABLE `permiso`
  MODIFY `idpermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `schedule_list`
--
ALTER TABLE `schedule_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=306;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `servicio_reserva`
--
ALTER TABLE `servicio_reserva`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=328;

--
-- AUTO_INCREMENT de la tabla `system_info`
--
ALTER TABLE `system_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT de la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  MODIFY `idusuario_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=674;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD CONSTRAINT `departamentos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`idusuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `schedule_list`
--
ALTER TABLE `schedule_list`
  ADD CONSTRAINT `fk_usuario` FOREIGN KEY (`reserved_by`) REFERENCES `usuario` (`idusuario`);

--
-- Filtros para la tabla `servicio_reserva`
--
ALTER TABLE `servicio_reserva`
  ADD CONSTRAINT `FK_RESERVA` FOREIGN KEY (`reserva_id`) REFERENCES `schedule_list` (`id`),
  ADD CONSTRAINT `FK_SERVICIO` FOREIGN KEY (`servicio_id`) REFERENCES `servicios` (`id`);

--
-- Filtros para la tabla `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD CONSTRAINT `fk_usuario_permiso_permiso` FOREIGN KEY (`idpermiso`) REFERENCES `permiso` (`idpermiso`),
  ADD CONSTRAINT `fk_usuario_permiso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
