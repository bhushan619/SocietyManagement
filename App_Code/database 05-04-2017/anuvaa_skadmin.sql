-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 50.62.209.38:3306
-- Generation Time: Apr 04, 2017 at 11:06 PM
-- Server version: 5.5.43-37.2-log
-- PHP Version: 5.5.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `anuvaa_skadmin`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`anuvaa_skadmin`@`%` PROCEDURE `sp_execute_debitTransaction` ()  BEGIN
END$$

CREATE DEFINER=`anuvaa_skadmin`@`%` PROCEDURE `sp_insert_Invoice` (IN `varDateTime` TEXT, IN `varSubTotal` TEXT, IN `varDiscount` TEXT, IN `varTax` TEXT, IN `varOther` TEXT, IN `varTotal` TEXT)  BEGIN

 SELECT @invoiceid:= concat("SKSI", FLOOR(RAND()*9567242));

INSERT INTO `tblinvoice`(`varInvoiceNo`, `varDateTime`,   `varSubTotal`, `varDiscount`, `varTax`, `varOther`, `varTotal`)
values
(  @invoiceid, varDateTime, varSubTotal, varDiscount, varTax, varOther, varTotal);

 

END$$

CREATE DEFINER=`anuvaa_skadmin`@`%` PROCEDURE `sp_insert_RoleFeaturesMap` (IN `spRoleId` INT, IN `spFeatureId` INT, IN `spIsCreate` INT, IN `spIsRead` INT, IN `spIsUpdate` INT, IN `spIsDelete` INT, IN `varSocietyId` TEXT, IN `spIsActive` INT)  BEGIN
declare rValue int;
	IF EXISTS (SELECT * FROM `rolefeaturesmap` WHERE `varEmpId`=varSocietyId and `FeatureId`=spFeatureId) 
	THEN   

	set rValue=0;
	ELSE  
INSERT INTO `rolefeaturesmap`(`RoleId`, `FeatureId`, `IsCreate`, `IsRead`, `IsUpdate`, `IsDelete`, `varEmpId`, `IsActive`) VALUES (spRoleId,spFeatureId,spIsCreate,spIsRead,spIsUpdate,spIsDelete,varSocietyId,spIsActive);

	END IF;
END$$

CREATE DEFINER=`anuvaa_skadmin`@`%` PROCEDURE `sp_select_FeatureAdmin` (IN `spintEmpId` TEXT)  BEGIN
SELECT DISTINCT 
                         tblskpersonnel.varEmpName, featuresmaster.varFeatureName, featuresmaster.PageName, featuresmaster.isSubMenu, featuresmaster.CreatedDate, 
                         featuresmaster.varIcon, featuresmaster.SortOrder, featuresmaster.IsActive, featuresmaster.FeatureId, featuresmaster.ParentId
FROM            tblskpersonnel INNER JOIN
                         rolefeaturesmap ON tblskpersonnel.intEmpCode = rolefeaturesmap.varEmpId INNER JOIN
                         rolesmaster ON rolefeaturesmap.RoleId = rolesmaster.RoleId INNER JOIN
                         featuresmaster ON rolefeaturesmap.FeatureId = featuresmaster.FeatureId
WHERE        featuresmaster.IsActive=1  and (rolefeaturesmap.varEmpId = spintEmpId) order by SortOrder asc;
END$$

CREATE DEFINER=`anuvaa_skadmin`@`%` PROCEDURE `sp_select_RoleFeaturesMap` ()  BEGIN
SELECT DISTINCT tblskpersonnel.varEmpName, featuresmaster.varFeatureName
FROM            rolefeaturesmap INNER JOIN
                         tblskpersonnel ON rolefeaturesmap.varEmpId = tblskpersonnel.intEmpCode INNER JOIN
                         featuresmaster ON rolefeaturesmap.FeatureId = featuresmaster.FeatureId ORDER BY rolefeaturesmap.FeatureId, rolefeaturesmap.varEmpId;
END$$

CREATE DEFINER=`anuvaa_skadmin`@`%` PROCEDURE `sp_select_SubMenuFromFeatureAdmin` (IN `varEmpId` TEXT, IN `spParentMenuId` TEXT)  BEGIN
SELECT DISTINCT 
                         tblskpersonnel.varEmpName, featuresmaster.varFeatureName, featuresmaster.PageName, featuresmaster.isSubMenu, featuresmaster.CreatedDate, 
                         featuresmaster.varIcon, featuresmaster.SortOrder, featuresmaster.IsActive, featuresmaster.FeatureId, featuresmaster.ParentId
FROM            tblskpersonnel INNER JOIN
                         rolefeaturesmap ON tblskpersonnel.intEmpCode = rolefeaturesmap.varEmpId INNER JOIN
                         rolesmaster ON rolefeaturesmap.RoleId = rolesmaster.RoleId INNER JOIN
                         featuresmaster ON rolefeaturesmap.FeatureId = featuresmaster.FeatureId
WHERE        featuresmaster.IsActive=1  and (rolefeaturesmap.varEmpId = varEmpId) and featuresmaster.ParentId=spParentMenuId order by SortOrder asc;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `citymaster`
--

CREATE TABLE `citymaster` (
  `CityId` int(11) NOT NULL,
  `StateId` int(11) NOT NULL,
  `CityCode` int(11) DEFAULT NULL,
  `TimeZoneId` int(11) NOT NULL,
  `CityName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `citymaster`
--

INSERT INTO `citymaster` (`CityId`, `StateId`, `CityCode`, `TimeZoneId`, `CityName`, `CreatedDate`, `CreatedBy`, `IsActive`) VALUES
(1, 1, NULL, 0, 'Adilabad', '0000-00-00 00:00:00', NULL, 1),
(2, 1, NULL, 0, 'Anantapur', '0000-00-00 00:00:00', NULL, 1),
(3, 1, NULL, 0, 'Chittor', '0000-00-00 00:00:00', NULL, 1),
(4, 1, NULL, 0, 'East Godavari', '0000-00-00 00:00:00', NULL, 1),
(5, 1, NULL, 0, 'Guntur', '0000-00-00 00:00:00', NULL, 1),
(6, 1, NULL, 0, 'Hyderabad', '0000-00-00 00:00:00', NULL, 1),
(7, 1, NULL, 0, 'Karimnagar', '0000-00-00 00:00:00', NULL, 1),
(8, 1, NULL, 0, 'Khammam', '0000-00-00 00:00:00', NULL, 1),
(9, 1, NULL, 0, 'Krishna', '0000-00-00 00:00:00', NULL, 1),
(10, 1, NULL, 0, 'Kurnool', '0000-00-00 00:00:00', NULL, 1),
(11, 1, NULL, 0, 'Mahbubnagar', '0000-00-00 00:00:00', NULL, 1),
(12, 1, NULL, 0, 'Medak', '0000-00-00 00:00:00', NULL, 1),
(13, 1, NULL, 0, 'Nalgonda', '0000-00-00 00:00:00', NULL, 1),
(14, 1, NULL, 0, 'Nellore', '0000-00-00 00:00:00', NULL, 1),
(15, 1, NULL, 0, 'Nizamabad', '0000-00-00 00:00:00', NULL, 1),
(16, 1, NULL, 0, 'Prakasam', '0000-00-00 00:00:00', NULL, 1),
(17, 1, NULL, 0, 'Rangareddy', '0000-00-00 00:00:00', NULL, 1),
(18, 1, NULL, 0, 'Srikakulam', '0000-00-00 00:00:00', NULL, 1),
(19, 1, NULL, 0, 'Vishakapattanam', '0000-00-00 00:00:00', NULL, 1),
(20, 1, NULL, 0, 'Vizianagaram', '0000-00-00 00:00:00', NULL, 1),
(21, 1, NULL, 0, 'Warangal', '0000-00-00 00:00:00', NULL, 1),
(22, 1, NULL, 0, 'West Godavari', '0000-00-00 00:00:00', NULL, 1),
(23, 1, NULL, 0, 'YSR Kadapa', '0000-00-00 00:00:00', NULL, 1),
(24, 2, NULL, 0, 'Anjaw', '0000-00-00 00:00:00', NULL, 1),
(25, 2, NULL, 0, 'Changlang', '0000-00-00 00:00:00', NULL, 1),
(26, 2, NULL, 0, 'East Kameng', '0000-00-00 00:00:00', NULL, 1),
(27, 2, NULL, 0, 'East Godavari', '0000-00-00 00:00:00', NULL, 1),
(28, 2, NULL, 0, 'Pasighat', '0000-00-00 00:00:00', NULL, 1),
(29, 2, NULL, 0, 'Lohit', '0000-00-00 00:00:00', NULL, 1),
(30, 2, NULL, 0, 'Lower Subansiri', '0000-00-00 00:00:00', NULL, 1),
(31, 2, NULL, 0, 'Papum Pare', '0000-00-00 00:00:00', NULL, 1),
(32, 2, NULL, 0, 'Tawang Town', '0000-00-00 00:00:00', NULL, 1),
(33, 2, NULL, 0, 'Tirap', '0000-00-00 00:00:00', NULL, 1),
(34, 2, NULL, 0, 'Lower Dibang Valley', '0000-00-00 00:00:00', NULL, 1),
(35, 2, NULL, 0, 'Upper Siang', '0000-00-00 00:00:00', NULL, 1),
(36, 2, NULL, 0, 'Upper Subansiri', '0000-00-00 00:00:00', NULL, 1),
(37, 2, NULL, 0, 'West Kameng', '0000-00-00 00:00:00', NULL, 1),
(38, 2, NULL, 0, 'West Siang', '0000-00-00 00:00:00', NULL, 1),
(39, 2, NULL, 0, 'Upper Dibang Valley', '0000-00-00 00:00:00', NULL, 1),
(40, 2, NULL, 0, 'Kurung Kumey', '0000-00-00 00:00:00', NULL, 1),
(41, 3, NULL, 0, 'Baksa', '0000-00-00 00:00:00', NULL, 1),
(42, 3, NULL, 0, 'Barpeta', '0000-00-00 00:00:00', NULL, 1),
(43, 3, NULL, 0, 'Bongaigaon', '0000-00-00 00:00:00', NULL, 1),
(44, 3, NULL, 0, 'Cachar', '0000-00-00 00:00:00', NULL, 1),
(45, 3, NULL, 0, 'Chirang', '0000-00-00 00:00:00', NULL, 1),
(46, 3, NULL, 0, 'Darrang', '0000-00-00 00:00:00', NULL, 1),
(47, 3, NULL, 0, 'Dhemaji', '0000-00-00 00:00:00', NULL, 1),
(48, 3, NULL, 0, 'Dhubri', '0000-00-00 00:00:00', NULL, 1),
(49, 3, NULL, 0, 'Dibrugarh', '0000-00-00 00:00:00', NULL, 1),
(50, 3, NULL, 0, 'Goalpara', '0000-00-00 00:00:00', NULL, 1),
(51, 3, NULL, 0, 'Golaghat', '0000-00-00 00:00:00', NULL, 1),
(52, 3, NULL, 0, 'Hailakandi', '0000-00-00 00:00:00', NULL, 1),
(53, 3, NULL, 0, 'Jorhat', '0000-00-00 00:00:00', NULL, 1),
(54, 3, NULL, 0, 'Karbi Anglong', '0000-00-00 00:00:00', NULL, 1),
(55, 3, NULL, 0, 'Karimganj', '0000-00-00 00:00:00', NULL, 1),
(56, 3, NULL, 0, 'Kokrajhar', '0000-00-00 00:00:00', NULL, 1),
(57, 3, NULL, 0, 'Lakhimpur ', '0000-00-00 00:00:00', NULL, 1),
(58, 3, NULL, 0, 'Marigaon', '0000-00-00 00:00:00', NULL, 1),
(59, 3, NULL, 0, 'Nagaon', '0000-00-00 00:00:00', NULL, 1),
(60, 3, NULL, 0, 'Nalbari', '0000-00-00 00:00:00', NULL, 1),
(61, 3, NULL, 0, 'Dima Hasao', '0000-00-00 00:00:00', NULL, 1),
(62, 3, NULL, 0, 'Sivasagar', '0000-00-00 00:00:00', NULL, 1),
(63, 3, NULL, 0, 'Sonitpur', '0000-00-00 00:00:00', NULL, 1),
(64, 3, NULL, 0, 'Tinsukia', '0000-00-00 00:00:00', NULL, 1),
(65, 3, NULL, 0, 'Kamrup Metro', '0000-00-00 00:00:00', NULL, 1),
(66, 3, NULL, 0, 'Udalguri', '0000-00-00 00:00:00', NULL, 1),
(67, 4, NULL, 0, 'Araria', '0000-00-00 00:00:00', NULL, 1),
(68, 4, NULL, 0, 'Arwal', '0000-00-00 00:00:00', NULL, 1),
(69, 4, NULL, 0, 'Aurangabad', '0000-00-00 00:00:00', NULL, 1),
(70, 4, NULL, 0, 'Banka', '0000-00-00 00:00:00', NULL, 1),
(71, 4, NULL, 0, 'Begusarai', '0000-00-00 00:00:00', NULL, 1),
(72, 4, NULL, 0, 'Bhagalpur', '0000-00-00 00:00:00', NULL, 1),
(73, 4, NULL, 0, 'Bhojpur', '0000-00-00 00:00:00', NULL, 1),
(74, 4, NULL, 0, 'Buxar', '0000-00-00 00:00:00', NULL, 1),
(75, 4, NULL, 0, 'East Champaran', '0000-00-00 00:00:00', NULL, 1),
(76, 4, NULL, 0, 'Gaya', '0000-00-00 00:00:00', NULL, 1),
(77, 4, NULL, 0, ' Gopalganj', '0000-00-00 00:00:00', NULL, 1),
(78, 4, NULL, 0, 'Jamui', '0000-00-00 00:00:00', NULL, 1),
(79, 4, NULL, 0, 'Jehanabad', '0000-00-00 00:00:00', NULL, 1),
(80, 4, NULL, 0, 'Kaimur', '0000-00-00 00:00:00', NULL, 1),
(81, 4, NULL, 0, 'Katihar', '0000-00-00 00:00:00', NULL, 1),
(82, 4, NULL, 0, 'Khagaria', '0000-00-00 00:00:00', NULL, 1),
(83, 4, NULL, 0, 'Kishanganj ', '0000-00-00 00:00:00', NULL, 1),
(84, 4, NULL, 0, 'Lakhisarai', '0000-00-00 00:00:00', NULL, 1),
(85, 4, NULL, 0, 'Madhepura', '0000-00-00 00:00:00', NULL, 1),
(86, 4, NULL, 0, 'Madhubani', '0000-00-00 00:00:00', NULL, 1),
(87, 4, NULL, 0, 'Munger', '0000-00-00 00:00:00', NULL, 1),
(88, 4, NULL, 0, 'Muzaffarpur', '0000-00-00 00:00:00', NULL, 1),
(89, 4, NULL, 0, 'Nalanda', '0000-00-00 00:00:00', NULL, 1),
(90, 4, NULL, 0, 'Nawada', '0000-00-00 00:00:00', NULL, 1),
(91, 4, NULL, 0, 'Patna', '0000-00-00 00:00:00', NULL, 1),
(92, 4, NULL, 0, 'Purnia', '0000-00-00 00:00:00', NULL, 1),
(93, 4, NULL, 0, 'Rohtas', '0000-00-00 00:00:00', NULL, 1),
(94, 4, NULL, 0, 'Saharsa', '0000-00-00 00:00:00', NULL, 1),
(95, 4, NULL, 0, 'Samastipur', '0000-00-00 00:00:00', NULL, 1),
(96, 4, NULL, 0, 'Saran', '0000-00-00 00:00:00', NULL, 1),
(97, 4, NULL, 0, 'Sheikhpura', '0000-00-00 00:00:00', NULL, 1),
(98, 4, NULL, 0, 'Sheohar', '0000-00-00 00:00:00', NULL, 1),
(99, 4, NULL, 0, 'Sitamarhi', '0000-00-00 00:00:00', NULL, 1),
(100, 4, NULL, 0, 'Siwan', '0000-00-00 00:00:00', NULL, 1),
(101, 4, NULL, 0, 'Supaul', '0000-00-00 00:00:00', NULL, 1),
(102, 4, NULL, 0, 'Vaishali', '0000-00-00 00:00:00', NULL, 1),
(103, 4, NULL, 0, 'West Champaran', '0000-00-00 00:00:00', NULL, 1),
(104, 5, NULL, 0, 'Balod', '0000-00-00 00:00:00', NULL, 1),
(105, 5, NULL, 0, 'Baloda Bazar', '0000-00-00 00:00:00', NULL, 1),
(106, 5, NULL, 0, 'Balrampur', '0000-00-00 00:00:00', NULL, 1),
(107, 5, NULL, 0, 'Bastar', '0000-00-00 00:00:00', NULL, 1),
(108, 5, NULL, 0, 'Bemetara', '0000-00-00 00:00:00', NULL, 1),
(109, 5, NULL, 0, 'Bijapur', '0000-00-00 00:00:00', NULL, 1),
(110, 5, NULL, 0, 'Bilaspur', '0000-00-00 00:00:00', NULL, 1),
(111, 5, NULL, 0, 'Dantewada', '0000-00-00 00:00:00', NULL, 1),
(112, 5, NULL, 0, 'Dhamtari', '0000-00-00 00:00:00', NULL, 1),
(113, 5, NULL, 0, 'Durg', '0000-00-00 00:00:00', NULL, 1),
(114, 5, NULL, 0, 'Gariaband', '0000-00-00 00:00:00', NULL, 1),
(115, 5, NULL, 0, 'Janjgir-Champa', '0000-00-00 00:00:00', NULL, 1),
(116, 5, NULL, 0, 'Jashpur', '0000-00-00 00:00:00', NULL, 1),
(117, 5, NULL, 0, 'Kanker', '0000-00-00 00:00:00', NULL, 1),
(118, 5, NULL, 0, 'Kawardha', '0000-00-00 00:00:00', NULL, 1),
(119, 5, NULL, 0, 'Kondagaon', '0000-00-00 00:00:00', NULL, 1),
(120, 5, NULL, 0, 'Korba ', '0000-00-00 00:00:00', NULL, 1),
(121, 5, NULL, 0, 'Koriya', '0000-00-00 00:00:00', NULL, 1),
(122, 5, NULL, 0, 'Mahasamund', '0000-00-00 00:00:00', NULL, 1),
(123, 5, NULL, 0, 'Mungeli', '0000-00-00 00:00:00', NULL, 1),
(124, 5, NULL, 0, 'Narayanpur', '0000-00-00 00:00:00', NULL, 1),
(125, 5, NULL, 0, 'Raigarh', '0000-00-00 00:00:00', NULL, 1),
(126, 5, NULL, 0, 'Raipur', '0000-00-00 00:00:00', NULL, 1),
(127, 5, NULL, 0, 'Sukma', '0000-00-00 00:00:00', NULL, 1),
(128, 5, NULL, 0, 'Surajpur', '0000-00-00 00:00:00', NULL, 1),
(129, 5, NULL, 0, 'Surguja', '0000-00-00 00:00:00', NULL, 1),
(130, 6, NULL, 0, 'North Goa', '0000-00-00 00:00:00', NULL, 1),
(131, 6, NULL, 0, 'South Goa', '0000-00-00 00:00:00', NULL, 1),
(132, 7, NULL, 0, 'Ahmedabad', '0000-00-00 00:00:00', NULL, 1),
(133, 7, NULL, 0, 'Amreli District', '0000-00-00 00:00:00', NULL, 1),
(134, 7, NULL, 0, 'Anand', '0000-00-00 00:00:00', NULL, 1),
(135, 7, NULL, 0, 'Banaskantha', '0000-00-00 00:00:00', NULL, 1),
(136, 7, NULL, 0, 'Bharuch', '0000-00-00 00:00:00', NULL, 1),
(137, 7, NULL, 0, 'Bhavnagar', '0000-00-00 00:00:00', NULL, 1),
(138, 7, NULL, 0, 'Dahod', '0000-00-00 00:00:00', NULL, 1),
(139, 7, NULL, 0, 'Gandhinagar', '0000-00-00 00:00:00', NULL, 1),
(140, 7, NULL, 0, 'Jamnagar', '0000-00-00 00:00:00', NULL, 1),
(141, 7, NULL, 0, 'Junagadh', '0000-00-00 00:00:00', NULL, 1),
(142, 7, NULL, 0, 'Kheda', '0000-00-00 00:00:00', NULL, 1),
(143, 7, NULL, 0, 'Mehsana', '0000-00-00 00:00:00', NULL, 1),
(144, 7, NULL, 0, 'Narmada', '0000-00-00 00:00:00', NULL, 1),
(145, 7, NULL, 0, 'Navsari', '0000-00-00 00:00:00', NULL, 1),
(146, 7, NULL, 0, 'Panchmahal', '0000-00-00 00:00:00', NULL, 1),
(147, 7, NULL, 0, 'Patan', '0000-00-00 00:00:00', NULL, 1),
(148, 7, NULL, 0, 'Porbandar ', '0000-00-00 00:00:00', NULL, 1),
(149, 7, NULL, 0, 'Rajkot', '0000-00-00 00:00:00', NULL, 1),
(150, 7, NULL, 0, 'Sabarkantha', '0000-00-00 00:00:00', NULL, 1),
(151, 7, NULL, 0, 'Surat', '0000-00-00 00:00:00', NULL, 1),
(152, 7, NULL, 0, 'Surendranagar', '0000-00-00 00:00:00', NULL, 1),
(153, 7, NULL, 0, 'Vapi', '0000-00-00 00:00:00', NULL, 1),
(154, 7, NULL, 0, 'The Dangs', '0000-00-00 00:00:00', NULL, 1),
(155, 7, NULL, 0, 'Vadodara', '0000-00-00 00:00:00', NULL, 1),
(156, 7, NULL, 0, 'Valsad', '0000-00-00 00:00:00', NULL, 1),
(157, 8, NULL, 0, 'Ambala', '0000-00-00 00:00:00', NULL, 1),
(158, 8, NULL, 0, 'Bhiwani', '0000-00-00 00:00:00', NULL, 1),
(159, 8, NULL, 0, 'Faridabad', '0000-00-00 00:00:00', NULL, 1),
(160, 8, NULL, 0, 'Fatehabad', '0000-00-00 00:00:00', NULL, 1),
(161, 8, NULL, 0, 'Hisar', '0000-00-00 00:00:00', NULL, 1),
(162, 8, NULL, 0, 'Jhajjar', '0000-00-00 00:00:00', NULL, 1),
(163, 8, NULL, 0, 'Jind', '0000-00-00 00:00:00', NULL, 1),
(164, 8, NULL, 0, 'Kaithal', '0000-00-00 00:00:00', NULL, 1),
(165, 8, NULL, 0, 'Karnal', '0000-00-00 00:00:00', NULL, 1),
(166, 8, NULL, 0, 'Kurukshetra', '0000-00-00 00:00:00', NULL, 1),
(167, 8, NULL, 0, 'Mahendragarh', '0000-00-00 00:00:00', NULL, 1),
(168, 8, NULL, 0, 'Mewat', '0000-00-00 00:00:00', NULL, 1),
(169, 8, NULL, 0, 'Palwal', '0000-00-00 00:00:00', NULL, 1),
(170, 8, NULL, 0, 'Panchkula', '0000-00-00 00:00:00', NULL, 1),
(171, 8, NULL, 0, 'Panipat', '0000-00-00 00:00:00', NULL, 1),
(172, 8, NULL, 0, 'Rohtak', '0000-00-00 00:00:00', NULL, 1),
(173, 8, NULL, 0, 'Sirsa', '0000-00-00 00:00:00', NULL, 1),
(174, 8, NULL, 0, 'Sonipat', '0000-00-00 00:00:00', NULL, 1),
(175, 8, NULL, 0, ' Yamuna Nagar', '0000-00-00 00:00:00', NULL, 1),
(176, 9, NULL, 0, 'Bilaspur', '0000-00-00 00:00:00', NULL, 1),
(177, 9, NULL, 0, 'Chamba', '0000-00-00 00:00:00', NULL, 1),
(178, 9, NULL, 0, 'Kangra', '0000-00-00 00:00:00', NULL, 1),
(179, 9, NULL, 0, 'Kinnaur', '0000-00-00 00:00:00', NULL, 1),
(180, 9, NULL, 0, 'Kullu', '0000-00-00 00:00:00', NULL, 1),
(181, 9, NULL, 0, 'Lahaul and Spiti', '0000-00-00 00:00:00', NULL, 1),
(182, 9, NULL, 0, 'Mandi', '0000-00-00 00:00:00', NULL, 1),
(183, 9, NULL, 0, 'Shimla', '0000-00-00 00:00:00', NULL, 1),
(184, 9, NULL, 0, 'Sirmaur', '0000-00-00 00:00:00', NULL, 1),
(185, 9, NULL, 0, 'Solan', '0000-00-00 00:00:00', NULL, 1),
(186, 9, NULL, 0, 'Una', '0000-00-00 00:00:00', NULL, 1),
(187, 10, NULL, 0, 'Baramulla', '0000-00-00 00:00:00', NULL, 1),
(188, 10, NULL, 0, 'Budgam', '0000-00-00 00:00:00', NULL, 1),
(189, 10, NULL, 0, 'Doda', '0000-00-00 00:00:00', NULL, 1),
(190, 10, NULL, 0, 'Ganderbal', '0000-00-00 00:00:00', NULL, 1),
(191, 10, NULL, 0, 'Jammu', '0000-00-00 00:00:00', NULL, 1),
(192, 10, NULL, 0, 'Kargil', '0000-00-00 00:00:00', NULL, 1),
(193, 10, NULL, 0, 'Kathua', '0000-00-00 00:00:00', NULL, 1),
(194, 10, NULL, 0, 'Kishtwar', '0000-00-00 00:00:00', NULL, 1),
(195, 10, NULL, 0, 'Kulgam', '0000-00-00 00:00:00', NULL, 1),
(196, 10, NULL, 0, 'Kupwara', '0000-00-00 00:00:00', NULL, 1),
(197, 10, NULL, 0, 'Leh', '0000-00-00 00:00:00', NULL, 1),
(198, 10, NULL, 0, 'Poonch', '0000-00-00 00:00:00', NULL, 1),
(199, 10, NULL, 0, 'Pulwama', '0000-00-00 00:00:00', NULL, 1),
(200, 10, NULL, 0, 'Rajouri', '0000-00-00 00:00:00', NULL, 1),
(201, 10, NULL, 0, 'Ramban', '0000-00-00 00:00:00', NULL, 1),
(202, 10, NULL, 0, 'Reasi', '0000-00-00 00:00:00', NULL, 1),
(203, 10, NULL, 0, 'Samba', '0000-00-00 00:00:00', NULL, 1),
(204, 10, NULL, 0, 'Shopian', '0000-00-00 00:00:00', NULL, 1),
(205, 10, NULL, 0, 'Srinagar', '0000-00-00 00:00:00', NULL, 1),
(206, 10, NULL, 0, 'Udhampur', '0000-00-00 00:00:00', NULL, 1),
(207, 11, NULL, 0, 'Bokaro', '0000-00-00 00:00:00', NULL, 1),
(208, 11, NULL, 0, 'Chaibasa (West Singhbhum)', '0000-00-00 00:00:00', NULL, 1),
(209, 11, NULL, 0, 'Chatra', '0000-00-00 00:00:00', NULL, 1),
(210, 11, NULL, 0, 'Dhanbad', '0000-00-00 00:00:00', NULL, 1),
(211, 11, NULL, 0, 'Dumka', '0000-00-00 00:00:00', NULL, 1),
(212, 11, NULL, 0, 'Garhwa', '0000-00-00 00:00:00', NULL, 1),
(213, 11, NULL, 0, 'Giridih', '0000-00-00 00:00:00', NULL, 1),
(214, 11, NULL, 0, 'Godda', '0000-00-00 00:00:00', NULL, 1),
(215, 11, NULL, 0, 'Gumla', '0000-00-00 00:00:00', NULL, 1),
(216, 11, NULL, 0, 'Hazaribagh ', '0000-00-00 00:00:00', NULL, 1),
(217, 11, NULL, 0, 'Jamshedpur (East Singhbhum)', '0000-00-00 00:00:00', NULL, 1),
(218, 11, NULL, 0, 'Jamtara', '0000-00-00 00:00:00', NULL, 1),
(219, 11, NULL, 0, 'Kharsawan', '0000-00-00 00:00:00', NULL, 1),
(220, 11, NULL, 0, 'Koderma', '0000-00-00 00:00:00', NULL, 1),
(221, 11, NULL, 0, 'Latehar', '0000-00-00 00:00:00', NULL, 1),
(222, 11, NULL, 0, 'Lohardaga', '0000-00-00 00:00:00', NULL, 1),
(223, 11, NULL, 0, 'Pakur', '0000-00-00 00:00:00', NULL, 1),
(224, 11, NULL, 0, 'Palamu', '0000-00-00 00:00:00', NULL, 1),
(225, 11, NULL, 0, 'Ranchi', '0000-00-00 00:00:00', NULL, 1),
(226, 11, NULL, 0, 'Sahebganj', '0000-00-00 00:00:00', NULL, 1),
(227, 11, NULL, 0, 'Saraikela', '0000-00-00 00:00:00', NULL, 1),
(228, 11, NULL, 0, 'Simdega', '0000-00-00 00:00:00', NULL, 1),
(229, 12, NULL, 0, 'Bagalkot', '0000-00-00 00:00:00', NULL, 1),
(230, 12, NULL, 0, 'Bangalore Urban', '0000-00-00 00:00:00', NULL, 1),
(231, 12, NULL, 0, 'Bangalore Rural', '0000-00-00 00:00:00', NULL, 1),
(232, 12, NULL, 0, 'Bellary', '0000-00-00 00:00:00', NULL, 1),
(233, 12, NULL, 0, 'Bidar', '0000-00-00 00:00:00', NULL, 1),
(234, 12, NULL, 0, 'Bijapur', '0000-00-00 00:00:00', NULL, 1),
(235, 12, NULL, 0, 'Chamarajanagar', '0000-00-00 00:00:00', NULL, 1),
(236, 12, NULL, 0, 'Chikballapur', '0000-00-00 00:00:00', NULL, 1),
(237, 12, NULL, 0, 'Chikmagalur', '0000-00-00 00:00:00', NULL, 1),
(238, 12, NULL, 0, 'Chitradurga', '0000-00-00 00:00:00', NULL, 1),
(239, 12, NULL, 0, 'Dakshina Kannada', '0000-00-00 00:00:00', NULL, 1),
(240, 12, NULL, 0, 'Davanagere', '0000-00-00 00:00:00', NULL, 1),
(241, 12, NULL, 0, 'Dharwad', '0000-00-00 00:00:00', NULL, 1),
(242, 12, NULL, 0, 'Gadag', '0000-00-00 00:00:00', NULL, 1),
(243, 12, NULL, 0, 'Gulbarga', '0000-00-00 00:00:00', NULL, 1),
(244, 12, NULL, 0, 'Hassan', '0000-00-00 00:00:00', NULL, 1),
(245, 12, NULL, 0, 'Haveri', '0000-00-00 00:00:00', NULL, 1),
(246, 12, NULL, 0, 'Kodagu', '0000-00-00 00:00:00', NULL, 1),
(247, 12, NULL, 0, 'Kolar', '0000-00-00 00:00:00', NULL, 1),
(248, 12, NULL, 0, 'Koppal', '0000-00-00 00:00:00', NULL, 1),
(249, 12, NULL, 0, 'Mandya', '0000-00-00 00:00:00', NULL, 1),
(250, 12, NULL, 0, 'Mysore', '0000-00-00 00:00:00', NULL, 1),
(251, 12, NULL, 0, 'Raichur', '0000-00-00 00:00:00', NULL, 1),
(252, 12, NULL, 0, 'Ramanagara', '0000-00-00 00:00:00', NULL, 1),
(253, 12, NULL, 0, 'Shimoga', '0000-00-00 00:00:00', NULL, 1),
(254, 12, NULL, 0, 'Tumkur', '0000-00-00 00:00:00', NULL, 1),
(255, 12, NULL, 0, 'Udupi', '0000-00-00 00:00:00', NULL, 1),
(256, 12, NULL, 0, 'Uttara Kannada', '0000-00-00 00:00:00', NULL, 1),
(257, 12, NULL, 0, 'Yadgir', '0000-00-00 00:00:00', NULL, 1),
(258, 13, NULL, 0, 'Alappuzha', '0000-00-00 00:00:00', NULL, 1),
(259, 13, NULL, 0, 'Eranakulam', '0000-00-00 00:00:00', NULL, 1),
(260, 13, NULL, 0, 'Idukki', '0000-00-00 00:00:00', NULL, 1),
(261, 13, NULL, 0, 'Kannur', '0000-00-00 00:00:00', NULL, 1),
(262, 13, NULL, 0, 'Kasargod', '0000-00-00 00:00:00', NULL, 1),
(263, 13, NULL, 0, 'Kollam', '0000-00-00 00:00:00', NULL, 1),
(264, 13, NULL, 0, 'Kottayam', '0000-00-00 00:00:00', NULL, 1),
(265, 13, NULL, 0, 'Kozhikode', '0000-00-00 00:00:00', NULL, 1),
(266, 13, NULL, 0, 'Mallapuram', '0000-00-00 00:00:00', NULL, 1),
(267, 13, NULL, 0, 'Palakkad', '0000-00-00 00:00:00', NULL, 1),
(268, 13, NULL, 0, 'Pathanamthitta', '0000-00-00 00:00:00', NULL, 1),
(269, 13, NULL, 0, 'Thiruvananthapuram', '0000-00-00 00:00:00', NULL, 1),
(270, 13, NULL, 0, 'Thrissur', '0000-00-00 00:00:00', NULL, 1),
(271, 13, NULL, 0, 'Wayanad', '0000-00-00 00:00:00', NULL, 1),
(272, 14, NULL, 0, 'Alirajpur', '0000-00-00 00:00:00', NULL, 1),
(273, 14, NULL, 0, 'Anuppur', '0000-00-00 00:00:00', NULL, 1),
(274, 14, NULL, 0, 'Ashoknagar', '0000-00-00 00:00:00', NULL, 1),
(275, 14, NULL, 0, 'Balaghat', '0000-00-00 00:00:00', NULL, 1),
(276, 14, NULL, 0, 'Barwani', '0000-00-00 00:00:00', NULL, 1),
(277, 14, NULL, 0, 'Betul', '0000-00-00 00:00:00', NULL, 1),
(278, 14, NULL, 0, 'Bhind', '0000-00-00 00:00:00', NULL, 1),
(279, 14, NULL, 0, 'Bhopal ', '0000-00-00 00:00:00', NULL, 1),
(280, 14, NULL, 0, 'Burhanpur', '0000-00-00 00:00:00', NULL, 1),
(281, 14, NULL, 0, 'Chhatarpur', '0000-00-00 00:00:00', NULL, 1),
(282, 14, NULL, 0, 'Chhindwara', '0000-00-00 00:00:00', NULL, 1),
(283, 14, NULL, 0, 'Damoh', '0000-00-00 00:00:00', NULL, 1),
(284, 14, NULL, 0, 'Datia', '0000-00-00 00:00:00', NULL, 1),
(285, 14, NULL, 0, 'Dewas', '0000-00-00 00:00:00', NULL, 1),
(286, 14, NULL, 0, 'Dhar', '0000-00-00 00:00:00', NULL, 1),
(287, 14, NULL, 0, 'Dindori', '0000-00-00 00:00:00', NULL, 1),
(288, 14, NULL, 0, 'Guna', '0000-00-00 00:00:00', NULL, 1),
(289, 14, NULL, 0, 'Gwalior', '0000-00-00 00:00:00', NULL, 1),
(290, 14, NULL, 0, 'Harda', '0000-00-00 00:00:00', NULL, 1),
(291, 14, NULL, 0, 'Hoshangabad', '0000-00-00 00:00:00', NULL, 1),
(292, 14, NULL, 0, 'Indore', '0000-00-00 00:00:00', NULL, 1),
(293, 14, NULL, 0, 'Jabalpur', '0000-00-00 00:00:00', NULL, 1),
(294, 14, NULL, 0, 'Jhabua', '0000-00-00 00:00:00', NULL, 1),
(295, 14, NULL, 0, 'Katni', '0000-00-00 00:00:00', NULL, 1),
(296, 14, NULL, 0, 'Khandwa', '0000-00-00 00:00:00', NULL, 1),
(297, 14, NULL, 0, 'Khargone', '0000-00-00 00:00:00', NULL, 1),
(298, 14, NULL, 0, 'Mandla', '0000-00-00 00:00:00', NULL, 1),
(299, 14, NULL, 0, 'Mandsaur', '0000-00-00 00:00:00', NULL, 1),
(300, 14, NULL, 0, 'Morena', '0000-00-00 00:00:00', NULL, 1),
(301, 14, NULL, 0, 'Narsinghpur', '0000-00-00 00:00:00', NULL, 1),
(302, 14, NULL, 0, 'Neemuch', '0000-00-00 00:00:00', NULL, 1),
(303, 14, NULL, 0, 'Panna', '0000-00-00 00:00:00', NULL, 1),
(304, 14, NULL, 0, 'Raisen', '0000-00-00 00:00:00', NULL, 1),
(305, 14, NULL, 0, 'Rajgarh', '0000-00-00 00:00:00', NULL, 1),
(306, 14, NULL, 0, 'Ratlam', '0000-00-00 00:00:00', NULL, 1),
(307, 14, NULL, 0, 'Rewa', '0000-00-00 00:00:00', NULL, 1),
(308, 14, NULL, 0, 'Sagar', '0000-00-00 00:00:00', NULL, 1),
(309, 14, NULL, 0, 'Satna', '0000-00-00 00:00:00', NULL, 1),
(310, 14, NULL, 0, 'Sehore', '0000-00-00 00:00:00', NULL, 1),
(311, 14, NULL, 0, 'Seoni', '0000-00-00 00:00:00', NULL, 1),
(312, 14, NULL, 0, 'Singrauli', '0000-00-00 00:00:00', NULL, 1),
(313, 14, NULL, 0, 'Shahdol', '0000-00-00 00:00:00', NULL, 1),
(314, 14, NULL, 0, 'Shajapur', '0000-00-00 00:00:00', NULL, 1),
(315, 14, NULL, 0, 'Sheopur', '0000-00-00 00:00:00', NULL, 1),
(316, 14, NULL, 0, 'Shivpuri', '0000-00-00 00:00:00', NULL, 1),
(317, 14, NULL, 0, 'Sidhi', '0000-00-00 00:00:00', NULL, 1),
(318, 14, NULL, 0, 'Tikamgarh', '0000-00-00 00:00:00', NULL, 1),
(319, 14, NULL, 0, 'Ujjain', '0000-00-00 00:00:00', NULL, 1),
(320, 14, NULL, 0, 'Umaria', '0000-00-00 00:00:00', NULL, 1),
(321, 14, NULL, 0, 'Vidisha', '0000-00-00 00:00:00', NULL, 1),
(322, 15, NULL, 0, 'Ahmednagar', '0000-00-00 00:00:00', NULL, 1),
(323, 15, NULL, 0, 'Akola', '0000-00-00 00:00:00', NULL, 1),
(324, 15, NULL, 0, 'Amravati', '0000-00-00 00:00:00', NULL, 1),
(325, 15, NULL, 0, 'Aurangabad', '0000-00-00 00:00:00', NULL, 1),
(326, 15, NULL, 0, 'Beed', '0000-00-00 00:00:00', NULL, 1),
(327, 15, NULL, 0, 'Bhandara', '0000-00-00 00:00:00', NULL, 1),
(328, 15, NULL, 0, 'Buldhana', '0000-00-00 00:00:00', NULL, 1),
(329, 15, NULL, 0, 'Chandrapur', '0000-00-00 00:00:00', NULL, 1),
(330, 15, NULL, 0, 'Dhule', '0000-00-00 00:00:00', NULL, 1),
(331, 15, NULL, 0, 'Gadchiroli', '0000-00-00 00:00:00', NULL, 1),
(332, 15, NULL, 0, 'Gondia', '0000-00-00 00:00:00', NULL, 1),
(333, 15, NULL, 0, 'Hingoli', '0000-00-00 00:00:00', NULL, 1),
(334, 15, NULL, 0, 'Jalgaon', '0000-00-00 00:00:00', NULL, 1),
(335, 15, NULL, 0, 'Jalna', '0000-00-00 00:00:00', NULL, 1),
(336, 15, NULL, 0, 'Kolhapur', '0000-00-00 00:00:00', NULL, 1),
(337, 15, NULL, 0, 'Latur', '0000-00-00 00:00:00', NULL, 1),
(338, 15, NULL, 0, 'Mumbai Surburban', '0000-00-00 00:00:00', NULL, 1),
(339, 15, NULL, 0, 'Nagpur', '0000-00-00 00:00:00', NULL, 1),
(340, 15, NULL, 0, 'Nanded', '0000-00-00 00:00:00', NULL, 1),
(341, 15, NULL, 0, 'Nashik', '0000-00-00 00:00:00', NULL, 1),
(342, 15, NULL, 0, 'Nundarbar', '0000-00-00 00:00:00', NULL, 1),
(343, 15, NULL, 0, 'Osmanabad', '0000-00-00 00:00:00', NULL, 1),
(344, 15, NULL, 0, 'Parbhani', '0000-00-00 00:00:00', NULL, 1),
(345, 15, NULL, 0, 'Pune', '0000-00-00 00:00:00', NULL, 1),
(346, 15, NULL, 0, 'Raigarh', '0000-00-00 00:00:00', NULL, 1),
(347, 15, NULL, 0, 'Ratnagiri', '0000-00-00 00:00:00', NULL, 1),
(348, 15, NULL, 0, 'Sangli', '0000-00-00 00:00:00', NULL, 1),
(349, 15, NULL, 0, 'Satara', '0000-00-00 00:00:00', NULL, 1),
(350, 15, NULL, 0, 'Sindhudurg', '0000-00-00 00:00:00', NULL, 1),
(351, 15, NULL, 0, 'Solapur', '0000-00-00 00:00:00', NULL, 1),
(352, 15, NULL, 0, 'Thane', '0000-00-00 00:00:00', NULL, 1),
(353, 15, NULL, 0, 'Wardha', '0000-00-00 00:00:00', NULL, 1),
(354, 15, NULL, 0, 'Washim', '0000-00-00 00:00:00', NULL, 1),
(355, 15, NULL, 0, 'Yavatmal', '0000-00-00 00:00:00', NULL, 1),
(356, 16, NULL, 0, 'Bishnupur', '0000-00-00 00:00:00', NULL, 1),
(357, 16, NULL, 0, 'Chandel', '0000-00-00 00:00:00', NULL, 1),
(358, 16, NULL, 0, 'Churachandpur', '0000-00-00 00:00:00', NULL, 1),
(359, 16, NULL, 0, 'Imphal East', '0000-00-00 00:00:00', NULL, 1),
(360, 16, NULL, 0, 'Imphal West', '0000-00-00 00:00:00', NULL, 1),
(361, 16, NULL, 0, 'Senapati', '0000-00-00 00:00:00', NULL, 1),
(362, 16, NULL, 0, 'Tamenglong', '0000-00-00 00:00:00', NULL, 1),
(363, 16, NULL, 0, 'Thoubal', '0000-00-00 00:00:00', NULL, 1),
(364, 16, NULL, 0, 'Ukhrul', '0000-00-00 00:00:00', NULL, 1),
(365, 17, NULL, 0, 'East Garo Hills / North Garo Hills', '0000-00-00 00:00:00', NULL, 1),
(366, 17, NULL, 0, 'East Khasi Hills', '0000-00-00 00:00:00', NULL, 1),
(367, 17, NULL, 0, 'Jaintia Hills / East Jaintia Hills', '0000-00-00 00:00:00', NULL, 1),
(368, 17, NULL, 0, 'Ri-Bhoi', '0000-00-00 00:00:00', NULL, 1),
(369, 17, NULL, 0, 'South Garo Hills', '0000-00-00 00:00:00', NULL, 1),
(370, 17, NULL, 0, 'West Garo Hills / South West Garo Hills', '0000-00-00 00:00:00', NULL, 1),
(371, 17, NULL, 0, 'West Khasi Hills / South West Khasi Hills', '0000-00-00 00:00:00', NULL, 1),
(372, 18, NULL, 0, 'Aizawl', '0000-00-00 00:00:00', NULL, 1),
(373, 18, NULL, 0, 'Champhai', '0000-00-00 00:00:00', NULL, 1),
(374, 18, NULL, 0, 'Kolasib', '0000-00-00 00:00:00', NULL, 1),
(375, 18, NULL, 0, 'Lawngtlai', '0000-00-00 00:00:00', NULL, 1),
(376, 18, NULL, 0, 'Lunglei', '0000-00-00 00:00:00', NULL, 1),
(377, 18, NULL, 0, 'Mamit', '0000-00-00 00:00:00', NULL, 1),
(378, 18, NULL, 0, 'Saiha', '0000-00-00 00:00:00', NULL, 1),
(379, 18, NULL, 0, 'Serchhip', '0000-00-00 00:00:00', NULL, 1),
(380, 19, NULL, 0, 'Dimapur', '0000-00-00 00:00:00', NULL, 1),
(381, 19, NULL, 0, 'Kiphire', '0000-00-00 00:00:00', NULL, 1),
(382, 19, NULL, 0, 'Kohima', '0000-00-00 00:00:00', NULL, 1),
(383, 19, NULL, 0, 'Longleng', '0000-00-00 00:00:00', NULL, 1),
(384, 19, NULL, 0, 'Mokokchung', '0000-00-00 00:00:00', NULL, 1),
(385, 19, NULL, 0, 'Mon', '0000-00-00 00:00:00', NULL, 1),
(386, 19, NULL, 0, 'Peren', '0000-00-00 00:00:00', NULL, 1),
(387, 19, NULL, 0, 'Phek', '0000-00-00 00:00:00', NULL, 1),
(388, 19, NULL, 0, 'Tuensang', '0000-00-00 00:00:00', NULL, 1),
(389, 19, NULL, 0, 'Wokha', '0000-00-00 00:00:00', NULL, 1),
(390, 19, NULL, 0, 'Zunheboto', '0000-00-00 00:00:00', NULL, 1),
(391, 20, NULL, 0, 'Angul', '0000-00-00 00:00:00', NULL, 1),
(392, 20, NULL, 0, 'Balangir', '0000-00-00 00:00:00', NULL, 1),
(393, 20, NULL, 0, 'Balasore', '0000-00-00 00:00:00', NULL, 1),
(394, 20, NULL, 0, 'Bargarh', '0000-00-00 00:00:00', NULL, 1),
(395, 20, NULL, 0, 'Bhadrak', '0000-00-00 00:00:00', NULL, 1),
(396, 20, NULL, 0, 'Boudh (Bauda)', '0000-00-00 00:00:00', NULL, 1),
(397, 20, NULL, 0, 'Cuttack', '0000-00-00 00:00:00', NULL, 1),
(398, 20, NULL, 0, 'Debagarh (Deogarh)', '0000-00-00 00:00:00', NULL, 1),
(399, 20, NULL, 0, 'Dhenkanal', '0000-00-00 00:00:00', NULL, 1),
(400, 20, NULL, 0, 'Gajapati', '0000-00-00 00:00:00', NULL, 1),
(401, 20, NULL, 0, 'Ganjam', '0000-00-00 00:00:00', NULL, 1),
(402, 20, NULL, 0, 'Jagatsinghpur', '0000-00-00 00:00:00', NULL, 1),
(403, 20, NULL, 0, 'Jajapur (Jajpur)', '0000-00-00 00:00:00', NULL, 1),
(404, 20, NULL, 0, 'Jharsuguda', '0000-00-00 00:00:00', NULL, 1),
(405, 20, NULL, 0, 'Kalahandi', '0000-00-00 00:00:00', NULL, 1),
(406, 20, NULL, 0, 'Kandhamal', '0000-00-00 00:00:00', NULL, 1),
(407, 20, NULL, 0, 'Kendrapara', '0000-00-00 00:00:00', NULL, 1),
(408, 20, NULL, 0, 'Kendujhar (Keonjhar)', '0000-00-00 00:00:00', NULL, 1),
(409, 20, NULL, 0, 'Khordha', '0000-00-00 00:00:00', NULL, 1),
(410, 20, NULL, 0, 'Koraput', '0000-00-00 00:00:00', NULL, 1),
(411, 20, NULL, 0, 'Malkangiri', '0000-00-00 00:00:00', NULL, 1),
(412, 20, NULL, 0, 'Mayurbhanj', '0000-00-00 00:00:00', NULL, 1),
(413, 20, NULL, 0, 'Nabarangpur', '0000-00-00 00:00:00', NULL, 1),
(414, 20, NULL, 0, 'Nayagarh', '0000-00-00 00:00:00', NULL, 1),
(415, 20, NULL, 0, 'Nuapada', '0000-00-00 00:00:00', NULL, 1),
(416, 20, NULL, 0, 'Puri', '0000-00-00 00:00:00', NULL, 1),
(417, 20, NULL, 0, 'Rayagada', '0000-00-00 00:00:00', NULL, 1),
(418, 20, NULL, 0, 'Sambalpur', '0000-00-00 00:00:00', NULL, 1),
(419, 20, NULL, 0, 'Subarnapur', '0000-00-00 00:00:00', NULL, 1),
(420, 20, NULL, 0, 'Sundergarh', '0000-00-00 00:00:00', NULL, 1),
(421, 21, NULL, 0, 'Amritsar', '0000-00-00 00:00:00', NULL, 1),
(422, 21, NULL, 0, 'Barnala', '0000-00-00 00:00:00', NULL, 1),
(423, 21, NULL, 0, 'Bathinda', '0000-00-00 00:00:00', NULL, 1),
(424, 21, NULL, 0, 'Faridkot', '0000-00-00 00:00:00', NULL, 1),
(425, 21, NULL, 0, 'Fatehgarh Sahib', '0000-00-00 00:00:00', NULL, 1),
(426, 21, NULL, 0, 'Ferozepur', '0000-00-00 00:00:00', NULL, 1),
(427, 21, NULL, 0, 'Fazilka', '0000-00-00 00:00:00', NULL, 1),
(428, 21, NULL, 0, 'Gurdaspur', '0000-00-00 00:00:00', NULL, 1),
(429, 21, NULL, 0, 'Hoshiarpur', '0000-00-00 00:00:00', NULL, 1),
(430, 21, NULL, 0, 'Jalandhar', '0000-00-00 00:00:00', NULL, 1),
(431, 21, NULL, 0, 'Kapurthala', '0000-00-00 00:00:00', NULL, 1),
(432, 21, NULL, 0, 'Ludhiana', '0000-00-00 00:00:00', NULL, 1),
(433, 21, NULL, 0, 'Mansa', '0000-00-00 00:00:00', NULL, 1),
(434, 21, NULL, 0, 'Moga', '0000-00-00 00:00:00', NULL, 1),
(435, 21, NULL, 0, 'Muktsar', '0000-00-00 00:00:00', NULL, 1),
(436, 21, NULL, 0, 'Pathankot', '0000-00-00 00:00:00', NULL, 1),
(437, 21, NULL, 0, 'Rupnagar', '0000-00-00 00:00:00', NULL, 1),
(438, 21, NULL, 0, 'Mohali', '0000-00-00 00:00:00', NULL, 1),
(439, 21, NULL, 0, 'Shahid Bhagat Singh Nagar/ Nawanshahr', '0000-00-00 00:00:00', NULL, 1),
(440, 21, NULL, 0, 'Tarn Taran', '0000-00-00 00:00:00', NULL, 1),
(441, 22, NULL, 0, 'Ajmer', '0000-00-00 00:00:00', NULL, 1),
(442, 22, NULL, 0, 'Alwar', '0000-00-00 00:00:00', NULL, 1),
(443, 22, NULL, 0, 'Banswara', '0000-00-00 00:00:00', NULL, 1),
(444, 22, NULL, 0, 'Baran', '0000-00-00 00:00:00', NULL, 1),
(445, 22, NULL, 0, 'Barmer', '0000-00-00 00:00:00', NULL, 1),
(446, 22, NULL, 0, 'Bharatpur', '0000-00-00 00:00:00', NULL, 1),
(447, 22, NULL, 0, 'Bhilwara', '0000-00-00 00:00:00', NULL, 1),
(448, 22, NULL, 0, 'Bikaner', '0000-00-00 00:00:00', NULL, 1),
(449, 22, NULL, 0, 'Bundi', '0000-00-00 00:00:00', NULL, 1),
(450, 22, NULL, 0, 'Chittorgarh', '0000-00-00 00:00:00', NULL, 1),
(451, 22, NULL, 0, 'Churu', '0000-00-00 00:00:00', NULL, 1),
(452, 22, NULL, 0, 'Dausa', '0000-00-00 00:00:00', NULL, 1),
(453, 22, NULL, 0, 'Dholpur', '0000-00-00 00:00:00', NULL, 1),
(454, 22, NULL, 0, 'Dungarpur', '0000-00-00 00:00:00', NULL, 1),
(455, 22, NULL, 0, 'Hanumangarh', '0000-00-00 00:00:00', NULL, 1),
(456, 22, NULL, 0, 'Jaipur', '0000-00-00 00:00:00', NULL, 1),
(457, 22, NULL, 0, 'Jaisalmer', '0000-00-00 00:00:00', NULL, 1),
(458, 22, NULL, 0, 'Jalor', '0000-00-00 00:00:00', NULL, 1),
(459, 22, NULL, 0, 'Jhalawar', '0000-00-00 00:00:00', NULL, 1),
(460, 22, NULL, 0, 'Jhunjhunu', '0000-00-00 00:00:00', NULL, 1),
(461, 22, NULL, 0, 'Jodhpur', '0000-00-00 00:00:00', NULL, 1),
(462, 22, NULL, 0, 'Karauli', '0000-00-00 00:00:00', NULL, 1),
(463, 22, NULL, 0, 'Kota', '0000-00-00 00:00:00', NULL, 1),
(464, 22, NULL, 0, 'Nagaur', '0000-00-00 00:00:00', NULL, 1),
(465, 22, NULL, 0, 'Pali', '0000-00-00 00:00:00', NULL, 1),
(466, 22, NULL, 0, 'Pratapgarh', '0000-00-00 00:00:00', NULL, 1),
(467, 22, NULL, 0, 'Rajsamand', '0000-00-00 00:00:00', NULL, 1),
(468, 22, NULL, 0, 'Sawai Madhopur', '0000-00-00 00:00:00', NULL, 1),
(469, 22, NULL, 0, 'Sikar  Sirohi', '0000-00-00 00:00:00', NULL, 1),
(470, 22, NULL, 0, 'Sri Ganganagar', '0000-00-00 00:00:00', NULL, 1),
(471, 22, NULL, 0, 'Tonk', '0000-00-00 00:00:00', NULL, 1),
(472, 22, NULL, 0, 'Udaipur', '0000-00-00 00:00:00', NULL, 1),
(473, 22, NULL, 0, 'Rajasthan', '0000-00-00 00:00:00', NULL, 1),
(474, 23, NULL, 0, 'East Sikkim', '0000-00-00 00:00:00', NULL, 1),
(475, 23, NULL, 0, 'North Sikkim', '0000-00-00 00:00:00', NULL, 1),
(476, 23, NULL, 0, 'South Sikkim', '0000-00-00 00:00:00', NULL, 1),
(477, 23, NULL, 0, 'West Sikkim', '0000-00-00 00:00:00', NULL, 1),
(478, 24, NULL, 0, 'Ariyalur', '0000-00-00 00:00:00', NULL, 1),
(479, 24, NULL, 0, 'Chennai', '0000-00-00 00:00:00', NULL, 1),
(480, 24, NULL, 0, 'Coimbatore', '0000-00-00 00:00:00', NULL, 1),
(481, 24, NULL, 0, 'Cuddalore', '0000-00-00 00:00:00', NULL, 1),
(482, 24, NULL, 0, 'Dharmapuri', '0000-00-00 00:00:00', NULL, 1),
(483, 24, NULL, 0, 'Dindigul', '0000-00-00 00:00:00', NULL, 1),
(484, 24, NULL, 0, 'Erode', '0000-00-00 00:00:00', NULL, 1),
(485, 24, NULL, 0, 'Kanchipuram', '0000-00-00 00:00:00', NULL, 1),
(486, 24, NULL, 0, 'Kanniyakumari', '0000-00-00 00:00:00', NULL, 1),
(487, 24, NULL, 0, 'Karur', '0000-00-00 00:00:00', NULL, 1),
(488, 24, NULL, 0, 'Krishnagiri', '0000-00-00 00:00:00', NULL, 1),
(489, 24, NULL, 0, 'Madurai', '0000-00-00 00:00:00', NULL, 1),
(490, 24, NULL, 0, 'Nagapattinam', '0000-00-00 00:00:00', NULL, 1),
(491, 24, NULL, 0, 'Namakkal', '0000-00-00 00:00:00', NULL, 1),
(492, 24, NULL, 0, 'Nilgiris', '0000-00-00 00:00:00', NULL, 1),
(493, 24, NULL, 0, 'Perambalur', '0000-00-00 00:00:00', NULL, 1),
(494, 24, NULL, 0, 'Pudukkottai', '0000-00-00 00:00:00', NULL, 1),
(495, 24, NULL, 0, 'Ramanathapuram', '0000-00-00 00:00:00', NULL, 1),
(496, 24, NULL, 0, 'Salem', '0000-00-00 00:00:00', NULL, 1),
(497, 24, NULL, 0, 'Sivaganga', '0000-00-00 00:00:00', NULL, 1),
(498, 24, NULL, 0, 'Thanjavur', '0000-00-00 00:00:00', NULL, 1),
(499, 24, NULL, 0, 'Theni', '0000-00-00 00:00:00', NULL, 1),
(500, 24, NULL, 0, 'Thoothukudi', '0000-00-00 00:00:00', NULL, 1),
(501, 24, NULL, 0, 'Thiruvarur', '0000-00-00 00:00:00', NULL, 1),
(502, 24, NULL, 0, 'Tirunelveli', '0000-00-00 00:00:00', NULL, 1),
(503, 24, NULL, 0, 'Tiruchirappalli', '0000-00-00 00:00:00', NULL, 1),
(504, 24, NULL, 0, 'Thiruvallur', '0000-00-00 00:00:00', NULL, 1),
(505, 24, NULL, 0, 'Tiruppur', '0000-00-00 00:00:00', NULL, 1),
(506, 24, NULL, 0, 'Tiruvannamalai', '0000-00-00 00:00:00', NULL, 1),
(507, 24, NULL, 0, ' Vellore', '0000-00-00 00:00:00', NULL, 1),
(508, 24, NULL, 0, 'Villupuram', '0000-00-00 00:00:00', NULL, 1),
(509, 24, NULL, 0, 'Virudhunagar', '0000-00-00 00:00:00', NULL, 1),
(510, 25, NULL, 0, 'Dhalai', '0000-00-00 00:00:00', NULL, 1),
(511, 25, NULL, 0, 'Gomati', '0000-00-00 00:00:00', NULL, 1),
(512, 25, NULL, 0, 'Khowai', '0000-00-00 00:00:00', NULL, 1),
(513, 25, NULL, 0, 'North Tripura', '0000-00-00 00:00:00', NULL, 1),
(514, 25, NULL, 0, 'Sipahijala', '0000-00-00 00:00:00', NULL, 1),
(515, 25, NULL, 0, 'South Tripura', '0000-00-00 00:00:00', NULL, 1),
(516, 25, NULL, 0, 'Unakoti', '0000-00-00 00:00:00', NULL, 1),
(517, 25, NULL, 0, 'West Tripura', '0000-00-00 00:00:00', NULL, 1),
(518, 26, NULL, 0, 'Agra', '0000-00-00 00:00:00', NULL, 1),
(519, 26, NULL, 0, 'Aligarh', '0000-00-00 00:00:00', NULL, 1),
(520, 26, NULL, 0, 'Allahabad', '0000-00-00 00:00:00', NULL, 1),
(521, 26, NULL, 0, 'Auraiya', '0000-00-00 00:00:00', NULL, 1),
(522, 26, NULL, 0, 'Azamgarh', '0000-00-00 00:00:00', NULL, 1),
(523, 26, NULL, 0, 'Baghpat', '0000-00-00 00:00:00', NULL, 1),
(524, 26, NULL, 0, 'Bahraich', '0000-00-00 00:00:00', NULL, 1),
(525, 26, NULL, 0, 'Ballia', '0000-00-00 00:00:00', NULL, 1),
(526, 26, NULL, 0, 'Balrampur', '0000-00-00 00:00:00', NULL, 1),
(527, 26, NULL, 0, 'Banda', '0000-00-00 00:00:00', NULL, 1),
(528, 26, NULL, 0, 'Barabanki', '0000-00-00 00:00:00', NULL, 1),
(529, 26, NULL, 0, 'Bareilly', '0000-00-00 00:00:00', NULL, 1),
(530, 26, NULL, 0, 'Basti', '0000-00-00 00:00:00', NULL, 1),
(531, 26, NULL, 0, 'Bijnor', '0000-00-00 00:00:00', NULL, 1),
(532, 26, NULL, 0, 'Budaun', '0000-00-00 00:00:00', NULL, 1),
(533, 26, NULL, 0, 'Bulandshahar', '0000-00-00 00:00:00', NULL, 1),
(534, 26, NULL, 0, 'Chandauli', '0000-00-00 00:00:00', NULL, 1),
(535, 26, NULL, 0, 'Chitrakoot', '0000-00-00 00:00:00', NULL, 1),
(536, 26, NULL, 0, 'Deoria', '0000-00-00 00:00:00', NULL, 1),
(537, 26, NULL, 0, 'Etah ', '0000-00-00 00:00:00', NULL, 1),
(538, 26, NULL, 0, 'Etawah', '0000-00-00 00:00:00', NULL, 1),
(539, 26, NULL, 0, 'Faizabad', '0000-00-00 00:00:00', NULL, 1),
(540, 26, NULL, 0, 'Farukkhabad', '0000-00-00 00:00:00', NULL, 1),
(541, 26, NULL, 0, 'Fatehpur', '0000-00-00 00:00:00', NULL, 1),
(542, 26, NULL, 0, 'Firozabad', '0000-00-00 00:00:00', NULL, 1),
(543, 26, NULL, 0, 'Gautam Buddha Nagar', '0000-00-00 00:00:00', NULL, 1),
(544, 26, NULL, 0, 'Ghaziabad', '0000-00-00 00:00:00', NULL, 1),
(545, 26, NULL, 0, 'Ghazipur', '0000-00-00 00:00:00', NULL, 1),
(546, 26, NULL, 0, 'Gonda', '0000-00-00 00:00:00', NULL, 1),
(547, 26, NULL, 0, 'Gorakhpur', '0000-00-00 00:00:00', NULL, 1),
(548, 26, NULL, 0, 'Hamirpur', '0000-00-00 00:00:00', NULL, 1),
(549, 26, NULL, 0, 'Hardoi', '0000-00-00 00:00:00', NULL, 1),
(550, 26, NULL, 0, 'Hathras', '0000-00-00 00:00:00', NULL, 1),
(551, 26, NULL, 0, 'Jalaun', '0000-00-00 00:00:00', NULL, 1),
(552, 26, NULL, 0, 'Jaunpur', '0000-00-00 00:00:00', NULL, 1),
(553, 26, NULL, 0, 'Jhansi', '0000-00-00 00:00:00', NULL, 1),
(554, 26, NULL, 0, 'Jyotiba Phoole Nagar', '0000-00-00 00:00:00', NULL, 1),
(555, 26, NULL, 0, 'Kannauj', '0000-00-00 00:00:00', NULL, 1),
(556, 26, NULL, 0, 'Kanpur Dehat', '0000-00-00 00:00:00', NULL, 1),
(557, 26, NULL, 0, 'Kanpur Nagar', '0000-00-00 00:00:00', NULL, 1),
(558, 26, NULL, 0, 'Kaushambi', '0000-00-00 00:00:00', NULL, 1),
(559, 26, NULL, 0, 'Kushi Nagar (Padrauna)', '0000-00-00 00:00:00', NULL, 1),
(560, 26, NULL, 0, 'Hathras', '0000-00-00 00:00:00', NULL, 1),
(561, 26, NULL, 0, ' Lakhimpur Kheri', '0000-00-00 00:00:00', NULL, 1),
(562, 26, NULL, 0, 'Lalitpur', '0000-00-00 00:00:00', NULL, 1),
(563, 26, NULL, 0, 'Lucknow', '0000-00-00 00:00:00', NULL, 1),
(564, 26, NULL, 0, 'Maharajganj', '0000-00-00 00:00:00', NULL, 1),
(565, 26, NULL, 0, 'Mahoba', '0000-00-00 00:00:00', NULL, 1),
(566, 26, NULL, 0, 'Mainpuri', '0000-00-00 00:00:00', NULL, 1),
(567, 26, NULL, 0, 'Mathura', '0000-00-00 00:00:00', NULL, 1),
(568, 26, NULL, 0, 'MAU', '0000-00-00 00:00:00', NULL, 1),
(569, 26, NULL, 0, 'Meerut', '0000-00-00 00:00:00', NULL, 1),
(570, 26, NULL, 0, 'Mirzapur', '0000-00-00 00:00:00', NULL, 1),
(571, 26, NULL, 0, 'Moradabad', '0000-00-00 00:00:00', NULL, 1),
(572, 26, NULL, 0, 'Muzaffar Nagar', '0000-00-00 00:00:00', NULL, 1),
(573, 26, NULL, 0, 'Pilibhit', '0000-00-00 00:00:00', NULL, 1),
(574, 26, NULL, 0, 'Pratapgarh', '0000-00-00 00:00:00', NULL, 1),
(575, 26, NULL, 0, 'Raebareli', '0000-00-00 00:00:00', NULL, 1),
(576, 26, NULL, 0, 'Rampur', '0000-00-00 00:00:00', NULL, 1),
(577, 26, NULL, 0, 'Saharanpur', '0000-00-00 00:00:00', NULL, 1),
(578, 26, NULL, 0, 'Sant Kabir Nagar', '0000-00-00 00:00:00', NULL, 1),
(579, 26, NULL, 0, 'Sant Ravidas Nagar', '0000-00-00 00:00:00', NULL, 1),
(580, 26, NULL, 0, 'Shahjahanpur', '0000-00-00 00:00:00', NULL, 1),
(581, 26, NULL, 0, 'Shravasti', '0000-00-00 00:00:00', NULL, 1),
(582, 26, NULL, 0, 'Siddharth Nagar', '0000-00-00 00:00:00', NULL, 1),
(583, 26, NULL, 0, 'Sitapur', '0000-00-00 00:00:00', NULL, 1),
(584, 26, NULL, 0, 'Sonbhadra', '0000-00-00 00:00:00', NULL, 1),
(585, 26, NULL, 0, 'Sultanpur', '0000-00-00 00:00:00', NULL, 1),
(586, 26, NULL, 0, 'Unnao', '0000-00-00 00:00:00', NULL, 1),
(587, 26, NULL, 0, 'Varanasi', '0000-00-00 00:00:00', NULL, 1),
(588, 27, NULL, 0, 'Almora', '0000-00-00 00:00:00', NULL, 1),
(589, 27, NULL, 0, 'Bageshwar', '0000-00-00 00:00:00', NULL, 1),
(590, 27, NULL, 0, 'Chamoli', '0000-00-00 00:00:00', NULL, 1),
(591, 27, NULL, 0, 'Champawat', '0000-00-00 00:00:00', NULL, 1),
(592, 27, NULL, 0, 'Dehradun', '0000-00-00 00:00:00', NULL, 1),
(593, 27, NULL, 0, 'Haridwar', '0000-00-00 00:00:00', NULL, 1),
(594, 27, NULL, 0, 'Nainital', '0000-00-00 00:00:00', NULL, 1),
(595, 27, NULL, 0, 'Pauri Garhwal', '0000-00-00 00:00:00', NULL, 1),
(596, 27, NULL, 0, 'Pithoragarh', '0000-00-00 00:00:00', NULL, 1),
(597, 27, NULL, 0, 'Rudra Prayag', '0000-00-00 00:00:00', NULL, 1),
(598, 27, NULL, 0, 'Udham Singh Nagar', '0000-00-00 00:00:00', NULL, 1),
(599, 27, NULL, 0, 'Uttarkashi', '0000-00-00 00:00:00', NULL, 1),
(600, 28, NULL, 0, 'Bankura', '0000-00-00 00:00:00', NULL, 1),
(601, 28, NULL, 0, 'Bardhaman', '0000-00-00 00:00:00', NULL, 1),
(602, 28, NULL, 0, 'Birbhum', '0000-00-00 00:00:00', NULL, 1),
(603, 28, NULL, 0, 'Cooch Behar', '0000-00-00 00:00:00', NULL, 1),
(604, 28, NULL, 0, 'Darjeeling', '0000-00-00 00:00:00', NULL, 1),
(605, 28, NULL, 0, 'East Midnapore', '0000-00-00 00:00:00', NULL, 1),
(606, 28, NULL, 0, 'Hooghly', '0000-00-00 00:00:00', NULL, 1),
(607, 28, NULL, 0, 'Howrah', '0000-00-00 00:00:00', NULL, 1),
(608, 28, NULL, 0, 'Maldah', '0000-00-00 00:00:00', NULL, 1),
(609, 28, NULL, 0, 'Murshidabad', '0000-00-00 00:00:00', NULL, 1),
(610, 28, NULL, 0, 'Nadia', '0000-00-00 00:00:00', NULL, 1),
(611, 28, NULL, 0, 'North 24 Parganas', '0000-00-00 00:00:00', NULL, 1),
(612, 28, NULL, 0, 'North Dinajpur', '0000-00-00 00:00:00', NULL, 1),
(613, 28, NULL, 0, 'Purulia', '0000-00-00 00:00:00', NULL, 1),
(614, 28, NULL, 0, 'South 24 Parganas', '0000-00-00 00:00:00', NULL, 1),
(615, 28, NULL, 0, 'South Dinajpur', '0000-00-00 00:00:00', NULL, 1),
(616, 28, NULL, 0, 'West Midnapore', '0000-00-00 00:00:00', NULL, 1),
(617, 15, NULL, 0, 'Chalisgaon', '0000-00-00 00:00:00', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `cityneighbourhoods`
--

CREATE TABLE `cityneighbourhoods` (
  `NeighbourhoodId` int(11) NOT NULL,
  `CityId` int(11) NOT NULL,
  `LocationName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `countrymaster`
--

CREATE TABLE `countrymaster` (
  `CountryId` int(11) NOT NULL,
  `CountryName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ISDCode` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `Culture` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `CurrencyCode` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `IsActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `countrymaster`
--

INSERT INTO `countrymaster` (`CountryId`, `CountryName`, `ISDCode`, `Culture`, `CurrencyCode`, `IsActive`) VALUES
(1, 'India', '0', '0', '0', 1);

-- --------------------------------------------------------

--
-- Table structure for table `featuresmaster`
--

CREATE TABLE `featuresmaster` (
  `FeatureId` bigint(11) NOT NULL,
  `ParentId` int(11) NOT NULL,
  `varFeatureName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `PageName` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `isSubMenu` bigint(20) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `varIcon` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `SortOrder` int(11) NOT NULL,
  `IsActive` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `featuresmaster`
--

INSERT INTO `featuresmaster` (`FeatureId`, `ParentId`, `varFeatureName`, `PageName`, `isSubMenu`, `CreatedDate`, `varIcon`, `SortOrder`, `IsActive`) VALUES
(1, 0, 'Masters', 'Masters', 0, '2016-05-31 00:00:00', 'fa fa-cogs', 1, 1),
(4, 1, 'AddFeature', '~/SK/MasterData/AddFeature.aspx', 1, '2016-06-01 00:00:00', '', 4, 1),
(5, 1, 'VendorServices', '~/SK/MasterData/VendorServices.aspx', 1, '2016-06-02 00:00:00', '', 5, 1),
(6, 1, 'VendorServicesTypes', '~/SK/MasterData/VendorServicesTypes.aspx', 1, '2016-06-03 00:00:00', '', 6, 1),
(7, 1, 'VendorServiceSubTypes', '~/SK/MasterData/VendorServiceSubTypes.aspx', 1, '2016-06-04 00:00:00', '', 7, 1),
(8, 0, 'Accounting', 'Accounting', 0, '2016-06-19 00:00:00', 'fa fa-money', 8, 1),
(9, 8, 'Add Accounts', '~/SK/Accounts/AddAccountName.aspx', 1, '2016-06-20 00:00:00', '', 9, 1),
(10, 8, 'Account Entries', '~/SK/Accounts/Entries.aspx', 1, '2016-06-21 00:00:00', '', 10, 1),
(11, 8, 'Ledger', '~/SK/Accounts/Ledger.aspx', 1, '2016-06-22 00:00:00', '', 11, 1),
(12, 8, 'Balance Sheet', '~/SK/Accounts/BalanceSheet.aspx', 1, '2016-06-23 00:00:00', '', 12, 1),
(13, 0, 'Society Details', 'Society Details', 0, '2016-07-04 00:00:00', 'fa fa-home', 13, 1),
(14, 13, 'Add Society', '~/SK/Society/AddSociety.aspx', 1, '2016-06-05 00:00:00', '', 14, 1),
(15, 13, 'View Society', '~/SK/View/Viewsociety.aspx', 1, '2016-06-05 00:00:00', '', 15, 1),
(16, 0, 'Vendor', 'Vendor', 0, '2016-07-04 00:00:00', 'fa fa-user', 16, 1),
(17, 16, 'Add Vendor', '~/SK/Vendors/AddVendor.aspx', 1, '2016-06-06 00:00:00', '', 17, 1),
(18, 16, 'View Vendor', '~/SK/Vendors/ViewVendor.aspx', 1, '2016-06-06 00:00:00', '', 18, 1),
(19, 0, 'Invoices', 'Invoices', 0, '2016-07-01 00:00:00', 'fa fa-inr', 19, 1),
(20, 19, 'Create Invoices', '~/SK/SocietyAccounts/CreateInvoice.aspx', 1, '2016-07-02 00:00:00', '', 20, 1),
(21, 19, 'View Invoices', '~/SK/SocietyAccounts/Invoices.aspx', 1, '2016-07-03 00:00:00', '', 21, 1),
(22, 0, 'Employee', 'Employee', 0, '2016-07-04 00:00:00', 'fa fa-user', 22, 1),
(23, 22, 'AssignRoleFeatures', '~/SK/Employee/AssignRoleFeatures.aspx', 1, '2016-06-15 00:00:00', '', 23, 1),
(24, 22, 'Add Employee', '~/SK/Employee/AddEmployee.aspx', 1, '2016-07-05 00:00:00', '', 24, 1),
(25, 22, 'View Empolyee ', '~/SK/Employee/ViewEmpolyee.aspx', 1, '2016-07-06 00:00:00', '', 25, 1),
(26, 0, 'Report', '~/SK/Reports/Dashboard.aspx', 0, '2016-07-07 00:00:00', 'fa fa-pie-chart', 26, 1),
(27, 0, 'Support', 'Support', 0, '2016-07-01 00:00:00', 'fa fa-inr', 27, 1),
(28, 27, 'Add Support', '~/SK/Support/Support.aspx', 1, '2016-06-06 00:00:00', '', 28, 1),
(29, 27, 'View Support', '~/SK/View/ViewSupport.aspx', 1, '2016-06-06 00:00:00', '', 29, 1),
(30, 0, 'Classified', '~/SK/View/ViewClassified.aspx', 0, '2016-06-05 00:00:00', 'fa fa-list-alt', 30, 1),
(31, 0, 'Enquiry', '~/SK/View/ViewEnquiry.aspx', 0, '2016-06-05 00:00:00', 'fa fa-calendar', 31, 1);

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

-- --------------------------------------------------------

--
-- Table structure for table `statemaster`
--

CREATE TABLE `statemaster` (
  `StateId` int(11) NOT NULL,
  `StateName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `CountryId` int(11) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `statemaster`
--

INSERT INTO `statemaster` (`StateId`, `StateName`, `CountryId`, `CreatedDate`, `CreatedBy`, `IsActive`) VALUES
(1, 'Andhra Pradesh', 1, '0000-00-00 00:00:00', 0, 1),
(2, 'Arunachal Pradesh', 1, '0000-00-00 00:00:00', 0, 1),
(3, 'Assam', 1, '0000-00-00 00:00:00', 0, 1),
(4, 'Bihar', 1, '0000-00-00 00:00:00', 0, 1),
(5, 'Chattisgardh', 1, '0000-00-00 00:00:00', 0, 1),
(6, 'Goa', 1, '0000-00-00 00:00:00', 0, 1),
(7, 'Gujarat', 1, '0000-00-00 00:00:00', 0, 1),
(8, 'Haryana', 1, '0000-00-00 00:00:00', 0, 1),
(9, 'Himachal Pradesh', 1, '0000-00-00 00:00:00', 0, 1),
(10, 'Jammu and Kashmir', 1, '0000-00-00 00:00:00', 0, 1),
(11, 'Jharkhand', 1, '0000-00-00 00:00:00', 0, 1),
(12, 'Karnataka', 1, '0000-00-00 00:00:00', 0, 1),
(13, 'Kerala', 1, '0000-00-00 00:00:00', 0, 1),
(14, 'Madhya Pradesh', 1, '0000-00-00 00:00:00', 0, 1),
(15, 'Maharashtra', 1, '0000-00-00 00:00:00', 0, 1),
(16, 'Manipur', 1, '0000-00-00 00:00:00', 0, 1),
(17, 'Meghalaya', 1, '0000-00-00 00:00:00', 0, 1),
(18, 'Mizoram', 1, '0000-00-00 00:00:00', 0, 1),
(19, 'Nagaland', 1, '0000-00-00 00:00:00', 0, 1),
(20, 'Orissa', 1, '0000-00-00 00:00:00', 0, 1),
(21, 'Punjab', 1, '0000-00-00 00:00:00', 0, 1),
(22, 'Rajastan', 1, '0000-00-00 00:00:00', 0, 1),
(23, 'Sikkim', 1, '0000-00-00 00:00:00', 0, 1),
(24, 'Tamil Nadu', 1, '0000-00-00 00:00:00', 0, 1),
(25, 'Tripura', 1, '0000-00-00 00:00:00', 0, 1),
(26, 'Uttar Pradesh', 1, '0000-00-00 00:00:00', 0, 1),
(27, 'Uttarakhand', 1, '0000-00-00 00:00:00', 0, 1),
(28, 'West Bengal', 1, '0000-00-00 00:00:00', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblaccountbook`
--

CREATE TABLE `tblaccountbook` (
  `intId` bigint(20) NOT NULL,
  `varDate` date NOT NULL,
  `varAccountNo` longtext NOT NULL,
  `varVoucher` longtext NOT NULL,
  `varReason` longtext NOT NULL,
  `varPreviousBalance` longtext NOT NULL,
  `varEntryType` tinyint(1) NOT NULL,
  `varAmount` longtext NOT NULL,
  `varBalance` longtext NOT NULL,
  `varEntryBy` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `ex1` longtext NOT NULL,
  `ex2` longtext NOT NULL,
  `ex3` longtext NOT NULL,
  `ex4` longtext NOT NULL,
  `ex5` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tblaccountbook`
--

INSERT INTO `tblaccountbook` (`intId`, `varDate`, `varAccountNo`, `varVoucher`, `varReason`, `varPreviousBalance`, `varEntryType`, `varAmount`, `varBalance`, `varEntryBy`, `ex1`, `ex2`, `ex3`, `ex4`, `ex5`) VALUES
(1, '2016-07-01', '5412', '152002', 'Saary', '0', 1, '70000', '70000', 'SKSK1234', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblaccountdetails`
--

CREATE TABLE `tblaccountdetails` (
  `intId` bigint(20) NOT NULL,
  `varAccountNo` longtext NOT NULL,
  `varAccountName` longtext NOT NULL,
  `varDescription` longtext NOT NULL,
  `ex1` longtext NOT NULL,
  `ex2` longtext NOT NULL,
  `ex3` longtext NOT NULL,
  `ex4` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tblaccountdetails`
--

INSERT INTO `tblaccountdetails` (`intId`, `varAccountNo`, `varAccountName`, `varDescription`, `ex1`, `ex2`, `ex3`, `ex4`) VALUES
(1, '7499', 'Program', '', '', '', '', ''),
(2, '6916', 'Managment', '', '', '', '', ''),
(3, '5412', 'Salary', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblenquiry`
--

CREATE TABLE `tblenquiry` (
  `intId` bigint(20) NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varServiceName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `adhar` longtext COLLATE utf8_unicode_ci NOT NULL,
  `pan` longtext COLLATE utf8_unicode_ci NOT NULL,
  `createdDate` date NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblenquiry`
--

INSERT INTO `tblenquiry` (`intId`, `varName`, `varMobile`, `varEmail`, `varServiceName`, `varDescription`, `adhar`, `pan`, `createdDate`, `ex4`) VALUES
(1, 'Diali', '748399329966', 'dipali.bhandare001@gmail.com', 'JH dlfdd', 'Sjkddfif', '', '', '2016-07-07', ''),
(2, 'Dipali ', '748399329966', 'dipali.bhandare001@gmail.com', 'Hjfgolgkfk65543 v', 'Fhkl', '', '', '2016-07-07', ''),
(3, 'Dipali ', '748399329966', 'dipali.bhandare001@gmail.com', 'Uddhmdhj2345', 'Tjhsfduk345667', '', '', '2016-07-07', ''),
(4, 'Dipali', '748399329966', 'dipali.bhandare001@gmail.com', 'Jjsddktr23457', 'Sjsfhmdd12457', '', '', '2016-07-07', ''),
(5, 'Dipali', '748399329966', 'dipali.bhandare001@gmail.com', 'Dyjjfi12447', 'Hsiohfj35', '', '', '2016-07-07', ''),
(6, 'Dipali ', '748399329966', 'dipali.bhandare001@gmail.com', 'Hhdfjh2456', 'Gsdgkk357', '', '', '2016-07-07', ''),
(7, 'Dipali ', '748399329966', 'dipali.bhandare001@gmail.com', 'He foyy245', 'Gajj35', '', '', '2016-07-07', ''),
(8, 'Dipali ', '748399329966', 'dipali.bhandare001@gmail.com', 'Bbj246', 'Shdgj2456', '', '', '2016-07-07', ''),
(9, 'Dipali ', '748399329966', 'dipali.bhandare001@gmail.com', 'Ghd24', 'DG gh135', '', '', '2016-07-07', ''),
(10, 'Adghj', '748399329966', 'dipali.bhandare001@gmail.com', 'Sdfghj356', 'Wsdg34', '', '', '2016-07-07', ''),
(11, 'jgjhg', '8678', 'po', 'yiyiyi8686868', 'jghjgjgj87686788', '', '', '2016-07-07', ''),
(12, '', '', 'po', '', '', '', '', '2016-07-07', ''),
(13, 'khjkjhk', '45454646', 'po', 'hkhkhkhk56522', 'kghjkghjhgjghj556556', '', '', '2016-07-07', ''),
(14, 'F hi', '748399329966', 'dipali.bhandare001@gmail.com', 'DDhhhhhauuwwr5667', 'Rtyvavbaksk26262', 'IMG-20160706-WA0000.jpg', 'IMG-20160706-WA0002.jpg', '2016-07-07', ''),
(15, 'petyr', '57656', 'opo', 'jghjgj789', 'hjkhkhk98797', '', '', '2016-07-08', ''),
(16, '', '', 'careers@societykatta.com', '', '', '', '', '2016-07-08', ''),
(17, 'ytutyu878', '77778', 'asd@gmail.com', '', '87878', '', '', '2016-07-08', ''),
(18, 'darmendr jiyalal pardeshi', '7719919163', 'dharma.pardeshi@gmail.com', 'electrician electrcal serviece', '', '1468654121057.jpg', '1468654155386.jpg', '2016-07-16', ''),
(19, 'Nagesh Pandurang Barge', '7588680490', 'visionpest@rediffmail.com', 'Vision Pest Management Services', '•	General Disinfestations Services (Cockroaches, Ants & Silverfish) \r\n•	Bed bugs Control Treatment    \r\n•	Pre & Post Construction Anti Termite Control Treatment\r\n•	Rodent Control Services\r\n•	Mosquito Control Treatment\r\n•	Flies Control Treatment\r\n•	Wood Borer Control Services\r\n•	Lizards & Spider Control Treatment\r\n•	Ticks Control Treatmen', 'IMG_20160802_182405.jpg', 'panCard.jpg', '2016-08-02', ''),
(20, 'Jinal Jain', '9421289989', 'Jinaljain1111@gmail.com', 'asdfghj', 'cvbnm', '', '', '2017-03-01', ''),
(21, 'Jinal Jain', '9421289989', 'Jinaljain1111@gmail.com', 'cvvbn', 'cvbn', '', '', '2017-03-02', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblinvoice`
--

CREATE TABLE `tblinvoice` (
  `intId` bigint(20) NOT NULL,
  `varInvoiceNo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDateTime` date NOT NULL,
  `varSubTotal` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDiscount` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varTax` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varOther` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varTotal` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex6` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex7` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblinvoice`
--

INSERT INTO `tblinvoice` (`intId`, `varInvoiceNo`, `varDateTime`, `varSubTotal`, `varDiscount`, `varTax`, `varOther`, `varTotal`, `ex1`, `ex2`, `ex3`, `ex4`, `ex5`, `ex6`, `ex7`) VALUES
(1, 'SKSI3605286', '2016-07-01', '1200', 'NA', 'NA', 'NA', '1200', '', '', '', '', '', '', ''),
(2, 'SKSI2659477', '2016-07-09', '3444', 'NA', 'NA', 'NA', '3444', '', '', '', '', '', '', ''),
(3, 'SKSI1402031', '2016-07-09', '3444', 'NA', 'NA', 'NA', '3444', '', '', '', '', '', '', ''),
(4, 'SKSI4564481', '2016-07-20', '2222', 'NA', 'NA', 'NA', '2222', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblinvoicedetails`
--

CREATE TABLE `tblinvoicedetails` (
  `intId` bigint(20) NOT NULL,
  `varInvoiceId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varParticulars` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAttachment` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAmount` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex6` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex7` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblinvoicedetails`
--

INSERT INTO `tblinvoicedetails` (`intId`, `varInvoiceId`, `varParticulars`, `varAttachment`, `varAmount`, `ex1`, `ex2`, `ex3`, `ex4`, `ex5`, `ex6`, `ex7`) VALUES
(1, 'SKSI3605286', 'Renewal', 'NA', '1200', '', '', '', '', '', '', ''),
(2, 'SKSI2659477', 'pay', 'NA', '3333', '', '', '', '', '', '', ''),
(3, 'SKSI2659477', 'pay', 'NA', '111', '', '', '', '', '', '', ''),
(4, 'SKSI1402031', 'pay', 'NA', '3333', '', '', '', '', '', '', ''),
(5, 'SKSI1402031', 'pay', 'NA', '111', '', '', '', '', '', '', ''),
(6, 'SKSI4564481', 'dd', 'NA', '2222', '', '', '', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblinvoiceforsocietyorvendors`
--

CREATE TABLE `tblinvoiceforsocietyorvendors` (
  `intId` bigint(20) NOT NULL,
  `varSocietyOrVendor` bigint(20) NOT NULL,
  `varPersonnelId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varInvoiceId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varRecieved` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varOutstanding` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPaymentStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varTransactionId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varTransactionStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPaymode` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varInvoiceStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblinvoiceforsocietyorvendors`
--

INSERT INTO `tblinvoiceforsocietyorvendors` (`intId`, `varSocietyOrVendor`, `varPersonnelId`, `varInvoiceId`, `varRecieved`, `varOutstanding`, `varPaymentStatus`, `varTransactionId`, `varTransactionStatus`, `varPaymode`, `varInvoiceStatus`, `ex1`, `ex2`, `ex3`, `ex4`) VALUES
(1, 2, 'SKS9194840', 'SKSI3605286', '1200.0', '0', 'Paid', '35ac6bf5e02a1e9b1ba7', 'success', 'Internet Banking', 'Paid', '', '', '', ''),
(2, 2, 'SKS7306312', 'SKSI2659477', '0', '3444', 'Pending', '0', 'Started', 'NA', 'Started', '', '', '', ''),
(3, 2, 'SKS7306312', 'SKSI1402031', '0', '3444', 'Pending', '0', 'Started', 'NA', 'Started', '', '', '', ''),
(4, 2, 'SKS6430159', 'SKSI1402031', '0', '3444', 'Pending', '0', 'Started', 'NA', 'Started', '', '', '', ''),
(5, 2, 'SKS647980', 'SKSI4564481', '2222.0', '0', 'Paid', '8dfa48611189a659caca', 'success', 'Internet Banking', 'Paid', '', '', '', '');

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

-- --------------------------------------------------------

--
-- Table structure for table `tblskhelp`
--

CREATE TABLE `tblskhelp` (
  `intId` bigint(20) NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varSub` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDate` date NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblskpersonnel`
--

CREATE TABLE `tblskpersonnel` (
  `intId` bigint(20) NOT NULL,
  `intEmpCode` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intDeptId` bigint(20) NOT NULL,
  `intRole` bigint(20) NOT NULL,
  `intEmpType` int(11) NOT NULL,
  `varEmpName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMaritalStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varFatherHusband` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDateOfJoin` date NOT NULL,
  `varDOB` date NOT NULL,
  `varGender` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMbPrimary` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMbOther` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEmailOther` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPANNo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPFNo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varESINo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intCountry` bigint(20) NOT NULL,
  `intState` bigint(20) NOT NULL,
  `intCity` bigint(20) NOT NULL,
  `varPin` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAddress` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPermanentAddress` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPrimaryEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varUsername` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPassword` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varImage` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `intCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblskpersonnel`
--

INSERT INTO `tblskpersonnel` (`intId`, `intEmpCode`, `intDeptId`, `intRole`, `intEmpType`, `varEmpName`, `varMaritalStatus`, `varFatherHusband`, `varDateOfJoin`, `varDOB`, `varGender`, `varMbPrimary`, `varMbOther`, `varEmailOther`, `varPANNo`, `varPFNo`, `varESINo`, `intCountry`, `intState`, `intCity`, `varPin`, `varAddress`, `varPermanentAddress`, `varPrimaryEmail`, `varUsername`, `varPassword`, `varMobile`, `varImage`, `intIsActive`, `intCreatedBy`, `varCreatedDate`, `ex1`, `ex2`, `ex3`) VALUES
(1, 'SKSK1234', 3, 6, 0, 'Jyoti Patil', 'Unmarried', 'Valmik Patil', '2016-06-01', '2016-08-19', 'Female', '9403304696', '9403910390', 'jyotipatil612@hotmail.com', '1111111111111', '4444', '7777', 1, 15, 324, '425001', 'Flat No. 1, Akshay Chambers, Samarth Colony, Near Prabhat Chowk, Jalgaon Maharashtra (India).', 'Flat No. 1, Akshay Chambers, Samarth Colony, Near Prabhat Chowk, Jalgaon Maharashtra (India).', 'jyotipatil612@hotmail.com', 'support', '1', '7066660206', '', 1, '', '2016-06-01', '', '', ''),
(3, 'SKSE9937259', 3, 7, 1, 'Jyoti', 'Unmarried', 'Valmik', '2016-07-24', '2016-07-19', 'Female', '9696969696', '', '', '', '', '', 1, 15, 330, '', '', '', 'jyotipatl612@hotmail.com', 'jyotipatl612@hotmail.com', '123', '9696969696', 'NoProfile.png', 1, '1', '2016-07-01', '', '', ''),
(4, 'SKSE7129145', 3, 7, 1, 'Dipali Bhandare', 'Unmarried', 'Pramod', '2016-06-13', '1993-02-02', 'Female', '9561756988', '', 'dipali.bhandare001@gmail.com', '', '', '', 1, 15, 342, '425412', '76 A Namaskar Colony Near Maruti Suzuki Showroom', '76 A Namaskar Colony Near Maruti Suzuki Showroom', 'dipali.bhandare001@gmail.com', 'dipali.bhandare001@gmail.com', '123', '9561756988', 'NoProfile.png', 1, '1', '2016-07-01', '', '', ''),
(5, 'SKSE8772722', 1, 3, 1, 'Sejal Patil', 'Unmarried', 'Nitin', '2016-07-07', '1994-02-17', 'Female', '8421084949', '', 'careers@societykatta.com', '', '', '', 1, 15, 334, '425201', 'Aanad nagar Jamner road bhusawal', 'Aanad nagar Jamner road bhusawal', 'careers@societykatta.com', 'careers@societykatta.com', 'p1', '8421084949', 'NoProfile.png', 1, '1', '2016-07-07', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblsksupport`
--

CREATE TABLE `tblsksupport` (
  `intId` bigint(20) NOT NULL,
  `varPersonneId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intPersonelRole` bigint(20) NOT NULL,
  `varDate` date NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varUsername` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varSubject` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varRemark` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `citymaster`
--
ALTER TABLE `citymaster`
  ADD PRIMARY KEY (`CityId`),
  ADD KEY `FK_CityMaster_StateMaster` (`StateId`),
  ADD KEY `FK_CityMaster_Timezones` (`TimeZoneId`);

--
-- Indexes for table `cityneighbourhoods`
--
ALTER TABLE `cityneighbourhoods`
  ADD PRIMARY KEY (`NeighbourhoodId`);

--
-- Indexes for table `countrymaster`
--
ALTER TABLE `countrymaster`
  ADD PRIMARY KEY (`CountryId`);

--
-- Indexes for table `featuresmaster`
--
ALTER TABLE `featuresmaster`
  ADD PRIMARY KEY (`FeatureId`);

--
-- Indexes for table `rolefeaturesmap`
--
ALTER TABLE `rolefeaturesmap`
  ADD KEY `FK_RoleFeaturesMap_FeaturesMaster` (`FeatureId`),
  ADD KEY `FK_RoleFeaturesMap_RolesMaster` (`RoleId`);

--
-- Indexes for table `rolesmaster`
--
ALTER TABLE `rolesmaster`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `statemaster`
--
ALTER TABLE `statemaster`
  ADD PRIMARY KEY (`StateId`);

--
-- Indexes for table `tblaccountbook`
--
ALTER TABLE `tblaccountbook`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblaccountdetails`
--
ALTER TABLE `tblaccountdetails`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblinvoice`
--
ALTER TABLE `tblinvoice`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblinvoicedetails`
--
ALTER TABLE `tblinvoicedetails`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblinvoiceforsocietyorvendors`
--
ALTER TABLE `tblinvoiceforsocietyorvendors`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblskdepartment`
--
ALTER TABLE `tblskdepartment`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblskhelp`
--
ALTER TABLE `tblskhelp`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblskpersonnel`
--
ALTER TABLE `tblskpersonnel`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblsksupport`
--
ALTER TABLE `tblsksupport`
  ADD PRIMARY KEY (`intId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `citymaster`
--
ALTER TABLE `citymaster`
  MODIFY `CityId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=618;
--
-- AUTO_INCREMENT for table `cityneighbourhoods`
--
ALTER TABLE `cityneighbourhoods`
  MODIFY `NeighbourhoodId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `countrymaster`
--
ALTER TABLE `countrymaster`
  MODIFY `CountryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `rolesmaster`
--
ALTER TABLE `rolesmaster`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `statemaster`
--
ALTER TABLE `statemaster`
  MODIFY `StateId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `tblaccountbook`
--
ALTER TABLE `tblaccountbook`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tblaccountdetails`
--
ALTER TABLE `tblaccountdetails`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `tblinvoice`
--
ALTER TABLE `tblinvoice`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `tblinvoicedetails`
--
ALTER TABLE `tblinvoicedetails`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tblinvoiceforsocietyorvendors`
--
ALTER TABLE `tblinvoiceforsocietyorvendors`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tblskdepartment`
--
ALTER TABLE `tblskdepartment`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tblskhelp`
--
ALTER TABLE `tblskhelp`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblskpersonnel`
--
ALTER TABLE `tblskpersonnel`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tblsksupport`
--
ALTER TABLE `tblsksupport`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
