-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 19, 2025 at 03:21 AM
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
(337, 1, 'A new student assistant has been added: Ashleeh Thess Ranalan', '2025-03-16 16:39:06'),
(338, 1, 'A new student assistant has been added: Alter Lloyd Corcuera', '2025-03-16 16:39:55'),
(339, 1, 'Added new duty hours: 5 hours', '2025-03-16 16:40:37'),
(340, 1, 'Added new duty hours: 10 hours', '2025-03-16 16:40:37'),
(341, 1, 'Added new duty hours: 90 hours', '2025-03-16 16:40:37'),
(342, 1, 'Added new duty hours: 180 hours', '2025-03-16 16:40:38'),
(343, 1, 'A new student assistant has been added: Nono Vincent Bagtasos', '2025-03-16 16:41:26'),
(344, 1, 'Assigned duty schedule to Nono Vincent Bagtasos on Monday from 07:00 AM to 10:00 AM for 5 hours', '2025-03-16 16:41:59'),
(345, 1, 'Assigned duty schedule to Nono Vincent Bagtasos on Tuesday from 07:00 AM to 10:00 AM for 5 hours', '2025-03-16 16:42:12'),
(346, 1, 'Assigned duty schedule to Nono Vincent Bagtasos on Monday from 08:00 AM to 11:00 AM for 10 hours', '2025-03-17 10:12:17'),
(347, 1, 'Assigned duty schedule to Nono Vincent Bagtasos on Tuesday from 08:00 AM to 11:00 AM for 10 hours', '2025-03-17 10:12:25'),
(348, 1, 'Time-in for student assistant Nono Vincent Bagtasos has been Approved. Current Status: Late', '2025-03-17 10:19:41'),
(349, 1, 'Time-in for student assistant Nono Vincent Bagtasos has been Pending. Current Status: Late', '2025-03-17 10:40:33'),
(350, 1, 'Time-in for student assistant Nono Vincent Bagtasos has been Approved. Current Status: Late', '2025-03-17 10:42:22'),
(351, 1, 'Assigned duty schedule to Nono Vincent Bagtasos on Wednesday from 08:00 AM to 11:00 AM for 10 hours', '2025-03-17 10:43:13'),
(352, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Approved.', '2025-03-17 10:49:11'),
(353, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Approved.', '2025-03-17 10:55:41'),
(354, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Approved.', '2025-03-17 10:56:12'),
(355, 1, 'A new student assistant has been added: Warren Babaylan', '2025-03-17 11:54:27'),
(356, 1, 'A new student assistant has been added: eliza may guin parba', '2025-03-17 12:28:28'),
(357, 1, 'Assigned duty schedule to eliza may guin parba on Monday, Wednesday from 07:30 AM to 05:30 PM for 90 hours', '2025-03-17 12:29:23'),
(358, 1, 'Assigned duty schedule to eliza may guin parba on Friday from 07:30 AM to 05:30 PM for 90 hours', '2025-03-17 12:29:43'),
(359, 1, 'Time-in for student assistant eliza may guin parba has been Approved. Current Status: Late', '2025-03-17 12:33:49'),
(360, 1, 'Time-in for student assistant Nono Vincent Bagtasos has been Approved. Current Status: Late', '2025-03-18 09:49:19'),
(361, 1, 'Assigned duty schedule to Nono Vincent Bagtasos on Tuesday from 08:00 AM to 11:00 AM for 10 hours', '2025-03-18 10:16:03'),
(362, 1, 'Time-in for student assistant Nono Vincent Bagtasos has been Approved. Current Status: Late', '2025-03-18 10:16:33'),
(363, 1, 'A new student assistant has been added: Kenneth Abalo', '2025-03-18 10:28:23'),
(364, 1, 'Assigned duty schedule to Kenneth Abalo on Tuesday from 08:30 AM to 01:00 PM for 10 hours', '2025-03-18 10:28:47'),
(365, 1, 'The leave request for student assistant Kenneth Abalo has been Approved.', '2025-03-18 10:32:34'),
(366, 1, 'The leave request for student assistant Kenneth Abalo has been Approved.', '2025-03-18 10:42:31'),
(367, 1, 'The leave request for student assistant Kenneth Abalo has been Approved.', '2025-03-18 11:06:23'),
(368, 1, 'Assigned duty schedule to Kenneth Abalo on Wednesday from 08:30 AM to 01:00 PM for 10 hours', '2025-03-18 11:06:43'),
(369, 1, 'The leave request for student assistant Nono Vincent Bagtasos has been Approved.', '2025-03-18 11:22:37'),
(370, 1, 'Assigned duty schedule to Kenneth Abalo on Friday from 08:30 AM to 01:00 PM for 10 hours', '2025-03-18 11:23:49'),
(371, 1, 'The leave request for student assistant Kenneth Abalo has been Approved.', '2025-03-18 11:25:29'),
(372, 1, 'Assigned duty schedule to Warren Babaylan on Monday, Thursday from 10:00 AM to 11:00 AM for 10 hours', '2025-03-19 09:52:38'),
(373, 1, 'Assigned duty schedule to Warren Babaylan on Wednesday from 10:00 AM to 11:00 AM for 10 hours', '2025-03-19 09:53:20'),
(374, 1, 'The leave request for student assistant Warren Babaylan has been Approved.', '2025-03-19 09:54:47'),
(375, 1, 'The leave request for student assistant Warren Babaylan has been Rejected.', '2025-03-19 09:56:31'),
(376, 1, 'Assigned duty schedule to Ashleeh Thess Ranalan on Tuesday from 08:00 AM to 03:00 PM for 180 hours', '2025-03-19 09:58:30'),
(377, 1, 'Time-in for student assistant Warren Babaylan has been Approved. Current Status: Present', '2025-03-19 10:19:35');

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
(75, 5),
(76, 10),
(77, 90),
(78, 180);

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
(222, 102, 1, '08:00:00', '11:00:00', 76, 1.00),
(224, 102, 3, '08:00:00', '11:00:00', 76, 0.00),
(225, 104, 1, '07:30:00', '17:30:00', 77, 0.00),
(226, 104, 3, '07:30:00', '17:30:00', 77, 0.00),
(227, 104, 5, '07:30:00', '17:30:00', 77, 0.00),
(228, 102, 2, '08:00:00', '11:00:00', 76, 0.75),
(229, 105, 2, '08:30:00', '13:00:00', 76, 0.00),
(230, 105, 3, '08:30:00', '13:00:00', 76, 0.00),
(231, 105, 5, '08:30:00', '13:00:00', 76, 0.00),
(232, 103, 1, '10:00:00', '11:00:00', 76, 0.00),
(233, 103, 4, '10:00:00', '11:00:00', 76, 0.00),
(234, 103, 3, '10:00:00', '11:00:00', 76, 0.00),
(235, 100, 2, '08:00:00', '15:00:00', 78, 0.00);

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
(25, 102, 'Take Exam.', 'Good day Sir, please allow me to take absent, because I have final exam on that day.', '2025-03-19', 2, 1, 'Ok'),
(28, 105, 'Personal', 'Good day sir, I will take an absent this day because I have an final exam to take', '2025-03-18', 2, 1, 'Sure no problem.'),
(29, 105, 'Personal', 'I also leave on Wednesday Sir, Because I have an exam', '2025-03-19', 2, 1, 'Sure Ok ra'),
(30, 103, 'Sakit tiil', 'absent sako sir', '2025-03-19', 3, 1, 'not valid reason');

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
  `email` varchar(50) NOT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student_assistant`
--

INSERT INTO `student_assistant` (`sa_id`, `firstname`, `lastname`, `student_id`, `email`, `username`, `password`) VALUES
(100, 'Ashleeh Thess', 'Ranalan', '02-2324-07849', 'asog.ranalan.coc@phinmaed.com', '02-2324-07849', 'ranalan'),
(101, 'Alter Lloyd', 'Corcuera', '02232405468', 'almo.corcuera.coc@phinmaed.com', '02232405468', 'corcuera'),
(102, 'Nono Vincent', 'Bagtasos', '02-2122-034022', 'nonbagtasos@gmail.com', '02-2122-034022', 'bagtasos'),
(103, 'Warren', 'Babaylan', '02-2122-034021', 'waba.babaylan.coc@phinmaed.com', '02-2122-034021', 'babaylan'),
(104, 'eliza may guin', 'parba', '02-2223-05865', 'elma.parba.coc@phinmaed.com', '02-2223-05865', 'parba'),
(105, 'Kenneth', 'Abalo', '02-2122-034023', 'kenabalo@gmail.com', '02-2122-034023', 'abalo');

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
(61, 102, 222, '2025-03-17', '10:13:27', '10:03:15', 2, 2, 1),
(62, 104, 225, '2025-03-17', '12:33:19', NULL, 2, 2, 1),
(64, 102, 228, '2025-03-18', '10:16:11', '11:01:23', 2, 2, 1),
(65, 103, 234, '2025-03-19', '09:57:02', NULL, 2, 1, 1);

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
  ADD UNIQUE KEY `student_id` (`student_id`),
  ADD UNIQUE KEY `email` (`email`);

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
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `admin_activity_log`
--
ALTER TABLE `admin_activity_log`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=378;

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
  MODIFY `duty_hours_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `sa_duty_schedule`
--
ALTER TABLE `sa_duty_schedule`
  MODIFY `duty_schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=236;

--
-- AUTO_INCREMENT for table `sa_leave_request`
--
ALTER TABLE `sa_leave_request`
  MODIFY `leave_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `student_assistant`
--
ALTER TABLE `student_assistant`
  MODIFY `sa_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `time_track`
--
ALTER TABLE `time_track`
  MODIFY `track_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

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
