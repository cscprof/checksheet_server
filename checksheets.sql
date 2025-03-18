/*
MySQL Backup
Database: checksheet
Backup Time: 2025-03-02 12:31:44
*/

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `checksheet`.`core_theme_courses`;
DROP TABLE IF EXISTS `checksheet`.`core_themes`;
DROP TABLE IF EXISTS `checksheet`.`course_majors`;
DROP TABLE IF EXISTS `checksheet`.`course_minors`;
DROP TABLE IF EXISTS `checksheet`.`course_statuses`;
DROP TABLE IF EXISTS `checksheet`.`course_students`;
DROP TABLE IF EXISTS `checksheet`.`courses`;
DROP TABLE IF EXISTS `checksheet`.`major_students`;
DROP TABLE IF EXISTS `checksheet`.`majors`;
DROP TABLE IF EXISTS `checksheet`.`minor_students`;
DROP TABLE IF EXISTS `checksheet`.`minors`;
DROP TABLE IF EXISTS `checksheet`.`prerequisites`;
DROP TABLE IF EXISTS `checksheet`.`semesters`;
DROP TABLE IF EXISTS `checksheet`.`students`;
DROP TABLE IF EXISTS `checksheet`.`users`;
CREATE TABLE `core_theme_courses` (
  `core_theme_id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `theme_id` int NOT NULL,
  `transferable` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`core_theme_id`) USING BTREE,
  KEY `fk_course_course_theme` (`course_id`),
  KEY `fk_theme_course_theme` (`theme_id`),
  CONSTRAINT `fk_course_course_theme` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  CONSTRAINT `fk_theme_course_theme` FOREIGN KEY (`theme_id`) REFERENCES `core_themes` (`core_theme_id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `core_themes` (
  `core_theme_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `min_credits` int DEFAULT NULL,
  `max_credits` int DEFAULT NULL,
  PRIMARY KEY (`core_theme_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `course_majors` (
  `course_major_id` int NOT NULL AUTO_INCREMENT,
  `major_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  PRIMARY KEY (`course_major_id`) USING BTREE,
  KEY `fk_courses_course_major` (`course_id`),
  CONSTRAINT `fk_courses_course_major` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=140404 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `course_minors` (
  `course_minor_id` int NOT NULL AUTO_INCREMENT,
  `minor_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  PRIMARY KEY (`course_minor_id`) USING BTREE,
  KEY `fk_minor_course_minor` (`minor_id`),
  KEY `fk_course_course_minr` (`course_id`),
  CONSTRAINT `fk_course_course_minr` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  CONSTRAINT `fk_minor_course_minor` FOREIGN KEY (`minor_id`) REFERENCES `minors` (`minor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `course_statuses` (
  `course_status_id` int NOT NULL AUTO_INCREMENT,
  `course_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`course_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `course_students` (
  `course_student_id` int NOT NULL AUTO_INCREMENT,
  `course_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `grade` varchar(8) DEFAULT NULL,
  `course_status_id` int DEFAULT NULL,
  `semester_id` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  PRIMARY KEY (`course_student_id`),
  KEY `fk_students_course_studet` (`student_id`),
  KEY `fk_courses_course_student` (`course_id`),
  KEY `fk_course_status_course_Student` (`course_status_id`),
  CONSTRAINT `fk_course_status_course_Student` FOREIGN KEY (`course_status_id`) REFERENCES `course_statuses` (`course_status_id`),
  CONSTRAINT `fk_courses_course_student` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  CONSTRAINT `fk_students_course_studet` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `courses` (
  `course_id` int NOT NULL AUTO_INCREMENT,
  `course_code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_name` varchar(128) NOT NULL,
  `credits` int NOT NULL DEFAULT '0',
  `semester_id` int DEFAULT NULL,
  `minimum_credits` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`course_id`),
  KEY `fk_semester_courses` (`semester_id`),
  CONSTRAINT `fk_semester_courses` FOREIGN KEY (`semester_id`) REFERENCES `semesters` (`semester_id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `major_students` (
  `major_student_id` int NOT NULL AUTO_INCREMENT,
  `major_id` int NOT NULL,
  `student_id` int NOT NULL,
  PRIMARY KEY (`major_student_id`),
  KEY `fk_student_student_majors` (`student_id`),
  KEY `fk_major_student_major` (`major_id`),
  CONSTRAINT `fk_major_student_major` FOREIGN KEY (`major_id`) REFERENCES `majors` (`major_id`),
  CONSTRAINT `fk_student_student_majors` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `majors` (
  `major_id` int NOT NULL AUTO_INCREMENT,
  `major_name` varchar(64) NOT NULL,
  `major_abbreviation` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`major_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `minor_students` (
  `minor_student_id` int NOT NULL AUTO_INCREMENT,
  `minor_id` int NOT NULL,
  `student_id` int NOT NULL,
  PRIMARY KEY (`minor_student_id`) USING BTREE,
  KEY `fk_students_minor_student` (`student_id`),
  KEY `fk_minor_minor_student` (`minor_id`),
  CONSTRAINT `fk_minor_minor_student` FOREIGN KEY (`minor_id`) REFERENCES `minors` (`minor_id`),
  CONSTRAINT `fk_students_minor_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `minors` (
  `minor_id` int NOT NULL AUTO_INCREMENT,
  `minor_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `minor_abbreviation` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`minor_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `prerequisites` (
  `prerequisite_id` int NOT NULL AUTO_INCREMENT,
  `course_id` int NOT NULL,
  `prereq_course_id` int NOT NULL,
  PRIMARY KEY (`prerequisite_id`),
  KEY `fk_course_prereq` (`course_id`),
  KEY `fk_prereq_course_prereq` (`prereq_course_id`),
  CONSTRAINT `fk_course_prereq` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`),
  CONSTRAINT `fk_prereq_course_prereq` FOREIGN KEY (`prereq_course_id`) REFERENCES `courses` (`course_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `semesters` (
  `semester_id` int NOT NULL AUTO_INCREMENT,
  `semester_name` varchar(32) NOT NULL,
  PRIMARY KEY (`semester_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `students` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lastname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `preferred_name` varchar(64) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `account_guid` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `math_proficient` bit(1) NOT NULL DEFAULT b'1',
  `reading_proficient` bit(1) NOT NULL DEFAULT b'1',
  `foreign_language` bit(1) NOT NULL DEFAULT b'1',
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `fk_users_students` (`account_guid`),
  CONSTRAINT `fk_users_students` FOREIGN KEY (`account_guid`) REFERENCES `users` (`user_guid`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `users` (
  `user_guid` varchar(64) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `auth_token` varchar(48) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `token_expire` int DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `email_address` varchar(128) NOT NULL,
  `username` varchar(32) NOT NULL,
  PRIMARY KEY (`user_guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
BEGIN;
LOCK TABLES `checksheet`.`core_theme_courses` WRITE;
DELETE FROM `checksheet`.`core_theme_courses`;
INSERT INTO `checksheet`.`core_theme_courses` (`core_theme_id`,`course_id`,`theme_id`,`transferable`) VALUES (1, 3, 3, b'0'),(2, 4, 3, b'0'),(3, 5, 3, b'0'),(4, 6, 5, b'1'),(5, 7, 5, b'1'),(6, 13, 5, b'1'),(7, 14, 2, b'1'),(8, 43, 6, b'1'),(9, 44, 6, b'1'),(10, 45, 6, b'1'),(11, 46, 2, b'1'),(12, 47, 2, b'1'),(13, 49, 7, b'1'),(14, 50, 7, b'1'),(15, 51, 7, b'1'),(16, 52, 7, b'1'),(17, 53, 8, b'1'),(18, 54, 7, b'1'),(19, 55, 7, b'1'),(20, 56, 8, b'1'),(21, 57, 8, b'1'),(22, 58, 8, b'1'),(23, 59, 8, b'1'),(24, 60, 8, b'1'),(25, 61, 4, b'0'),(26, 62, 4, b'0'),(27, 63, 4, b'0'),(28, 64, 9, b'1'),(29, 78, 5, b'1'),(30, 79, 2, b'1'),(31, 80, 5, b'1'),(32, 81, 7, b'1'),(33, 82, 7, b'1'),(34, 83, 8, b'1'),(35, 84, 7, b'1'),(36, 85, 9, b'0'),(37, 86, 6, b'1'),(38, 87, 5, b'1'),(39, 88, 5, b'1'),(40, 89, 5, b'1'),(41, 90, 6, b'1'),(42, 91, 1, b'1'),(43, 92, 1, b'1'),(44, 43, 7, b'1'),(45, 44, 7, b'1'),(46, 45, 7, b'1'),(47, 86, 7, b'1'),(48, 90, 7, b'1');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`core_themes` WRITE;
DELETE FROM `checksheet`.`core_themes`;
INSERT INTO `checksheet`.`core_themes` (`core_theme_id`,`name`,`min_credits`,`max_credits`) VALUES (1, 'Community of Learners', 1, 1),(2, 'Reason and Rhetoric', 6, 6),(3, 'God', 9, 9),(4, 'Humanity', 6, 6),(5, 'Cosmos', 8, 9),(6, 'Society A', 3, 3),(7, 'Society B', 3, 6),(8, 'Society C', 3, 3),(9, 'Cultural Engagement', 6, 6);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`course_majors` WRITE;
DELETE FROM `checksheet`.`course_majors`;
INSERT INTO `checksheet`.`course_majors` (`course_major_id`,`major_id`,`course_id`) VALUES (1, 1, 15),(2, 1, 16),(3, 1, 17),(4, 1, 19),(5, 1, 20),(6, 1, 23),(7, 1, 24),(8, 1, 26),(9, 1, 31),(10, 1, 32),(11, 1, 68),(12, 1, 70),(13, 2, 15),(14, 2, 16),(15, 2, 17),(16, 2, 20),(17, 2, 23),(18, 2, 24),(19, 2, 26),(20, 2, 31),(21, 2, 32),(22, 2, 68),(23, 2, 70),(24, 2, 18),(25, 2, 25),(26, 2, 36),(27, 2, 37),(28, 2, 38),(29, 2, 39),(30, 2, 40),(31, 2, 41),(32, 2, 42),(33, 2, 48),(34, 3, 15),(35, 3, 16),(36, 3, 19),(37, 3, 23),(38, 3, 24),(39, 3, 26),(40, 3, 32),(41, 3, 1),(42, 3, 2),(43, 3, 8),(44, 3, 9),(45, 3, 10),(46, 3, 11),(47, 3, 12),(48, 3, 18),(49, 3, 25),(50, 3, 37),(51, 3, 43),(52, 3, 44),(53, 3, 48),(140401, 1, 34),(140402, 1, 35),(140403, 1, 30);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`course_minors` WRITE;
DELETE FROM `checksheet`.`course_minors`;
INSERT INTO `checksheet`.`course_minors` (`course_minor_id`,`minor_id`,`course_id`) VALUES (1, 1, 93),(2, 1, 21),(3, 1, 22),(4, 1, 27),(5, 1, 28),(6, 1, 29),(7, 2, 32),(8, 2, 36),(9, 2, 37),(10, 2, 40),(11, 2, 41),(12, 2, 42),(13, 3, 32),(14, 3, 33),(15, 3, 94),(16, 3, 71),(17, 3, 72),(18, 3, 76);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`course_statuses` WRITE;
DELETE FROM `checksheet`.`course_statuses`;
INSERT INTO `checksheet`.`course_statuses` (`course_status_id`,`course_status`) VALUES (1, 'Failed'),(2, 'Passed'),(3, 'In-Progress'),(4, 'Scheduled'),(5, 'Audit'),(6, 'Transfer'),(7, 'uNSCHEDULED');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`course_students` WRITE;
DELETE FROM `checksheet`.`course_students`;
INSERT INTO `checksheet`.`course_students` (`course_student_id`,`course_id`,`student_id`,`grade`,`course_status_id`,`semester_id`,`year`) VALUES (1, 91, 1, 'A', 2, 1, 2023),(2, 47, 1, NULL, 6, 2, 2023),(3, 14, 1, 'B', 2, 1, 2023),(4, 64, 1, NULL, 4, 1, 2025),(5, 85, 1, NULL, 4, 1, 2026),(6, 3, 1, NULL, 2, 1, 2023),(7, 4, 1, NULL, 2, 2, 2024),(8, 5, 1, NULL, 4, 2, 2026),(9, 78, 1, 'A', 2, 2, 2024),(10, 88, 1, NULL, 3, 1, 2024),(11, 7, 1, NULL, 4, 1, 2025),(12, 62, 1, 'C', 2, 2, 2024),(13, 63, 1, NULL, 4, 2, 2025),(14, 90, 1, NULL, 4, 2, 2025),(15, 43, 1, NULL, 4, 1, 2026),(16, 15, 1, 'A', 2, 2, 2024),(17, 16, 1, 'B', 3, 1, 2024),(18, 17, 1, 'A', 2, 1, 2023),(19, 19, 1, NULL, 4, 1, 2025),(20, 20, 1, NULL, 4, 2, 2025),(21, 23, 1, 'A', 2, 2, 2024),(22, 24, 1, NULL, 4, 2, 2025),(23, 26, 1, NULL, 4, 1, 2025),(24, 30, 1, NULL, 4, 2, 2026),(25, 34, 1, NULL, 4, 1, 2026),(26, 35, 1, NULL, 4, 2, 2027),(27, 70, 1, NULL, 4, 2, 2026),(28, 36, 1, NULL, 4, 2, 2025),(29, 37, 1, NULL, 3, 1, 2024),(30, 30, 1, NULL, 4, 2, 2026),(31, 41, 1, NULL, 4, 2, 2027),(32, 42, 1, NULL, 4, 1, 2026),(33, 32, 1, NULL, 4, 2, 2027),(34, 65, 1, 'A', 2, 1, 2023),(35, 18, 1, 'B', 2, 1, 2023),(36, 66, 1, NULL, 3, 1, 2024),(37, 91, 2, 'B', 2, 1, 2023),(38, 46, 2, 'B', 2, 1, 2023),(39, 14, 2, 'A', 2, 1, 2024),(40, 64, 2, NULL, 4, 1, 2025),(41, 85, 2, NULL, 7, 2, 2027),(42, 3, 2, 'A', 2, 1, 2023),(43, 4, 2, 'A', 2, 2, 2024),(44, 5, 2, NULL, 7, 2, 2026),(45, 78, 2, NULL, 7, 2, 2025),(46, 88, 2, NULL, 7, 2, 2027),(47, 87, 2, NULL, 7, 1, 2026),(48, 61, 2, NULL, 7, 2, 2024),(49, 62, 2, 'B', 2, 1, 2023),(50, 63, 2, 'B', 2, 2, 2024),(51, 90, 2, NULL, 4, 2, 2025),(52, 51, 2, 'B', 2, 1, 2024),(53, 52, 2, NULL, NULL, NULL, 2026),(54, 15, 2, 'A', 2, 1, 2023),(55, 16, 2, 'B', 2, 2, 2024),(56, 17, 2, 'A', 2, 2, 2024),(57, 18, 2, NULL, 7, 1, 2025),(58, 20, 2, 'C', 2, 1, 2024),(59, 23, 2, NULL, 4, 2, 2025),(60, 24, 2, NULL, 7, 2, 2027),(61, 25, 2, 'A', 2, 1, 2024),(62, 26, 2, NULL, 7, 2, 2026),(63, 31, 2, NULL, 7, 1, 2025),(64, 32, 2, NULL, 7, 1, 2026),(65, 36, 2, NULL, 4, 2, 2025),(66, 37, 2, NULL, 7, 1, 2025),(67, 38, 2, NULL, 7, 1, 2025),(68, 39, 2, NULL, 7, 1, 2026),(69, 40, 2, NULL, 7, 2, 2026),(70, 41, 2, NULL, 7, 2, 2027),(71, 42, 2, NULL, 7, 1, 2026),(72, 70, 2, NULL, 7, 1, 2025),(73, 68, 2, NULL, 4, 2, 2025),(74, 65, 2, 'C', 2, 2, 2024),(159, 91, 3, 'A', 2, 1, 2021),(160, 47, 3, 'B', 2, 1, 2021),(161, 79, 3, 'B', 2, 2, 2022),(162, 64, 3, 'B', 2, 1, 2022),(163, 85, 3, 'B', 2, 1, 2024),(164, 3, 3, 'A', 2, 1, 2021),(165, 4, 3, 'A', 2, 2, 2022),(166, 5, 3, 'B', 2, 1, 2023),(167, 78, 3, 'A', 2, 1, 2022),(168, 88, 3, 'A', 2, 1, 2024),(169, 6, 3, 'A', 4, 2, 2025),(170, 62, 3, 'B', 2, 1, 2021),(171, 63, 3, 'C', 2, 2, 2022),(172, 90, 3, 'A', 2, 1, 2021),(173, 1, 3, 'A', 2, 1, 2021),(174, 2, 3, 'A', 2, 1, 2022),(175, 8, 3, 'A', 2, 1, 2021),(176, 9, 3, 'A', 2, 1, 2022),(177, 10, 3, 'B', 2, 2, 2023),(178, 11, 3, 'A', 2, 2, 2023),(179, 12, 3, 'B', 2, 1, 2023),(180, 25, 3, 'B', 2, 2, 2022),(181, 15, 3, 'B', 2, 2, 2022),(182, 16, 3, 'B', 2, 1, 2022),(183, 18, 3, 'A', 2, 1, 2023),(184, 19, 3, 'A', 2, 2, 2023),(185, 23, 3, 'B', 2, 2, 2024),(186, 24, 3, 'A', 2, 2, 2023),(187, 26, 3, 'A', 2, 1, 2023),(188, 32, 3, 'B', 2, 1, 2024),(189, 37, 3, 'A', 2, 1, 2023),(190, 43, 3, 'B', 2, 1, 2022),(191, 44, 3, 'A', 2, 2, 2023),(192, 48, 3, 'B', 2, 2, 2023),(193, 40, 3, 'B', 2, 2, 2024),(194, 36, 3, 'A', 2, 2, 2024),(195, 41, 3, 'B', 4, 2, 2025),(196, 42, 3, 'C', 2, 1, 2024),(197, 31, 3, 'B', 2, 2, 2024),(198, 20, 3, 'B', 4, 2, 2025),(199, 95, 3, 'B', 4, 2, 2025),(200, 96, 3, 'A', 4, 2, 2025);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`courses` WRITE;
DELETE FROM `checksheet`.`courses`;
INSERT INTO `checksheet`.`courses` (`course_id`,`course_code`,`course_name`,`credits`,`semester_id`,`minimum_credits`) VALUES (1, 'ACC 151', 'Prin Of Acct', 3, 3, 0),(2, 'ACC 256', 'Mgr Acct', 3, 2, 0),(3, 'BIB 112', 'Old Testament Survey', 3, 3, 0),(4, 'BIB 113', 'New Testament Survey', 3, 3, 0),(5, 'BIB 300', 'Biblical Worldview', 3, 3, 60),(6, 'BIO 101', 'Human Biology', 3, 3, 0),(7, 'BIO 210', 'Id & Evolution', 3, 1, 0),(8, 'BUS 110', 'Found Of Bus', 3, 3, 0),(9, 'BUS 241', 'Bus Analytics I', 3, 1, 0),(10, 'BUS 242', 'Bus Analytics Ii', 3, 2, 0),(11, 'BUS 310', 'Prin Of Mgt', 3, 3, 28),(12, 'BUS 311', 'Bus Law', 3, 3, 28),(13, 'CHM 100', 'Introductory Applied Chemistry', 3, 2, 0),(14, 'COM 101', 'Principles Of Communication', 3, 3, 0),(15, 'CSC 101', 'Introduction To Programming', 3, 1, 0),(16, 'CSC 102', 'Object-Oriented Programming', 3, 2, 0),(17, 'CSC 133', 'Survey Of Computer Science', 4, 2, 0),(18, 'CSC 190', 'Html', 1, 1, 0),(19, 'CSC 203', 'Software Engineering', 3, 1, 0),(20, 'CSC 204', 'Algorithms', 3, 1, 0),(21, 'CSC 205', 'HCI Design & Programming', 3, 6, 0),(22, 'CSC 206', 'Web Programming', 3, 5, 0),(23, 'CSC 251', 'Networks And Security', 4, 2, 0),(24, 'CSC 311', 'Cyberethics And Cyber Law', 2, 2, 0),(25, 'CSC 344', 'Management Information System', 3, 3, 0),(26, 'CSC 363', 'Database Systems', 3, 1, 0),(27, 'CSC 364', 'Front-End Development', 3, 7, 0),(28, 'CSC 407', 'Cloud and Backend', 3, 4, 0),(29, 'CSC 408', 'Mobile Applications', 3, 7, 0),(30, 'CSC 425', 'Operating Sys Archtcr', 3, 2, 0),(31, 'CSC 427', 'Artifcial Intelligence', 3, 1, 0),(32, 'CSC 441', 'Project Management', 3, 3, 60),(33, 'CSC 465', 'Big Data Analytics', 3, 7, 0),(34, 'CSC 483', 'Senior Software Project', 3, 1, 90),(35, 'CSC 484', 'Senior Software Project', 3, 2, 0),(36, 'CYB 335', 'Unix & Linux Program', 3, 2, 28),(37, 'CYB 354', 'Cybersecurity', 3, 1, 0),(38, 'CYB 410', 'Intrusn Dectct-Prevnt', 3, 1, 0),(39, 'CYB 420', 'Gov Risk Compliance', 3, 1, 0),(40, 'CYB 425', 'Disaster Recovery & Bus Cont Plan', 3, 2, 0),(41, 'CYB 471', 'Computer Forensics', 3, 2, 60),(42, 'CYB 472', 'Faithful Hacking', 3, 1, 0),(43, 'ECO 211', 'Microeconomics', 3, 1, 0),(44, 'ECO 212', 'Macroeconomics', 3, 2, 0),(45, 'ECO 270', 'Principles Of Microeconomics For En', 3, 3, 0),(46, 'ENG 100', 'English Composition With Lab', 4, 1, 0),(47, 'ENG 101', 'English Composition', 3, 3, 0),(48, 'ENG311', 'Business And Technical Writing', 3, 7, 0),(49, 'HIS 150', 'Survey Of American History', 3, 2, 0),(50, 'HIS 250', 'US I: Coonial', 3, 2, 0),(51, 'HIS 220', 'Europe I: Ancient Thru Medieval', 3, 1, 0),(52, 'HIS 221', 'Europe II: 1500-1815', 3, 2, 0),(53, 'HIS 222', 'Europe III: 1815-Present', 3, 1, 0),(54, 'HIS 251', 'US II: 19th Century', 3, 1, 0),(55, 'HIS 252', 'US IIIi: Am Since 1900', 3, 2, 0),(56, 'HIS 260', 'Latin America', 3, 2, 0),(57, 'HIS 290', 'Modern Asia', 3, 1, 0),(58, 'HIS 304', 'Genocide', 3, 2, 0),(59, 'HIS 365', 'World Religions', 3, 1, 0),(60, 'HIS 391', 'History Of Russia', 3, 2, 0),(61, 'HUM 100', 'Humanities Lab', 1, 2, 0),(62, 'HUM 103', 'Invitation To The Humanties', 3, 3, 0),(63, 'HUM 203', 'Making The West', 3, 3, 0),(64, 'HUM 303', 'Perspectives:Mod&Cltr', 3, 3, 0),(65, 'MAT 095', 'Algebra', 3, 3, 0),(66, 'MAT 101', 'College Algebra', 3, 3, 0),(67, 'MAT 102', 'Trigonometry', 3, 2, 0),(68, 'MAT 105', 'Elementary Statistical Methods', 3, 3, 0),(69, 'MAT 120', 'Pre-Calculus', 3, 1, 0),(70, 'MAT 130', 'Discrete Math', 3, 2, 0),(71, 'MAT 161', 'Calculus I', 4, 3, 0),(72, 'MAT 162', 'Calculus II', 4, 3, 0),(73, 'MAT 261', 'Calculus III', 4, 3, 0),(74, 'MAT 265', 'Probability And Statistics', 3, 3, 0),(75, 'MAT 307', 'Linear Algebra', 3, 1, 0),(76, 'MAT 350', 'Numerical Methods', 3, 4, 0),(77, 'MAT 405', 'Differential Equations', 3, 3, 0),(78, 'PED 103', 'Physical Fitness', 1, 3, 0),(79, 'PHI 100', 'Critical Thinking', 3, 3, 0),(80, 'PHY 160', 'Introduction To Acoustics', 3, 2, 0),(81, 'POL 151', 'American Government', 3, 1, 0),(82, 'POL 203', 'International Relations', 3, 7, 0),(83, 'POL 211', 'Comparative Politics', 3, 6, 0),(84, 'POL 309', 'Liberalism', 3, 6, 0),(85, 'POL 352', 'Great Issues In Politics', 3, 3, 0),(86, 'PSY 201', 'Introduction To Psychology', 3, 3, 0),(87, 'SCS 105', 'Environmental Science', 3, 3, 0),(88, 'SCS 110', 'Intro Natural Science', 4, 3, 0),(89, 'SCS 215', 'Earth And Space Science', 3, 1, 0),(90, 'SOC 120', 'Society', 3, 3, 0),(91, 'SSC 101', 'Learning And Transition', 1, 3, 0),(92, 'SSC 104', 'College, Calling, & Career', 1, 3, 0),(93, 'COM 350', 'Com Design: Digital', 3, 5, 28),(94, 'EGR 371', 'Operations Research', 3, 6, 0),(95, 'BUS 330', 'Finance', 3, 3, 0),(96, 'BUS 331', 'Investments', 3, 2, 60);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`major_students` WRITE;
DELETE FROM `checksheet`.`major_students`;
INSERT INTO `checksheet`.`major_students` (`major_student_id`,`major_id`,`student_id`) VALUES (1, 1, 1),(2, 2, 2),(3, 3, 3),(4, 1, 4),(5, 2, 5),(6, 3, 6),(7, 1, 7),(8, 2, 8),(9, 3, 9),(11, 1, 10),(12, 2, 11),(13, 3, 12),(14, 1, 13),(15, 2, 14),(16, 3, 15),(17, 1, 15),(18, 2, 17),(19, 3, 18);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`majors` WRITE;
DELETE FROM `checksheet`.`majors`;
INSERT INTO `checksheet`.`majors` (`major_id`,`major_name`,`major_abbreviation`) VALUES (1, 'Computer Science', 'CSC'),(2, 'Cybersecurity', 'Cyber'),(3, 'Computer Information Systems', 'CIS');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`minor_students` WRITE;
DELETE FROM `checksheet`.`minor_students`;
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`minors` WRITE;
DELETE FROM `checksheet`.`minors`;
INSERT INTO `checksheet`.`minors` (`minor_id`,`minor_name`,`minor_abbreviation`) VALUES (1, 'Software Development', 'SW'),(2, 'Cybersecurity', 'Cyber'),(3, 'DataScience', 'DS');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`prerequisites` WRITE;
DELETE FROM `checksheet`.`prerequisites`;
INSERT INTO `checksheet`.`prerequisites` (`prerequisite_id`,`course_id`,`prereq_course_id`) VALUES (1, 2, 1),(2, 5, 3),(3, 85, 3),(4, 24, 3),(5, 5, 4),(6, 85, 4),(7, 24, 4),(8, 10, 9),(9, 16, 15),(10, 76, 15),(11, 19, 16),(12, 20, 16),(13, 21, 16),(14, 22, 16),(15, 23, 17),(16, 30, 17),(17, 34, 19),(18, 31, 20),(19, 33, 20),(20, 30, 20),(21, 34, 20),(22, 27, 21),(23, 29, 21),(24, 28, 22),(25, 33, 26),(26, 27, 26),(27, 28, 26),(28, 35, 34),(29, 41, 36),(30, 42, 36),(31, 61, 46),(32, 24, 47),(33, 64, 62),(34, 63, 63),(35, 64, 63),(36, 85, 64),(37, 67, 66),(38, 69, 66),(39, 70, 66),(40, 48, 68),(41, 10, 68),(42, 74, 72),(43, 75, 72),(44, 76, 72),(45, 77, 72),(46, 33, 74),(47, 21, 93);
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`semesters` WRITE;
DELETE FROM `checksheet`.`semesters`;
INSERT INTO `checksheet`.`semesters` (`semester_id`,`semester_name`) VALUES (1, 'Fall'),(2, 'Spring'),(3, 'Both'),(4, 'Even Fall'),(5, 'Odd Fall'),(6, 'Even Spring'),(7, 'Odd Spring');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`students` WRITE;
DELETE FROM `checksheet`.`students`;
INSERT INTO `checksheet`.`students` (`student_id`,`firstname`,`lastname`,`preferred_name`,`email`,`account_guid`,`math_proficient`,`reading_proficient`,`foreign_language`,`is_active`,`updated_at`,`created_at`) VALUES (1, 'Cathy', 'Compsci', NULL, 'carly@ggeneva.edu', '45873860-8a72-44c0-886b-c8738c0cb61d', b'1', b'1', b'1', b'1', NULL, NULL),(2, 'Sandra', 'Cyber', 'Alby', 'sandra@ggeneva.edu', '45873860-8a72-44c0-886b-c8738c0cb61d', b'1', b'1', b'1', b'1', NULL, NULL),(3, 'Mike', 'Mis', 'Mikey', 'mike@ggeneva.edu', '45873860-8a72-44c0-886b-c8738c0cb61d', b'1', b'0', b'0', b'1', NULL, NULL),(4, 'Carly', 'Computer', NULL, 'carly@ggeneva.edu', '5695e873-3612-4765-976f-d167b554d2a3', b'1', b'1', b'1', b'1', NULL, NULL),(5, 'Sandra', 'Cyber', 'Alby', 'sandra@ggeneva.edu', '5695e873-3612-4765-976f-d167b554d2a3', b'1', b'1', b'1', b'1', NULL, NULL),(6, 'Mike', 'Mis', 'Mikey', 'mike@ggeneva.edu', '5695e873-3612-4765-976f-d167b554d2a3', b'1', b'0', b'0', b'1', NULL, NULL),(7, 'Carly', 'Computer', NULL, 'carly@ggeneva.edu', '642691bb-eed0-4296-9b83-bca8807aa458', b'1', b'1', b'1', b'1', NULL, NULL),(8, 'Sandra', 'Cyber', 'Alby', 'sandra@ggeneva.edu', '642691bb-eed0-4296-9b83-bca8807aa458', b'1', b'1', b'1', b'1', NULL, NULL),(9, 'Mike', 'Mis', 'Mikey', 'mike@ggeneva.edu', '642691bb-eed0-4296-9b83-bca8807aa458', b'1', b'0', b'0', b'1', NULL, NULL),(10, 'Carly', 'Computer', NULL, 'carly@ggeneva.edu', 'b622cfaf-2d8e-4136-aece-68616ccfd039', b'1', b'1', b'1', b'1', NULL, NULL),(11, 'Sandra', 'Cyber', 'Alby', 'sandra@ggeneva.edu', 'b622cfaf-2d8e-4136-aece-68616ccfd039', b'1', b'1', b'1', b'1', NULL, NULL),(12, 'Mike', 'Mis', 'Mikey', 'mike@ggeneva.edu', 'b622cfaf-2d8e-4136-aece-68616ccfd039', b'1', b'0', b'0', b'1', NULL, NULL),(13, 'Carly', 'Computer', NULL, 'carly@ggeneva.edu', 'bd1de653-f5e6-48a0-8f52-7302843112de', b'1', b'1', b'1', b'1', NULL, NULL),(14, 'Sandra', 'Cyber', 'Alby', 'sandra@ggeneva.edu', 'bd1de653-f5e6-48a0-8f52-7302843112de', b'1', b'1', b'1', b'1', NULL, NULL),(15, 'Mike', 'Mis', 'Mikey', 'mike@ggeneva.edu', 'bd1de653-f5e6-48a0-8f52-7302843112de', b'1', b'0', b'0', b'1', NULL, NULL),(16, 'Carly', 'Computer', NULL, 'carly@ggeneva.edu', 'e4106f7b-9eea-45c7-baff-6947fa1d0dc5', b'1', b'1', b'1', b'1', NULL, NULL),(17, 'Sandra', 'Cyber', 'Alby', 'sandra@ggeneva.edu', 'e4106f7b-9eea-45c7-baff-6947fa1d0dc5', b'1', b'1', b'1', b'1', NULL, NULL),(18, 'Mike', 'Mis', 'Mikey', 'mike@ggeneva.edu', 'e4106f7b-9eea-45c7-baff-6947fa1d0dc5', b'1', b'0', b'0', b'1', NULL, NULL),(19, 'Michael', 'Jones', 'Mikey', 'mikeymike@geneva.edu', '45873860-8a72-44c0-886b-c8738c0cb61d', b'0', b'1', b'1', b'1', '2025-03-02 17:14:01', '2025-03-02 17:14:01');
UNLOCK TABLES;
COMMIT;
BEGIN;
LOCK TABLES `checksheet`.`users` WRITE;
DELETE FROM `checksheet`.`users`;
INSERT INTO `checksheet`.`users` (`user_guid`,`firstname`,`lastname`,`auth_token`,`token_expire`,`password`,`email_address`,`username`) VALUES ('45873860-8a72-44c0-886b-c8738c0cb61d', 'Scott', 'Madeira', 'vUP4CtZZXTnVDoPXPcMc8dNo%bVpq9N6', NULL, 'admin', 'smadeira@geneva.edu', 'smadeira'),('5695e873-3612-4765-976f-d167b554d2a3', 'Cam', 'Kazmarski', NULL, NULL, 'kazmarski', 'cskazmar@geneva.edu', 'ckazmarski'),('642691bb-eed0-4296-9b83-bca8807aa458', 'Iley', 'Tweed', NULL, NULL, 'tweed', 'ietweed@geneva.edu', 'itweed'),('b622cfaf-2d8e-4136-aece-68616ccfd039', 'Ethan', 'Snyder', NULL, NULL, 'snyder', 'edsnyder1@geneva.edu', 'esnyder'),('bd1de653-f5e6-48a0-8f52-7302843112de', 'Katelynn', 'Bell', NULL, NULL, 'bell', 'knbell@geneva.edu', 'kbell'),('e4106f7b-9eea-45c7-baff-6947fa1d0dc5', 'Caleb', 'Hyatt', NULL, NULL, 'hyatt', 'cphyatt@geneva.edu', 'chyatt');
UNLOCK TABLES;
COMMIT;
