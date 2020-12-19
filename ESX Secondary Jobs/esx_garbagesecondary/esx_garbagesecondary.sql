INSERT INTO `jobs` (`id`, `name`, `label`) VALUES
(NULL, 'eboueur', 'Vuilnisman');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('eboueur', 0, 'interim', 'Medewerker', 250, '{}', '{}');

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('poubelle', 'Vuilnis', 1, 0, 1);
