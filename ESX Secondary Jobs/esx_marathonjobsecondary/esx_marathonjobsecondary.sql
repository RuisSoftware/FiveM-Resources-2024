INSERT INTO `jobs` (`name`, `label`, `SecondaryJob`) VALUES
('runner', 'Athleet', 1);

CREATE TABLE `marathon_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `track` int(10) COLLATE utf8mb4_bin NOT NULL,
  `runner` varchar(60) COLLATE utf8mb4_bin NOT NULL,
  `laptime` bigint DEFAULT 999999,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES 
('goldmedal_run', 'Gouden medaille', 1, '0', '1'),
('silvermedal_run', 'Zilveren medaille', 1, '0', '1'),
('bronzemedal_run', 'Bronze medaille', 1, '0', '1');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('runner', 0, 'employee', 'Marathonlopere', 1300, '{\"shoes\": 10,\"glasses_1\": 15,\"torso_1\": 152,\"shoes_2\": 3,\"helmet_2\": 2,\"mask_2\": 0,\"decals_2\": 0,\"bags_2\": 0,\"mask_1\": 0,\"eyebrows_4\": 0,\"bproof_2\": 0,\"torso_2\": 15,\"helmet_1\": 76,\"makeup_3\": 0,\"glasses\": 0,\"tshirt_1\": 80,\"bags_1\": 0,\"decals_1\": 0,\"lipstick_1\": 0,\"shoes_1\": 31,\"glasses_2\": 3,\"hair_color_1\": 3,\"hair_color_2\": 0,\"chain_1\": 0,\"bproof_1\": 0,\"arms": 12,\"tshirt_2\": 0,\"makeup_4\": 0,\"chain_2\": 0,\"pants_2\": 3,\"lipstick_3\": 0,\"makeup_1\": 0,\"pants_1\": 14,\"lipstick_2\": 0,\"sex\": 0}' , '{\"shoes\": 10,\"glasses_1\": 15,\"torso_1\": 152,\"shoes_2\": 3,\"helmet_2\": 2,\"mask_2\": 0,\"decals_2\": 0,\"bags_2\": 0,\"mask_1\": 0,\"eyebrows_4\": 0,\"bproof_2\": 0,\"torso_2\": 15,\"helmet_1\": 76,\"makeup_3\": 0,\"glasses\": 0,\"tshirt_1\": 80,\"bags_1\": 0,\"decals_1\": 0,\"lipstick_1\": 0,\"shoes_1\": 31,\"glasses_2\": 3,\"hair_color_1\": 3,\"hair_color_2\": 0,\"chain_1\": 0,\"bproof_1\": 0,\"arms\": 12,\"tshirt_2\": 0,\"makeup_4\": 0,\"chain_2\": 0,\"pants_2\": 3,\"lipstick_3\": 0,\"makeup_1\": 0,\"pants_1\": 14,\"lipstick_2\": 0,\"sex\": 0}');

