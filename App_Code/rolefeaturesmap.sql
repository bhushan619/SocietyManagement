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
-- Table structure for table `rolefeaturesmap`
--

CREATE TABLE `rolefeaturesmap` (
  `RoleId` smallint(6) NOT NULL,
  `FeatureId` int(11) NOT NULL,
  `IsCreate` tinyint(1) NOT NULL,
  `IsRead` tinyint(1) NOT NULL,
  `IsUpdate` tinyint(1) NOT NULL,
  `IsDelete` tinyint(1) NOT NULL,
  `varEmpId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `IsActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `rolefeaturesmap`
--

INSERT INTO `rolefeaturesmap` (`RoleId`, `FeatureId`, `IsCreate`, `IsRead`, `IsUpdate`, `IsDelete`, `varEmpId`, `IsActive`) VALUES
(7, 1, 0, 0, 0, 0, 'SKSE2193225', 1),
(7, 4, 0, 0, 0, 0, 'SKSE2193225', 1),
(7, 5, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 6, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 7, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 8, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 9, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 10, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 11, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 12, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 13, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 14, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 15, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 16, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 17, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 18, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 19, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 20, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 21, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 22, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 23, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 24, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 25, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 0, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 26, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 27, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 28, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 29, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 30, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 31, 0, 0, 0, 0, 'SKSK1234', 1),
(7, 1, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 4, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 5, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 6, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 7, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 8, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 9, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 10, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 11, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 12, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 13, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 14, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 15, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 16, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 17, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 18, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 19, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 20, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 21, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 22, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 23, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 24, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 25, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 0, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 26, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 27, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 28, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 29, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 30, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 31, 0, 0, 0, 0, 'SKSE9937259', 1),
(7, 16, 0, 0, 0, 0, 'SKSE7129145', 1),
(7, 17, 0, 0, 0, 0, 'SKSE7129145', 1),
(7, 18, 0, 0, 0, 0, 'SKSE7129145', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rolefeaturesmap`
--
ALTER TABLE `rolefeaturesmap`
  ADD KEY `FK_RoleFeaturesMap_FeaturesMaster` (`FeatureId`),
  ADD KEY `FK_RoleFeaturesMap_RolesMaster` (`RoleId`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
