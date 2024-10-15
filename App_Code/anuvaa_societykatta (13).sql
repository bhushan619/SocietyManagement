-- phpMyAdmin SQL Dump
-- version 4.6.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 07, 2016 at 10:39 AM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+05:30";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `anuvaa_societykatta`
--

DELIMITER $$
--
-- Procedures
--
CREATE  PROCEDURE `GetNavigationMenus` (IN `inUserId` INT, IN `inFeatureId` INT)  BEGIN
	SELECT A.FeatureId,FMC.FeatureName,A.PageName 
  FROM featuresmaster A
    INNER JOIN featuresmasterculturemap FMC ON FMC.FeatureId=A.FeatureId
    INNER JOIN rolefeaturesmap C ON C.FeatureId = A.FeatureId
    INNER JOIN users U ON U.RoleId=C.RoleId
  WHERE U.UserId=inUserId AND A.ParentId=inFeatureId AND U.IsActive=1 AND A.isActive=1
  ORDER BY A.FeatureId,A.ParentId;
END$$

CREATE  PROCEDURE `GetParentMenuByUserId` (IN `inUserId` INT)  BEGIN
    SELECT A.FeatureId,FMC.FeatureName,A.PageName,A.SortOrder
    FROM featuresmaster A
      INNER JOIN featuresmasterculturemap FMC ON FMC.FeatureId=A.FeatureId
      INNER JOIN rolefeaturesmap C ON C.FeatureId = A.FeatureId
      INNER JOIN users U ON U.RoleId=C.RoleId
    WHERE A.ParentId=0 AND A.IsActive=1 
    AND U.UserId=inUserId AND U.IsActive=1 
    ORDER BY A.SortOrder;
END$$

CREATE  PROCEDURE `GetReportParentMenusByUserId` (IN `inUserId` INT)  BEGIN
    SELECT A.FeatureId,FMC.FeatureName,A.PageName,A.SortOrder
    FROM featuresmaster A
      INNER JOIN featuresmasterculturemap FMC ON FMC.FeatureId=A.FeatureId
      INNER JOIN rolefeaturesmap C ON C.FeatureId = A.FeatureId
      INNER JOIN users U ON U.RoleId=C.RoleId
    WHERE A.ParentId=-1 AND A.IsActive=1 
    AND U.UserId=inUserId AND U.IsActive=1
    ORDER BY A.SortOrder;
END$$

CREATE  PROCEDURE `sp_Delete_VendorService` (IN `spintServiceCode` INT)  BEGIN
DELETE FROM `tblvendorservices` WHERE `intServiceCode`=spintServiceCode;
DELETE FROM `tblvendorservicestype` WHERE `intServiceCode`=spintServiceCode;
DELETE FROM `tblvendorservicesubtype` WHERE `intServiceCode`=spintServiceCode;

END$$

CREATE  PROCEDURE `sp_Delete_VendorServiceSubType` (IN `spintServicesubtypeCode` INT)  BEGIN

DELETE FROM `tblvendorservicesubtype` WHERE intServicesubtypeCode=spintServicesubtypeCode ;
END$$

CREATE  PROCEDURE `sp_Delete_VendorServiceType` (IN `spintServicetypeCode` INT)  BEGIN
DELETE FROM `tblvendorservicestype` WHERE `intServicetypeCode`=spintServicetypeCode;
DELETE FROM `tblvendorservicesubtype` WHERE `intServicetypeCode`=spintServicetypeCode;
END$$

CREATE  PROCEDURE `sp_insert_Feature` (IN `spFeatureName` TEXT, IN `spParentId` INT, IN `spPageName` TEXT, IN `spCreatedBy` INT, IN `spCultureId` INT, IN `spIsActive` TINYINT, IN `rValue` INT, IN `spisSubMenu` TEXT)  BEGIN
IF EXISTS (SELECT * FROM `featuresmaster` WHERE `varFeatureName`=spFeatureName and ParentId=spParentId) 
THEN 
 set rValue=0;
   ELSE 
  INSERT INTO `featuresmaster`( `ParentId`, `varFeatureName`, `PageName`,isSubMenu, CreatedDate, `CreatedBy`, `IsActive`) VALUES (spParentId, spFeatureName,spPageName,spisSubMenu,convert_tz(now() , @@session.time_zone ,'+05:30'),spCreatedBy,spIsActive);
  END IF;
END$$

CREATE  PROCEDURE `sp_insert_Invoice` (IN `varOrderNo` TEXT, IN `varDateTime` TEXT, IN `intFromSocietyId` TEXT, IN `intFromRole` TEXT, IN `intFromId` TEXT, IN `varSubTotal` TEXT, IN `varDiscount` TEXT, IN `varTax` TEXT, IN `varOther` TEXT, IN `varTotal` TEXT)  BEGIN

 SELECT @invoiceid:= concat("SKSI", FLOOR(RAND()*9567242));

INSERT INTO `tblinvoice`(`varInvoiceId`, `varOrderNo`, `varDateTime`, `intFromSocietyId`, `intFromRole`, `intFromId`,  `varSubTotal`, `varDiscount`, `varTax`, `varOther`, `varTotal`)
values
(  @invoiceid,varOrderNo, varDateTime, intFromSocietyId, intFromRole, intFromId,   varSubTotal, varDiscount, varTax, varOther, varTotal);

 

END$$

CREATE  PROCEDURE `sp_insert_Role` (IN `spDeptId` INT(10), IN `spCreatedBy` INT(10), IN `spIsActive` TINYINT(1), IN `spRoleName` TEXT, IN `spCultureId` INT(10), IN `rValue` INT(10), IN `spSocietyId` TEXT)  IF EXISTS (SELECT * FROM rolesmasterculturemap WHERE RoleName = spRoleName  and varSocietyId=spSocietyId LIMIT 1) THEN 
 set rValue=0;
   ELSE 
   INSERT INTO `rolesmaster`( DeptId,`CreatedDate`, `CreatedBy`, `IsActive`) VALUES (spDeptId,convert_tz(now() , @@session.time_zone ,'+05:30'),spCreatedBy,spIsActive);
   SELECT @roleide:=LAST_INSERT_ID();
INSERT INTO `rolesmasterculturemap`(`RoleId`,varSocietyId, `RoleName`, `CultureId`) VALUES (@roleide,spSocietyId ,spRoleName, spCultureId);  
INSERT INTO `rolefeaturesmap` (`RoleId`, `FeatureId`, `IsCreate`, `IsRead`, `IsUpdate`, `IsDelete`, `varSocietyId`, `IsActive`) VALUES
(@roleide,  5, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  51, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  52, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  6, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  53, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  54, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  7, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  55, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  15, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  56, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  8, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  57, 0, 0, 0, 0, spSocietyId, 1),
(@roleide,  58, 0, 0, 0, 0, spSocietyId, 1);
   END IF$$

CREATE  PROCEDURE `sp_insert_RoleFeaturesMap` (IN `spRoleId` INT, IN `spFeatureId` INT, IN `spIsCreate` INT, IN `spIsRead` INT, IN `spIsUpdate` INT, IN `spIsDelete` INT, IN `varSocietyId` TEXT, IN `spIsActive` INT)  BEGIN
declare rValue int;
	IF EXISTS (SELECT * FROM `rolefeaturesmap` WHERE `RoleId`=spRoleId and `FeatureId`=spFeatureId) 
	THEN   

	set rValue=0;
	ELSE  
INSERT INTO `rolefeaturesmap`(`RoleId`, `FeatureId`, `IsCreate`, `IsRead`, `IsUpdate`, `IsDelete`, `varSocietyId`, `IsActive`) VALUES (spRoleId,spFeatureId,spIsCreate,spIsRead,spIsUpdate,spIsDelete,varSocietyId,spIsActive);

	END IF;
END$$

CREATE  PROCEDURE `sp_insert_Society` (IN `spSvarRegistrationNo` TEXT, IN `spSvarName` TEXT, IN `spSvarSAddress` TEXT, IN `spSvarSPhone` TEXT, IN `spSvarSMobile` TEXT, IN `spSvarSEmail` TEXT, IN `spSvarCountryId` TEXT, IN `spSvarStateId` TEXT, IN `spSvarCityId` TEXT, IN `spEmpName` TEXT, IN `spPassword` TEXT, IN `cpname` TEXT, IN `cpmobile` TEXT, IN `cpphone` TEXT, IN `cpemail` TEXT)  NO SQL
BEGIN 


 SELECT @societyid:= concat("SKS", FLOOR(RAND()*9567242));
 SELECT @empid:= concat("SKSE", FLOOR(RAND()*9567242));

 INSERT INTO `tblsocietyinfo`
 (`intSocietyCode`, `varRegistrationNo`, `varName`, `varSAddress`, `varSPhone`, `varSMobile`, `varSEmail`, `varCountryId`, `varStateId`, `varCityId`,varContactPerson,varContactMobile,varContactPhone,varContactEmail,`varIsActive`) VALUES 
 (@societyid,spSvarRegistrationNo,spSvarName,spSvarSAddress,spSvarSPhone,spSvarSMobile,spSvarSEmail,spSvarCountryId,spSvarStateId,spSvarCityId,cpname,  cpmobile,  cpphone,  cpemail ,1);

   INSERT INTO `tblmasterdepartment`
 (  `varSocietyId`, `varDepartmentName`, `varDescription`, `varCreatedDate`, `intCreatedBy`, `intIsActive`) VALUES 
 (@societyid,'Administration','Administrative Services',convert_tz(now() , @@session.time_zone ,'+05:30'),1,1);

 SELECT @adeptid:=LAST_INSERT_ID();

 INSERT INTO `rolesmaster`
 (  `DeptId`, `CreatedDate`, `CreatedBy`, `IsActive`) VALUES
  ( @adeptid,convert_tz(now() , @@session.time_zone ,'+05:30'),1,1);

   SELECT @roleid:=LAST_INSERT_ID();

  INSERT INTO `rolesmasterculturemap`
  (`RoleId`, `varSocietyId`, `RoleName`, `CultureId`) VALUES 
  (@roleid,@societyid,'Admin',1); 

 INSERT INTO `rolefeaturesmap` (`RoleId`, `FeatureId`, `IsCreate`, `IsRead`, `IsUpdate`, `IsDelete`, `varSocietyId`, `IsActive`) VALUES
(@roleid, 2, 0, 0, 0, 0, @societyid, 1),
(@roleid, 23, 0, 0, 0, 0, @societyid, 1),
(@roleid, 24, 0, 0, 0, 0, @societyid, 1),
(@roleid, 25, 0, 0, 0, 0, @societyid, 1),
(@roleid, 26, 0, 0, 0, 0, @societyid, 1),
(@roleid, 27, 0, 0, 0, 0, @societyid, 1),
(@roleid, 28, 0, 0, 0, 0, @societyid, 1),
(@roleid, 29, 0, 0, 0, 0, @societyid, 1),
(@roleid, 30, 0, 0, 0, 0, @societyid, 1),
(@roleid, 31, 0, 0, 0, 0, @societyid, 1),
(@roleid, 32, 0, 0, 0, 0, @societyid, 1),
(@roleid, 33, 0, 0, 0, 0, @societyid, 1),
(@roleid, 15, 0, 0, 0, 0, @societyid, 1),
(@roleid, 34, 0, 0, 0, 0, @societyid, 1),
(@roleid, 35, 0, 0, 0, 0, @societyid, 1),
(@roleid, 36, 0, 0, 0, 0, @societyid, 1),
(@roleid, 37, 0, 0, 0, 0, @societyid, 1),
(@roleid, 38, 0, 0, 0, 0, @societyid, 1),
(@roleid, 39, 0, 0, 0, 0, @societyid, 1),
(@roleid, 40, 0, 0, 0, 0, @societyid, 1),
(@roleid, 41, 0, 0, 0, 0, @societyid, 1),
(@roleid, 42, 0, 0, 0, 0, @societyid, 1),
(@roleid, 43, 0, 0, 0, 0, @societyid, 1),
(@roleid, 44, 0, 0, 0, 0, @societyid, 1),
(@roleid, 46, 0, 0, 0, 0, @societyid, 1),
(@roleid, 47, 0, 0, 0, 0, @societyid, 1),
(@roleid, 48, 0, 0, 0, 0, @societyid, 1),
(@roleid, 4, 0, 0, 0, 0, @societyid, 1),
(@roleid, 49, 0, 0, 0, 0, @societyid, 1),
(@roleid, 50, 0, 0, 0, 0, @societyid, 1),
(@roleid, 5, 0, 0, 0, 0, @societyid, 1),
(@roleid, 51, 0, 0, 0, 0, @societyid, 1),
(@roleid, 52, 0, 0, 0, 0, @societyid, 1),
(@roleid, 6, 0, 0, 0, 0, @societyid, 1),
(@roleid, 53, 0, 0, 0, 0, @societyid, 1),
(@roleid, 54, 0, 0, 0, 0, @societyid, 1),
(@roleid, 7, 0, 0, 0, 0, @societyid, 1),
(@roleid, 55, 0, 0, 0, 0, @societyid, 1),
(@roleid, 56, 0, 0, 0, 0, @societyid, 1),
(@roleid, 8, 0, 0, 0, 0, @societyid, 1),
(@roleid, 57, 0, 0, 0, 0, @societyid, 1),
(@roleid, 58, 0, 0, 0, 0, @societyid, 1),
(@roleid, 9, 0, 0, 0, 0, @societyid, 1),
(@roleid, 12, 0, 0, 0, 0, @societyid, 1),
(@roleid, 59, 0, 0, 0, 0, @societyid, 1);

  INSERT INTO `tblmasterdepartment`
 (  `varSocietyId`, `varDepartmentName`, `varDescription`, `varCreatedDate`, `intCreatedBy`, `intIsActive`) VALUES 
 (@societyid,'Property','Property Details',convert_tz(now() , @@session.time_zone ,'+05:30'),1,1);

 SELECT @pdeptid:=LAST_INSERT_ID();

  INSERT INTO `rolesmaster`
 (  `DeptId`, `CreatedDate`, `CreatedBy`, `IsActive`) VALUES
  ( @pdeptid,convert_tz(now() , @@session.time_zone ,'+05:30'),1,1);

   SELECT @roleidp:=LAST_INSERT_ID();

  INSERT INTO `rolesmasterculturemap`
  (`RoleId`, `varSocietyId`, `RoleName`, `CultureId`) VALUES 
  (@roleidp,@societyid,'Property Owner',1);

INSERT INTO `rolefeaturesmap` (`RoleId`, `FeatureId`, `IsCreate`, `IsRead`, `IsUpdate`, `IsDelete`, `varSocietyId`, `IsActive`) VALUES
(@roleidp,6, 0, 0, 0, 0, @societyid, 1),
(@roleidp,10, 0, 0, 0, 0, @societyid, 1),
(@roleidp,11, 0, 0, 0, 0, @societyid, 1),
(@roleidp,13, 0, 0, 0, 0, @societyid, 1),
(@roleidp,14, 0, 0, 0, 0, @societyid, 1),
(@roleidp,16, 0, 0, 0, 0, @societyid, 1),
(@roleidp,5, 0, 0, 0, 0, @societyid, 1),
(@roleidp,51, 0, 0, 0, 0, @societyid, 1),
(@roleidp,52, 0, 0, 0, 0, @societyid, 1),
(@roleidp,6, 0, 0, 0, 0, @societyid, 1),
(@roleidp,53, 0, 0, 0, 0, @societyid, 1),
(@roleidp,54, 0, 0, 0, 0, @societyid, 1),
(@roleidp,7, 0, 0, 0, 0, @societyid, 1),
(@roleidp,55, 0, 0, 0, 0, @societyid, 1),
(@roleidp,56, 0, 0, 0, 0, @societyid, 1),
(@roleidp,8, 0, 0, 0, 0, @societyid, 1),
(@roleidp,57, 0, 0, 0, 0, @societyid, 1),
(@roleidp,58, 0, 0, 0, 0, @societyid, 1),
(@roleidp,15, 0, 0, 0, 0, @societyid, 1);


  INSERT INTO `tblmastermemployeetype`
  ( `varSocietyId`, `varEmpTypeName`, `varDescription`, `varCreatedDate`, `intCreatedBy`, `intIsActive`) VALUES 
  (@societyid,'Permanant','Permanant Employee',convert_tz(now() , @@session.time_zone ,'+05:30'),1,1);

   SELECT @emptype:=LAST_INSERT_ID();

   INSERT INTO `tblsocietypersonnel`
  (`intSocietyId`, `intEmpCode`, `intDeptId`, `intRole`, `intEmpType`, `varEmpName`, `intCountry`, `intState`, `intCity`, varImage,varMbPrimary,varPrimaryEmail,`varUsername`, `varPassword`, `intIsActive`, `intCreatedBy`, `varCreatedDate`,varDOB,varDateOfJoin) VALUES 
  (@societyid,@empid,@adeptid,@roleid, @emptype,spEmpName,spSvarCountryId,spSvarStateId,spSvarCityId,'NoProfile.png', cpmobile,  cpphone, @empid,spPassword,1,1,convert_tz(now() , @@session.time_zone ,'+05:30'),'0001-01-01','0001-01-01');

INSERT INTO `tblassignnotifications`( `varSocietyId`, `varPersonalId`, `intRoleId` ) VALUES (@societyid,@empid, @roleid);


    INSERT INTO `tblmastermemployeetype`
  ( `varSocietyId`, `varEmpTypeName`, `varDescription`, `varCreatedDate`, `intCreatedBy`, `intIsActive`) VALUES 
  (@societyid,'Contract Basis','Contract Basis Employee',convert_tz(now() , @@session.time_zone ,'+05:30'),1,1); 
 END$$

CREATE  PROCEDURE `sp_insert_Title` (IN `spCreatedBy` INT, IN `spIsActive` INT, IN `spTitleName` TEXT, IN `spCultureId` INT, IN `rValue` INT, IN `spsocietyid` TEXT)  IF EXISTS (SELECT * FROM `titlemasterculturemap` WHERE `TitleName`= spTitleName and varSocietyid=spsocietyid  LIMIT 1) THEN 
 set rValue=0;
   ELSE 
   INSERT INTO `titlemaster`( `CreatedDate`, `CreatedBy`, `IsActive`) VALUES (convert_tz(now() , @@session.time_zone ,'+05:30'),spCreatedBy,spIsActive);

INSERT INTO `titlemasterculturemap`(`TitleId`,varSocietyid, `TitleName`, `CultureId`) VALUES (LAST_INSERT_ID(),spsocietyid,spTitleName,spCultureId); 
   END IF$$

CREATE  PROCEDURE `sp_insert_User_FromAdmin` (IN `spSocietyId` INT, IN `spIsActive` INT, IN `spCreatedBy` TEXT, IN `spTitleId` INT, IN `spFirstName` TEXT, IN `spMiddleName` TEXT, IN `spFamilyName` TEXT, IN `spDisplayName` TEXT, IN `spUsername` TEXT, IN `spPassword` TEXT, IN `spEmailAddress` TEXT, IN `spCountryCode` TEXT, IN `spPhoneNumber` BIGINT, IN `spRoleId` INT, IN `spDefaultCultureId` INT, IN `rValue` INT)  BEGIN

DECLARE expectedlimit int;
DECLARE currentlimit int;
DECLARE returnvalue int;


SELECT Limits INTO expectedlimit
FROM appproperties
WHERE (SocietyId = spSocietyId);
SELECT count(UserId) INTO currentlimit
FROM `users`
WHERE (SocietyId = spSocietyId);

IF expectedlimit>currentlimit
THEN
	IF EXISTS (SELECT * FROM users WHERE RoleId=spRoleId AND EmailAddress =spEmailAddress) 
	THEN   
	set returnvalue=1;
	set rValue=returnvalue;
	ELSE  
	INSERT INTO `users`( `SocietyId`, `TitleId`, `FirstName`, `MiddleName`, `FamilyName`, `DisplayName`, `Username`, `Password`, `UserImage`, `EmailAddress`, `Fax`, `CountryCode`, `PhoneNumber`, `RoleId`, `DefaultCultureId`, `LicenceKey`, `DeviceType`,  `IsBlocked`, `FirstLoginDate`, `LastLoginDate`, `LoginExpiryDate`, `RegisteredDate`, `IsLoggedIn`, `CreatedDate`, `CreatedBy`, `IsActive`) VALUES (spSocietyId,spTitleId,spFirstName,spMiddleName,spFamilyName,spDisplayName,spUsername, spPassword,'NoProfile.png',spEmailAddress,'0',spCountryCode,spPhoneNumber,spRoleId,spDefaultCultureId,'','',0,'','','',convert_tz(now() , @@session.time_zone ,'+05:30'),0,convert_tz(now() , @@session.time_zone ,'+05:30'),spCreatedBy,spIsActive);
	set returnvalue=0;
	set rValue=returnvalue;
	END IF;
ELSE 
   	set returnvalue=2;
	set rValue=returnvalue;
END IF; 
select rValue;
END$$

CREATE  PROCEDURE `sp_insert_VendorService` (IN `spServiceCode` INT, IN `spName` TEXT, IN `spDescription` TEXT, IN `spVisitingFee` TEXT, IN `spRemark` TEXT, IN `spCreatedBy` TEXT, IN `spIsActive` TEXT, IN `spvarImage` TEXT, IN `rValue` TEXT)  BEGIN
IF EXISTS (SELECT * FROM tblvendorservices WHERE varName=spName) 
THEN 
 set rValue=0;
ELSE 
	INSERT INTO tblvendorservices(intServiceCode,  varName, varDescription, varVisitingFee, varRemark, CreatedDate, CreatedBy, varIsActive,varImage) 
	VALUES 	(spServiceCode,spName,spDescription,spVisitingFee,spRemark,convert_tz(now() , @@session.time_zone,'+05:30'),spCreatedBy,spIsActive,spvarImage);
   END IF;
END$$

CREATE  PROCEDURE `sp_insert_VendorServiceSubType` (IN `spintServicesubtypeCode` INT, IN `spSevicetypeCode` INT, IN `spServiceCode` INT, IN `spName` TEXT, IN `spPrice` TEXT, IN `spDescription` TEXT, IN `spRemark` TEXT, IN `spCreatedBy` TEXT, IN `spIsActive` TEXT, IN `rValue` TEXT)  BEGIN
IF EXISTS (SELECT * FROM tblvendorservicesubtype WHERE varName=spName and intSevicetypeCode=spSevicetypeCode) 
THEN 
 set rValue=0;
ELSE 
INSERT INTO `tblvendorservicesubtype`( intServicesubtypeCode, `intServiceCode`,	intSevicetypeCode, `varName`,varPrice, `varDescription`, `varRemark`, `CreatedDate`, `CreatedBy`, `varIsActive`) 
	VALUES 	(spintServicesubtypeCode,spServiceCode,spSevicetypeCode,spName,spPrice,spDescription,spRemark,convert_tz(now() , @@session.time_zone,'+05:30'),spCreatedBy,spIsActive);
   END IF;
END$$

CREATE  PROCEDURE `sp_insert_VendorServiceType` (IN `spServicetypeCode` INT, IN `spServiceCode` INT, IN `spName` TEXT, IN `spDescription` TEXT, IN `spRemark` TEXT, IN `spCreatedBy` TEXT, IN `spIsActive` TEXT, IN `rValue` TEXT)  BEGIN
IF EXISTS (SELECT * FROM tblvendorservicestype WHERE varName=spName) 
THEN 
 set rValue=0;
ELSE 
INSERT INTO `tblvendorservicestype`( `intServicetypeCode`, `intServiceCode`, `varName`, `varDescription`, `varRemark`, `CreatedDate`, `CreatedBy`, `varIsActive`) 
	VALUES 	(spServicetypeCode,spServiceCode,spName,spDescription,spRemark,convert_tz(now() , @@session.time_zone,'+05:30'),spCreatedBy,spIsActive);
   END IF;
END$$

CREATE  PROCEDURE `sp_SelectUserName` ()  BEGIN
SELECT        CONCAT(FirstName,' ',  MiddleName,' ',FamilyName) AS Username,UserId
FROM    users WHERE  users.IsActive = 1  ;
END$$

CREATE  PROCEDURE `sp_select_Feature` (IN `spintRoleId` TEXT)  BEGIN
SELECT DISTINCT 
                         rolefeaturesmap.RoleId, featuresmaster.FeatureId, featuresmaster.ParentId, featuresmaster.varFeatureName, featuresmaster.PageName, 
                         featuresmaster.isSubMenu, featuresmaster.IsActive,featuresmaster.varIcon
FROM            featuresmaster INNER JOIN
                         rolefeaturesmap ON featuresmaster.FeatureId = rolefeaturesmap.FeatureId
WHERE        (rolefeaturesmap.RoleId = spintRoleId) and featuresmaster.IsActive=1;
END$$

CREATE  PROCEDURE `sp_select_MenuFromFeature` (IN `spParentId` TEXT)  BEGIN
SELECT   DISTINCT     featuresmaster.FeatureId, featuresmaster.ParentId, featuresmaster.PageName, featuresmaster.CreatedDate, featuresmaster.CreatedBy, 
                         featuresmaster.varFeatureName,  featuresmaster.IsActive
FROM            featuresmaster  where ParentId=spParentId;
END$$

CREATE  PROCEDURE `sp_select_PropertyDetailsByWhere` (IN `spwhere` TEXT)  BEGIN
 SET @getproperty= concat("SELECT    tblproperty.intid,    tblmastersocietywing.varWingName, tblmasterunittype.varUnitTypeName, tblmasterflatpremisestype.varFlatPremisesName, tblproperty.varPropertyId, 
                         tblproperty.varSocietyId, tblproperty.intRoleId, tblproperty.intWingId, tblproperty.intPremisesUnitId, tblproperty.intPremisesTypeId, tblproperty.varPropertyCode, 
                         tblproperty.varName, tblproperty.varExtensionNo, tblproperty.varAlternateAddress, tblproperty.varPhoneNo, tblproperty.varMobile, tblproperty.varAlternateMobile, 
                         tblproperty.varEmail, tblproperty.varAlternateEmail, tblproperty.varUsername, tblproperty.varImage, tblproperty.varPassword, date_format(tblproperty.varCreatedDate,'%d-%m-%Y') as varCreatedDate ,  tblproperty.varCreatedBy, 
                         tblproperty.intIsActive, tblpropertydetails.varDateofPurchase, tblpropertydetails.varArea, tblpropertydetails.varIsRenovated, tblpropertydetails.varCosting, 
                         tblpropertydetails.varCurrency
FROM            tblproperty INNER JOIN
                         tblmastersocietywing ON tblproperty.intWingId = tblmastersocietywing.intId INNER JOIN
                         tblmasterunittype ON tblproperty.intPremisesUnitId = tblmasterunittype.intId INNER JOIN
                         tblmasterflatpremisestype ON tblproperty.intPremisesTypeId = tblmasterflatpremisestype.intId INNER JOIN
                         tblpropertydetails ON tblproperty.varPropertyId = tblpropertydetails.varPropertyId where ",spwhere);

						 PREPARE stmt FROM @getproperty;
EXECUTE stmt;
						 
END$$

CREATE  PROCEDURE `sp_select_Role` (IN `spSocietyId` TEXT)  BEGIN
SELECT      (SELECT `varDepartmentName` FROM `tblmasterdepartment` WHERE `intId`=rolesmaster.DeptId  ) As Department, rolesmasterculturemap.RoleName,  rolesmaster.CreatedDate, rolesmaster.CreatedBy, rolesmaster.IsActive, rolesmaster.RoleId,
                         rolesmasterculturemap.CultureId
FROM            rolesmaster INNER JOIN
                         rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE rolesmaster.IsActive=1 AND rolesmasterculturemap.varSocietyId  = spSocietyId and  rolesmaster.RoleId!=1;
END$$

CREATE  PROCEDURE `sp_select_RoleByDepartmentId` (IN `spDeptId` INT)  BEGIN
SELECT      (SELECT `varDepartmentName` FROM `tblmasterdepartment` WHERE `intId`=rolesmaster.DeptId  ) As Department, rolesmasterculturemap.RoleName,  rolesmaster.CreatedDate, rolesmaster.CreatedBy, rolesmaster.IsActive, rolesmaster.RoleId,
                         rolesmasterculturemap.CultureId
FROM            rolesmaster INNER JOIN
                         rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE rolesmaster.DeptId =spDeptId and rolesmaster.IsActive=1 AND rolesmaster.RoleId!=1  ;
END$$

CREATE  PROCEDURE `sp_select_RoleFeaturesMap` (IN `spvarSocietyId` LONGTEXT, IN `spAdminId` LONGTEXT, IN `spPropertyId` LONGTEXT)  BEGIN
SELECT        rolesmasterculturemap.RoleName AS Role, featuresmaster.varFeatureName AS `Feature Name`
FROM            rolefeaturesmap INNER JOIN
                         rolesmaster ON rolefeaturesmap.RoleId = rolesmaster.RoleId INNER JOIN
                         rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId INNER JOIN
                         featuresmaster ON rolefeaturesmap.FeatureId = featuresmaster.FeatureId
WHERE        (rolefeaturesmap.IsActive = 1) AND (rolefeaturesmap.varSocietyId = spvarSocietyId) and (rolefeaturesmap.RoleId <> spAdminId) AND (rolefeaturesmap.RoleId <> spPropertyId);
END$$

CREATE  PROCEDURE `sp_Select_SocietyPersonnelFullDetail_By_WhereCondi` (IN `spwhere` TEXT)  BEGIN
 SET @getemp= concat("SELECT        tblsocietypersonnel.intId, tblsocietypersonnel.intDeptId AS DeptId, tblsocietypersonnel.intRole AS RoleId, tblsocietypersonnel.intEmpCode, 
                         tblsocietypersonnel.intSocietyId, tblsocietypersonnel.intEmpType, tblsocietypersonnel.varEmpName as EmpName, tblmasterdepartment.varDepartmentName, 
                         rolesmasterculturemap.RoleName, countrymaster.CountryName, statemaster.StateName, citymaster.CityName, tblsocietypersonnel.varEmpPoliceVerify, 
                         tblsocietypersonnel.varMaritalStatus, tblsocietypersonnel.varFatherHusband, tblsocietypersonnel.varSpouseName,DATE_FORMAT(tblsocietypersonnel.varDateOfJoin,'%d-%m-%Y') as varDateOfJoin , 
                       DATE_FORMAT(tblsocietypersonnel.varDOB,'%d-%m-%Y') as varDOB, tblsocietypersonnel.varGender, tblsocietypersonnel.varMbOther, tblsocietypersonnel.varEmailOther, tblsocietypersonnel.varPANNo, 
                         tblsocietypersonnel.varPFNo, tblsocietypersonnel.varESINo, tblsocietypersonnel.varPin, tblsocietypersonnel.varAddress, 
                         tblsocietypersonnel.varPermanentAddress, tblsocietypersonnel.varPrimaryEmail, tblsocietypersonnel.varUsername, tblsocietypersonnel.varPassword, 
                         tblsocietypersonnel.varImage, tblsocietypersonnel.varMobile, tblsocietypersonnel.varFBLink, tblsocietypersonnel.varGoogleLink, 
                         tblsocietypersonnel.varTwitterLink, tblsocietypersonnel.intIsActive, tblsocietypersonnel.intCreatedBy, tblsocietypersonnel.varCreatedDate, 
                         tblsocietypersonnel.varProviderName, tblsocietypersonnel.varContactPerson, tblsocietypersonnel.varContactPersonMbNo, 
                         tblsocietypersonnel.varContactPersonAddress, tblsocietypersonnel.intCountry, tblsocietypersonnel.intState, tblsocietypersonnel.intCity, 
                         tblsocietypersonnel.varMbPrimary
FROM            tblsocietypersonnel INNER JOIN
                         tblmasterdepartment ON tblsocietypersonnel.intDeptId = tblmasterdepartment.intId INNER JOIN
                         rolesmasterculturemap ON tblsocietypersonnel.intRole = rolesmasterculturemap.RoleId INNER JOIN
                         citymaster ON tblsocietypersonnel.intCity = citymaster.CityId INNER JOIN
                         countrymaster ON tblsocietypersonnel.intCountry = countrymaster.CountryId INNER JOIN
                         statemaster ON tblsocietypersonnel.intState = statemaster.StateId where ",spwhere);

 PREPARE stmt FROM @getemp;
EXECUTE stmt;
						 
END$$

CREATE  PROCEDURE `sp_select_SubMenuFromFeature` (IN `spintRoleId` LONGTEXT, IN `spParentMenuId` INT)  BEGIN
SELECT   DISTINCT     featuresmaster.FeatureId, featuresmaster.ParentId, featuresmaster.PageName, featuresmaster.CreatedDate, featuresmaster.CreatedBy, featuresmaster.isSubMenu, 
                         featuresmaster.varFeatureName, featuresmaster.IsActive, rolefeaturesmap.RoleId,featuresmaster.varIcon
FROM            featuresmaster INNER JOIN
                         rolefeaturesmap ON featuresmaster.FeatureId = rolefeaturesmap.FeatureId
WHERE        (rolefeaturesmap.RoleId = spintRoleId) AND (featuresmaster.ParentId = spParentMenuId);
END$$

CREATE  PROCEDURE `sp_select_Title` (IN `spSocietyId` TEXT)  SELECT        titlemaster.TitleId, titlemaster.CreatedDate, titlemaster.CreatedBy, titlemaster.IsActive, titlemasterculturemap.TitleName
FROM            titlemaster INNER JOIN
                         titlemasterculturemap ON titlemaster.TitleId = titlemasterculturemap.TitleId
WHERE        (titlemasterculturemap.varSocietyId = spSocietyId)$$

CREATE  PROCEDURE `sp_Select_UserProfile` (IN `spUserId` INT)  BEGIN
SELECT       * FROM            users
WHERE        (UserId = spUserId);
END$$

CREATE  PROCEDURE `sp_select_Users_By_SocietyId` (IN `spSocietyId` INT)  BEGIN
SELECT `UserId`,concat( `FirstName`, ' ',`MiddleName`, ' ',`FamilyName`) as Name,(SELECT rolesmasterculturemap.RoleName FROM rolesmaster INNER JOIN rolesmasterculturemap ON rolesmaster.RoleId = rolesmasterculturemap.RoleId WHERE rolesmaster.RoleId= users.`RoleId`) as Role,`IsActive` FROM `users` WHERE `SocietyId`=spSocietyId AND users.RoleId!=1 AND users.RoleId!=2  ;
END$$

CREATE  PROCEDURE `sp_select_VendorService` (IN `spIsActive` INT)  BEGIN
SELECT intId, intServiceCode,varName,varDescription,varVisitingFee,varRemark,CreatedDate,CreatedBy,varIsActive FROM tblvendorservices WHERE varIsActive = spIsActive; 
END$$

CREATE  PROCEDURE `sp_select_VendorServiceById` (IN `spintServiceCode` INT)  BEGIN
SELECT        intId, intServiceCode, varName, varDescription, varRemark, varVisitingFee, varIsActive, varImage, CreatedBy, CreatedDate
FROM            tblvendorservices WHERE        (intServiceCode = spintServiceCode);
END$$

CREATE  PROCEDURE `sp_select_VendorServiceSubType` ()  BEGIN
SELECT        tblvendorservicesubtype.intSevicetypeCode,tblvendorservices.intServiceCode, tblvendorservices.varName AS Service, tblvendorservicestype.varName AS Type, tblvendorservicesubtype.varName AS SubType,
                          tblvendorservicesubtype.varPrice, tblvendorservicesubtype.varIsActive, tblvendorservicesubtype.intServicesubtypeCode
FROM            tblvendorservices INNER JOIN
                         tblvendorservicestype ON tblvendorservices.intServiceCode = tblvendorservicestype.intServiceCode INNER JOIN
                         tblvendorservicesubtype ON tblvendorservicestype.intServicetypeCode = tblvendorservicesubtype.intSevicetypeCode
; 
END$$

CREATE  PROCEDURE `sp_select_VendorServiceSubTypeById` (IN `spintServicesubtypeCode` INT)  BEGIN
SELECT        tblvendorservices.intServiceCode, tblvendorservices.varName AS Service,tblvendorservicesubtype.intSevicetypeCode, tblvendorservicestype.varName AS Type, tblvendorservicesubtype.varName AS SubType,
                          tblvendorservicesubtype.varPrice, tblvendorservicesubtype.varIsActive, tblvendorservicesubtype.intServicesubtypeCode,tblvendorservicesubtype.varDescription,tblvendorservicesubtype.varRemark,
						  tblvendorservicesubtype.CreatedDate,tblvendorservicesubtype.CreatedBy
FROM            tblvendorservices INNER JOIN
                         tblvendorservicestype ON tblvendorservices.intServiceCode = tblvendorservicestype.intServiceCode INNER JOIN
                         tblvendorservicesubtype ON tblvendorservicestype.intServicetypeCode = tblvendorservicesubtype.intSevicetypeCode
WHERE        (tblvendorservicesubtype.intServicesubtypeCode =  spintServicesubtypeCode); 
END$$

CREATE  PROCEDURE `sp_select_VendorServiceType` ()  BEGIN
SELECT        tblvendorservices.varName AS Service, tblvendorservicestype.intId, tblvendorservicestype.intServicetypeCode, tblvendorservicestype.intServiceCode, 
                         tblvendorservicestype.varName AS Type, tblvendorservicestype.varDescription, tblvendorservicestype.varRemark, tblvendorservicestype.CreatedDate, 
                         tblvendorservicestype.CreatedBy, tblvendorservicestype.varIsActive
FROM            tblvendorservices INNER JOIN
                         tblvendorservicestype ON tblvendorservices.intServiceCode = tblvendorservicestype.intServiceCode;

END$$

CREATE  PROCEDURE `sp_select_VendorServiceTypeById` (IN `spintServicetypeCode` INT)  BEGIN
SELECT        tblvendorservices.varName AS Service, tblvendorservicestype.intId, tblvendorservicestype.intServicetypeCode, tblvendorservicestype.intServiceCode, 
                         tblvendorservicestype.varName AS Type, tblvendorservicestype.varDescription, tblvendorservicestype.varRemark, tblvendorservicestype.CreatedDate, 
                         tblvendorservicestype.CreatedBy, tblvendorservicestype.varIsActive
FROM            tblvendorservices INNER JOIN
                         tblvendorservicestype ON tblvendorservices.intServiceCode = tblvendorservicestype.intServiceCode
WHERE        (tblvendorservicestype.intServicetypeCode =  spintServicetypeCode); 
END$$

CREATE  PROCEDURE `sp_select_VendorServiceTypeByService` (IN `spServiceCode` INT)  BEGIN
SELECT        tblvendorservices.intServiceCode, tblvendorservicestype.intServicetypeCode, tblvendorservices.varName AS Service, 
                         tblvendorservicestype.varName AS Type
FROM            tblvendorservices INNER JOIN
                         tblvendorservicestype ON tblvendorservices.intServiceCode = tblvendorservicestype.intServiceCode
WHERE        (tblvendorservices.intServiceCode =  spServiceCode); 
END$$

CREATE  PROCEDURE `sp_Update_UserProfileByUserId` (IN `spUserId` INT, IN `spTitleId` INT, IN `spFirstName` TEXT, IN `spMiddleName` TEXT, IN `spFamilyName` TEXT, IN `spDisplayName` TEXT, IN `spUserImage` TEXT, IN `spEmailAddress` TEXT, IN `spFax` TEXT, IN `spCountryCode` TEXT, IN `spPhoneNumber` BIGINT)  BEGIN
UPDATE users SET TitleId=spTitleId,FirstName=spFirstName,MiddleName=spMiddleName,FamilyName=spFamilyName,DisplayName=spDisplayName,UserImage=spUserImage,EmailAddress=spEmailAddress,Fax=spFax,CountryCode=spCountryCode,PhoneNumber=spPhoneNumber WHERE UserId=spUserId;
END$$

CREATE  PROCEDURE `sp_Update_UserProfileByUserIdFromAdmin` (IN `spUserId` INT, IN `spTitleId` INT, IN `spFirstName` TEXT, IN `spMiddleName` TEXT, IN `spFamilyName` TEXT, IN `spDisplayName` TEXT, IN `spUserImage` TEXT, IN `spEmailAddress` TEXT, IN `spFax` TEXT, IN `spCountryCode` TEXT, IN `spPhoneNumber` BIGINT, IN `spUsername` TEXT, IN `spIsActive` INT, IN `spRoleId` INT)  BEGIN
UPDATE users SET TitleId=spTitleId,FirstName=spFirstName,MiddleName=spMiddleName,FamilyName=spFamilyName,DisplayName=spDisplayName,UserImage=spUserImage,EmailAddress=spEmailAddress,Fax=spFax,CountryCode=spCountryCode,PhoneNumber=spPhoneNumber,`Username`=spUsername,`IsActive`=spIsActive ,`RoleId`=spRoleId WHERE UserId=spUserId;
END$$

CREATE  PROCEDURE `sp_Update_VendorService` (IN `spServiceCode` INT, IN `spName` TEXT, IN `spDescription` TEXT, IN `spRemark` TEXT, IN `spVisitingFee` TEXT, IN `spIsActive` TEXT, IN `spvarImage` TEXT)  BEGIN

UPDATE `tblvendorservices` SET varName= spName, varDescription=spDescription,varRemark=spRemark, varVisitingFee =spVisitingFee,varIsActive=spIsActive,varImage=spvarImage WHERE  intServiceCode= spServiceCode;

END$$

CREATE  PROCEDURE `sp_Update_VendorServiceSubType` (IN `spServicesubtypeCode` INT, IN `spServicetypeCode` INT, IN `spServiceCode` INT, IN `spName` TEXT, IN `spPrice` TEXT, IN `spDescription` TEXT, IN `spRemark` TEXT, IN `spIsActive` TEXT)  BEGIN

UPDATE `tblvendorservicesubtype` SET intServicesubtypeCode= spServicesubtypeCode,intSevicetypeCode=spServicetypeCode,intServiceCode= spServiceCode,varName= spName,varPrice=spPrice, varDescription=spDescription,varRemark=spRemark,varIsActive=spIsActive WHERE intServicesubtypeCode= spServicesubtypeCode;

END$$

CREATE  PROCEDURE `sp_Update_VendorServiceType` (IN `spServicetypeCode` INT, IN `spServiceCode` INT, IN `spName` TEXT, IN `spDescription` TEXT, IN `spRemark` TEXT, IN `spIsActive` TEXT)  BEGIN

UPDATE `tblvendorservicestype` SET intServiceCode= spServiceCode,varName= spName, varDescription=spDescription,varRemark=spRemark,varIsActive=spIsActive WHERE intServicetypeCode= spServicetypeCode;

END$$

CREATE  PROCEDURE `StoredProcedure1` ()  BEGIN
 SELECT @societyid:= concat("SKS", FLOOR(RAND()*9567242));
 INSERT INTO `tblmasterdepartment`
 (  `varSocietyId`, `varDepartmentName`, `varDescription`, `varCreatedDate`, `intCreatedBy`, `intIsActive`) VALUES 
 (@societyid,'Administration','Administrative Services',convert_tz(now() , @@session.time_zone ,'+05:30'),1,1);

 SELECT @deptid:=LAST_INSERT_ID();
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `appproperties`
--

CREATE TABLE `appproperties` (
  `SocietyId` int(11) NOT NULL,
  `Limits` tinyint(3) UNSIGNED NOT NULL,
  `Type` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
(153, 7, NULL, 0, 'Tapi', '0000-00-00 00:00:00', NULL, 1),
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
(616, 28, NULL, 0, 'West Midnapore', '0000-00-00 00:00:00', NULL, 1);

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
  `CreatedBy` int(11) NOT NULL,
  `IsActive` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `featuresmaster`
--

INSERT INTO `featuresmaster` (`FeatureId`, `ParentId`, `varFeatureName`, `PageName`, `isSubMenu`, `CreatedDate`, `varIcon`, `CreatedBy`, `IsActive`) VALUES
(1, 0, 'Masters', 'Masters', 0, '2016-05-02 00:00:00', 'fa fa-cogs', 1, 1),
(2, 0, 'Society Details', 'Society Details', 0, '2016-05-02 00:00:00', 'fa fa-home', 1, 1),
(3, 0, 'Employee', 'Employee', 0, '2016-05-02 00:00:00', 'fa fa-user', 1, 1),
(4, 0, 'Invoices', 'Invoices', 0, '2016-05-02 00:00:00', 'fa fa-inr', 1, 1),
(5, 0, 'Classified', 'Classified', 0, '2016-05-02 00:00:00', 'fa fa-list-alt', 1, 1),
(6, 0, 'Events', 'Events', 0, '2016-05-02 00:00:00', 'fa fa-calendar', 1, 1),
(7, 0, 'Poll', 'Poll', 0, '2016-05-02 00:00:00', 'fa fa-bullhorn', 1, 1),
(8, 0, 'Notice Board', 'Notice Board', 0, '2016-05-02 00:00:00', 'fa fa-flag', 1, 1),
(9, 0, 'Requests', '~/Society/Admin/Property/Approvals.aspx\n', 0, '2016-05-02 00:00:00', 'fa fa-inbox', 1, 1),
(10, 0, 'My Property', '~/Society/Property/MyProperty.aspx', 0, '2016-05-02 00:00:00', 'fa fa-home', 1, 1),
(11, 0, 'Invoices', '~/Society/Property/Invoices.aspx', 0, '2016-05-02 00:00:00', 'fa fa-inr', 1, 1),
(12, 0, 'Reports', '~/Society/Reports/Reports.aspx', 0, '2016-05-02 00:00:00', 'fa fa-pie-chart', 1, 1),
(13, 0, 'View Notices', '~/Society/Property/ViewNotices.aspx', 0, '2016-05-02 00:00:00', 'fa fa-file', 1, 1),
(14, 0, 'Group Discussion', '~/Society/GD/GroupDiscussion.aspx', 0, '2016-05-02 00:00:00', 'fa fa-comments-o', 1, 0),
(15, 0, 'Gallery', '~/Society/Extras/Gallary.aspx', 0, '2016-05-02 00:00:00', 'fa fa-camera', 1, 1),
(16, 0, 'Generate Requests', '~/Society/Property/Requests.aspx', 0, '2016-05-02 00:00:00', 'fa fa-inbox', 1, 1),
(17, 1, 'Add Feature', '~/SK/MasterData/AddFeature.aspx', 1, '2016-05-02 00:00:00', '', 1, 0),
(18, 1, 'Vendor Services', '~/SK/MasterData/VendorServices.aspx', 1, '2016-05-02 00:00:00', '', 1, 0),
(19, 1, 'Vendor Services Types', '~/SK/MasterData/VendorServicesTypes.aspx', 1, '2016-05-02 00:00:00', '', 1, 0),
(20, 1, 'Vendor Service SubTypes', '~/SK/MasterData/VendorServiceSubTypes.aspx', 1, '2016-05-02 00:00:00', '', 1, 0),
(21, 1, 'Add Society', '~/SK/Society/AddSociety.aspx', 1, '2016-05-02 00:00:00', '', 1, 0),
(22, 1, 'Add Vendor', '~/SK/Vendor/AddVendor.aspx', 1, '2016-05-02 00:00:00', '', 1, 0),
(23, 2, 'Add AccountType ', '~/Society/Admin/MasterData/AddAccountType.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(24, 2, 'Add Asset Facility', '~/Society/Admin/MasterData/AddAssetFacility.aspx\'', 1, '2016-05-02 00:00:00', '', 1, 1),
(25, 2, 'Add Complaints Type', '~/Society/Admin/MasterData/AddComplaintsType.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(26, 2, 'Add Department', '~/Society/Admin/MasterData/AddDepartment.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(27, 2, 'Add DocumentType', '~/Society/Admin/MasterData/AddDocumentType.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(28, 2, 'Add EmployeeType', '~/Society/Admin/MasterData/AddEmployeeType.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(29, 2, 'Add EventType', '~/Society/Admin/MasterData/AddEventType.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(30, 2, 'Add Flat Additional Area', '~/Society/Admin/MasterData/AddFlatAdditionalArea.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(31, 2, 'Add Flat Premises Type', '~/Society/Admin/MasterData/AddFlatPremisesType.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(32, 2, 'Add Helpline', '~/Society/Admin/MasterData/AddHelpline.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(33, 2, 'Add Notice Type', '~/Society/Admin/MasterData/AddNoticeType.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(34, 2, 'Add Parking Level', '~/Society/Admin/MasterData/AddParkingLevel.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(35, 2, 'Add Parking Slot', '~/Society/Admin/MasterData/AddParkingSlot.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(36, 2, 'Add Roles', '~/Society/Admin/MasterData/AddRoles.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(37, 2, 'Add Society Wing', '~/Society/Admin/MasterData/AddSocietyWing.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(38, 2, 'Add Bank Details', '~/Society/Common/AddBankDetails.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(39, 2, 'Add Unit Type  ', '~/Society/Admin/MasterData/AddUnitType.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(40, 2, 'Add Document', '~/Society/Common/AddDocument.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(41, 2, 'Add Property', '~/Society/Admin/Property/AddProperty.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(42, 2, 'View Property', '~/Society/Admin/Property/ViewPropertyList.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(43, 2, 'Assign Features', '~/Society/Admin/Employee/AssignRoleFeatures.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(44, 2, 'Assign Notification', '~/Society/Admin/Employee/AssignNotification.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(45, 2, 'Security', '~/Society/Admin/InOutManager.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(46, 2, 'Assign Parking', '~/Society/Admin/Property/AssignParking.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(47, 2, 'Add Employee', '~/Society/Admin/Employee/AddEmployee.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(48, 2, 'View Empolyee ', '~/Society/Admin/Employee/ViewEmpolyee.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(49, 4, 'Create Invoices', '~/Society/Accounts/CreateInvoice.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(50, 4, 'View Invoices', '~/Society/Accounts/Invoices.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(51, 5, 'Add Classified', '~/Society/Extras/Classified.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(52, 5, 'View Classified', '~/Society/View/ViewClassified.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(53, 6, 'Add Event', '~/Society/Extras/EventAndAnouncement.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(54, 6, 'View Events', '~/Society/View/ViewEventEnnouncement.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(55, 7, 'Add Poll', '~/Society/Extras/Poll.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(56, 7, 'View Polls', '~/Society/View/ViewSelfPoll.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(57, 8, 'Add NoticeBoard Entry', '~/Society/Extras/NoticeBoard.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(58, 8, 'View NoticeBoard', '~/Society/View/ViewNoticeboard.aspx', 1, '2016-05-02 00:00:00', '', 1, 1),
(59, 0, 'Send Notice', '~/Society/Extras/Notice.aspx', 0, '2016-05-02 00:00:00', 'fa fa-file-text-o', 1, 1);

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
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `IsActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rolesmaster`
--

CREATE TABLE `rolesmaster` (
  `RoleId` smallint(6) NOT NULL,
  `DeptId` bigint(20) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `IsActive` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rolesmasterculturemap`
--

CREATE TABLE `rolesmasterculturemap` (
  `RoleId` smallint(6) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `RoleName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `CultureId` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `varAccountBookEntry` bigint(20) NOT NULL,
  `varDate` date NOT NULL,
  `varSocietyId` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `varPersonalId` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `varAccountNo` longtext NOT NULL,
  `varVoucher` longtext NOT NULL,
  `varReason` longtext NOT NULL,
  `varAccountEntryType` longtext NOT NULL,
  `varPreviousBalance` longtext NOT NULL,
  `varAmount` longtext NOT NULL,
  `varBalance` bigint(20) NOT NULL,
  `ex1` longtext NOT NULL,
  `ex2` longtext NOT NULL,
  `ex3` longtext NOT NULL,
  `ex4` longtext NOT NULL,
  `ex5` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tblaccountdetails`
--

CREATE TABLE `tblaccountdetails` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `varPersonalId` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `varAccountNo` longtext NOT NULL,
  `varAccountName` longtext NOT NULL,
  `ex1` longtext NOT NULL,
  `ex2` longtext NOT NULL,
  `ex3` longtext NOT NULL,
  `ex4` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tblaccountledger`
--

CREATE TABLE `tblaccountledger` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `varPersonalId` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `varDate` date NOT NULL,
  `varAccountNo` longtext NOT NULL,
  `varParticulers` longtext NOT NULL,
  `varAccountBookEntry` longtext NOT NULL,
  `varDebitAmount` longtext NOT NULL,
  `varCreditAmount` longtext NOT NULL,
  `varAccountEntryType` longtext NOT NULL,
  `ex1` longtext NOT NULL,
  `ex2` longtext NOT NULL,
  `ex3` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tblassignnotifications`
--

CREATE TABLE `tblassignnotifications` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPersonalId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intRoleId` bigint(20) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblbankdetails`
--

CREATE TABLE `tblbankdetails` (
  `intId` int(11) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPersonnelId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intRoleId` bigint(20) NOT NULL,
  `varAccountHolderName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAccountNo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varBankName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intAccountType` bigint(20) NOT NULL,
  `varIFSCCode` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMCIRCode` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varBranchAddress` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varBranchName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `varCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblclassified`
--

CREATE TABLE `tblclassified` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPersonalId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intRole` bigint(20) NOT NULL,
  `varSubject` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varLocation` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intCountry` bigint(20) NOT NULL,
  `intState` bigint(20) NOT NULL,
  `intCity` bigint(20) NOT NULL,
  `varPin` bigint(20) NOT NULL,
  `varContactName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varClassifiedImage` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `varCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbldocuments`
--

CREATE TABLE `tbldocuments` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPersonnelId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intRoleId` bigint(20) NOT NULL,
  `intDocumentType` bigint(20) NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDocument` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbleventannouncement`
--

CREATE TABLE `tbleventannouncement` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPersonalId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intRole` bigint(20) NOT NULL,
  `intEventType` bigint(20) NOT NULL,
  `varSubject` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varStartDate` date NOT NULL,
  `varEndDate` date NOT NULL,
  `varStartTime` time NOT NULL,
  `varEndTime` time NOT NULL,
  `varLocation` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEventCapacity` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intCountry` bigint(20) NOT NULL,
  `intState` bigint(20) NOT NULL,
  `intCity` bigint(20) NOT NULL,
  `varPin` bigint(20) NOT NULL,
  `varContactName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEventImage` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `varCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblinouthistory`
--

CREATE TABLE `tblinouthistory` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` text COLLATE utf8_unicode_ci NOT NULL,
  `varPersonnelId` text COLLATE utf8_unicode_ci NOT NULL,
  `varInOut` tinyint(4) NOT NULL,
  `varDate` date NOT NULL,
  `varTime` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblinoutstatus`
--

CREATE TABLE `tblinoutstatus` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` text COLLATE utf8_unicode_ci NOT NULL,
  `varPersonnelId` text COLLATE utf8_unicode_ci NOT NULL,
  `intRoleId` int(11) DEFAULT NULL,
  `varStatus` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblinvoice`
--

CREATE TABLE `tblinvoice` (
  `intId` bigint(20) NOT NULL,
  `varInvoiceId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varOrderNo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDateTime` date NOT NULL,
  `intFromSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intFromRole` bigint(20) NOT NULL,
  `intFromId` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblinvoiceforpersonnels`
--

CREATE TABLE `tblinvoiceforpersonnels` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varInvoiceId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intRoleId` bigint(20) NOT NULL,
  `varPersonnelId` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmasteraccounttype`
--

CREATE TABLE `tblmasteraccounttype` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAccountName` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmasterassetfacility`
--

CREATE TABLE `tblmasterassetfacility` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAssetFacilityName` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmastercomplainttype`
--

CREATE TABLE `tblmastercomplainttype` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varComplaintTypeName` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmasterdepartment`
--

CREATE TABLE `tblmasterdepartment` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmasterdocumenttype`
--

CREATE TABLE `tblmasterdocumenttype` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDocumentName` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmastereventtype`
--

CREATE TABLE `tblmastereventtype` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEventTypeName` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmasterflatadditionalarea`
--

CREATE TABLE `tblmasterflatadditionalarea` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAreaName` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmasterflatpremisestype`
--

CREATE TABLE `tblmasterflatpremisestype` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intUnitType` bigint(20) NOT NULL,
  `varFlatPremisesName` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmasterhelpline`
--

CREATE TABLE `tblmasterhelpline` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varHelplineName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varContactPerson` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varHelpMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varHelpPhone` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varHelpEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAddress` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varRemark` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `varCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex6` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblmastermemployeetype`
--

CREATE TABLE `tblmastermemployeetype` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEmpTypeName` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmasternoticetype`
--

CREATE TABLE `tblmasternoticetype` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varNoticeTypeName` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmasterparkinglevel`
--

CREATE TABLE `tblmasterparkinglevel` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varparkinglevel` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblmasterparkinglevelslot`
--

CREATE TABLE `tblmasterparkinglevelslot` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intparkinglevelId` bigint(20) NOT NULL,
  `varparkinglevelSlot` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varRemark` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `intCreatedBy` bigint(20) NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `intIsAssigned` tinyint(4) NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblmastersocietywing`
--

CREATE TABLE `tblmastersocietywing` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varWingName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varRemark` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `intCreatedBy` bigint(11) NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblmasterunittype`
--

CREATE TABLE `tblmasterunittype` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varUnitTypeName` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblnotice`
--

CREATE TABLE `tblnotice` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPersonalId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intRole` bigint(20) NOT NULL,
  `intNoticeType` int(11) NOT NULL,
  `varAssignType` bigint(20) NOT NULL,
  `varNoticeTitle` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varValueDate` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varReportTo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varImage` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `varCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex6` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblnotifications`
--

CREATE TABLE `tblnotifications` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext NOT NULL,
  `varNotType` longtext NOT NULL,
  `intNotFromId` longtext NOT NULL,
  `varNotFromRoleId` bigint(20) NOT NULL,
  `intNotToId` longtext NOT NULL,
  `varNotToRoleId` int(11) NOT NULL,
  `varNotText` longtext NOT NULL,
  `varLink` longtext NOT NULL,
  `varCache` longtext NOT NULL,
  `varStatus` longtext NOT NULL,
  `varRemark` longtext NOT NULL,
  `varDateTime` datetime NOT NULL,
  `ex1` longtext NOT NULL,
  `ex2` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tblpoll`
--

CREATE TABLE `tblpoll` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPersonalId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intRole` bigint(20) NOT NULL,
  `varQuestion` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varOptionalText` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varOption1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varOption2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varOption3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varOption4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAnswer` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varContactName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `varCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblpollanswer`
--

CREATE TABLE `tblpollanswer` (
  `intId` bigint(20) NOT NULL DEFAULT '0',
  `intPollId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPersonalId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAnswer` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAnswerDate` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAnswerTime` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varRemark` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblproperty`
--

CREATE TABLE `tblproperty` (
  `intId` bigint(20) NOT NULL DEFAULT '0',
  `varPropertyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intRoleId` bigint(20) NOT NULL,
  `intWingId` bigint(20) NOT NULL,
  `intPremisesUnitId` bigint(20) NOT NULL,
  `intPremisesTypeId` bigint(20) NOT NULL,
  `varPropertyCode` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varGender` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varExtensionNo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAlternateAddress` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPhoneNo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAlternateMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAlternateEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varUsername` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPassword` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `varCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `varImage` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varFBLink` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varGoogleLink` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varTwitterLink` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblpropertydetails`
--

CREATE TABLE `tblpropertydetails` (
  `intId` bigint(20) NOT NULL,
  `varPropertyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDateofPurchase` date NOT NULL,
  `varArea` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varIsRenovated` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCosting` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCurrency` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblpropertyfamily`
--

CREATE TABLE `tblpropertyfamily` (
  `intId` bigint(20) NOT NULL,
  `intPropertyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varGender` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAge` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varOccupation` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAlternateAddress` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMobileNo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAlternateMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varAlternateEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `varCreatedDate` date NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblpropertyvehical`
--

CREATE TABLE `tblpropertyvehical` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPropertyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varParkingSlot` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varVehicalType` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varVehicalName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varVehicalNumber` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varVehicalColor` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `varCreatedDate` date NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblrequest`
--

CREATE TABLE `tblrequest` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPersonneId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intPersonelRole` bigint(20) NOT NULL,
  `varAssignToRoleId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDate` date NOT NULL,
  `varTime` longtext COLLATE utf8_unicode_ci NOT NULL,
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

-- --------------------------------------------------------

--
-- Table structure for table `tblsocietygallary`
--

CREATE TABLE `tblsocietygallary` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPersonalId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intRole` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varSubject` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varGallaryImage` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `varCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblsocietyinfo`
--

CREATE TABLE `tblsocietyinfo` (
  `intId` bigint(20) NOT NULL,
  `intSocietyCode` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varRegistrationNo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varSAddress` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varSPhone` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varSMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varSEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varSFax` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCountryId` int(11) NOT NULL,
  `varStateId` int(11) NOT NULL,
  `varCityId` int(11) NOT NULL,
  `varPin` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varConstructedby` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCompany` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCompanyAddress` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varContactPerson` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varContactMobile` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varContactPhone` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varContactEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varConstuctionYear` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varTotalArea` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varTotalWings` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblsocietymembertransactions`
--

CREATE TABLE `tblsocietymembertransactions` (
  `intId` bigint(20) NOT NULL,
  `varOrderNo` longtext NOT NULL,
  `varMemberId` longtext NOT NULL,
  `intDeptId` bigint(20) NOT NULL,
  `intRole` bigint(20) NOT NULL,
  `varMemberName` longtext NOT NULL,
  `varMemberCity` longtext NOT NULL,
  `varMemberAddress` longtext NOT NULL,
  `varMemberState` longtext NOT NULL,
  `varInvoiceId` longtext NOT NULL,
  `varDate` longtext NOT NULL,
  `varTime` longtext NOT NULL,
  `varPaymentAmount` longtext NOT NULL,
  `varPaymentStatus` longtext NOT NULL,
  `varTransactionId` longtext NOT NULL,
  `varTransactionStatus` longtext NOT NULL,
  `varPaymode` longtext NOT NULL,
  `varOrderStatus` longtext NOT NULL,
  `ex1` longtext NOT NULL,
  `ex2` longtext NOT NULL,
  `ex3` longtext NOT NULL,
  `ex4` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32;

-- --------------------------------------------------------

--
-- Table structure for table `tblsocietynoticeboard`
--

CREATE TABLE `tblsocietynoticeboard` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPersonalId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intRole` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varSubject` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDescription` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `varCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblsocietypersonnel`
--

CREATE TABLE `tblsocietypersonnel` (
  `intId` bigint(20) NOT NULL,
  `intSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intEmpCode` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intDeptId` bigint(20) NOT NULL,
  `intRole` bigint(20) NOT NULL,
  `intEmpType` int(11) NOT NULL,
  `varEmpName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varEmpPoliceVerify` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varMaritalStatus` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varFatherHusband` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varSpouseName` longtext COLLATE utf8_unicode_ci NOT NULL,
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
  `varFBLink` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varGoogleLink` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varTwitterLink` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varImage` longtext COLLATE utf8_unicode_ci NOT NULL,
  `intIsActive` tinyint(4) NOT NULL,
  `intCreatedBy` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` date NOT NULL,
  `varProviderName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varContactPerson` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varContactPersonMbNo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varContactPersonAddress` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex3` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex4` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex5` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex6` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblsubscription`
--

CREATE TABLE `tblsubscription` (
  `intId` bigint(20) NOT NULL,
  `varEmail` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varCreatedDate` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex1` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ex2` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblsuperadmin`
--

CREATE TABLE `tblsuperadmin` (
  `intId` int(11) NOT NULL DEFAULT '0',
  `varUsername` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varPassword` longtext COLLATE utf8_unicode_ci NOT NULL,
  `varDesignation` longtext COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `titlemaster`
--

CREATE TABLE `titlemaster` (
  `TitleId` int(11) NOT NULL,
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `titlemasterculturemap`
--

CREATE TABLE `titlemasterculturemap` (
  `TitleId` int(11) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `TitleName` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `CultureId` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE `visitors` (
  `intId` bigint(20) NOT NULL,
  `varSocietyId` longtext COLLATE utf8_unicode_ci NOT NULL,
  `FirstName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `LastName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `ContactNumber` bigint(20) NOT NULL,
  `Email` text COLLATE utf8_unicode_ci NOT NULL,
  `VehicleNo` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ArrivedFrom` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `InTime` time NOT NULL,
  `OutTime` time DEFAULT NULL,
  `PurposeOFVisit` text COLLATE utf8_unicode_ci NOT NULL,
  `Comments` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CreatedDate` datetime NOT NULL,
  `IsActive` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appproperties`
--
ALTER TABLE `appproperties`
  ADD KEY `FK_AppProperties_SocietyMaster` (`SocietyId`);

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
  ADD PRIMARY KEY (`RoleId`);

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
-- Indexes for table `tblaccountledger`
--
ALTER TABLE `tblaccountledger`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblassignnotifications`
--
ALTER TABLE `tblassignnotifications`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblbankdetails`
--
ALTER TABLE `tblbankdetails`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblclassified`
--
ALTER TABLE `tblclassified`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tbldocuments`
--
ALTER TABLE `tbldocuments`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tbleventannouncement`
--
ALTER TABLE `tbleventannouncement`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblinouthistory`
--
ALTER TABLE `tblinouthistory`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblinoutstatus`
--
ALTER TABLE `tblinoutstatus`
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
-- Indexes for table `tblinvoiceforpersonnels`
--
ALTER TABLE `tblinvoiceforpersonnels`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmasteraccounttype`
--
ALTER TABLE `tblmasteraccounttype`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmasterassetfacility`
--
ALTER TABLE `tblmasterassetfacility`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmastercomplainttype`
--
ALTER TABLE `tblmastercomplainttype`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmasterdepartment`
--
ALTER TABLE `tblmasterdepartment`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmasterdocumenttype`
--
ALTER TABLE `tblmasterdocumenttype`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmastereventtype`
--
ALTER TABLE `tblmastereventtype`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmasterflatadditionalarea`
--
ALTER TABLE `tblmasterflatadditionalarea`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmasterflatpremisestype`
--
ALTER TABLE `tblmasterflatpremisestype`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmasterhelpline`
--
ALTER TABLE `tblmasterhelpline`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmastermemployeetype`
--
ALTER TABLE `tblmastermemployeetype`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmasternoticetype`
--
ALTER TABLE `tblmasternoticetype`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmasterparkinglevel`
--
ALTER TABLE `tblmasterparkinglevel`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmasterparkinglevelslot`
--
ALTER TABLE `tblmasterparkinglevelslot`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmastersocietywing`
--
ALTER TABLE `tblmastersocietywing`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblmasterunittype`
--
ALTER TABLE `tblmasterunittype`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblnotice`
--
ALTER TABLE `tblnotice`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblnotifications`
--
ALTER TABLE `tblnotifications`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblpoll`
--
ALTER TABLE `tblpoll`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblpollanswer`
--
ALTER TABLE `tblpollanswer`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblproperty`
--
ALTER TABLE `tblproperty`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblpropertydetails`
--
ALTER TABLE `tblpropertydetails`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblpropertyfamily`
--
ALTER TABLE `tblpropertyfamily`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblpropertyvehical`
--
ALTER TABLE `tblpropertyvehical`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblrequest`
--
ALTER TABLE `tblrequest`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblsocietygallary`
--
ALTER TABLE `tblsocietygallary`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblsocietyinfo`
--
ALTER TABLE `tblsocietyinfo`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblsocietymembertransactions`
--
ALTER TABLE `tblsocietymembertransactions`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblsocietynoticeboard`
--
ALTER TABLE `tblsocietynoticeboard`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblsocietypersonnel`
--
ALTER TABLE `tblsocietypersonnel`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblsubscription`
--
ALTER TABLE `tblsubscription`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `tblsuperadmin`
--
ALTER TABLE `tblsuperadmin`
  ADD PRIMARY KEY (`intId`);

--
-- Indexes for table `titlemaster`
--
ALTER TABLE `titlemaster`
  ADD PRIMARY KEY (`TitleId`);

--
-- Indexes for table `visitors`
--
ALTER TABLE `visitors`
  ADD PRIMARY KEY (`intId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `citymaster`
--
ALTER TABLE `citymaster`
  MODIFY `CityId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=617;
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
  MODIFY `RoleId` smallint(6) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `statemaster`
--
ALTER TABLE `statemaster`
  MODIFY `StateId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `tblaccountbook`
--
ALTER TABLE `tblaccountbook`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblaccountdetails`
--
ALTER TABLE `tblaccountdetails`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblaccountledger`
--
ALTER TABLE `tblaccountledger`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblassignnotifications`
--
ALTER TABLE `tblassignnotifications`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblbankdetails`
--
ALTER TABLE `tblbankdetails`
  MODIFY `intId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblclassified`
--
ALTER TABLE `tblclassified`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbldocuments`
--
ALTER TABLE `tbldocuments`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tbleventannouncement`
--
ALTER TABLE `tbleventannouncement`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblinouthistory`
--
ALTER TABLE `tblinouthistory`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblinoutstatus`
--
ALTER TABLE `tblinoutstatus`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblinvoice`
--
ALTER TABLE `tblinvoice`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblinvoicedetails`
--
ALTER TABLE `tblinvoicedetails`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblinvoiceforpersonnels`
--
ALTER TABLE `tblinvoiceforpersonnels`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmasteraccounttype`
--
ALTER TABLE `tblmasteraccounttype`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmasterassetfacility`
--
ALTER TABLE `tblmasterassetfacility`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmastercomplainttype`
--
ALTER TABLE `tblmastercomplainttype`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmasterdepartment`
--
ALTER TABLE `tblmasterdepartment`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmasterdocumenttype`
--
ALTER TABLE `tblmasterdocumenttype`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmastereventtype`
--
ALTER TABLE `tblmastereventtype`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmasterflatadditionalarea`
--
ALTER TABLE `tblmasterflatadditionalarea`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmasterflatpremisestype`
--
ALTER TABLE `tblmasterflatpremisestype`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmasterhelpline`
--
ALTER TABLE `tblmasterhelpline`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmastermemployeetype`
--
ALTER TABLE `tblmastermemployeetype`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmasternoticetype`
--
ALTER TABLE `tblmasternoticetype`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmasterparkinglevel`
--
ALTER TABLE `tblmasterparkinglevel`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmasterparkinglevelslot`
--
ALTER TABLE `tblmasterparkinglevelslot`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmastersocietywing`
--
ALTER TABLE `tblmastersocietywing`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblmasterunittype`
--
ALTER TABLE `tblmasterunittype`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblnotice`
--
ALTER TABLE `tblnotice`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblpoll`
--
ALTER TABLE `tblpoll`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblpropertydetails`
--
ALTER TABLE `tblpropertydetails`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblpropertyfamily`
--
ALTER TABLE `tblpropertyfamily`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblpropertyvehical`
--
ALTER TABLE `tblpropertyvehical`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblrequest`
--
ALTER TABLE `tblrequest`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblsocietygallary`
--
ALTER TABLE `tblsocietygallary`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblsocietyinfo`
--
ALTER TABLE `tblsocietyinfo`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblsocietymembertransactions`
--
ALTER TABLE `tblsocietymembertransactions`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblsocietynoticeboard`
--
ALTER TABLE `tblsocietynoticeboard`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblsocietypersonnel`
--
ALTER TABLE `tblsocietypersonnel`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `tblsubscription`
--
ALTER TABLE `tblsubscription`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `titlemaster`
--
ALTER TABLE `titlemaster`
  MODIFY `TitleId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `visitors`
--
ALTER TABLE `visitors`
  MODIFY `intId` bigint(20) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
