-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 08, 2022 at 04:38 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `secure_login`
--

-- --------------------------------------------------------

--
-- Table structure for table `api_token`
--

CREATE TABLE `api_token` (
  `sn` int(11) NOT NULL,
  `api_key` varchar(200) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `api_token`
--

INSERT INTO `api_token` (`sn`, `api_key`, `status`) VALUES
(1, '$2y$10$e6WvtZuOY6oZ3X359IsO6ON2GHJPfnHWYQv91EEW2thrsLw2GpZkS', 1);

-- --------------------------------------------------------

--
-- Table structure for table `loginattempts`
--

CREATE TABLE `loginattempts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user` bigint(20) UNSIGNED DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `timestamp` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user` bigint(20) UNSIGNED DEFAULT NULL,
  `hash` varchar(255) DEFAULT NULL,
  `timestamp` int(10) UNSIGNED DEFAULT NULL,
  `type` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`id`, `user`, `hash`, `timestamp`, `type`) VALUES
(1, 1, '$2y$10$HviYW36IQK1fEq/B2WlU2OsmzaV3KN3lOWPJ6WHMX6kQ48ErgOjLq', 1659198419, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` bigint(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` varchar(200) NOT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `phone`, `email`, `password`, `token`, `verified`) VALUES
(1, 'Rohan Adhikari', 9746892002, 'adhikarirohan249@gmail.com', '$2y$10$PQSbi8Oo5W1S2EDvIyKRj.OYH9BG/e0Wd4W3wsURAeinhX0tpCWN2', 'uKB1NgU5RIltmvL8ii4P7syclY8XFMZM7LauBIWV9A7yR16vkx', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_token`
--
ALTER TABLE `api_token`
  ADD PRIMARY KEY (`sn`);

--
-- Indexes for table `loginattempts`
--
ALTER TABLE `loginattempts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `api_token`
--
ALTER TABLE `api_token`
  MODIFY `sn` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `loginattempts`
--
ALTER TABLE `loginattempts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
