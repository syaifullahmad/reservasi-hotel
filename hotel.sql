-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 18, 2024 at 12:00 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hotel`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `gender` enum('male','female','','') NOT NULL,
  `job` varchar(255) NOT NULL,
  `birthdate` date NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `facilities`
--

CREATE TABLE `facilities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `facility_name` varchar(255) NOT NULL,
  `detail` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `facilities`
--

INSERT INTO `facilities` (`id`, `facility_name`, `detail`, `created_at`, `updated_at`) VALUES
(1, 'Resutaurant', 'Terdapat restaurant dan salon', '2024-08-15 21:28:32', '2024-08-15 21:28:32'),
(2, 'View', 'View city light', '2024-08-16 01:45:13', '2024-08-16 01:45:13'),
(3, 'AC double', 'AC berjumlah 4', '2024-08-17 14:54:00', '2024-08-17 14:54:00');

-- --------------------------------------------------------

--
-- Table structure for table `facility_rooms`
--

CREATE TABLE `facility_rooms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `facility_name` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `facility_rooms`
--

INSERT INTO `facility_rooms` (`id`, `facility_name`, `created_at`, `updated_at`) VALUES
(1, 'Kamar Luas', '2024-08-15 21:28:51', '2024-08-15 21:28:51'),
(2, 'View', '2024-08-16 01:45:56', '2024-08-16 01:45:56'),
(3, 'AC', '2024-08-17 14:54:12', '2024-08-17 14:54:12');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `log` varchar(255) NOT NULL,
  `executor_id` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `bukti` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type_id` varchar(255) NOT NULL,
  `number` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'a',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `type_id`, `number`, `status`, `created_at`, `updated_at`) VALUES
(2, '2', '2', 'a', '2024-08-16 01:49:51', '2024-08-16 01:49:51'),
(4, '2', '3', 'a', '2024-08-17 14:37:03', '2024-08-17 14:37:03'),
(5, '1', '1', 'a', '2024-08-17 14:57:07', '2024-08-17 14:57:07'),
(6, '4', '4', 'a', '2024-08-17 14:57:20', '2024-08-17 14:57:20');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `room_id` varchar(255) NOT NULL,
  `check_in` varchar(255) NOT NULL,
  `many_room` varchar(255) NOT NULL,
  `check_out` varchar(255) NOT NULL,
  `status` enum('waiting for payment','process','verified','failed','rejected','checked in','checked out','canceled') NOT NULL DEFAULT 'waiting for payment',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `room_id`, `check_in`, `many_room`, `check_out`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, '', '2024-08-17', '1', '2024-08-18', 'waiting for payment', '2024-08-17 15:52:14', '2024-08-17 15:52:14'),
(2, 1, '', '2024-08-17', '1', '2024-08-18', 'waiting for payment', '2024-08-17 15:52:52', '2024-08-17 15:52:52'),
(3, 1, '', '2024-08-17', '1', '2024-08-18', 'waiting for payment', '2024-08-17 15:53:05', '2024-08-17 15:53:05'),
(4, 1, '', '2024-08-17', '1', '2024-08-18', 'waiting for payment', '2024-08-17 15:53:14', '2024-08-17 15:53:14'),
(5, 1, '', '2024-08-17', '1', '2024-08-18', 'waiting for payment', '2024-08-17 15:53:51', '2024-08-17 15:53:51'),
(6, 1, '', '2024-08-17', '1', '2024-08-18', 'waiting for payment', '2024-08-17 16:04:08', '2024-08-17 16:04:08'),
(7, 1, '', '2024-08-17', '1', '2024-08-18', 'waiting for payment', '2024-08-17 16:05:08', '2024-08-17 16:05:08'),
(8, 1, '', '2024-08-17', '1', '2024-08-18', 'waiting for payment', '2024-08-17 16:05:18', '2024-08-17 16:05:18');

-- --------------------------------------------------------

--
-- Table structure for table `type_rooms`
--

CREATE TABLE `type_rooms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `foto` varchar(255) NOT NULL,
  `price` varchar(255) NOT NULL,
  `facilities` varchar(255) NOT NULL,
  `information` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `type_rooms`
--

INSERT INTO `type_rooms` (`id`, `name`, `foto`, `price`, `facilities`, `information`, `created_at`, `updated_at`) VALUES
(1, 'Deluxe Room', '1723906594deluxe-room.jpg', '1000000', 'Kamar Luas, AC', 'Hebat', '2024-08-15 21:31:23', '2024-08-17 14:56:34'),
(2, 'Strandard Room', '1723906548standard-room.jpg', '850000', 'Kamar Luas, View', 'Cakep', '2024-08-16 01:49:28', '2024-08-17 14:55:48'),
(4, 'Superior Room', '1723906529superior-room.jpg', '1200000', 'Kamar Luas, View, AC', '-', '2024-08-17 14:55:29', '2024-08-17 14:56:01');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` enum('customer','resepsionis','admin','') NOT NULL,
  `phone` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `role`, `phone`, `password`, `created_at`, `updated_at`) VALUES
(1, 'ahmad', 'syaifulahmad0428@gmail.com', 'customer', '083822995378', '$2y$10$HaxstH2hQ0Of/qIkaYAaE.38d6l9I.zCvKXf./mHoQboaP5O4KV2.', '2024-08-15 19:20:41', '2024-08-15 19:44:15'),
(2, 'admin 20670116 Ahmad', 'admin123@gmail.com', 'admin', '0898218763761', '$2y$10$C/4uUkxDqgHtdH9RAiJ/Ge55gTT44xDI.fYTfTVbSqEdW4moSLMKC', '2024-08-15 19:31:46', '2024-08-15 20:16:58'),
(3, 'petugas', 'petugas123@gmail.com', 'resepsionis', '089812341234', '$2y$10$Lu1Lbjexi6UTrPtKng4qH.nhMG88.Ih63SySTkXnR9BCimwMin7LK', '2024-08-15 19:37:28', '2024-08-15 19:37:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `facilities`
--
ALTER TABLE `facilities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `facility_rooms`
--
ALTER TABLE `facility_rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `type_rooms`
--
ALTER TABLE `type_rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `facilities`
--
ALTER TABLE `facilities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `facility_rooms`
--
ALTER TABLE `facility_rooms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `type_rooms`
--
ALTER TABLE `type_rooms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
