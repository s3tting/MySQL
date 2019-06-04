-- 1.One-To-One Relationship
CREATE DATABASE `table_relation_exercise`;
CREATE TABLE `passports` (
`passport_id` INT PRIMARY KEY NOT NULL UNIQUE,
`passport_number` VARCHAR(45) NOT NULL UNIQUE
);
CREATE TABLE `persons`(
`person_id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR (45) NOT NULL,
`salary` DECIMAL (10,2),
`passport_id` INT UNIQUE NOT NULL,
CONSTRAINT `fk_person_passport` 
FOREIGN KEY (`passport_id`) 
REFERENCES `passports`(`passport_id`)
);
INSERT INTO `passports` (`passport_id` , `passport_number`)
VALUES (101 , "N34FG21B"),
(102 , "K65LO4R7"),
(103 , "ZE657QP2");

INSERT INTO `persons`(`first_name` , `salary` , `passport_id`)
VALUES ("Roberto" , 43300.00 , 102),
("Tom" , 56100.00 , 103),
("Yana" , 60200.00 , 101);

-- 2.One-To-Many Relationship
CREATE TABLE `manufacturers`(
`manufacturer_id` INT PRIMARY KEY NOT NULL,
`name` VARCHAR (45) NOT NULL ,
`established_on` DATE NOT NULL
);
CREATE TABLE `models`(
`model_id` INT PRIMARY KEY NOT NULL ,
`name` VARCHAR (45) NOT NULL ,
`manufacturer_id` INT NOT NULL,
CONSTRAINT `fk_model_manufacturer` FOREIGN KEY (`manufacturer_id`)
REFERENCES `manufacturers`(`manufacturer_id`) 
);
INSERT INTO `manufacturers`( `manufacturer_id`, `name`, `established_on`)
VALUES (1,"BMW" , "1916/03/01"),
(2,"Tesla" , "2003/01/01"),
(3,"Lada" , "1966/05/01");

INSERT INTO `models`(`model_id` , `name` , `manufacturer_id`)
VALUES (101, "X1" , 1),
(102, "i6" , 1),
(103, "Model S" , 2),
(104, "Model X" , 2),
(105, "Model 3" , 2),
(106, "Nova" , 3);

SELECT `man`.`name`, `established_on`, `model_id` , `mod`.`name`  FROM `manufacturers` AS `man`
INNER JOIN `models` AS `mod`
ON `man`.`manufacturer_id` = `mod`.`manufacturer_id`;

-- 3.Many-To-Many Relationship
CREATE TABLE `students`(
`student_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (45) NOT NULL
);
CREATE TABLE `exams`(
`exam_id` INT PRIMARY KEY NOT NULL UNIQUE,
`name` VARCHAR(45) NOT NULL 
);
CREATE TABLE `students_exams`(
`student_id` INT NOT NULL,
`exam_id` INT NOT NULL,
PRIMARY KEY (`student_id`, `exam_id`),
CONSTRAINT `fk_students` FOREIGN KEY (`student_id`)  REFERENCES `students`(`student_id`),
CONSTRAINT `fk_exams` FOREIGN KEY (`exam_id`) REFERENCES `exams`(`exam_id`)
);
INSERT INTO `students`(`student_id`, `name`)
VALUES (1, "Mila"),
(2, "Toni"),
(3, "Ron");

INSERT INTO `exams` (`exam_id` , `name`)
VALUES (101 , "Spring MVC"),
(102 , "Neo4j"),
(103 , "Oracle 11g");

INSERT INTO `students_exams`(`student_id`, `exam_id`)
VALUES (1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103);

-- 4.Self-Referencing
CREATE TABLE `teachers`(
`teacher_id` INT PRIMARY KEY NOT NULL,
`name` VARCHAR(20) NOT NULL,
`manager_id` INT
);
INSERT INTO `teachers`
VALUES (101,"John",NULL),
(102,"Maya",106),
(103,"Silvia",106),
(104,"Ted",105),
(105,"Mark",101),
(106,"Greta",101);
ALTER TABLE `teachers`
ADD CONSTRAINT `fk_manager_teacher` FOREIGN KEY (`manager_id`)
REFERENCES `teachers`(`teacher_id`);

-- 5.Online Store Database
CREATE DATABASE `online_store`;
USE `online_store`;

CREATE TABLE `cities`(
`city_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50)
);
CREATE TABLE `customers`(
`customer_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (50),
`birthday`DATE,
`city_id` INT,
CONSTRAINT `fk_customer_city` FOREIGN KEY (`city_id`) REFERENCES `cities`(`city_id`)
);
CREATE TABLE `orders`(
`order_id` INT PRIMARY KEY,
`customer_id` INT,
CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`)
);
CREATE TABLE `item_types`(
`item_type_id` INT PRIMARY KEY,
`name`VARCHAR (50)
);
CREATE TABLE `items`(
`item_id` INT PRIMARY KEY ,
`name` VARCHAR (50),
`item_type_id` INT ,
CONSTRAINT `fk_items_types` FOREIGN KEY (`item_type_id`) REFERENCES `item_types`(`item_type_id`)
);
CREATE TABLE  `order_items`(
`order_id` INT ,
`item_id` INT ,
CONSTRAINT PRIMARY KEY (`order_id` , `item_id`) ,
CONSTRAINT `fk_order_orders` FOREIGN KEY (`order_id`) REFERENCES `orders`(`order_id`),
CONSTRAINT `fk_item_items` FOREIGN KEY (`item_id`) REFERENCES `items`(`item_id`)
);

-- 6.University Database
CREATE DATABASE `university`;
USE `university`;

CREATE TABLE `majors`(
`major_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50)
);
CREATE TABLE `students`(
`student_id` INT PRIMARY KEY,
`student_number` VARCHAR (12),
`student_name` VARCHAR (50),
`major_id` INT,
CONSTRAINT `fk_student_major` FOREIGN KEY (`major_id`) REFERENCES `majors`(`major_id`)
);
CREATE TABLE `payments`(
`payment_id` INT PRIMARY KEY ,
`payment_date` DATE,
`payment_amount` DECIMAL(8,2),
`student_id` INT ,
CONSTRAINT `fk_payment_student` FOREIGN KEY (`student_id`) REFERENCES `students`(`student_id`)
);
CREATE TABLE `subjects`(
`subject_id` INT PRIMARY KEY,
`subject_name` VARCHAR (50)
);
CREATE TABLE `agenda`(
`student_id` INT ,
`subject_id` INT ,
CONSTRAINT PRIMARY KEY (`student_id` ,`subject_id` ),
CONSTRAINT `fk_agenda_student` FOREIGN KEY (`student_id`) REFERENCES `students`(`student_id`),
CONSTRAINT `fk_agenda_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects`(`subject_id`)
);

-- 9. Peaks in Rila
USE `geography`;
SELECT  `mountain_range` , `peak_name` , `elevation` AS `peak_elevation`
FROM `mountains`
INNER JOIN `peaks`
ON `mountains`.`id` = `peaks`.`mountain_id`
WHERE `mountain_range` = "Rila"
ORDER BY `peak_elevation` DESC ;





