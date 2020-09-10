CREATE TABLE IF NOT EXISTS `glovebox_inventory` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`plate` varchar(8) NOT NULL,
	`data` text NOT NULL,
	`owned` int(11) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `plate` (`plate`)
);

CREATE TABLE IF NOT EXISTS `trunk_inventory` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`plate` varchar(8) NOT NULL,
	`data` text NOT NULL,
	`owned` int(11) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `plate` (`plate`)
);

ALTER TABLE `items`
	ADD COLUMN `price` int(11) NOT NULL DEFAULT 0
;

-- ONLY ADD MORE WEAPONS IF YOU ARE SURE! ALSO ADD THE NEW WEAPONS IN DISC-AMMO
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `price`) VALUES 
('WEAPON_FLASHLIGHT', 'Flashlight', 1, 0, 1, 10),
('WEAPON_STUNGUN', 'Taser', 100, 1, 1, 80),
('WEAPON_KNIFE', 'Knife', 100, 1, 1, 20),
('WEAPON_BAT', 'Baseball Bat', 1, 0, 1, 10),
('WEAPON_ADVANCEDRIFLE', 'Advanced Rifle', 1, 0, 1, 20000),
('WEAPON_APPISTOL', 'AP Pistol', 1, 0, 1, 10000),
('WEAPON_ASSAULTRIFLE', 'Assault Rifle', 1, 0, 1, 20000),
('WEAPON_ASSAULTSHOTGUN', 'Assault Shotgun', 1, 0, 1, 15000),
('WEAPON_ASSAULTSMG', 'Assault SMG', 1, 0, 1, 22000),
('WEAPON_AUTOSHOTGUN', 'Auto Shotgun', 1, 0, 1, 17500),
('WEAPON_CARBINERIFLE', 'Carbine Rifle', 1, 0, 1, 16500),
('WEAPON_COMBATPISTOL', 'Combat Pistol', 1, 0, 1, 1000),
('WEAPON_PISTOL', 'Pistol', 1, 0, 1, 7500),
('WEAPON_PUMPSHOTGUN', 'Pump Shotgun', 1, 0, 1, 12500),
('WEAPON_SMG', 'SMG', 1, 0, 1, 15000),
('flashlight', 'Flashlight', 2, 0, 1),
('grip', 'Grip', 2, 0, 1),
('scope', 'Scope', 2, 0, 1),
('skin', 'Skin', 2, 0, 1),
('supressor', 'Suppressor', 2, 0, 1);


ALTER TABLE `disc_ammo` ADD COLUMN `attach` TEXT NOT NULL DEFAULT '[]' AFTER `count`;