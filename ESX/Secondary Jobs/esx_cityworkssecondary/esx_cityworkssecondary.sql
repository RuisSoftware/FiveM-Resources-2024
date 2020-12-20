INSERT INTO `jobs` (`name`, `label`) VALUES
('works', 'Gemeente');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('works', 0, 'interim', 'Klusjesman', 50, '{}', '{}');

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('pay_works', 'Werkbon gemeente', 1, 0, 1);
