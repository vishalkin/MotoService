-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 04, 2016 at 07:36 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `sedb`
--

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE IF NOT EXISTS `bids` (
  `BId` int(11) NOT NULL,
  `Pid` int(11) NOT NULL,
  `SPId` int(11) NOT NULL,
  `flag` int(11) NOT NULL,
  PRIMARY KEY (`BId`),
  KEY `FK_Bids_Post` (`Pid`),
  KEY `SPId` (`SPId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `CId` int(11) NOT NULL AUTO_INCREMENT,
  `CName` varchar(50) NOT NULL,
  `CPhone` int(11) NOT NULL,
  `CAddress` text NOT NULL,
  `CEmail` varchar(50) NOT NULL,
  `CPassword` varchar(50) NOT NULL,
  `CPhoto` varchar(255) NOT NULL,
  PRIMARY KEY (`CId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `gives`
--

CREATE TABLE IF NOT EXISTS `gives` (
  `GId` int(11) NOT NULL AUTO_INCREMENT,
  `SId` int(11) NOT NULL,
  `SPId` int(11) NOT NULL,
  PRIMARY KEY (`GId`),
  KEY `FK_Gives_Service` (`SId`),
  KEY `FK_Gives_ServiceProvider` (`SPId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE IF NOT EXISTS `post` (
  `PId` int(11) NOT NULL AUTO_INCREMENT,
  `SRId` int(11) NOT NULL,
  `CId` int(11) NOT NULL,
  PRIMARY KEY (`PId`),
  KEY `FK_Post_ServiceRequest` (`SRId`),
  KEY `FK_Post_Customer` (`CId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE IF NOT EXISTS `service` (
  `SId` int(11) NOT NULL AUTO_INCREMENT,
  `Sname` varchar(50) NOT NULL,
  `SDesc` varchar(250) NOT NULL,
  PRIMARY KEY (`SId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `serviceprovider`
--

CREATE TABLE IF NOT EXISTS `serviceprovider` (
  `SPId` int(11) NOT NULL AUTO_INCREMENT,
  `SPName` varchar(50) NOT NULL,
  `SPPhone` int(11) NOT NULL,
  `SPAdddress` varchar(200) NOT NULL,
  `SPEmail` varchar(50) NOT NULL,
  `SPPassword` varchar(50) NOT NULL,
  `SPPhoto` varchar(255) NOT NULL,
  PRIMARY KEY (`SPId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `servicerequest`
--

CREATE TABLE IF NOT EXISTS `servicerequest` (
  `SRId` int(11) NOT NULL AUTO_INCREMENT,
  `SId` int(11) NOT NULL,
  `SRDesc` text NOT NULL,
  `SRDate` date NOT NULL,
  `LatestBy` date NOT NULL,
  PRIMARY KEY (`SRId`),
  KEY `FK_ServiceRequest_Service` (`SId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bids`
--
ALTER TABLE `bids`
  ADD CONSTRAINT `FK_Bids_Post` FOREIGN KEY (`Pid`) REFERENCES `post` (`PId`),
  ADD CONSTRAINT `fk_Service_provider` FOREIGN KEY (`SPId`) REFERENCES `serviceprovider` (`SPId`);

--
-- Constraints for table `gives`
--
ALTER TABLE `gives`
  ADD CONSTRAINT `FK_Gives_Service` FOREIGN KEY (`SId`) REFERENCES `service` (`SId`),
  ADD CONSTRAINT `FK_Gives_ServiceProvider` FOREIGN KEY (`SPId`) REFERENCES `serviceprovider` (`SPId`);

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `FK_Post_ServiceRequest` FOREIGN KEY (`SRId`) REFERENCES `servicerequest` (`SRId`),
  ADD CONSTRAINT `FK_Post_Customer` FOREIGN KEY (`CId`) REFERENCES `customer` (`CId`);

--
-- Constraints for table `servicerequest`
--
ALTER TABLE `servicerequest`
  ADD CONSTRAINT `FK_ServiceRequest_Service` FOREIGN KEY (`SId`) REFERENCES `service` (`SId`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
