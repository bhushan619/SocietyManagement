-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 50.62.209.38:3306
-- Generation Time: Apr 04, 2017 at 11:04 PM
-- Server version: 5.5.43-37.2-log
-- PHP Version: 5.5.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `anuvaa_services`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`services`@`%` PROCEDURE `sp_Delete_VendorService` (IN `spintServiceCode` INT)  BEGIN
DELETE FROM `tblvendorservices` WHERE `intServiceCode`=spintServiceCode;
DELETE FROM `tblvendorservicestype` WHERE `intServiceCode`=spintServiceCode;
DELETE FROM `tblvendorservicesubtype` WHERE `intServiceCode`=spintServiceCode;

END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_Delete_VendorServiceSubType` (IN `spintServicesubtypeCode` INT)  BEGIN

DELETE FROM `tblvendorservicesubtype` WHERE intServicesubtypeCode=spintServicesubtypeCode ;
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_Delete_VendorServiceType` (IN `spintServicetypeCode` INT)  BEGIN
DELETE FROM `tblvendorservicestype` WHERE `intServicetypeCode`=spintServicetypeCode;
DELETE FROM `tblvendorservicesubtype` WHERE `intServicetypeCode`=spintServicetypeCode;
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_insert_Order` (IN `intCustId` TEXT, IN `varVendorId` TEXT, IN `intServiceID` TEXT, IN `varOrderCreatedDate` TEXT, IN `varOrderDate` TEXT, IN `varOrderTime` TEXT, IN `intCountryId` TEXT, IN `intStateId` TEXT, IN `intCityId` TEXT, IN `varAddress` TEXT, IN `intNeighbourhood` TEXT, IN `varAmount` TEXT, IN `varRecieved` TEXT, IN `varPaymentStatus` TEXT, IN `varTransactionId` TEXT, IN `varTransactionStatus` TEXT, IN `varPaymode` TEXT, IN `varOrderStatus` TEXT)  BEGIN

 SELECT @invoiceid:= concat("SKSSI", FLOOR(RAND()*9567242));

INSERT INTO `tblorder`(`intOrderId`, `intCustId`, `varVendorId`,intServiceID, `varOrderCreatedDate`, `varOrderDate`, `varOrderTime`, `intCountryId`, `intStateId`, `intCityId`, `varAddress`, `intNeighbourhood`, `varAmount`, `varRecieved`, `varPaymentStatus`, `varTransactionId`, `varTransactionStatus`, `varPaymode`, `varOrderStatus`)
values
(  @invoiceid,  `intCustId`, `varVendorId`,intServiceID, `varOrderCreatedDate`, `varOrderDate`, `varOrderTime`, `intCountryId`, `intStateId`, `intCityId`, `varAddress`, `intNeighbourhood`, `varAmount`, `varRecieved`, `varPaymentStatus`, `varTransactionId`, `varTransactionStatus`, `varPaymode`, `varOrderStatus`);

 

END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_insert_Vendor` (IN `varName` TEXT, IN `varContactPerson` TEXT, IN `varPhoneNo` TEXT, IN `varMobileNo` TEXT, IN `varEmailId` TEXT, IN `varCountry` TEXT, IN `varState` TEXT, IN `varCity` TEXT, IN `varAddress` TEXT, IN `varNeighbourhood` TEXT, IN `varPincode` TEXT, IN `varUsername` TEXT, IN `varPassword` TEXT, IN `varCreatedDate` TEXT, IN `CreatedBy` TEXT, IN `varIsActive` TEXT, IN `varAbout` TEXT, IN `varImage` TEXT, IN `varCharges` TEXT, IN `varDescription` TEXT, IN `intServiceId` TEXT)  BEGIN

 SELECT @VendorCode:= concat("SKSV", FLOOR(RAND()*9567242));

 INSERT INTO tblvendor(intVendorCode, varName, varContactPerson, varPhoneNo, varMobileNo, varEmailId, varCountry, varState, varCity, varAddress, varNeighbourhood, varPincode, varUsername, varPassword, varCreatedDate, CreatedBy, varIsActive) 
 VALUES 
 ( @VendorCode, varName, varContactPerson, varPhoneNo, varMobileNo, varEmailId, varCountry, varState, varCity, varAddress, varNeighbourhood, varPincode, varUsername, varPassword, varCreatedDate, CreatedBy, varIsActive) ;

 INSERT INTO `tblvendorabout`(`varVendorId`, `varAbout`, `varImage`) 
 VALUES
  (@VendorCode, varAbout, varImage) ;
INSERT INTO `tblvendordescription`(`varVendorId`, `varCharges`, `varDescription`) 
VALUES 
(@VendorCode, varCharges, varDescription) ;
INSERT INTO `tblvendorofferedservices`(`varVendorId`, `intServiceId`) 
VALUES 
(@VendorCode, intServiceId) ;

INSERT INTO `tblreviews`(`intOrderId`,`varVendorId`, `varCustomerId`, `intRating`, `varReview`, `intOnTime`, `intQuality`) 
VALUES 
(0,@VendorCode, 1, 3,'Good Service an on time presence..', 1,1);
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_insert_VendorService` (IN `spServiceCode` INT, IN `spName` TEXT, IN `spDescription` TEXT, IN `spVisitingFee` TEXT, IN `spRemark` TEXT, IN `spCreatedBy` TEXT, IN `spIsActive` TEXT, IN `spvarImage` TEXT, IN `rValue` TEXT)  BEGIN
IF EXISTS (SELECT * FROM tblvendorservices WHERE varName=spName) 
THEN 
 set rValue=0;
ELSE 
	INSERT INTO tblvendorservices(intServiceCode,  varName, varDescription, varVisitingFee, varRemark, CreatedDate, CreatedBy, varIsActive,varImage) 
	VALUES 	(spServiceCode,spName,spDescription,spVisitingFee,spRemark,convert_tz(now() , @@session.time_zone,'+05:30'),spCreatedBy,spIsActive,spvarImage);
   END IF;
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_insert_VendorServiceSubType` (IN `spintServicesubtypeCode` INT, IN `spSevicetypeCode` INT, IN `spServiceCode` INT, IN `spName` TEXT, IN `spPrice` TEXT, IN `spDescription` TEXT, IN `spRemark` TEXT, IN `spCreatedBy` TEXT, IN `spIsActive` TEXT, IN `rValue` TEXT)  BEGIN
IF EXISTS (SELECT * FROM tblvendorservicesubtype WHERE varName=spName and intSevicetypeCode=spSevicetypeCode) 
THEN 
 set rValue=0;
ELSE 
INSERT INTO `tblvendorservicesubtype`( intServicesubtypeCode, `intServiceCode`,	intSevicetypeCode, `varName`,varPrice, `varDescription`, `varRemark`, `CreatedDate`, `CreatedBy`, `varIsActive`) 
	VALUES 	(spintServicesubtypeCode,spServiceCode,spSevicetypeCode,spName,spPrice,spDescription,spRemark,convert_tz(now() , @@session.time_zone,'+05:30'),spCreatedBy,spIsActive);
   END IF;
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_insert_VendorServiceType` (IN `spServicetypeCode` INT, IN `spServiceCode` INT, IN `spName` TEXT, IN `spDescription` TEXT, IN `spRemark` TEXT, IN `spCreatedBy` TEXT, IN `spIsActive` TEXT, IN `rValue` TEXT)  BEGIN
IF EXISTS (SELECT * FROM tblvendorservicestype WHERE varName=spName) 
THEN 
 set rValue=0;
ELSE 
INSERT INTO `tblvendorservicestype`( `intServicetypeCode`, `intServiceCode`, `varName`, `varDescription`, `varRemark`, `CreatedDate`, `CreatedBy`, `varIsActive`) 
	VALUES 	(spServicetypeCode,spServiceCode,spName,spDescription,spRemark,convert_tz(now() , @@session.time_zone,'+05:30'),spCreatedBy,spIsActive);
   END IF;
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_select_Vendor` ()  BEGIN
SELECT        tblvendor.varName AS Name, tblvendor.varContactPerson AS `Contact Person`, tblvendorabout.varAbout AS `About Us`, tblvendordescription.varCharges AS Charges, 
                         tblvendordescription.varDescription AS Description, tblvendorservices.varName AS `Service Name`, tblvendorabout.varImage AS Image, 
                         tblvendor.varPhoneNo AS `Ph no`, tblvendor.varMobileNo AS Mobile, tblvendor.varEmailId AS Email, tblvendor.varAddress AS Address, 
                         tblvendor.varNeighbourhood AS Neighbourhood, tblvendor.varPincode AS PIN, tblvendor.varIsActive, citymaster.CityName, countrymaster.CountryName, 
                         statemaster.StateName, tblvendor.intId, tblvendor.intVendorCode
FROM            tblvendor INNER JOIN
                         tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN
                         tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN
                         tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN
                         tblvendorservices ON tblvendorofferedservices.intServiceId = tblvendorservices.intServiceCode INNER JOIN
                         citymaster ON tblvendor.varCity = citymaster.CityId INNER JOIN
                         countrymaster ON tblvendor.varCountry = countrymaster.CountryId INNER JOIN
                         statemaster ON tblvendor.varState = statemaster.StateId order BY tblvendor.intId desc
;
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_select_VendorById` (IN `spintVendorCode` TEXT)  BEGIN
SELECT        tblvendor.varName AS Name, tblvendor.varContactPerson AS varContactPerson, tblvendorabout.varAbout AS varAbout, tblvendordescription.varCharges AS Charges, 
                         tblvendordescription.varDescription AS Description, tblvendorservices.intServiceCode AS ServicevarName, tblvendorabout.varImage AS varImage, 
                         tblvendor.varPhoneNo AS varPhoneNo, tblvendor.varMobileNo AS varMobileNo, tblvendor.varEmailId AS varEmailId, tblvendor.varAddress AS varAddress, 
                         tblvendor.varNeighbourhood AS varNeighbourhood, tblvendor.varPincode AS varPincode, tblvendor.varIsActive, citymaster.CityName, countrymaster.CountryName, 
                         statemaster.StateName, tblvendor.intId, tblvendor.intVendorCode, tblvendor.varCountry, tblvendor.varState, tblvendor.varCity, tblvendor.varName,tblvendor.varUsername, tblvendor.varPassword,tblvendor.varCreatedDate, 
                         tblvendor.CreatedBy, tblvendor.varIsActive
FROM            tblvendor INNER JOIN
                         tblvendorabout ON tblvendor.intVendorCode = tblvendorabout.varVendorId INNER JOIN
                         tblvendordescription ON tblvendor.intVendorCode = tblvendordescription.varVendorId INNER JOIN
                         tblvendorofferedservices ON tblvendor.intVendorCode = tblvendorofferedservices.varVendorId INNER JOIN
                         tblvendorservices ON tblvendorofferedservices.intServiceId = tblvendorservices.intServiceCode INNER JOIN
                         citymaster ON tblvendor.varCity = citymaster.CityId INNER JOIN
                         countrymaster ON tblvendor.varCountry = countrymaster.CountryId INNER JOIN
                         statemaster ON tblvendor.varState = statemaster.StateId
WHERE tblvendor.intId=spintVendorCode; 
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_select_VendorService` (IN `spIsActive` INT)  BEGIN
SELECT intId, intServiceCode,varName,varDescription,varVisitingFee,varRemark,CreatedDate,CreatedBy,varIsActive FROM tblvendorservices WHERE varIsActive = spIsActive; 
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_select_VendorServiceById` (IN `spintServiceCode` INT)  BEGIN
SELECT        intId, intServiceCode, varName, varDescription, varRemark, varVisitingFee, varIsActive, varImage, CreatedBy, CreatedDate
FROM            tblvendorservices WHERE        (intServiceCode = spintServiceCode);
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_select_VendorServiceSubType` ()  BEGIN
SELECT        tblvendorservicesubtype.intSevicetypeCode,tblvendorservices.intServiceCode, tblvendorservices.varName AS Service, tblvendorservicestype.varName AS Type, tblvendorservicesubtype.varName AS SubType,
                          tblvendorservicesubtype.varPrice, tblvendorservicesubtype.varIsActive, tblvendorservicesubtype.intServicesubtypeCode
FROM            tblvendorservices INNER JOIN
                         tblvendorservicestype ON tblvendorservices.intServiceCode = tblvendorservicestype.intServiceCode INNER JOIN
                         tblvendorservicesubtype ON tblvendorservicestype.intServicetypeCode = tblvendorservicesubtype.intSevicetypeCode
; 
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_select_VendorServiceSubTypeById` (IN `spintServicesubtypeCode` INT)  BEGIN
SELECT        tblvendorservices.intServiceCode, tblvendorservices.varName AS Service,tblvendorservicesubtype.intSevicetypeCode, tblvendorservicestype.varName AS Type, tblvendorservicesubtype.varName AS SubType,
                          tblvendorservicesubtype.varPrice, tblvendorservicesubtype.varIsActive, tblvendorservicesubtype.intServicesubtypeCode,tblvendorservicesubtype.varDescription,tblvendorservicesubtype.varRemark,
						  tblvendorservicesubtype.CreatedDate,tblvendorservicesubtype.CreatedBy
FROM            tblvendorservices INNER JOIN
                         tblvendorservicestype ON tblvendorservices.intServiceCode = tblvendorservicestype.intServiceCode INNER JOIN
                         tblvendorservicesubtype ON tblvendorservicestype.intServicetypeCode = tblvendorservicesubtype.intSevicetypeCode
WHERE        (tblvendorservicesubtype.intServicesubtypeCode =  spintServicesubtypeCode); 
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_select_VendorServiceType` ()  BEGIN
SELECT        tblvendorservices.varName AS Service, tblvendorservicestype.intId, tblvendorservicestype.intServicetypeCode, tblvendorservicestype.intServiceCode, 
                         tblvendorservicestype.varName AS Type, tblvendorservicestype.varDescription, tblvendorservicestype.varRemark, tblvendorservicestype.CreatedDate, 
                         tblvendorservicestype.CreatedBy, tblvendorservicestype.varIsActive
FROM            tblvendorservices INNER JOIN
                         tblvendorservicestype ON tblvendorservices.intServiceCode = tblvendorservicestype.intServiceCode;

END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_select_VendorServiceTypeById` (IN `spintServicetypeCode` INT)  BEGIN
SELECT        tblvendorservices.varName AS Service, tblvendorservicestype.intId, tblvendorservicestype.intServicetypeCode, tblvendorservicestype.intServiceCode, 
                         tblvendorservicestype.varName AS Type, tblvendorservicestype.varDescription, tblvendorservicestype.varRemark, tblvendorservicestype.CreatedDate, 
                         tblvendorservicestype.CreatedBy, tblvendorservicestype.varIsActive
FROM            tblvendorservices INNER JOIN
                         tblvendorservicestype ON tblvendorservices.intServiceCode = tblvendorservicestype.intServiceCode
WHERE        (tblvendorservicestype.intServicetypeCode =  spintServicetypeCode); 
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_select_VendorServiceTypeByService` (IN `spServiceCode` INT)  BEGIN
SELECT        tblvendorservices.intServiceCode, tblvendorservicestype.intServicetypeCode, tblvendorservices.varName AS Service, 
                         tblvendorservicestype.varName AS Type
FROM            tblvendorservices INNER JOIN
                         tblvendorservicestype ON tblvendorservices.intServiceCode = tblvendorservicestype.intServiceCode
WHERE        (tblvendorservices.intServiceCode =  spServiceCode); 
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_Update_Vendor` (IN `spVendorCode` TEXT, IN `spFirstName` TEXT, IN `spContactPerson` TEXT, IN `spPhoneNo` TEXT, IN `spMobileNo` TEXT, IN `spEmailId` TEXT, IN `spCountry` TEXT, IN `spState` TEXT, IN `spCity` TEXT, IN `spPincode` TEXT, IN `spAddress` TEXT, IN `spNeighbourhood` TEXT, IN `spIsActive` TEXT, IN `varAbout` TEXT, IN `varImage` TEXT, IN `varCharges` TEXT, IN `varDescription` TEXT, IN `intServiceId` TEXT)  BEGIN
UPDATE `tblvendor` SET  `varName`=spFirstName,`varContactPerson`=spContactPerson,`varPhoneNo`=spPhoneNo,`varMobileNo`=spMobileNo,`varEmailId`=spEmailId,`varCountry`=spCountry,`varState`=spState,`varCity`=spCity,`varPincode`=spPincode,`varAddress`=spAddress,`varNeighbourhood`=spNeighbourhood,`varIsActive`=spIsActive WHERE  intId= spVendorCode;

UPDATE `tblvendorofferedservices` SET  `intServiceId`=intServiceId  WHERE `intId`=spVendorCode;

UPDATE `tblvendorabout` SET `varAbout`=varAbout ,`varImage`=varImage WHERE `intId`=spVendorCode;

UPDATE `tblvendordescription` SET  `varCharges`=varCharges,`varDescription`=varDescription WHERE `intId`=spVendorCode;
END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_Update_VendorService` (IN `spServiceCode` INT, IN `spName` TEXT, IN `spDescription` TEXT, IN `spRemark` TEXT, IN `spVisitingFee` TEXT, IN `spIsActive` TEXT, IN `spvarImage` TEXT)  BEGIN

UPDATE `tblvendorservices` SET varName= spName, varDescription=spDescription,varRemark=spRemark, varVisitingFee =spVisitingFee,varIsActive=spIsActive,varImage=spvarImage WHERE  intServiceCode= spServiceCode;

END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_Update_VendorServiceSubType` (IN `spServicesubtypeCode` INT, IN `spServicetypeCode` INT, IN `spServiceCode` INT, IN `spName` TEXT, IN `spPrice` TEXT, IN `spDescription` TEXT, IN `spRemark` TEXT, IN `spIsActive` TEXT)  BEGIN

UPDATE `tblvendorservicesubtype` SET intServicesubtypeCode= spServicesubtypeCode,intSevicetypeCode=spServicetypeCode,intServiceCode= spServiceCode,varName= spName,varPrice=spPrice, varDescription=spDescription,varRemark=spRemark,varIsActive=spIsActive WHERE intServicesubtypeCode= spServicesubtypeCode;

END$$

CREATE DEFINER=`services`@`%` PROCEDURE `sp_Update_VendorServiceType` (IN `spServicetypeCode` INT, IN `spServiceCode` INT, IN `spName` TEXT, IN `spDescription` TEXT, IN `spRemark` TEXT, IN `spIsActive` TEXT)  BEGIN

UPDATE `tblvendorservicestype` SET intServiceCode= spServiceCode,varName= spName, varDescription=spDescription,varRemark=spRemark,varIsActive=spIsActive WHERE intServicetypeCode= spServicetypeCode;

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
-- Table structure for table `tblcustomer`
--

CREATE TABLE `tblcustomer` (
  `intId` bigint(20) NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci,
  `varMobile` longtext COLLATE utf8_unicode_ci,
  `varMobileVerify` longtext COLLATE utf8_unicode_ci,
  `varEmail` longtext COLLATE utf8_unicode_ci,
  `varEmailVerify` longtext COLLATE utf8_unicode_ci,
  `varAddress` longtext COLLATE utf8_unicode_ci,
  `varPassword` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varLandline` longtext COLLATE utf8_unicode_ci,
  `varLandmark` longtext COLLATE utf8_unicode_ci,
  `varCountry` longtext COLLATE utf8_unicode_ci,
  `varState` longtext COLLATE utf8_unicode_ci,
  `varCity` longtext COLLATE utf8_unicode_ci,
  `varNeighbourhood` bigint(20) NOT NULL,
  `varStatus` longtext COLLATE utf8_unicode_ci,
  `imgImage` longtext COLLATE utf8_unicode_ci,
  `ex1` longtext COLLATE utf8_unicode_ci,
  `ex2` longtext COLLATE utf8_unicode_ci,
  `ex3` longtext COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblcustomer`
--

INSERT INTO `tblcustomer` (`intId`, `varName`, `varMobile`, `varMobileVerify`, `varEmail`, `varEmailVerify`, `varAddress`, `varPassword`, `varLandline`, `varLandmark`, `varCountry`, `varState`, `varCity`, `varNeighbourhood`, `varStatus`, `imgImage`, `ex1`, `ex2`, `ex3`) VALUES
(1, 'Bhushan Savale688', '956142148945', NULL, 'savalebd@gmail.com', 'true', 'hgjgjj456757567;;;;', '123', '02576575757', 'klkkio900///;;', '1', '15', '327', 0, '1', '1 appcion.png', NULL, NULL, NULL),
(2, 'Kasbe', '8149148912', NULL, 'kasabe. vikram@gmail.com', '72291', NULL, 'sainath@1234', NULL, NULL, NULL, NULL, NULL, 0, '0', 'Noprofile.png', NULL, NULL, NULL),
(3, 'Nandan Talnikar', '98990120250', NULL, 'nandantalnikar@gmail.com', 'true', NULL, 'nandantalnikarsk', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL),
(4, 'Suhas Bhave', '9850153115', NULL, 'Laukikbhave9@gmail.com', 'true', NULL, 'pluscity', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL),
(5, 'Mayur Potdar', '9620961818', NULL, 'potdarmayur79@gmail.com', 'true', NULL, '123', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL),
(6, 'Jyoti Patil', '9403910390', NULL, 'jyotipatil612@hotmail.com', 'true', NULL, '123', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL),
(7, 'Dipali', '9561756988', NULL, 'sales@societykatta.com', 'true', NULL, 'sales@2016', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL),
(8, 'Nikita', '8421084949', NULL, 'careers@societykatta.com', 'true', NULL, '101', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL),
(9, 'priti', '7058211356', NULL, 'contact@societykatta.com', 'true', 'jalgaon', 'contact@2016', '', '', '', ':: Select State ::', ':: Select City ::', 0, '1', '9 Tulips.jpg', NULL, NULL, NULL),
(10, 'Dipali', '4556', NULL, 'dipali.bhandare001@gmail.com', 'true', NULL, '123', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL),
(11, 'leena', '567657657', NULL, 'pritipawar606@gmail.com', 'true', NULL, '1', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL),
(12, 'meera', '9789', NULL, 'contant@societykatta.com', 'true', NULL, '1', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL),
(13, 'asdasd', '987987987987', NULL, 'asdas@asdas.com', '21134', NULL, 'asdasd', NULL, NULL, NULL, NULL, NULL, 0, '0', 'Noprofile.png', NULL, NULL, NULL),
(14, 'hitendra shravan borse', '7798111190', NULL, 'hiten.borse70@gmail.com', 'true', NULL, 'sonulovehiten', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL),
(15, 'jinal', '9421289989', NULL, 'jinal@gmail.com', 'true', NULL, '1451', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL),
(16, 'payal kunte', '9970648892', NULL, 'payalkunte@gmail.com', 'true', NULL, '123', NULL, NULL, NULL, NULL, NULL, 0, '1', 'Noprofile.png', NULL, NULL, NULL);

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
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblenquiry`
--

INSERT INTO `tblenquiry` (`intId`, `varName`, `varMobile`, `varEmail`, `varServiceName`, `varDescription`, `ex1`, `ex2`, `ex3`, `ex4`) VALUES
(1, 'Mayur Potdar', '9620961818', 'contact@anuvaasoft.com', 'Software', 'need tie up', '13413698_1087743614643797_7811106574431708761_n.png', '13413698_1087743614643797_7811106574431708761_n.png', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblorder`
--

CREATE TABLE `tblorder` (
  `intId` bigint(20) NOT NULL,
  `intOrderId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intCustId` bigint(20) NOT NULL,
  `varVendorId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intServiceID` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varOrderCreatedDate` date NOT NULL,
  `varOrderDate` date DEFAULT NULL,
  `varOrderTime` longtext COLLATE utf8_unicode_ci,
  `intCountryId` bigint(20) NOT NULL,
  `intStateId` bigint(20) NOT NULL,
  `intCityId` bigint(20) NOT NULL,
  `varAddress` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intNeighbourhood` bigint(20) DEFAULT NULL,
  `varAmount` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varRecieved` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPaymentStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varTransactionId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varTransactionStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPaymode` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varOrderStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci,
  `ex2` longtext COLLATE utf8_unicode_ci,
  `ex3` longtext COLLATE utf8_unicode_ci,
  `ex4` longtext COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblorder`
--

INSERT INTO `tblorder` (`intId`, `intOrderId`, `intCustId`, `varVendorId`, `intServiceID`, `varOrderCreatedDate`, `varOrderDate`, `varOrderTime`, `intCountryId`, `intStateId`, `intCityId`, `varAddress`, `intNeighbourhood`, `varAmount`, `varRecieved`, `varPaymentStatus`, `varTransactionId`, `varTransactionStatus`, `varPaymode`, `varOrderStatus`, `ex1`, `ex2`, `ex3`, `ex4`) VALUES
(1, 'SKSSI1073750', 1, 'SKSV4121205', '75738', '2016-09-08', '2016-09-06', '9AM to 11AM', 1, 15, 334, 'hgjgjj456757567;;;;', 0, '100', '0', 'Pending', 'NA', 'Pending', 'NA', 'Cancelled', NULL, NULL, NULL, NULL),
(2, 'SKSSI3626607', 1, 'SKSV6584757', '93194', '2017-02-15', '2017-02-23', '3PM to 5PM', 1, 15, 334, 'hgjgjj456757567;;;;', 0, '0', '0', 'Pending', 'NA', 'Pending', 'NA', 'Cancelled', NULL, NULL, NULL, NULL),
(3, 'SKSSI2166085', 1, 'SKSV9346489', '68147', '2017-03-01', '2017-03-15', '9AM to 11AM', 1, 15, 334, 'hgjgjj456757567;;;;', 0, '0', '0', 'Pending', 'NA', 'Pending', 'NA', 'Cancelled', NULL, NULL, NULL, NULL),
(4, 'SKSSI2499017', 1, 'SKSV2274028', '93194', '2017-03-01', '2017-03-02', '1PM to 3PM', 0, 0, 0, '', 0, '0', '0', 'Pending', 'NA', 'Pending', 'NA', 'Started', NULL, NULL, NULL, NULL),
(5, 'SKSSI2821803', 1, 'SKSV2274028', '93194', '2017-03-01', '2017-03-02', '1PM to 3PM', 1, 15, 327, 'hgjgjj456757567;;;;', 0, '0', '0', 'Pending', 'NA', 'Pending', 'NA', 'Started', NULL, NULL, NULL, NULL),
(6, 'SKSSI6418814', 1, 'SKSV8505861', '85715', '2017-03-01', '2017-03-08', '11AM to 1PM', 1, 15, 327, 'hgjgjj456757567;;;;', 0, '0', '0', 'Pending', 'NA', 'Pending', 'NA', 'Cancelled', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tblordercomplaints`
--

CREATE TABLE `tblordercomplaints` (
  `intId` bigint(20) NOT NULL,
  `intCustId` bigint(20) NOT NULL,
  `intOrderId` bigint(20) NOT NULL,
  `varSubject` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsResolved` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblorderhistory`
--

CREATE TABLE `tblorderhistory` (
  `intId` bigint(20) NOT NULL,
  `intOrderId` bigint(20) NOT NULL,
  `varDate` date NOT NULL,
  `varTime` time NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblorderhistory`
--

INSERT INTO `tblorderhistory` (`intId`, `intOrderId`, `varDate`, `varTime`, `varDescription`) VALUES
(1, 0, '2017-03-03', '00:00:11', ''),
(2, 0, '2017-03-02', '00:00:01', ''),
(3, 0, '2017-03-15', '00:00:09', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblreviews`
--

CREATE TABLE `tblreviews` (
  `intId` bigint(20) NOT NULL,
  `intOrderId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varVendorId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCustomerId` bigint(20) NOT NULL,
  `intRating` int(11) NOT NULL,
  `varReview` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intOnTime` tinyint(1) NOT NULL,
  `intQuality` tinyint(1) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblreviews`
--

INSERT INTO `tblreviews` (`intId`, `intOrderId`, `varVendorId`, `varCustomerId`, `intRating`, `varReview`, `intOnTime`, `intQuality`, `ex1`) VALUES
(1, '0', 'SKSV9346489', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(2, '0', 'SKSV2274028', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(3, '0', 'SKSV7792611', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(4, '0', 'SKSV4336372', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(5, '0', 'SKSV6804863', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(6, '0', 'SKSV7055258', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(7, '0', 'SKSV7368115', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(8, '0', 'SKSV8547497', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(9, '0', 'SKSV4091297', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(10, '0', 'SKSV3972750', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(11, '0', 'SKSV4564952', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(12, '0', 'SKSV6931217', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(13, '0', 'SKSV6310443', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(14, '0', 'SKSV3570294', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(15, '0', 'SKSV5756797', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(16, '0', 'SKSV8505861', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(17, '0', 'SKSV6124432', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(18, '0', 'SKSV5104575', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(19, '0', 'SKSV8953226', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(20, '0', 'SKSV3119111', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(21, '0', 'SKSV3754697', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(22, '0', 'SKSV2126778', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(23, '0', 'SKSV1976042', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(24, '0', 'SKSV3433544', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(25, '0', 'SKSV1717326', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(26, '0', 'SKSV994219', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(27, '0', 'SKSV5753905', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(28, '0', 'SKSV3415049', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(29, '0', 'SKSV9254266', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(30, '0', 'SKSV3245593', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(31, '0', 'SKSV5103988', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(32, '0', 'SKSV6069921', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(33, '0', 'SKSV63664', 1, 3, 'Good Service an on time presence..', 1, 1, '2016-07-01'),
(34, '0', 'SKSV4121205', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(35, '0', 'SKSV2855211', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(36, '0', 'SKSV4540990', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(37, '0', 'SKSV6584757', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(38, '0', 'SKSV7636606', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(39, '0', 'SKSV3345919', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(40, '0', 'SKSV9261305', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(41, '0', 'SKSV6987753', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(42, '0', 'SKSV3120927', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(43, '0', 'SKSV7152870', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(44, '0', 'SKSV7267084', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(45, '0', 'SKSV5933332', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(46, '0', 'SKSV4872944', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(47, '0', 'SKSV4435353', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(48, '0', 'SKSV6750997', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(49, '0', 'SKSV7778942', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(50, '0', 'SKSV8697451', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(51, '0', 'SKSV8887248', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(52, '0', 'SKSV4652474', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(53, '0', 'SKSV8255076', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(54, '0', 'SKSV3255490', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(55, '0', 'SKSV7079379', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(56, '0', 'SKSV760048', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(57, '0', 'SKSV8470581', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(58, '0', 'SKSV3016458', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(59, '0', 'SKSV1438525', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(60, '0', 'SKSV3061722', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(61, '0', 'SKSV2828460', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(62, '0', 'SKSV7426424', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(63, '0', 'SKSV1062216', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(64, '0', 'SKSV2651258', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(65, '0', 'SKSV3214152', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(66, '0', 'SKSV2074981', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(67, '0', 'SKSV9147939', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(68, '0', 'SKSV429215', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(69, '0', 'SKSV7964347', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(70, '0', 'SKSV6660100', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(71, '0', 'SKSV322247', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(72, '0', 'SKSV8190290', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(73, '0', 'SKSV3558750', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(74, '0', 'SKSV2790121', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(75, '0', 'SKSV8380109', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(76, '0', 'SKSV1359487', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(77, '0', 'SKSV5474677', 1, 3, 'Good Service an on time presence..', 1, 1, ''),
(78, 'SKSSI2166085', 'SKSV9346489', 1, 3, 'asdfgh', 1, 1, '2017-03-01');

-- --------------------------------------------------------

--
-- Table structure for table `tblvendor`
--

CREATE TABLE `tblvendor` (
  `intId` bigint(20) NOT NULL,
  `intVendorCode` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci,
  `varContactPerson` longtext COLLATE utf8_unicode_ci,
  `varPhoneNo` longtext COLLATE utf8_unicode_ci,
  `varMobileNo` longtext COLLATE utf8_unicode_ci,
  `varEmailId` longtext COLLATE utf8_unicode_ci,
  `varCountry` int(11) DEFAULT NULL,
  `varState` int(11) DEFAULT NULL,
  `varCity` int(11) DEFAULT NULL,
  `varAddress` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varNeighbourhood` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPincode` longtext COLLATE utf8_unicode_ci,
  `varUsername` longtext COLLATE utf8_unicode_ci,
  `varPassword` longtext COLLATE utf8_unicode_ci,
  `varCreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `varIsActive` tinyint(4) DEFAULT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci,
  `ex3` longtext COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblvendor`
--

INSERT INTO `tblvendor` (`intId`, `intVendorCode`, `varName`, `varContactPerson`, `varPhoneNo`, `varMobileNo`, `varEmailId`, `varCountry`, `varState`, `varCity`, `varAddress`, `varNeighbourhood`, `varPincode`, `varUsername`, `varPassword`, `varCreatedDate`, `CreatedBy`, `varIsActive`, `ex2`, `ex3`) VALUES
(1, 'SKSV9346489', 'Tank Cleaner', 'Sujit Patil', '8484839664', '8550905634', 'tank.cleaner@yahoo.com', 1, 15, 334, 'Plot No. 14, Namdeo Nagar, Pimprala, Jalgaon', 'Pimprala', '425001', 'tank.cleaner@yahoo.com', 'tank.cleaner', '2016-06-20 00:00:00', 1, 1, NULL, NULL),
(2, 'SKSV2274028', 'Gargi Sales and Services', 'Snehal Ghosalkar', '9422567297', '9923586924', 'gargiservices9@gmail.com', 1, 15, 334, 'Plot No. 53, Mundada Nagar, Jalgaon', 'Mundada Nagar', '425001', 'gargiservices9@gmail.com', 'gargiservices9', '2016-06-21 00:00:00', 1, 1, NULL, NULL),
(3, 'SKSV7792611', 'Sharma Furnitures', 'Manoj Sharma', '9657694776', '9657694776', 'sharmafurnitures@gmail.com', 1, 15, 334, 'Golani Complex, Bhusawal', 'Golani Complex', '425001', 'sharmafurnitures@gmail.com', '123', '2016-06-22 00:00:00', 1, 1, NULL, NULL),
(4, 'SKSV4336372', 'RV Trading & solutions pvt ltd', 'Rajendra R Auti', '9730006938', '9730006938', 'helprvtspl@gmail.com', 1, 15, 345, 'B 12 Kunal Aparment, Aundh, Pune', 'Aundh', '411007', 'helprvtspl@gmail.com', 'helprvtspl', '2016-06-25 00:00:00', 1, 1, NULL, NULL),
(5, 'SKSV6804863', 'M D Plumbers', 'Mohammed Taufeeque Razzaque Shaikh', '8624874881', '7057867977', 'taufeequeshaikh123@gmail.com', 1, 15, 345, 'Kondhwa khurd shiveneri nagar lane no 12.', 'Kondhwa', '411048', 'taufeequeshaikh123@gmail.com', 'taufeequeshaikh123', '2016-06-25 00:00:00', 1, 1, NULL, NULL),
(6, 'SKSV7055258', 'I Nath Interior', 'Nagsingh Advatsingh Bhate', '9823755739', '9823755739', 'abhaysinghbhati38@gmail.com', 1, 15, 345, 'Inder Coldrinks Opp Meera Soc Gate Shanker Peth Rd', 'Shankar Peth', '411042', 'abhaysinghbhati38@gmail.com', 'inathinterior', '2016-06-25 00:00:00', 1, 1, NULL, NULL),
(7, 'SKSV7368115', 'Rakesh chavan', 'Rakesh chavan', '8796624661', '8796624661', 'rakeshchavan23@gmail.com', 1, 15, 345, 'Flat No 4 Balaji food corner apartment shahu lane number 11 Near Cummins College Karve Nagar Pune', 'Karve Nagar', '411052', 'rakeshchavan23@gmail.com', 'rakeshchavan23', '2016-06-25 00:00:00', 1, 1, NULL, NULL),
(8, 'SKSV8547497', 'Kunal Enterprise ', 'Jitendra Bhandare', '8380808012', '8380808012', 'jitendra391@gmail.com', 1, 15, 345, 'Pune', 'Pune', '411001', 'jitendra391@gmail.com', 'jitendra391', '2016-06-25 00:00:00', 1, 0, NULL, NULL),
(9, 'SKSV4091297', 'R D Chavan Plumbing Chemicals Water Proofing Contractor', 'R D Chavan', '9028750305', '9028750305', 'r.d.c.0305@gmail.com', 1, 15, 345, 'H No 281 R No 4 Sopan Shivram Balwadkar Near Vitthal Mandir Balewadi', 'Balewadi', '411045', 'r.d.c.0305@gmail.com', 'rdc0305', '2016-06-27 00:00:00', 1, 1, NULL, NULL),
(10, 'SKSV3972750', 'Plumbing and Electrical Service', 'Manbahadur Dilip Awji', '9552532134', '9552532134', 'mdelectrical@gmail.com', 1, 15, 345, 'Wahlhekarwadi Chinchwade farm Chinchwad East', 'Chinchwad', '411019', 'mdelectrical@gmail.com', 'mdelectrical', '2016-06-27 00:00:00', 1, 1, NULL, NULL),
(11, 'SKSV4564952', 'KUNAL ENTEPRISE', 'JITENDRA  DAYARAM BHANDARE', '8380808012', '8380808012', 'jbhandare391@gmail.com', 1, 15, 345, 'Sr no38 shree ram colony\nShinde wasti keshav nagar mundhwa \nPune ', 'Mundwa', '411036', 'jbhandare391@gmail.com', 'jbhandare391', '2016-06-28 00:00:00', 1, 1, NULL, NULL),
(13, 'SKSV6310443', 'Om Sai Water Purification', 'Bhagwan Gyanji Ghungrut', '9226262208', '9175474791', 'bhagawanghungarut111@gmail.com', 1, 15, 345, 'Shendge Floor Mill Gokul Nagar', 'Gokul Nagar', '411048', 'bhagawanghungarut111@gmail.com', 'bhagawanghungarut111', '2016-06-28 00:00:00', 1, 1, NULL, NULL),
(14, 'SKSV3570294', 'Swaroop Services', 'Aakash Panchmukh', '7038599733', '7038599733', 'swaroop.services2010@gmail.com', 1, 15, 345, '191 anana Nagar, airport road Yerwada ', 'Yerwada', '', 'swaroop.services2010@gmail.com', 'swaroop.services2010', '2016-06-30 00:00:00', 1, 1, NULL, NULL),
(15, 'SKSV5756797', 'S R MAINTENANCE', 'RAHUL TUSAMAD', '8379002050', '8379002050', 'srmaintenance77@gmail.com', 1, 15, 345, 'Limbore Vasti near Arun Talkies Dapoli', 'Dapoli', '', 'srmaintenance77@gmail.com', 'srmaintenance77', '2016-06-30 00:00:00', 1, 1, NULL, NULL),
(16, 'SKSV8505861', 'Shanti Electrical Works', 'Chaitanya Shinde', '9860080211', '9860080211', 'shantielectricalworks@gmail.com', 1, 15, 345, 'Flat No 52 Om Shiv Shambo Heights Mohan Nagar Dhanakwadi', 'Dhanakwadi', '411043', 'shantielectricalworks@gmail.com', 'shantielectricalworks', '2016-06-30 00:00:00', 1, 1, NULL, NULL),
(17, 'SKSV6124432', 'Satyam Plumbers', 'Sudarshan Parida', '9960736030', '9860981676', 'sudarshanparidapune@gmail.com', 1, 15, 345, 'near domenos plza big bazar baner', 'Baner', '', 'sudarshanparidapune@gmail.com', 'sudarshanparidapune', '2016-06-30 00:00:00', 1, 1, NULL, NULL),
(18, 'SKSV5104575', 'Success Electricals Pvt Ltd', 'Sambhaji Sarade', '9881387270', '9881387270', 'sardesambhaji@gmail.com', 1, 15, 345, 'shivaji chowk hinjawadi near keshav mangal karyala mauli krupa building hinjawadi', 'Hinjewadi', '411057', 'sardesambhaji@gmail.com', 'sardesambhaji', '2016-06-30 00:00:00', 1, 1, NULL, NULL),
(19, 'SKSV8953226', 'Shreyash  Electrical', 'Shivaji B Humnabade', '9922127030', '9922127030', 'shivajitheboss342@gmail.com', 1, 15, 345, 'Maharastra nagri  sr/ no:1/1/1/3A gajanan nagar kalewadi fatta,Rahatan', 'Rahatan', '411017', 'shivajitheboss342@gmail.com', 'shivajitheboss342', '2016-06-30 00:00:00', 1, 1, NULL, NULL),
(20, 'SKSV3119111', 'Prathamesh Plumbing Services', 'Prafull Santosh Dengle', '8149432808', '8007632819', 'prafulldengle@gmail.com', 1, 15, 345, 'Kalasgaon Jadhav Vasti Near Govind super market Vishrantwadi', 'Vishrantwadi', '411015', 'prafulldengle@gmail.com', 'prafulldengle', '2016-06-30 00:00:00', 1, 1, NULL, NULL),
(21, 'SKSV3754697', 'Sanjay Wagh', 'Sanjay Wagh', '9890851950', '9890851950', 'gauravwagh85@gmail.com', 1, 15, 328, 'Plot no 68A Kisan Nagar Khamgaon ', 'Khamgaon', '', 'gauravwagh85@gmail.com', 'gauravwagh85', '2016-07-01 00:00:00', 1, 1, NULL, NULL),
(22, 'SKSV2126778', 'Sandeep electrical works ', 'Sandeep dahilkar', '8806600738', '8806600738', 'sandeepdahilkar199@gmail.com', 1, 15, 345, 'Plot no 555 ganganagar near Ganesh Mandir sector 28 pune', 'Pune', '', 'sandeepdahilkar199@gmail.com', 'sandeepdahilkar199@gmail.com', '2016-07-01 00:00:00', 1, 0, NULL, NULL),
(23, 'SKSV1976042', 'Sandeep electrical works ', 'Sandeep dahilkar', '8806600738', '8806600738', 'sandeepdahilkar199@gmail.com', 1, 15, 345, 'Plot no 555 ganganagar near Ganesh mandir', 'Pune', '411042', 'sandeepdahilkar199@gmail.com', 'sandeepdahilkar199', '2016-07-01 00:00:00', 1, 1, NULL, NULL),
(24, 'SKSV3433544', 'sai pest control service', 'panjabrao uddhav dupade', '9579291722', '9579291722', 'saipestcontrolservises@gmail.com', 1, 15, 345, 'Sr no 9 Tukaram Nagar Lane No 5 Kharodi ', 'Kharodi', '', 'saipestcontrolservises@gmail.com', 'saipestcontrolservises', '2016-07-02 00:00:00', 1, 1, NULL, NULL),
(25, 'SKSV1717326', 'Citi Pest Control Services', 'Vikas Admane', '02025231551', '9822337051', 'vikasadmane1977@gmail.com', 1, 15, 345, 'E 26 27 Hans Sarovar Market Yard ', 'Market Yard', '', 'vikasadmane1977@gmail.com', 'vikasadmane1977', '2016-07-02 00:00:00', 1, 1, NULL, NULL),
(26, 'SKSV994219', 'Good Night Pest Control', 'Amar Bogam ', '8805310010', '8805310010', 'amar1225@yahoo.com', 1, 15, 345, 'Address 476 mahatma phule peth pune 42', 'Pune', '', 'amar1225@yahoo.com', 'amar1225', '2016-07-02 00:00:00', 1, 1, NULL, NULL),
(27, 'SKSV5753905', 'Shalaka Electricals', 'Pravin Shendge', '8237730730', '8237730730', 'shalakaelectricals7@gmail.com', 1, 15, 345, 'sr no 10 kamraj nagar shivraj chowk yerwada', 'Yerwada', '411006', 'shalakaelectricals7@gmail.com', 'shalakaelectricals7', '2016-07-02 00:00:00', 1, 1, NULL, NULL),
(28, 'SKSV3415049', 'Home Services', 'Pokarram Punaram Parmar', '9371023456', '9371023456', 'homeservicepune97@gmail.com', 1, 15, 345, 'Parmar shop no 3 Plot no 20A 20B Sno 121 122 Pushpanagari Rambaug Colony Paud Road Near Krushna Hospital Kothrud Pune City Ex Serviceman Colony ', 'Kothrud', '411038', 'homeservicepune97@gmail.com', 'homeservicepune97', '2016-07-02 00:00:00', 1, 1, NULL, NULL),
(29, 'SKSV9254266', 'ACTIVE PLUS SERVICES', ' Gokul A. Mhetr', '9404978138', '9850760038', 'activegokulpcs@gmail.com', 1, 15, 345, 'D-16 Jijai villa Manaji Nagar Narhe Pune', 'Pune', '', 'activegokulpcs@gmail.com', 'activegokulpcs', '2016-07-04 00:00:00', 1, 1, NULL, NULL),
(30, 'SKSV3245593', 'Om Services ', 'Vilas H Supekar     ', '8087761717', '9158651717', 'omservices90@gmail.com', 1, 15, 345, 'Shop no 34, near sai mandir, pube alandi road, wadmukhwadi, pune', 'Pune', '412105', 'omservices90@gmail.com', 'omservices90', '2016-07-04 00:00:00', 1, 1, NULL, NULL),
(31, 'SKSV5103988', 'Sai Motors', 'Shrikant Shivaji Pawar', '9881464265', '9881464265', 'shrikantpawar9881464265@gmail.com', 1, 15, 345, 'Kondhwa khurd sant dnyaneshwar nagar sarve no   45 near marketyard pune 48', 'Market Yard', '', 'shrikantpawar9881464265@gmail.com', 'shrikantpawar9881464265', '2016-07-04 00:00:00', 1, 1, NULL, NULL),
(32, 'SKSV6069921', 'Painter Bhilare', 'Aanandrao Bhilare', '7040118250', '7040118250', 'tejashreebhilare99@gmail.com', 1, 15, 345, ' Mahavir nagar ,katraj - kondhawa road ,katraj ,Pune', 'Kondwa', '', 'tejashreebhilare99@gmail.com', 'tejashreebhilare99', '2016-07-04 00:00:00', 1, 1, NULL, NULL),
(33, 'SKSV63664', 'Biochem Pest Control', 'B B Sangale', '020026996161', '020026996161', 'biochempestpune01@gmail.com', 1, 15, 345, 'Shop No 21 Kanchan Plaza Gadital Hadapsar Pune 28', 'Hadapsar', '', 'biochempestpune01@gmail.com', 'biochempestpune01', '2016-07-04 00:00:00', 1, 1, NULL, NULL),
(34, 'SKSV4121205', 'Naitik Services', 'Shishir Patel', '7600955932', '9427307578', 'naitiksocietyservice@gmail.com', 1, 15, 345, 'Hadapsar', 'Hadapsar', '411012', 'naitiksocietyservice@gmail.com', 'naitiksocietyservice', '2016-07-07 00:00:00', 1, 1, NULL, NULL),
(35, 'SKSV2855211', 'Katkar enterprises', 'Katkar enterprises', '9075241643', '9011871042', 'katkargroup@gmail.com', 1, 15, 345, 'pune', '', '', 'katkargroup@gmail.com', 'katkargroup', '2016-07-07 00:00:00', 1, 1, NULL, NULL),
(36, 'SKSV4540990', 'Manan Mentenance & A/c Sales Services', 'Bhikabhau Kathorkar', '9881482256', '9881482256', 'mananmaintenance@gmail.com', 1, 15, 328, 'shraddha complex  groundfloor  near state bank buldhana road malkapur', 'malkapur', '443101', 'mananmaintenance@gmail.com', 'mananmaintenance', '2016-07-07 00:00:00', 1, 1, NULL, NULL),
(37, 'SKSV6584757', 'ICE COOL refrigeration and air conditioner', 'Zafar Khan', '8237157018', '8237157018', 'raczafarkhan@gmail.com', 1, 15, 334, '69 basement new B J market jalgaon', ' jalgaon', '425001', 'raczafarkhan@gmail.com', 'raczafarkhan', '2016-07-07 00:00:00', 1, 1, NULL, NULL),
(38, 'SKSV7636606', 'Vaishali Enterprises', 'Suhas Virendra Bhave', '9850153115', '9850153115', 'laukikbhave9@gmail.com', 1, 15, 345, 'pune', 'pune', '', 'laukikbhave9@gmail.com', 'laukikbhave9', '2016-07-07 00:00:00', 1, 1, NULL, NULL),
(39, 'SKSV3345919', 'Rathod construction', 'Gopal Rathod', '9657991062', '9657991062', 'gopalrathod99223@gmail.com', 1, 15, 345, 'khadki bajar pune 3', 'pune', '', 'gopalrathod99223@gmail.com', 'gopalrathod99223', '2016-07-07 00:00:00', 1, 1, NULL, NULL),
(40, 'SKSV9261305', 'Umesh Painter', 'Umesh Ramchandra Pal', '9921647543', '9921647543', 'umeshpla228@gmail.com', 1, 15, 345, 'S No 15 Bhalkar Vasti Warje Naka Karvenagar ', 'Pune', '411052', 'umeshpla228@gmail.com', 'umeshpla228', '2016-07-08 00:00:00', 1, 1, NULL, NULL),
(41, 'SKSV6987753', 'SocietyKatta', 'Shishir Patel', '7066660206', '7066660206', 'support@societykatta.com', 1, 7, 151, 'Vapi', 'Vapi', '425010', 'support@societykatta.com', '123', '2016-07-08 00:00:00', 1, 1, NULL, NULL),
(42, 'SKSV3120927', 'Ample Pest Control Services', 'Vishal Jagdale', '9657952121', '9657972121', 'amplepestcontrolservices@gmail.com', 1, 15, 345, 'Sn41/2A Plot no37B shanti nagar society, Chaudhari Vasti, Kharadi,Pune', 'pune', '', 'amplepestcontrolservices@gmail.com', 'amplepestcontrolservices', '2016-07-18 00:00:00', 1, 1, NULL, NULL),
(43, 'SKSV7152870', 'Monika Herbal Pest control', 'Laxman Varma', '7798602529', '7798602529', 'laxmanvarma1000@gmail.com', 1, 15, 345, 'Ramsmruti B-301 Pinaki colony vishrantwadi Pune Road', 'pune', '412105', 'laxmanvarma1000@gmail.com', 'laxmanvarma1000', '2016-07-18 00:00:00', 1, 1, NULL, NULL),
(44, 'SKSV7267084', 'Prime Pest control', 'Ram Mohane', '8408800518', '8408800518', 'mohaneram1@gmail.com', 1, 15, 345, 'Krvenagar .higne home colney near ganraj mitr mandal/ Krvenagar .kotharud.poud rd sing.rd krve rd Deccan.prabhat rd.sb.rd', 'pune', '', 'mohaneram1@gmail.com', 'mohaneram1', '2016-07-18 00:00:00', 1, 1, NULL, NULL),
(45, 'SKSV5933332', 'Shree Balaji Pest Control Service', 'Sachin Jagtap', '9881556601', '9881556601', 'sachinjagtap@yahoo.com', 1, 15, 345, 'Sr No 137/3/2/1 Vidya Valley Road Near Khadi Mashin Susgaon Pashan Pune, armament', 'pune', '', 'sachinjagtap@yahoo.com', 'sachinjagtap', '2016-07-18 00:00:00', 1, 1, NULL, NULL),
(46, 'SKSV4872944', 'Riyas modular kitchen and  furnitur', 'philip chacko', '9881635701', '9881635701', 'riyazmodular.30@gmail.com', 1, 15, 345, 'Lane number 7 , dhanori pune 15 .m.', 'pune', '', 'riyazmodular.30@gmail.com', 'riyazmodular.30', '2016-07-18 00:00:00', 1, 1, NULL, NULL),
(47, 'SKSV4435353', 'Secure Birdnet And Safetynets ', 'Mahesh D Jori', '7028554440', '7028554441', 'securenets61@gmail.com', 1, 15, 345, 'Add. 305 suvarna Plaza, Near Apeksha Plaza,Pune  Saswad Road, Phursyngi Pune.', 'pune', '411028', 'securenets61@gmail.com', 'securenets61', '2016-07-18 00:00:00', 1, 1, NULL, NULL),
(48, 'SKSV6750997', 'Viraj pest Control', 'Raju samsher Bawdiwale', '8888998376', '8888998376', 'virajpestcontrol777@gmail.com', 1, 15, 345, 'SR No 174 Bekrai Nagar Hadpasar pune', 'Pune', '', 'virajpestcontrol777@gmail.com', 'virajpestcontrol777', '2016-07-19 00:00:00', 1, 1, NULL, NULL),
(49, 'SKSV7778942', 'House Painting And Plumbing', 'Tawwab ali kadri', '9823241894', '9823241894', 'trkadri73@gmail.com', 1, 15, 325, ' Tr Enterprises Dewlai chok  aurangabad', 'aurangabad', '', 'trkadri73@gmail.com', 'trkadri73', '2016-07-19 00:00:00', 1, 1, NULL, NULL),
(50, 'SKSV8697451', 'Infinity Enterprises', 'Abdul Khan', '7741988817', '9029085776', 'infinityenterprises8817@gmail.com', 1, 15, 345, 'Aayesha Height, Flat no 3, Kasba Peth Pune 11 ', 'Pune', '', 'infinityenterprises8817@gmail.com', 'infinityenterprises8817', '2016-07-19 00:00:00', 1, 1, NULL, NULL),
(51, 'SKSV8887248', 'Samarth Electrical And Refrigeration', 'Dnyaneshwar aaachavan', '9420617557', '8390638588', 'samarthelectricals11@gmail.com', 1, 15, 325, 'Vijay Nagar, Garkhada Parisar, Aurangabad', 'Aurangabad', '', 'samarthelectricals11@gmail.com', 'samarthelectricals11', '2016-07-19 00:00:00', 1, 1, NULL, NULL),
(52, 'SKSV4652474', 'V M Patel', 'Mukid Patel', '9763572732', '9763572732', 'mukidpatel1212@email.com', 1, 15, 325, 'Amir nagar, Bajaj Hospital bidbypass road Aurangabad', 'aurangabad', '', 'mukidpatel1212@email.com', 'mukidpatel1212', '2016-07-20 00:00:00', 1, 1, NULL, NULL),
(53, 'SKSV8255076', 'K G N Plumber', 'MD lmran', '8805944114', '8805944114', 'shaek9559@gmel.com', 1, 15, 325, 'Sadat nagar railway station Aurangabad', 'Aurangabad', '', 'shaek9559@gmel.com', 'shaek9559', '2016-07-20 00:00:00', 1, 1, NULL, NULL),
(54, 'SKSV3255490', 'Jai Malhar Pest Control ', 'Kailas Doifode', '9922534299', '9158271064', 'kailasdoifode01469@gmail.com', 1, 15, 345, 'Singagadh Road Pune', 'Pune', '', 'kailasdoifode01469@gmail.com', 'kailasdoifode01469', '2016-07-20 00:00:00', 1, 1, NULL, NULL),
(55, 'SKSV7079379', 'Shri Sai Electronics', 'Atul Satish Birajdar', '7776884720', '7776884720', 'atulbirajdar1234@gmail.com', 1, 15, 325, 'Ram mandir, 5-3-49 Osmanpura, Aurangabad', 'Aurangabad', '431001', 'atulbirajdar1234@gmail.com', 'atulbirajdar1234', '2016-07-20 00:00:00', 1, 1, NULL, NULL),
(56, 'SKSV760048', 'S D S Pest Control Service', 'Dnyaneshwar G Shendage', '7776001010', '7776001010', 'sdspestcontrol7@gmail.com', 1, 15, 345, 'Shrinagar kalewadi Rahatni road, Nakhate nagar, near Ganesh mens wear', 'pune', '', 'sdspestcontrol7@gmail.com', 'sdspestcontrol7', '2016-07-28 00:00:00', 1, 1, NULL, NULL),
(57, 'SKSV8470581', 'Data online solution', 'Khan mohd javed', '8087373706', '8087373706', 'dataonline_csn@rediffmail.com', 1, 15, 617, 'Plot no 14 Dr zakir Hussain society near masons masjid chalisgaon dist jalgaon', 'Chalisgaon', '', 'dataonline_csn@rediffmail.com', 'dataonline_csn', '2016-07-28 00:00:00', 1, 1, NULL, NULL),
(58, 'SKSV3016458', 'Hindustan Battery And Invertor', 'B A Shaikh', '9423245544', '9423245544', 'hindustanabs@gmail.com', 1, 15, 345, 'Pune Solapur Road, opp  Harana complex, uruli kanchan, Tal. Haveli, Dist. pune', 'Pune', '', 'hindustanabs@gmail.com', 'hindustanabs', '2016-07-29 00:00:00', 1, 1, NULL, NULL),
(59, 'SKSV1438525', 'GALAXY RELOCATION PACKERS AND MOVERS', 'RAM MEHAR SHARMA', '8090884455', '09335519827', 'galaxypackerslko@gmail.com', 1, 26, 563, 'S-217, Transport nagar, Kanpur road Lucknow ', 'Lucknow ', '', 'galaxypackerslko@gmail.com', 'galaxypackerslko', '2016-07-30 00:00:00', 1, 1, NULL, NULL),
(60, 'SKSV3061722', ' international progressive packers and movers', 'sandeep poonia', '9714203937', '9374822601', 'sandeep_sfc@yahoo.in', 1, 7, 156, '9 cm rana complex khergaon raod gundlav valsad ', 'valsad ', '', 'sandeep_sfc@yahoo.in', 'sandeep_sfc', '2016-07-30 00:00:00', 1, 1, NULL, NULL),
(61, 'SKSV2828460', 'Accost Pest Management Service', 'Sunjit', '9604555205', '9960907304', 'accostpestcontrol@gmail.com', 1, 15, 345, 'Charapati Society, Flat No. 8, Survey No. 59, Sai Nagar, Khondawa BK, Pune H.O., Pune', 'Pune', '', 'accostpestcontrol@gmail.com', 'accostpestcontrol', '2016-08-01 00:00:00', 1, 1, NULL, NULL),
(62, 'SKSV7426424', 'Agarwal Cargo Packers & Movers ', 'Sunjit', '7600765019', '9812827543', 'agarwalcargovapi1992@gmail.com', 1, 7, 153, 'Office No. 320, Sai Leela Complex, Near big Bazar, Salvav, Vapi', 'Vapi', '396191', 'agarwalcargovapi1992@gmail.com', 'agarwalcargovapi1992', '2016-08-01 00:00:00', 1, 1, NULL, NULL),
(63, 'SKSV1062216', 'Subhash Electricals &Engineering Work', 'Punamsing Chouhan', '9404111197', '9404111197', 'punamsingh4466@gmail.com', 1, 15, 345, 'Behind Jain Mandir, Johariwada(Gulmandi), Aurangabad', 'Aurangabad', '431001', 'punamsingh4466@gmail.com', 'punamsingh4466', '2016-08-01 00:00:00', 1, 1, NULL, NULL),
(64, 'SKSV2651258', 'Aditya Enterprises', 'Vikram Kasbe', '8149148912', '8149148912', 'vikramkasbe@gmail.com', 1, 15, 345, 'S.No.45/3, Chandan Nagar, Kharadi Road, Pune-14 ', 'Pune', '', 'vikramkasbe@gmail.com', 'vikramkasbe', '2016-08-01 00:00:00', 1, 1, NULL, NULL),
(65, 'SKSV3214152', 'sandip Electricals & Security System', 'Sandip Jadhav', '9923615520', '9923615520', 'mrsandeepjadhav@gmail.com', 1, 15, 325, 'Plot No. 25, Shrikrushn Nagar, Shananurvadi, Aurangabad', 'Aurangabad', '', 'mrsandeepjadhav@gmail.com', 'mrsandeepjadhav', '2016-08-01 00:00:00', 1, 1, NULL, NULL),
(66, 'SKSV2074981', 'Ganesh Plumbing Works', 'Ganesh sirsath', '8055991021', '8055991021', 'ganesh.shirsath987@gmail.com', 1, 15, 325, 'Arihant Nagar Aurangabad', 'Aurangabad', '', 'ganesh.shirsath987@gmail.com', 'ganesh.shirsath987', '2016-08-01 00:00:00', 1, 1, NULL, NULL),
(67, 'SKSV9147939', 'New Galaxy Refrigeration ', 'shaikh shakur', '9665286172', '9665286172', 'newgalaxyrefrigeration123@gmail.com', 1, 15, 325, 'Town Hall, Near Amkhas Maidan, Aurangabad', 'Aurangabad', '', 'newgalaxyrefrigeration123@gmail.com', 'newgalaxyrefrigeration123', '2016-08-01 00:00:00', 1, 1, NULL, NULL),
(68, 'SKSV429215', ' Ideal Pest Control', 'Angad Gutte', '9604989591', '9604989591', 'idealpestcontrolpune@gmail.com', 1, 15, 345, 'Aakash londri, datt nagar,  dighi pune', 'Pune', '411015', 'idealpestcontrolpune@gmail.com', 'idealpestcontrolpune', '2016-08-02 00:00:00', 1, 1, NULL, NULL),
(69, 'SKSV7964347', 'Laxmi Multi Services', 'vinay', '9011658825', '9011658825', 'vinaymall996@gmail.com', 1, 15, 345, 'Mankar Chowk, Kaspate Wasti, Wakad 67', 'Wakad', '411057', 'vinaymall996@gmail.com', 'vinaymall996', '2016-08-09 00:00:00', 1, 1, NULL, NULL),
(70, 'SKSV6660100', 'Vision Pest Management Service', 'Nagesh Pandurang Barge', '7588680490', '7588680490', 'visionpest@rediffmail.com', 1, 15, 345, '10, Sagar Heights, Ambegaon Bk., Katraj, Pune -', 'Pune', '411046', 'visionpest@rediffmail.com', 'visionpest', '2016-08-09 00:00:00', 1, 1, NULL, NULL),
(71, 'SKSV322247', 'Ali Contractor', 'Mehboob Aarekhas', '9373007393', '9373007393', 'ali.contractor786@gmail.com', 1, 15, 345, 'Shop no. 5, Chouse Hardware, Manisha Plaza, N.I.B.M. Road, Kondhwa Khurd, Pune 48', 'Pune', '', 'ali.contractor786@gmail.com', 'ali.contractor786', '2016-08-10 00:00:00', 1, 1, NULL, NULL),
(72, 'SKSV8190290', 'Suraj Hardware', 'Bali Dnyandeo Tayade', '9763960947', '9763960947', 'suraj.hardware@gmail.com', 1, 15, 341, 'Tal.Dist. Nashik', 'Nashik', '', 'suraj.hardware@gmail.com', 'suraj.hardware', '2016-08-10 00:00:00', 1, 1, NULL, NULL),
(73, 'SKSV3558750', 'Balaji Furniture', 'Balaji Furniture', '9822441094', '9822441094', 'balajifurniture@gmail.com', 1, 15, 345, 'Shivsagar, Balaji Nagar', 'Pune', '', 'balajifurniture@gmail.com', 'balajifurniture', '2016-08-10 00:00:00', 1, 1, NULL, NULL),
(74, 'SKSV2790121', 'Rangashree Painters', 'Gopal Panase', '9881509296', '9881509296', 'rangashreepaint@gmail.com', 1, 15, 345, 'B2B-2/7, Shreekrishna Nagar society, near Mhatre Pul, Yerandawane, Pune 4', 'Pune', '', 'rangashreepaint@gmail.com', 'rangashreepaint', '2016-08-10 00:00:00', 1, 1, NULL, NULL),
(75, 'SKSV8380109', 'Sonakshi Electronic & Electrical ', 'Harish Kumar Ashok Singh', '7385317476', '7385317476', 'singhharishkumar38@gmail.com', 1, 15, 341, 'Ramkrishna nagar chuncha ambad..', 'Nashik', '', 'singhharishkumar38@gmail.com', 'singhharishkumar38', '2016-08-10 00:00:00', 1, 1, NULL, NULL),
(76, 'SKSV1359487', 'Shree Samartha Electrical and Engineers ', ' Prashant Deore', '9822559023', '9822770810', 'prashantdeore501@gmail.com', 1, 15, 341, 'Off. No. 4 , Vilas apt., next to mama mungi karyalaya , pumping station road , Gangapur road , Nashik', '', '', 'prashantdeore501@gmail.com', 'prashantdeore501', '2016-08-10 00:00:00', 1, 1, NULL, NULL),
(77, 'SKSV5474677', 'SocietyKatta', 'Bhushan Savale', '9561421489', '9561421489', 'societykatta@gmail.com', 1, 15, 345, 'Samarth Colony\r\nFlat no. 1 Akshay chambers, beside Nilon\\\\''s', '', '425001', 'societykatta@gmail.com', '123', '2016-08-29 00:00:00', 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tblvendorabout`
--

CREATE TABLE `tblvendorabout` (
  `intId` bigint(20) NOT NULL,
  `varVendorId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAbout` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varImage` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblvendorabout`
--

INSERT INTO `tblvendorabout` (`intId`, `varVendorId`, `varAbout`, `varImage`) VALUES
(1, 'SKSV9346489', 'We Clean Your Any Type Of Tanks', '429FAVICON.png'),
(2, 'SKSV2274028', 'All Types of service provider in Electrical AC and RO Residential or Commercial or Industrial', 'NoProfile.png'),
(3, 'SKSV7792611', 'We shape the wooden goods..', '221FAVICON.png'),
(4, 'SKSV4336372', 'All Electrical work and Plumbing', '4 auti (1).jpg'),
(5, 'SKSV6804863', 'All types of Electrical works', '652FAVICON.png'),
(6, 'SKSV7055258', 'Interior and Furniture works', '879WhatsApp-Image-20160625 (1).jpeg'),
(7, 'SKSV7368115', 'Plumbing Services', '929WhatsApp-Image-20160625 (2).jpeg'),
(8, 'SKSV8547497', 'House Painting Electrical Plumbing Workhouse Cleaning', 'NoProfile.png'),
(9, 'SKSV4091297', 'Plumbing Chemical Water Proofing Contractor', '498WhatsApp-Image-20160627 (1).jpeg'),
(10, 'SKSV3972750', 'Plumbing and Electrical Service', '613WhatsApp-Image-20160627 (2).jpeg'),
(11, 'SKSV4564952', 'Provide House painting All Eletrical Plumbing work House cleaning', '459kunal ent.png'),
(13, 'SKSV6310443', 'Water Purification Services', '952f3e86676-b511-42e3-b62b-78cd2ed54c6e.jpg'),
(14, 'SKSV3570294', 'We are provide carpentery services, plumbing, electrical,tiles, civil work, pop, painting and all office home renovation work fabrication e', '142WhatsApp-Image-20160628 (2).jpeg'),
(15, 'SKSV5756797', 'Sofa Repairing and new Making House Painting', '118WhatsApp-Image-20160629 (1).jpeg'),
(16, 'SKSV8505861', 'Electrical Works', '327FAVICON.png'),
(17, 'SKSV6124432', 'Plumbing Services', '239spp.jpg'),
(18, 'SKSV5104575', 'Electrical Services', '963WhatsApp-Image-20160629 (3).jpeg'),
(19, 'SKSV8953226', 'All tipe electrical wark in hose wairig and electrical mantainance', '632WhatsApp-Image-20160630.jpeg'),
(20, 'SKSV3119111', 'Plumbing Services', '958FAVICON.png'),
(21, 'SKSV3754697', 'All types of electric fitting Specialist in hospital and bank wiring CCTV camera wiring and fitting TV repair surgical appiliances repair stone crusher starter repair hotel and lodge wirings and all electrical works', '117WhatsApp-Image-20160630 (1).jpeg'),
(22, 'SKSV2126778', 'All electrical works', '957IMG-20160701-WA0001.jpg'),
(23, 'SKSV1976042', 'All electrical works', '621IMG-20160701-WA0001.jpg'),
(24, 'SKSV3433544', 'herbal pest spray commercial and residential', '527FAVICON.png'),
(25, 'SKSV1717326', 'General disinfestation Cockroach control Rodent control Bedbugs control Fleas control Anti termite treatment', '821FAVICON.png'),
(26, 'SKSV994219', 'Bedbag Cockroach Tarmait Ends Lezard Mousekuyto honey rat and other', '394FAVICON.png'),
(27, 'SKSV5753905', 'Electrical Services', '378pp.jpg'),
(28, 'SKSV3415049', 'Refrigerator Repair', '116Untitled.png'),
(29, 'SKSV9254266', 'Herbal and Chemical Pest Control', '29 download.jpg'),
(30, 'SKSV3245593', 'pest control,house keeping sofa cleaning electric maintanance all type of water tank cleaning pest contro', '30 TMPDOODLE1467648128313.jpg'),
(31, 'SKSV5103988', 'specialist in servicing & repairing of all types of car denting,painting,   mechanical work also done here & tow in serv', '522WhatsApp-Image-20160704.jpeg'),
(32, 'SKSV6069921', 'sainboard Temple painting Rangoli painting  Gate painting Murti (statue) pain', '529PainterLOGO.png'),
(33, 'SKSV63664', 'Pest Control Service', '218download.jpg'),
(34, 'SKSV4121205', 'Driver Services', '938FAVICON.png'),
(35, 'SKSV2855211', ' Pest control services.  Deep cleaning.  Painting services. complete solar solution', '554FAVICON.png'),
(36, 'SKSV4540990', 'AC Maintences and Repair Electric fitting plumbing industrial instrument installation cabling', '845FAVICON.png'),
(37, 'SKSV6584757', 'Air Conditioner Refrigeration washing machine RO Water purifire  repairing etc', '563ice.jpg'),
(38, 'SKSV7636606', 'painting work waterproofing sliding windows fabrication works civil works', '653FAVICON.png'),
(39, 'SKSV3345919', 'marbles floor dreniz bathroom and toilet water proofing rain water harwasting roof water proofing architect construction ', 'NoProfile.png'),
(40, 'SKSV9261305', 'Paint Polish  Contractor', '537umesh.jpg'),
(41, 'SKSV6987753', 'Laundry Services', '278FAVICON.png'),
(42, 'SKSV3120927', ' Cockroaches,Bed bugs,Fly,Ratcontrol,Spider Pre&post construction Anti Termite,Mosquit', '571FAVICON.png'),
(43, 'SKSV7152870', 'pest control When started my business Monika herbal pest control Pune', 'NoProfile.png'),
(44, 'SKSV7267084', 'residential commercial industrial pest control service', 'NoProfile.png'),
(45, 'SKSV5933332', 'pest control service', 'NoProfile.png'),
(46, 'SKSV4872944', 'reasonable rate and good quality as per order customised furniture made ample selection of colorful wooden lamination also do painting  electricals granite and tiles work', '781riya.jpg'),
(47, 'SKSV4435353', 'Deals in Birdnet, Safetynets, Spikes,Shade net, PVC Strips Curtains And all types of nylon net', '171secure pest.jpg'),
(48, 'SKSV6750997', 'Pest Control service', 'NoProfile.png'),
(49, 'SKSV7778942', 'house painting  pop  gypsum ceiling  All type panting all type pop gypsum texture melamine0 polish dco paint lamination', 'NoProfile.png'),
(50, 'SKSV8697451', 'installation of all type of Ac Packages VRV Pressicion ductable Split Ac and Cassette Ac Maintenance all type of cooling systems   ', 'NoProfile.png'),
(51, 'SKSV8887248', 'Refrigeration Air conditioner Deep freezer Water Coolar Washing machine VRF system Water purifire Electrical works', '221WhatsApp-Image-20160719.jpeg'),
(52, 'SKSV4652474', 'Drainage line Water Proof Plumber Fitting And All plumbing works', 'NoProfile.png'),
(53, 'SKSV8255076', 'All Plumbing Works', '742WhatsApp-Image-20160720.jpeg'),
(54, 'SKSV3255490', 'pest control service', 'NoProfile.png'),
(55, 'SKSV7079379', 'All type of electrical and electronic service', 'NoProfile.png'),
(56, 'SKSV760048', 'pest control service', 'NoProfile.png'),
(57, 'SKSV8470581', 'electrician fitting and maintainance water purifier installation and maintainance inverter and battery installation and maintainanceCCTV installation and maintainance', 'NoProfile.png'),
(58, 'SKSV3016458', 'electrical and garage works', '499WhatsApp Image 2016-07-29 at 4.40.54 PM.jpeg'),
(59, 'SKSV1438525', 'Specialist in transportation of household car carrier heavy waight commercial loading all over India service', 'NoProfile.png'),
(60, 'SKSV3061722', ' international packers and movers', 'NoProfile.png'),
(61, 'SKSV2828460', 'Bees Pest Control Services, Corporate Pest Control, Residential Pest Control, Mosquito Fogging, Pre Construction Pest Control, Termite Pest Control, Bed Bugs Pest Control, Cockroach Pest Contr', 'NoProfile.png'),
(62, 'SKSV7426424', 'International And Domastic House Hold Goods Industrial of Car Transportation Packing And Moving', 'NoProfile.png'),
(63, 'SKSV1062216', 'All type of Electrical Maintanance And New Fitings', 'NoProfile.png'),
(64, 'SKSV2651258', 'All type of plumbing work And Chair Repairing system', 'NoProfile.png'),
(65, 'SKSV3214152', 'All Electrical Works ', '175sandeep.jpg'),
(66, 'SKSV2074981', 'All type of Plumbing Work', 'NoProfile.png'),
(67, 'SKSV9147939', ' Ac repairing and refrigerator repair and all refrigeration system sales and service', 'NoProfile.png'),
(68, 'SKSV429215', 'Anti termites treatment honey Bee treatment cockroach herbal gel treatment bed bugs treatment rat treatment fogging treatment Hotels hostels college company home all type', 'NoProfile.png'),
(69, 'SKSV7964347', 'all plimbing And Electrical services', 'NoProfile.png'),
(70, 'SKSV6660100', ' General Disinfestations Services Cockroaches Ants and Silverfish Bed bugs Control Treatment Pre and Post Construction Anti Termite Control Treatment Rodent Control Services Mosquito Control Treatment Flies Control Treatment Wood Borer Control Services Lizards And Spider Control Treatment Ticks Control Treatment', 'NoProfile.png'),
(71, 'SKSV322247', 'Plumbing Water Proofing styling And Maintanance', 'NoProfile.png'),
(72, 'SKSV8190290', 'All Plumbing Works', '828suraj.jpeg'),
(73, 'SKSV3558750', 'All Furniture Works', 'NoProfile.png'),
(74, 'SKSV2790121', 'Decorators Civil Maintanance Painting Works', 'NoProfile.png'),
(75, 'SKSV8380109', 'All Electrical Work', '345sonakshi.jpeg'),
(76, 'SKSV1359487', 'All types of Electrical work Gov Electrical contractor ', 'NoProfile.png'),
(77, 'SKSV5474677', '', 'NoProfile.png');

-- --------------------------------------------------------

--
-- Table structure for table `tblvendordescription`
--

CREATE TABLE `tblvendordescription` (
  `intId` bigint(20) NOT NULL,
  `varVendorId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCharges` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblvendordescription`
--

INSERT INTO `tblvendordescription` (`intId`, `varVendorId`, `varCharges`, `varDescription`) VALUES
(1, 'SKSV9346489', '0', 'We Clean Your Any Type Of Tanks'),
(2, 'SKSV2274028', '0', 'All Types of service provider in Electrical AC and RO Residential or Commercial or Industrial'),
(3, 'SKSV7792611', '0', 'We shape the wooden goods..'),
(4, 'SKSV4336372', '0', 'All Electrical work and Plumbing'),
(5, 'SKSV6804863', '0', 'All types of Electrical works'),
(6, 'SKSV7055258', '0', 'Interior and Furniture works'),
(7, 'SKSV7368115', '0', 'Plumbing Services'),
(8, 'SKSV8547497', '0', 'House Painting Electrical Plumbing Workhouse Cleaning'),
(9, 'SKSV4091297', '0', 'Plumbing Chemical Water Proofing Contractor'),
(10, 'SKSV3972750', '0', 'Plumbing and Electrical Service'),
(11, 'SKSV4564952', '0', 'Provide House painting All Eletrical Plumbing work House cleaning'),
(13, 'SKSV6310443', '0', 'Water Purification Services'),
(14, 'SKSV3570294', '0', 'We are provide carpentery services, plumbing, electrical,tiles, civil work, pop, painting and all office home renovation work fabrication e'),
(15, 'SKSV5756797', '0', 'Sofa Repairing and new Making House Painting'),
(16, 'SKSV8505861', '0', 'Electrical Works'),
(17, 'SKSV6124432', '0', 'Plumbing Services'),
(18, 'SKSV5104575', '250', 'Electrical Services'),
(19, 'SKSV8953226', '0', 'All tipe electrical wark in hose wairig and electrical mantainance'),
(20, 'SKSV3119111', '150', 'Plumbing Services'),
(21, 'SKSV3754697', '0', 'All types of electric fitting Specialist in hospital and bank wiring CCTV camera wiring and fitting TV repair surgical appiliances repair stone crusher starter repair hotel and lodge wirings and all electrical works'),
(22, 'SKSV2126778', '0', 'All electrical works'),
(23, 'SKSV1976042', '0', 'All electrical works'),
(24, 'SKSV3433544', '0', 'herbal pest spray commercial and residential'),
(25, 'SKSV1717326', '0', 'General disinfestation Cockroach control Rodent control Bedbugs control Fleas control Anti termite treatment'),
(26, 'SKSV994219', '0', 'Bedbag Cockroach Tarmait Ends Lezard Mousekuyto honey rat and other'),
(27, 'SKSV5753905', '0', 'Electrical Services'),
(28, 'SKSV3415049', '0', 'Refrigerator Repair'),
(29, 'SKSV9254266', '0', 'Pest Control'),
(30, 'SKSV3245593', '0', 'Pest control ,house keeping sofa cleaning electric maintanance all type of water tank cleaning pest contro'),
(31, 'SKSV5103988', '0', 'specialist in servicing & repairing of all types of car denting,painting,   mechanical work also done here & tow in serv'),
(32, 'SKSV6069921', '50', 'We deal with designing  painting of Sainboards Temple Painting Gate painting & Murti statue painti'),
(33, 'SKSV63664', '0', 'Pest Control Service'),
(34, 'SKSV4121205', '100', 'Driver Services'),
(35, 'SKSV2855211', '0', ' Pest control services.  Deep cleaning.  Painting services. complete solar solution  '),
(36, 'SKSV4540990', '0', 'AC Maintences and Repair Electric fitting plumbing industrial instrument installation cabling'),
(37, 'SKSV6584757', '0', 'Air Conditioner Refrigeration washing machine RO Water purifire  repairing etc'),
(38, 'SKSV7636606', '0', 'painting work waterproofing sliding windows fabrication works civil works'),
(39, 'SKSV3345919', '0', 'marbles floor dreniz bathroom and toilet water proofing rain water harwasting roof water proofing architect construction '),
(40, 'SKSV9261305', '0', 'Paint Polish  Contractor'),
(41, 'SKSV6987753', '100', 'Laundry Services'),
(42, 'SKSV3120927', '0', ' Cockroaches,Bed bugs,Fly,Ratcontrol,Spider Pre&post construction Anti Termite,Mosquitoe'),
(43, 'SKSV7152870', '0', 'pest control When started my business Monika herbal pest control Pune'),
(44, 'SKSV7267084', '0', 'residential commercial industrial pest control service'),
(45, 'SKSV5933332', '0', 'pest control service'),
(46, 'SKSV4872944', '0', 'reasonable rate and good quality as per order customised furniture made ample selection of colorful wooden lamination also do painting  electricals granite and tiles work'),
(47, 'SKSV4435353', '0', 'Deals in Birdnet, Safetynets, Spikes,Shade net, PVC Strips Curtains And all types of nylon net e'),
(48, 'SKSV6750997', '0', 'Pest Control service'),
(49, 'SKSV7778942', '0', 'house painting  pop  gypsum ceiling  All type panting all type pop gypsum texture melamine polish dco paint lamination '),
(50, 'SKSV8697451', '0', 'installation of all type of Ac Packages VRV Pressicion ductable Split Ac and Cassette Ac Maintenance all type of cooling systems   '),
(51, 'SKSV8887248', '0', 'Refrigeration Air conditioner Deep freezer Water Coolar Washing machine VRF system Water purifire Electrical works'),
(52, 'SKSV4652474', '0', 'Drainage line Water Proof Plumber Fitting And All plumbing works'),
(53, 'SKSV8255076', '0', 'All Plumbing Works'),
(54, 'SKSV3255490', '0', 'pest control service'),
(55, 'SKSV7079379', '0', 'All type of electrical and electronic service'),
(56, 'SKSV760048', '0', 'pest control service'),
(57, 'SKSV8470581', '0', 'electrician fitting and maintainance water purifier installation and maintainance inverter and battery installation and maintainanceCCTV installation and maintainance'),
(58, 'SKSV3016458', '0', 'electrical and garage works'),
(59, 'SKSV1438525', '0', 'Specialist in transportation of household car carrier heavy waight commercial loading all over India service'),
(60, 'SKSV3061722', '0', ' international packers and movers'),
(61, 'SKSV2828460', '0', 'Bees Pest Control Services, Corporate Pest Control, Residential Pest Control, Mosquito Fogging, Pre Construction Pest Control, Termite Pest Control, Bed Bugs Pest Control, Cockroach Pest Control'),
(62, 'SKSV7426424', '0', 'International And Domastic House Hold Goods Industrial of Car Transportation Packing And Moving '),
(63, 'SKSV1062216', '0', 'All type of Electrical Maintanance And New Fitings'),
(64, 'SKSV2651258', '0', 'All type of plumbing work And Chair Repairing system'),
(65, 'SKSV3214152', '0', 'All Electrical Works '),
(66, 'SKSV2074981', '0', 'All type of Plumbing Work'),
(67, 'SKSV9147939', '0', ' Ac repairing and refrigerator repair and all refrigeration system sales and service '),
(68, 'SKSV429215', '0', 'Anti termites treatment honey Bee treatment cockroach herbal gel treatment bed bugs treatment rat treatment fogging treatment Hotels hostels college company home all type'),
(69, 'SKSV7964347', '0', 'all plimbing And Electrical services'),
(70, 'SKSV6660100', '0', ' General Disinfestations Services Cockroaches Ants and Silverfish Bed bugs Control Treatment Pre and Post Construction Anti Termite Control Treatment Rodent Control Services Mosquito Control Treatment Flies Control Treatment Wood Borer Control Services Lizards And Spider Control Treatment Ticks Control Treatment'),
(71, 'SKSV322247', '0', 'Plumbing Water Proofing styling And Maintanance'),
(72, 'SKSV8190290', '0', 'All Plumbing Works'),
(73, 'SKSV3558750', '0', 'All Furniture Works'),
(74, 'SKSV2790121', '0', 'Decorators Civil Maintanance Painting Works'),
(75, 'SKSV8380109', '0', 'All Electrical Work'),
(76, 'SKSV1359487', '0', 'All types of Electrical work\r\nGov Electrical contractor '),
(77, 'SKSV5474677', '100', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblvendorofferedservices`
--

CREATE TABLE `tblvendorofferedservices` (
  `intId` bigint(20) NOT NULL,
  `varVendorId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intServiceId` bigint(20) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblvendorofferedservices`
--

INSERT INTO `tblvendorofferedservices` (`intId`, `varVendorId`, `intServiceId`, `ex1`, `ex2`, `ex3`) VALUES
(1, 'SKSV9346489', 68147, '', '', ''),
(2, 'SKSV2274028', 93194, '', '', ''),
(3, 'SKSV7792611', 11516, '', '', ''),
(4, 'SKSV4336372', 85715, '', '', ''),
(5, 'SKSV6804863', 85715, '', '', ''),
(6, 'SKSV7055258', 86197, '', '', ''),
(7, 'SKSV7368115', 53514, '', '', ''),
(8, 'SKSV8547497', 53514, '', '', ''),
(9, 'SKSV4091297', 53514, '', '', ''),
(10, 'SKSV3972750', 85715, '', '', ''),
(11, 'SKSV4564952', 53514, '', '', ''),
(12, 'SKSV6931217', 74971, '', '', ''),
(13, 'SKSV6310443', 68147, '', '', ''),
(14, 'SKSV3570294', 86197, '', '', ''),
(15, 'SKSV5756797', 11516, '', '', ''),
(16, 'SKSV8505861', 85715, '', '', ''),
(17, 'SKSV6124432', 53514, '', '', ''),
(18, 'SKSV5104575', 85715, '', '', ''),
(19, 'SKSV8953226', 85715, '', '', ''),
(20, 'SKSV3119111', 53514, '', '', ''),
(21, 'SKSV3754697', 85715, '', '', ''),
(22, 'SKSV2126778', 85715, '', '', ''),
(23, 'SKSV1976042', 85715, '', '', ''),
(24, 'SKSV3433544', 63488, '', '', ''),
(25, 'SKSV1717326', 63488, '', '', ''),
(26, 'SKSV994219', 63488, '', '', ''),
(27, 'SKSV5753905', 85715, '', '', ''),
(28, 'SKSV3415049', 36632, '', '', ''),
(29, 'SKSV9254266', 63488, '', '', ''),
(30, 'SKSV3245593', 63488, '', '', ''),
(31, 'SKSV5103988', 91872, '', '', ''),
(32, 'SKSV6069921', 73119, '', '', ''),
(33, 'SKSV63664', 63488, '', '', ''),
(34, 'SKSV4121205', 75738, '', '', ''),
(35, 'SKSV2855211', 63488, '', '', ''),
(36, 'SKSV4540990', 93194, '', '', ''),
(37, 'SKSV6584757', 93194, '', '', ''),
(38, 'SKSV7636606', 73119, '', '', ''),
(39, 'SKSV3345919', 253141, '', '', ''),
(40, 'SKSV9261305', 73119, '', '', ''),
(41, 'SKSV6987753', 1, '', '', ''),
(42, 'SKSV3120927', 63488, '', '', ''),
(43, 'SKSV7152870', 63488, '', '', ''),
(44, 'SKSV7267084', 63488, '', '', ''),
(45, 'SKSV5933332', 63488, '', '', ''),
(46, 'SKSV4872944', 86197, '', '', ''),
(47, 'SKSV4435353', 25341, '', '', ''),
(48, 'SKSV6750997', 63488, '', '', ''),
(49, 'SKSV7778942', 73119, '', '', ''),
(50, 'SKSV8697451', 93194, '', '', ''),
(51, 'SKSV8887248', 85715, '', '', ''),
(52, 'SKSV4652474', 53514, '', '', ''),
(53, 'SKSV8255076', 53514, '', '', ''),
(54, 'SKSV3255490', 63488, '', '', ''),
(55, 'SKSV7079379', 85715, '', '', ''),
(56, 'SKSV760048', 63488, '', '', ''),
(57, 'SKSV8470581', 85715, '', '', ''),
(58, 'SKSV3016458', 1771, '', '', ''),
(59, 'SKSV1438525', 33593, '', '', ''),
(60, 'SKSV3061722', 33593, '', '', ''),
(61, 'SKSV2828460', 63488, '', '', ''),
(62, 'SKSV7426424', 33593, '', '', ''),
(63, 'SKSV1062216', 85715, '', '', ''),
(64, 'SKSV2651258', 53514, '', '', ''),
(65, 'SKSV3214152', 85715, '', '', ''),
(66, 'SKSV2074981', 53514, '', '', ''),
(67, 'SKSV9147939', 36632, '', '', ''),
(68, 'SKSV429215', 63488, '', '', ''),
(69, 'SKSV7964347', 53514, '', '', ''),
(70, 'SKSV6660100', 63488, '', '', ''),
(71, 'SKSV322247', 53514, '', '', ''),
(72, 'SKSV8190290', 53514, '', '', ''),
(73, 'SKSV3558750', 86197, '', '', ''),
(74, 'SKSV2790121', 73119, '', '', ''),
(75, 'SKSV8380109', 85715, '', '', ''),
(76, 'SKSV1359487', 85715, '', '', ''),
(77, 'SKSV5474677', 75738, '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `tblvendorservices`
--

CREATE TABLE `tblvendorservices` (
  `intId` bigint(20) NOT NULL,
  `intServiceCode` int(11) NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci,
  `varDescription` longtext COLLATE utf8_unicode_ci,
  `varVisitingFee` longtext COLLATE utf8_unicode_ci,
  `varRemark` longtext COLLATE utf8_unicode_ci,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `varIsActive` tinyint(1) DEFAULT NULL,
  `varImage` longtext COLLATE utf8_unicode_ci,
  `ex2` longtext COLLATE utf8_unicode_ci,
  `ex3` longtext COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tblvendorservices`
--

INSERT INTO `tblvendorservices` (`intId`, `intServiceCode`, `varName`, `varDescription`, `varVisitingFee`, `varRemark`, `CreatedDate`, `CreatedBy`, `varIsActive`, `varImage`, `ex2`, `ex3`) VALUES
(1, 75738, 'Driver on Demand', 'Driver on Demand', '100', '', '2016-04-15 21:12:43', 1, 1, '75738 driver.png', NULL, NULL),
(2, 25341, 'Safety Nets', 'Safety Nets', '100', '', '2016-04-15 21:12:43', 1, 1, '25341 Netsupplier.png', NULL, NULL),
(3, 93194, 'AC Service', 'An AC helps you stay cool in extreme hot and humid conditions and gives you a good reason to stay indoors. At times, your AC may develop problems and will urgently need some assistance to function smoothly. With the help of Sk Air Conditioner repair services, you can be assured that we will provide you the best services. Our AC repairing services will solve all minor and major problems of your AC. Our AC service is there to serve you anytime, anywhere, so just relax.', '150', '', '2016-04-15 21:14:34', 1, 1, '93194 acservice.png', NULL, NULL),
(4, 74971, 'PC & Laptop Repair', 'Technological equipments like laptops and computers play a crucial role in our lives. They have become communication tools which have made our lives easier. However, if these devices malfunction, Sk provides instant solutions to bring them back to life. Sk PC and laptop repair service is an expert in solving software and hardware related issues, OS issues and removal of viruses. Our professionals are computer and laptop repairing experts who have in-depth knowledge of gadgets and gizmos.', '200', '', '2016-04-15 21:15:24', 1, 1, '74971 pc laptop repair.png', NULL, NULL),
(5, 91872, 'Car Repair', 'You consider your car as a good companion that has been with you on the road of life. You adore your four-wheeler and love to show it off to your friends. However, sometimes before showing it off, you might want it to be washed and cleaned. Sks car spa service is there to wash it, clean it and shampoo it and make it ready for the road ahead. Our car washing services are unique because, we use modernized tools to clean the interior as well as the exterior of your car', '250', '', '2016-04-15 21:16:04', 1, 1, '91872 carrepairing.png', NULL, NULL),
(6, 31134, 'Salon At Home', 'Look pretty and gorgeous, any day, anytime and avail our Salon at Home services at the comfort of your home. Our beauty experts are trained to give you the best treatments, so sit back and enjoy them. Now, get waxing, manicure, pedicure, facial and massage done by our professionals and look fabulous on any occasion. Being beautiful now comes at an affordable price, with professionals who are amazing at their job and updated with the latest trends in fashion and style. Get that instant glow and be the star that grabs the limelight.', '300', '', '2016-04-15 21:16:49', 1, 1, '31134 barber.png', NULL, NULL),
(8, 63488, 'Pest Control Service', 'Pests are everywhere and they are capable of wrecking the entire household. It is very important for every household to make sure that they live in a hygienic and disease-free environment. To ensure this, one needs to pave way for a pest-free house. It is highly advised that every household gets a pest control service done at least once in three months. Skoffers the most distinguished pest control services and our background-checked professionals only make use of eco-friendly certified chemicals because we care for your well-being.', '375', '', '2016-04-15 21:18:21', 1, 1, '63488 pest control.png', NULL, NULL),
(9, 85715, 'Electrical Service', 'Why be at the receiving end of a shock and get a hair-raising experience, when Sk professionals offer a variety of electrical installation and repair solutions. Be it a switch board repair, a wiring problem, light fittings, installation and repair of electrical devices, Sk professionals are equipped to deal with it. Our professionals are skillfully trained to handle the most complex electrical problems. We provide electrical services at an affordable rate and also give tips to our customers on how to maintain the longevity of electrical devices.', '150', '', '2016-04-15 21:19:06', 1, 1, '85715 electrician.png', NULL, NULL),
(10, 53514, 'Plumbing Service', 'Your sink and your toilet play a vital role in your household and it’s because of these amenities life has become easy. When plumbing problems begin to cultivate, you can have a harrowing experience. Sk plumbing repair services is there to fix all plumbing-related problems and put you at ease. Our plumbers are professionals who have full knowledge of their work and can easily fix your sink and running toilet.', '175', '', '2016-04-15 21:19:41', 1, 1, '53514 plumber.png', NULL, NULL),
(11, 36632, 'Refrigerator Repair', 'Your refrigerator is an excellent home appliance that keeps food items fresh and makes them imperishable. But sometimes your fridge can fail to absorb moisture or the compressor might decide to calls it quits. With Sk refrigerator repair services, you can relax as our professionals can fix all refrigerator issues in an instant. Single or double door refrigerator, our refrigerator repair services promise to find right solutions.', '230', '', '2016-04-15 21:21:01', 1, 1, '36632 refrigerator.png', NULL, NULL),
(12, 62856, 'Washing Machine Repair', 'A washing machine is a reliable home appliance and serves as a blessing in disguise as it washes and cleans your clothes. It releases you from the struggle of washing your clothes on your own. But, what if your washing machine breaks down and you struggle to make ends meet. Sk washing machine repair services is the right choice to make as our technicians have deep knowledge of the appropriate methods to apply when your washing machine malfunctions. We are experts in fixing your washing machine, no matter what brand it is.', '200', '', '2016-04-15 21:21:45', 1, 1, '62856 washing service.png', NULL, NULL),
(13, 1, 'Laundry Service', 'Everyone wants to wear the best clothes and look stunning. But in life, everything doesn’t fall in the right place and at times, your clothes can get dirty, messy and stained. Sk laundry service provides the right solution and helps remove dust and stubborn stains that refuse to go. Our professionals dry clean your clothes at an affordable price. Free pickup and drop facility is an added advantage with our laundry services, so go ahead and get dirty and we’ll clean it for you.', '50', '', '2016-04-15 21:22:26', 1, 1, '1 laundry.png', NULL, NULL),
(14, 32525, 'Geyser Service', 'Winter or summer season, everyone craves for a hot shower that refreshes you. However, the source of consistent hot water supply can malfunction. Problems can get worse if your geyser remains unattended for a long time. Sk geyser repair service is there to fix all issues of your geyser. Our geyser service is the best as we check and only after we’re sure of the problem, we apply the right treatment.', '200', '', '2016-04-15 21:23:01', 1, 1, '32525 geyser services.png', NULL, NULL),
(15, 73119, 'Colour your home', 'How often do you paint your home? We are sure that it’s not very regular hence we recommend you to avoid associating yourself with unprofessional, shabby, traditional painters. With us it''s time to experience our innovative, mechanized and professional yet economic painting services.', '500', '', '2016-04-15 21:23:40', 1, 1, '73119 painter.png', NULL, NULL),
(16, 37747, 'Microwave Repair', 'A microwave is a much needed solace when you require food that only needs to be heated and consumed. Over the years, it slows down and may need quick fixes in order to function smoothly. You can whole-heartedly trust Sk to repair your microwave in order to eat that delicious cake or that mouth-watering pizza. Our professionals can repair convection, solo and a grill microwave. Sk microwave repair service is there to comfort all householders who are worried about their microwave oven getting damaged or spoilt.', '250', '', '2016-04-15 21:24:20', 1, 1, '37747 microwaverepairing.png', NULL, NULL),
(17, 18213, 'Sofa Spa', 'Your sofa has given you comfort and relaxation but while doing so it has gathered stains and dirt. The sofa fabric has absorbed dust particles, stains, dog fur, pests, termites and food crumbs. To cure your sofa off such issues, you can rely on Sk sofa cleaning services that deep cleans your sofa and gives it the right treatment. Our sofa cleaning experts use technologically enhanced tools to clean your sofa and make it look fabulous.', '200', '', '2016-04-15 21:24:59', 1, 1, '18213 sofaserivice.png', NULL, NULL),
(18, 86197, 'Carpentry Service', 'The craftsmanship of Sk carpentry services is unmatched because our professionals are equipped with the latest tools and products to give your house the best finish. From door installation, window fitting, reshaping and molding of a cabinet to construction of external and interior furniture, our professional carpenters do it all. Give us your house and we’ll turn it into a masterpiece.', '200', '', '2016-04-15 21:25:36', 1, 1, '86197 construction.png', NULL, NULL),
(19, 32331, 'Carpet Spa', 'Your carpet adds grace and elegance to your house and makes it look more inviting and presentable. However, over the years your carpet can get dirty and might even develop a stain, and sometimes dust particles too find space in your carpet that are not visible to the naked eye. Sk carpet cleaning services provide instant solution that gives your carpet a new look. Our carpet cleaners deep clean your carpet and ensure quality service. We are experts at cleaning residential carpets and make sure the life-span of your carpet increases by many years.', '150', '', '2016-04-15 21:26:09', 1, 1, '32331 carpet cleaning.png', NULL, NULL),
(20, 1515, 'Cooler Service', 'Cooler Service', '100', '', '2016-04-26 00:00:00', 1, 1, '1515 air cooler.png', NULL, NULL),
(21, 1616, 'TV Repair', 'TV Repair', '', '', '2016-04-26 00:00:00', 1, 1, '1616 tv repair.png', NULL, NULL),
(22, 1771, 'Two Wheeler Repair', 'Two Wheeler Repair', '', '', '2016-04-26 00:00:00', 1, 1, '1771 motercycle.png', NULL, NULL),
(23, 1881, 'Window Slider', 'Window Slider', '', '', '2016-04-26 00:00:00', 1, 1, '1881 window repairing.png', NULL, NULL),
(24, 11516, 'Furniture On Choice', 'Furniture On Choice', '', '', '2016-04-26 00:00:00', 1, 1, '11516 furniture.png', NULL, NULL),
(25, 1818, 'Mobile Repair', 'Mobile Repair', '', '', '2016-04-26 00:00:00', 1, 1, '1818 mobile repairing.png', NULL, NULL),
(26, 8741, 'Weilding Service', 'Weilding Service', '', '', '2016-04-26 00:00:00', 1, 1, '8741 weilding.png', NULL, NULL),
(27, 68147, 'Tank Cleaners', '', '', '', '2016-06-20 17:24:04', 1, 1, '68147 cleaning.png', NULL, NULL),
(28, 253141, 'Construction', 'Construction', '100', '', '2016-04-15 21:12:43', 1, 1, '253141 Construction.png', NULL, NULL),
(29, 33593, 'Transport', '', '', '', '2016-07-30 09:58:50', 1, 1, '33593 logo.png', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tblvendorservicestype`
--

CREATE TABLE `tblvendorservicestype` (
  `intId` bigint(20) NOT NULL,
  `intServicetypeCode` int(11) NOT NULL,
  `intServiceCode` int(11) NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci,
  `varDescription` longtext COLLATE utf8_unicode_ci,
  `varRemark` longtext COLLATE utf8_unicode_ci,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `varIsActive` tinyint(1) DEFAULT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci,
  `ex2` longtext COLLATE utf8_unicode_ci,
  `ex3` longtext COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblvendorservicesubtype`
--

CREATE TABLE `tblvendorservicesubtype` (
  `intId` bigint(20) NOT NULL,
  `intServicesubtypeCode` int(11) NOT NULL,
  `intServiceCode` int(11) NOT NULL,
  `intSevicetypeCode` int(11) NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci,
  `varPrice` longtext COLLATE utf8_unicode_ci,
  `varDescription` longtext COLLATE utf8_unicode_ci,
  `varRemark` longtext COLLATE utf8_unicode_ci,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `varIsActive` tinyint(1) DEFAULT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci,
  `ex2` longtext COLLATE utf8_unicode_ci,
  `ex3` longtext COLLATE utf8_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `citymaster`
--
ALTER TABLE `citymaster`
  ADD PRIMARY KEY (`CityId`);

--
-- Indexes for table `tblcustomer`
--
ALTER TABLE `tblcustomer`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblorder`
--
ALTER TABLE `tblorder`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblordercomplaints`
--
ALTER TABLE `tblordercomplaints`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblorderhistory`
--
ALTER TABLE `tblorderhistory`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblreviews`
--
ALTER TABLE `tblreviews`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblvendor`
--
ALTER TABLE `tblvendor`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblvendorabout`
--
ALTER TABLE `tblvendorabout`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblvendordescription`
--
ALTER TABLE `tblvendordescription`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblvendorofferedservices`
--
ALTER TABLE `tblvendorofferedservices`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblvendorservices`
--
ALTER TABLE `tblvendorservices`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblvendorservicestype`
--
ALTER TABLE `tblvendorservicestype`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblvendorservicesubtype`
--
ALTER TABLE `tblvendorservicesubtype`
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
-- AUTO_INCREMENT for table `tblcustomer`
--
ALTER TABLE `tblcustomer`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `tblenquiry`
--
ALTER TABLE `tblenquiry`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `tblorder`
--
ALTER TABLE `tblorder`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `tblordercomplaints`
--
ALTER TABLE `tblordercomplaints`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblorderhistory`
--
ALTER TABLE `tblorderhistory`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `tblreviews`
--
ALTER TABLE `tblreviews`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;
--
-- AUTO_INCREMENT for table `tblvendor`
--
ALTER TABLE `tblvendor`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;
--
-- AUTO_INCREMENT for table `tblvendorabout`
--
ALTER TABLE `tblvendorabout`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;
--
-- AUTO_INCREMENT for table `tblvendordescription`
--
ALTER TABLE `tblvendordescription`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;
--
-- AUTO_INCREMENT for table `tblvendorofferedservices`
--
ALTER TABLE `tblvendorofferedservices`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;
--
-- AUTO_INCREMENT for table `tblvendorservices`
--
ALTER TABLE `tblvendorservices`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `tblvendorservicestype`
--
ALTER TABLE `tblvendorservicestype`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblvendorservicesubtype`
--
ALTER TABLE `tblvendorservicesubtype`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
