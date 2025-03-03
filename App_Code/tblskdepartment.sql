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
-- Table structure for table `tblskdepartment`
--

CREATE TABLE `tblskdepartment` (
  `intId` bigint(20) NOT NULL,
  `varDepartmentName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varRemark` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `intCreatedBy` bigint(20) NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblskdepartment`
--

INSERT INTO `tblskdepartment` (`intId`, `varDepartmentName`, `varDescription`, `varRemark`, `varCreatedDate`, `intCreatedBy`, `intIsActive`, `ex1`, `ex2`, `ex3`, `ex4`, `ex5`) VALUES
(1, 'Society', '', '', '0000-00-00', 1, 1, '', '', '', '', ''),
(2, 'Services', '', '', '0000-00-00', 1, 1, '', '', '', '', ''),
(3, 'SK', '', '', '0000-00-00', 1, 1, '', '', '', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblskdepartment`
--
ALTER TABLE `tblskdepartment`
  ADD PRIMARY KEY (`intId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblskdepartment`
--
ALTER TABLE `tblskdepartment`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
