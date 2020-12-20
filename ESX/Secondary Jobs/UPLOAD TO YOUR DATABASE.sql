ALTER TABLE `users`
	ADD COLUMN `job2` varchar(255) NULL DEFAULT 'unemployed2' AFTER `job_grade`,
	ADD COLUMN `job2_grade` INT NULL DEFAULT 0 AFTER `job2`
;

INSERT INTO `jobs` (`name`, `label`) VALUES
('unemployed2', 'Unemployed');

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('unemployed2', 0, 'secondary', 'Secondary', 50, '{}', '{}');