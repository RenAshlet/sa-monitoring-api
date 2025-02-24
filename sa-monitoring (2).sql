-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 22, 2025 at 04:50 AM
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
(8, 30),
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
  `approved_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

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
  MODIFY `duty_hours_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sa_duty_schedule`
--
ALTER TABLE `sa_duty_schedule`
  MODIFY `duty_schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `sa_leave_request`
--
ALTER TABLE `sa_leave_request`
  MODIFY `leave_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student_assistant`
--
ALTER TABLE `student_assistant`
  MODIFY `sa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `time_track`
--
ALTER TABLE `time_track`
  MODIFY `track_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

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
