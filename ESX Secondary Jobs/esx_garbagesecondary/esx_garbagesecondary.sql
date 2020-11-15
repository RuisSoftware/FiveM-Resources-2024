INSERT INTO `jobs` (`id`, `name`, `label`, `whitelisted`, `SecondaryJob`) VALUES
(NULL, 'eboueur', 'Vuilnisman', 0, 1);

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(NULL, 'eboueur', 0, 'interim', 'Medewerker', 250, '{}', '{}');

INSERT INTO `items` (`id`, `name`, `label`, `weight`, `rare`, `can_remove`) VALUES
(NULL, 'poubelle', 'Vuilnis', 1, 0, 1);
