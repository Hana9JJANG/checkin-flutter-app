-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 28, 2020 at 03:40 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tapirGrocer`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_checkin`
--

CREATE TABLE `tb_checkin` (
  `checkinID` int(100) NOT NULL,
  `fname` varchar(100) NOT NULL,
  `nric` varchar(100) NOT NULL,
  `bodytemp` decimal(10,1) NOT NULL,
  `date` datetime NOT NULL,
  `ownerID` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_checkin`
--

INSERT INTO `tb_checkin` (`checkinID`, `fname`, `nric`, `bodytemp`, `date`, `ownerID`) VALUES
(11, 'Aydan Yusuf', '98738368', '36.1', '2020-11-28 04:56:12', 1),
(12, 'Grace', '38947857', '36.2', '2020-11-28 05:42:13', 1),
(13, 'Pat', '78498573', '36.0', '2020-11-28 05:42:56', 2);

-- --------------------------------------------------------

--
-- Table structure for table `tb_owner`
--

CREATE TABLE `tb_owner` (
  `ownerID` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pass` varchar(100) NOT NULL,
  `status` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tb_owner`
--

INSERT INTO `tb_owner` (`ownerID`, `name`, `email`, `pass`, `status`) VALUES
(1, 'Tapir Grocer', 'tapir@gmail.com', '202cb962ac59075b964b07152d234b70', 1),
(2, 'Sanmart', 'sanmart@gmail.com', '123', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_checkin`
--
ALTER TABLE `tb_checkin`
  ADD PRIMARY KEY (`checkinID`);

--
-- Indexes for table `tb_owner`
--
ALTER TABLE `tb_owner`
  ADD PRIMARY KEY (`ownerID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_checkin`
--
ALTER TABLE `tb_checkin`
  MODIFY `checkinID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `tb_owner`
--
ALTER TABLE `tb_owner`
  MODIFY `ownerID` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
