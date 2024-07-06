DROP DATABASE  IF EXISTS `DB2019007892`;
CREATE DATABASE IF NOT EXISTS`DB2019007892`;
USE DB2019007892;

CREATE TABLE `application` (
  `student_id` varchar(40) NOT NULL,
  `class_id` int NOT NULL,
  `time_id` int DEFAULT NULL,
  PRIMARY KEY (`student_id`,`class_id`)
);

CREATE TABLE `building` (
  `building_id` int NOT NULL,
  `name` text,
  `admin` text,
  `rooms` int DEFAULT NULL,
  PRIMARY KEY (`building_id`)
);

CREATE TABLE `class` (
  `class_id` int NOT NULL,
  `class_no` int DEFAULT NULL,
  `course_id` text,
  `name` text,
  `major_id` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `credit` int DEFAULT NULL,
  `lecturer_id` int DEFAULT NULL,
  `person_max` int DEFAULT NULL,
  `opened` int DEFAULT NULL,
  `room_id` int DEFAULT NULL,
  PRIMARY KEY (`class_id`)
);

CREATE TABLE `course` (
  `course_id` text,
  `name` text,
  `credit` int DEFAULT NULL
);

CREATE TABLE `credits` (
  `credits_id` int NOT NULL,
  `student_id` varchar(40) DEFAULT NULL,
  `course_id` text,
  `year` int DEFAULT NULL,
  `grade` text,
  PRIMARY KEY (`credits_id`)
);

CREATE TABLE `hopeclass` (
  `student_id` varchar(40) NOT NULL,
  `class_id` int NOT NULL,
  PRIMARY KEY (`student_id`,`class_id`)
);

CREATE TABLE `lecturer` (
  `lecturer_id` int NOT NULL,
  `name` text,
  `major_id` int DEFAULT NULL,
  PRIMARY KEY (`lecturer_id`)
);

CREATE TABLE `major` (
  `major_id` int NOT NULL,
  `name` text,
  PRIMARY KEY (`major_id`)
);

CREATE TABLE `room` (
  `room_id` int NOT NULL,
  `building_id` int DEFAULT NULL,
  `occupancy` int DEFAULT NULL,
  PRIMARY KEY (`room_id`)
) ;

CREATE TABLE `student` (
  `student_id` varchar(40) NOT NULL,
  `password` text,
  `name` text,
  `sex` text,
  `major_id` int DEFAULT NULL,
  `lecturer_id` int DEFAULT NULL,
  `year` int DEFAULT NULL,
  `state` int DEFAULT '1',
  PRIMARY KEY (`student_id`)
);

CREATE TABLE `time` (
  `time_id` int NOT NULL,
  `class_id` int DEFAULT NULL,
  `period` int DEFAULT NULL,
  `begin` text,
  `end` text,
  PRIMARY KEY (`time_id`)
);
