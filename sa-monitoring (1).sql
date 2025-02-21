-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 21, 2025 at 03:13 AM
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
(1, 'John', 'Smith', 'admin', 'admin123');

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
(11, 1, 'Added new student assistant: Ren Babaylan', '2025-02-19 09:54:00'),
(12, 1, 'Added new student assistant: Nono Bagtasos', '2025-02-19 09:59:47'),
(13, 1, 'Assigned duty schedule to Nono Bagtasos on Monday, Tuesday, Wednesday, Thursday, Friday, Saturday from 07:00 AM to 10:00 AM for 90 hours', '2025-02-19 10:04:26'),
(14, 1, 'Added new student assistant: Scott Salvana', '2025-02-19 10:43:12'),
(15, 1, 'Added new student assistant: Kenneth Abalo', '2025-02-19 10:45:08'),
(16, 1, 'Added new student assistant: Arvyn Ucang', '2025-02-19 10:52:47'),
(17, 1, 'Added new duty hours: 30 hours', '2025-02-19 12:04:43'),
(18, 1, 'Assigned duty schedule to Kenneth Abalo on Monday, Tuesday, Thursday, Friday, Saturday, Wednesday from 08:00 AM to 01:00 PM for 90 hours', '2025-02-19 14:06:12'),
(19, 1, 'Added new duty hours: 180 hours', '2025-02-19 14:29:11');

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
(8, 30),
(6, 90),
(7, 120),
(10, 180);

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
(54, 32, 1, '07:00:00', '10:00:00', 6, 0.00),
(55, 32, 2, '07:00:00', '10:00:00', 6, 0.00),
(56, 32, 3, '07:00:00', '10:00:00', 6, 0.00),
(57, 32, 4, '07:00:00', '10:00:00', 6, 0.00),
(58, 32, 5, '07:00:00', '10:00:00', 6, 0.00),
(59, 32, 6, '07:00:00', '10:00:00', 6, 0.00),
(60, 34, 3, '08:00:00', '13:00:00', 6, 0.00);

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
  `approved_status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `approved_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(31, 'Ren', 'Babaylan', '022122034021', '022122034021', 'babaylan'),
(32, 'Nono', 'Bagtasos', '022122034022', '022122034022', 'bagtasos'),
(33, 'Scott', 'Salvana', '022122034023', '022122034023', 'salvana'),
(34, 'Kenneth', 'Abalo', '022122034024', '022122034024', 'abalo'),
(35, 'Arvyn', 'Ucang', '022122034025', '022122034025', 'ucang');

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
  `approved_status` enum('Pending','Approved','Rejected') DEFAULT 'Pending',
  `status` enum('Absent','Present','Late') DEFAULT 'Absent',
  `approved_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `time_track`
--

INSERT INTO `time_track` (`track_id`, `sa_id`, `duty_schedule_id`, `date`, `time_in`, `time_out`, `approved_status`, `status`, `approved_by`) VALUES
(31, 32, 56, '2025-02-19', '14:12:15', NULL, 'Pending', 'Absent', NULL);

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
  ADD KEY `approved_by` (`approved_by`);

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
  ADD KEY `approved_by` (`approved_by`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `days`
--
ALTER TABLE `days`
  MODIFY `day_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `duty_hours`
--
ALTER TABLE `duty_hours`
  MODIFY `duty_hours_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sa_duty_schedule`
--
ALTER TABLE `sa_duty_schedule`
  MODIFY `duty_schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `sa_leave_request`
--
ALTER TABLE `sa_leave_request`
  MODIFY `leave_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `student_assistant`
--
ALTER TABLE `student_assistant`
  MODIFY `sa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `time_track`
--
ALTER TABLE `time_track`
  MODIFY `track_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

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
  ADD CONSTRAINT `sa_leave_request_ibfk_2` FOREIGN KEY (`approved_by`) REFERENCES `admin` (`admin_id`);

--
-- Constraints for table `time_track`
--
ALTER TABLE `time_track`
  ADD CONSTRAINT `time_track_ibfk_1` FOREIGN KEY (`sa_id`) REFERENCES `student_assistant` (`sa_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `time_track_ibfk_2` FOREIGN KEY (`duty_schedule_id`) REFERENCES `sa_duty_schedule` (`duty_schedule_id`),
  ADD CONSTRAINT `time_track_ibfk_3` FOREIGN KEY (`approved_by`) REFERENCES `admin` (`admin_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
