INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('motels_bed_black_money', 'Motels Black Money Bed', 0),
	('motels_black_money', 'Motels Black Money ', 0),
	('motels_bed_money', 'Motels Money Bed', 0),
	('motels_money', 'Motels Money ', 0)
;

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('motels', 'Motel Inventory', 0),
	('motels_bed', 'Motel Bed Inventory', 0)
;

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('motels', 'Motel Datastore', 0),
	('motels_bed', 'Motel Bed Datastore', 0)
;

CREATE TABLE IF NOT EXISTS `motels` (
	`id` bigint(255) NOT NULL,
	`owner` varchar(60) NOT NULL,
	`motel_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `motels`
	ADD PRIMARY KEY (`id`),
	ADD KEY `owner` (`owner`),
	ADD KEY `motel_id` (`motel_id`)
;
  
ALTER TABLE `motels` 
	MODIFY `id` bigint(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1
;

ALTER TABLE `users`
	ADD `last_motel` VARCHAR(50) NULL, 
	ADD `last_motel_room` VARCHAR(50) NULL
;