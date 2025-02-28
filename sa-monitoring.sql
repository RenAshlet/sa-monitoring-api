-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2025 at 12:46 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sa-monitoring`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `firstname` varchar(25) NOT NULL,
  `lastname` varchar(25) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `firstname`, `lastname`, `username`, `password`) VALUES
(1, 'John', 'Smith', 'admin', 'admin123'),
(3, 'Tony', 'Stark', 'ironman', 'stark'),
(4, 'Warren', 'Babaylan', 'goat', 'babaylan');

-- --------------------------------------------------------

--
-- Table structure for table `admin_activity_log`
--

CREATE TABLE `admin_activity_log` (
  `log_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `action` text NOT NULL,
  `timestamp` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_activity_log`
--

INSERT INTO `admin_activity_log` (`log_id`, `admin_id`, `action`, `timestamp`) VALUES
(71, 1, 'Added new student assistant: Ren Babaylan', '2025-02-22 12:10:37'),
(72, 1, 'Added new student assistant: Nono Vincent Bagtasos', '2025-02-22 12:11:01'),
(73, 1, 'Assigned duty schedule to Nono Vincent Bagtasos on Monday, Tuesday, Wednesday, Thursday, Friday, Saturday from 08:00 AM to 01:00 PM for 120 hours', '2025-02-22 12:11:32'),
(74, 1, 'A new student assistant has been added: Kenneth Abalo', '2025-02-22 12:13:42'),
(75, 1, 'Time-in for student assistant Nono Vincent Bagtasos has been Approved. Current Status: Late', '2025-02-22 12:17:25'),
(76, 1, 'Added new admin: Tony Stark', '2025-02-22 12:44:47'),
(77, 3, 'A new student assistant has been added: Hazel Mae Albaladejo', '2025-02-24 09:10:21'),
(78, 1, 'Added new duty hours: 10 hours', '2025-02-24 09:45:35'),
(79, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Approved.', '2025-02-24 11:01:53'),
(80, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Rejected.', '2025-02-24 11:33:49'),
(81, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Rejected.', '2025-02-24 11:49:12'),
(82, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Rejected.', '2025-02-24 11:52:06'),
(83, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Approved.', '2025-02-24 11:52:48'),
(84, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Rejected.', '2025-02-24 12:04:44'),
(85, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Pending.', '2025-02-24 12:05:44'),
(86, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Rejected.', '2025-02-24 12:05:52'),
(87, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Pending.', '2025-02-24 12:08:00'),
(88, 1, 'Added new duty hours: 50 hours', '2025-02-24 13:52:06'),
(89, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Rejected.', '2025-02-24 15:38:12'),
(90, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Pending.', '2025-02-24 15:38:29'),
(91, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Approved.', '2025-02-24 15:38:38'),
(92, 3, 'A new student assistant has been added: Joie Llegunas', '2025-02-24 15:41:30'),
(93, 3, 'A new student assistant has been added: Scott Salvana', '2025-02-24 15:41:43'),
(94, 3, 'A new student assistant has been added: Ren Babaylan', '2025-02-24 15:45:46'),
(95, 1, 'A new student assistant has been added: Miguel Asilo', '2025-02-24 16:18:42'),
(96, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Approved.', '2025-02-24 16:41:12'),
(97, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Pending.', '2025-02-24 16:47:12'),
(98, 1, 'New admin added: Warren Babaylan', '2025-02-25 11:22:42'),
(99, 1, 'A new student assistant has been added: Jahnine Balsabas', '2025-02-25 11:24:45'),
(100, 1, 'A new student assistant has been added: Carlos Lopez', '2025-02-25 14:11:50'),
(101, 1, 'A new student assistant has been added: Ronex Ochavillo', '2025-02-25 14:12:32'),
(102, 1, 'Assigned duty schedule to Ren Babaylan on Tuesday, Wednesday, Thursday, Monday, Friday, Saturday from 07:00 AM to 09:00 AM for 30 hours', '2025-02-26 12:40:18'),
(103, 1, 'Assigned duty schedule to Carlos Lopez on Monday, Tuesday, Wednesday, Thursday, Saturday, Friday from 08:00 AM to 01:00 PM for 90 hours', '2025-02-26 13:41:37'),
(104, 1, 'Assigned duty schedule to Carlos Lopez on Monday, Tuesday, Thursday, Friday, Saturday, Wednesday from 08:00 AM to 01:00 PM for 90 hours', '2025-02-26 13:43:38'),
(105, 1, 'Time-in for student assistant Carlos Lopez has been Rejected. Current Status: Absent', '2025-02-26 15:51:22'),
(106, 1, 'Time-in for student assistant Nono Vincent Bagtasos has been Rejected. Current Status: Absent', '2025-02-26 15:51:36'),
(107, 1, 'Time-in for student assistant Nono Vincent Bagtasos has been Approved. Current Status: Late', '2025-02-26 15:51:48'),
(108, 1, 'Time-in for student assistant Nono Vincent Bagtasos has been Approved. Current Status: Present', '2025-02-26 15:51:56'),
(109, 1, 'Time-in for student assistant Nono Vincent Bagtasos has been Rejected. Current Status: Late', '2025-02-26 16:35:13'),
(110, 1, 'Time-in for student assistant Nono Vincent Bagtasos has been Rejected. Current Status: Present', '2025-02-26 17:05:11');

-- --------------------------------------------------------

--
-- Table structure for table `approved_status`
--

CREATE TABLE `approved_status` (
  `approved_status_id` int(11) NOT NULL,
  `approved_status_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `approved_status`
--

INSERT INTO `approved_status` (`approved_status_id`, `approved_status_name`) VALUES
(1, 'Pending'),
(2, 'Approved'),
(3, 'Rejected');

-- --------------------------------------------------------

--
-- Table structure for table `days`
--

CREATE TABLE `days` (
  `day_id` int(11) NOT NULL,
  `day_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `days`
--

INSERT INTO `days` (`day_id`, `day_name`) VALUES
(5, 'Friday'),
(1, 'Monday'),
(6, 'Saturday'),
(4, 'Thursday'),
(2, 'Tuesday'),
(3, 'Wednesday');

-- --------------------------------------------------------

--
-- Table structure for table `duty_hours`
--

CREATE TABLE `duty_hours` (
  `duty_hours_id` int(11) NOT NULL,
  `required_duty_hours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `duty_hours`
--

INSERT INTO `duty_hours` (`duty_hours_id`, `required_duty_hours`) VALUES
(10, 10),
(8, 30),
(12, 50),
(6, 90),
(7, 120);

-- --------------------------------------------------------

--
-- Table structure for table `sa_duty_schedule`
--

CREATE TABLE `sa_duty_schedule` (
  `duty_schedule_id` int(11) NOT NULL,
  `sa_id` int(11) NOT NULL,
  `day_id` int(11) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `duty_hours_id` int(11) NOT NULL,
  `total_duty_hours` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sa_duty_schedule`
--

INSERT INTO `sa_duty_schedule` (`duty_schedule_id`, `sa_id`, `day_id`, `start_time`, `end_time`, `duty_hours_id`, `total_duty_hours`) VALUES
(67, 42, 1, '08:00:00', '13:00:00', 7, 1.72),
(68, 42, 2, '08:00:00', '13:00:00', 7, 0.00),
(69, 42, 3, '08:00:00', '13:00:00', 7, 0.00),
(70, 42, 4, '08:00:00', '13:00:00', 7, 0.00),
(71, 42, 5, '08:00:00', '13:00:00', 7, 0.00),
(72, 42, 6, '08:00:00', '13:00:00', 7, 2.02),
(73, 41, 5, '07:00:00', '09:00:00', 8, 0.00),
(74, 41, 6, '07:00:00', '09:00:00', 8, 0.00),
(75, 41, 1, '07:00:00', '09:00:00', 8, 0.00),
(76, 50, 5, '08:00:00', '13:00:00', 6, 0.00),
(77, 50, 3, '08:00:00', '13:00:00', 6, 0.00);

-- --------------------------------------------------------

--
-- Table structure for table `sa_leave_request`
--

CREATE TABLE `sa_leave_request` (
  `leave_id` int(11) NOT NULL,
  `sa_id` int(11) NOT NULL,
  `leave_type` varchar(50) NOT NULL,
  `reason` text DEFAULT NULL,
  `date` date DEFAULT NULL,
  `approved_status` int(11) NOT NULL DEFAULT 1,
  `approved_by` int(11) DEFAULT NULL,
  `admin_comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sa_leave_request`
--

INSERT INTO `sa_leave_request` (`leave_id`, `sa_id`, `leave_type`, `reason`, `date`, `approved_status`, `approved_by`, `admin_comment`) VALUES
(12, 42, 'checkup', 'Please allow me to take leave on that day sir because I will go to clinic and take a checkup', '2025-02-24', 2, 1, 'understood.'),
(13, 42, 'Personal', 'absent sako sir please', '2025-02-25', 2, 1, 'bfskdbva'),
(14, 42, 'sadboi', 'cahcua', '2025-02-26', 2, 1, ''),
(15, 42, 'Sick', 'labsick', '2025-02-27', 1, 1, ' dsv fsbvs');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `status_id` int(11) NOT NULL,
  `status_name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`status_id`, `status_name`) VALUES
(1, 'Present'),
(2, 'Late'),
(3, 'Absent');

-- --------------------------------------------------------

--
-- Table structure for table `student_assistant`
--

CREATE TABLE `student_assistant` (
  `sa_id` int(11) NOT NULL,
  `firstname` varchar(25) NOT NULL,
  `lastname` varchar(25) NOT NULL,
  `student_id` varchar(25) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_assistant`
--

INSERT INTO `student_assistant` (`sa_id`, `firstname`, `lastname`, `student_id`, `username`, `password`) VALUES
(41, 'Ren', 'Babaylan', '022122034021', '022122034021', 'babaylan'),
(42, 'Nono Vincent', 'Bagtasos', '022122034022', '022122034022', 'bagtasos'),
(43, 'Kenneth', 'Abalo', '022122034023', '022122034023', 'abalo'),
(44, 'Hazel Mae', 'Albaladejo', '022122034024', '022122034024', 'albaladejo'),
(45, 'Joie', 'Llegunas', '022122034025', '022122034025', 'llegunas'),
(46, 'Scott', 'Salvana', '022122034026', '022122034026', 'salvana'),
(48, 'Miguel', 'Asilo', '022122034027', '022122034027', 'asilo'),
(49, 'Jahnine', 'Balsabas', '022122034028', '022122034028', 'balsabas'),
(50, 'Carlos', 'Lopez', '022122034029', '022122034029', 'lopez'),
(51, 'Ronex', 'Ochavillo', '022122023031', '022122023031', 'ochavillo');

-- --------------------------------------------------------

--
-- Table structure for table `time_track`
--

CREATE TABLE `time_track` (
  `track_id` int(11) NOT NULL,
  `sa_id` int(11) NOT NULL,
  `duty_schedule_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `time_in` time DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `approved_status` int(11) NOT NULL DEFAULT 1,
  `status` int(11) NOT NULL DEFAULT 3,
  `approved_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `time_track`
--

INSERT INTO `time_track` (`track_id`, `sa_id`, `duty_schedule_id`, `date`, `time_in`, `time_out`, `approved_status`, `status`, `approved_by`) VALUES
(36, 42, 72, '2025-02-22', '12:17:01', '11:05:59', 3, 2, 1),
(37, 42, 67, '2025-02-24', '09:24:41', '11:08:08', 3, 1, 1),
(38, 42, 72, '2025-02-26', '12:57:51', '13:31:41', 3, 3, 1),
(39, 50, 76, '2025-02-26', '13:59:05', NULL, 3, 3, 1),
(40, 42, 72, '2025-02-27', '07:44:43', NULL, 1, 3, NULL);

--
-- Triggers `time_track`
--
DELIMITER $$
CREATE TRIGGER `update_total_duty_hours` AFTER UPDATE ON `time_track` FOR EACH ROW BEGIN
    -- Ensure we only compute total_duty_hours when time_out is updated
    IF NEW.time_out IS NOT NULL AND OLD.time_out IS NULL THEN
        -- Compute duty hours including minutes and seconds
        UPDATE sa_duty_schedule
        SET total_duty_hours = total_duty_hours + (TIMESTAMPDIFF(SECOND, NEW.time_in, NEW.time_out) / 3600.0)
        WHERE duty_schedule_id = NEW.duty_schedule_id;
    END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `admin_id` (`admin_id`);

--
-- Indexes for table `approved_status`
--
ALTER TABLE `approved_status`
  ADD PRIMARY KEY (`approved_status_id`);

--
-- Indexes for table `days`
--
ALTER TABLE `days`
  ADD PRIMARY KEY (`day_id`),
  ADD UNIQUE KEY `day_name` (`day_name`);

--
-- Indexes for table `duty_hours`
--
ALTER TABLE `duty_hours`
  ADD PRIMARY KEY (`duty_hours_id`),
  ADD UNIQUE KEY `required_duty_hours` (`required_duty_hours`);

--
-- Indexes for table `sa_duty_schedule`
--
ALTER TABLE `sa_duty_schedule`
  ADD PRIMARY KEY (`duty_schedule_id`),
  ADD UNIQUE KEY `sa_id` (`sa_id`,`day_id`,`start_time`),
  ADD KEY `day_id` (`day_id`),
  ADD KEY `duty_hours_id` (`duty_hours_id`);

--
-- Indexes for table `sa_leave_request`
--
ALTER TABLE `sa_leave_request`
  ADD PRIMARY KEY (`leave_id`),
  ADD KEY `sa_id` (`sa_id`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `approved_status` (`approved_status`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indexes for table `student_assistant`
--
ALTER TABLE `student_assistant`
  ADD PRIMARY KEY (`sa_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `student_id` (`student_id`);

--
-- Indexes for table `time_track`
--
ALTER TABLE `time_track`
  ADD PRIMARY KEY (`track_id`),
  ADD KEY `sa_id` (`sa_id`),
  ADD KEY `duty_schedule_id` (`duty_schedule_id`),
  ADD KEY `approved_by` (`approved_by`),
  ADD KEY `approved_status` (`approved_status`),
  ADD KEY `status` (`status`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `approved_status`
--
ALTER TABLE `approved_status`
  MODIFY `approved_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `days`
--
ALTER TABLE `days`
  MODIFY `day_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `duty_hours`
--
ALTER TABLE `duty_hours`
  MODIFY `duty_hours_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `sa_duty_schedule`
--
ALTER TABLE `sa_duty_schedule`
  MODIFY `duty_schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `sa_leave_request`
--
ALTER TABLE `sa_leave_request`
  MODIFY `leave_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student_assistant`
--
ALTER TABLE `student_assistant`
  MODIFY `sa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `time_track`
--
ALTER TABLE `time_track`
  MODIFY `track_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  ADD CONSTRAINT `admin_activity_log_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`) ON DELETE CASCADE;

--
-- Constraints for table `sa_duty_schedule`
--
ALTER TABLE `sa_duty_schedule`
  ADD CONSTRAINT `sa_duty_schedule_ibfk_1` FOREIGN KEY (`sa_id`) REFERENCES `student_assistant` (`sa_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sa_duty_schedule_ibfk_2` FOREIGN KEY (`day_id`) REFERENCES `days` (`day_id`),
  ADD CONSTRAINT `sa_duty_schedule_ibfk_3` FOREIGN KEY (`duty_hours_id`) REFERENCES `duty_hours` (`duty_hours_id`);

--
-- Constraints for table `sa_leave_request`
--
ALTER TABLE `sa_leave_request`
  ADD CONSTRAINT `sa_leave_request_ibfk_1` FOREIGN KEY (`sa_id`) REFERENCES `student_assistant` (`sa_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sa_leave_request_ibfk_2` FOREIGN KEY (`approved_by`) REFERENCES `admin` (`admin_id`),
  ADD CONSTRAINT `sa_leave_request_ibfk_3` FOREIGN KEY (`approved_status`) REFERENCES `approved_status` (`approved_status_id`);

--
-- Constraints for table `time_track`
--
ALTER TABLE `time_track`
  ADD CONSTRAINT `time_track_ibfk_1` FOREIGN KEY (`sa_id`) REFERENCES `student_assistant` (`sa_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `time_track_ibfk_2` FOREIGN KEY (`duty_schedule_id`) REFERENCES `sa_duty_schedule` (`duty_schedule_id`),
  ADD CONSTRAINT `time_track_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `admin` (`admin_id`),
  ADD CONSTRAINT `time_track_ibfk_4` FOREIGN KEY (`approved_status`) REFERENCES `approved_status` (`approved_status_id`),
  ADD CONSTRAINT `time_track_ibfk_5` FOREIGN KEY (`status`) REFERENCES `status` (`status_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
