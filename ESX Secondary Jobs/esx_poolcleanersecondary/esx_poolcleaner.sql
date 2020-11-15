INSERT INTO `jobs` (`name`, `label`, `SecondaryJob`) VALUES
('poolcleaner', 'Zwembad', 1);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('poolcleaner', 0, 'interim', 'Schoonmaker', 150, '{}', '{}');

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('contrat', 'Werkbon Zwembad', 1, 0, 1);
