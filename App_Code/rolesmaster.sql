-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2018 at 09:08 AM
-- Server version: 10.1.10-MariaDB
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `anuvaa_skadmin`
--

-- --------------------------------------------------------

--
-- Table structure for table `rolesmaster`
--

CREATE TABLE `rolesmaster` (
  `intId` bigint(20) NOT NULL,
  `DeptId` bigint(20) NOT NULL,
  `RoleId` smallint(6) NOT NULL,
  `RoleName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `IsActive` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `rolesmaster`
--

INSERT INTO `rolesmaster` (`intId`, `DeptId`, `RoleId`, `RoleName`, `CreatedDate`, `CreatedBy`, `IsActive`) VALUES
(1, 1, 1, 'Society Admin', '0000-00-00 00:00:00', 1, 1),
(2, 1, 2, 'Society Employee', '0000-00-00 00:00:00', 1, 1),
(3, 1, 3, 'Society Property', '0000-00-00 00:00:00', 1, 1),
(4, 2, 4, 'Services Customer', '0000-00-00 00:00:00', 1, 1),
(5, 2, 5, 'Services Vendor', '0000-00-00 00:00:00', 1, 1),
(6, 3, 6, 'SK Admin', '0000-00-00 00:00:00', 1, 1),
(7, 3, 7, 'SK Employee', '0000-00-00 00:00:00', 1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rolesmaster`
--
ALTER TABLE `rolesmaster`
  ADD PRIMARY KEY (`intId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rolesmaster`
--
ALTER TABLE `rolesmaster`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
