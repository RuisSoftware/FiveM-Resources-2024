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

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`, `price`) VALUES 
('WEAPON_FLASHLIGHT', 'Flashlight', 1, 0, 1, 10),
('WEAPON_STUNGUN', 'Taser', 100, 1, 1, 80),
('WEAPON_KNIFE', 'Knife', 100, 1, 1, 20),
('WEAPON_BAT', 'Baseball Bat', 1, 0, 1, 10),
('WEAPON_ADVANCEDRIFLE', 'Advanced Rifle', 1, 0, 1, 20000),
('WEAPON_ADVANCEDRIFLE_AMMO', 'Advanced Rifle Ammo', 1, 0, 1, 500),
('WEAPON_APPISTOL', 'AP Pistol', 1, 0, 1, 10000),
('WEAPON_APPISTOL_AMMO', 'AP Pistol Ammo', 1, 0, 1, 100),
('WEAPON_ASSAULTRIFLE', 'Assault Rifle', 1, 0, 1, 20000),
('WEAPON_ASSAULTRIFLE_AMMO', 'Assault Rifle Ammo', 1, 0, 1, 500),
('WEAPON_ASSAULTSHOTGUN', 'Assault Shotgun', 1, 0, 1, 15000),
('WEAPON_ASSAULTSHOTGUN_AMMO', 'Assault Shotgun Ammo', 1, 0, 1, 200),
('WEAPON_ASSAULTSMG', 'Assault SMG', 1, 0, 1, 22000),
('WEAPON_ASSAULTSMG_AMMO', 'Assault SMG Ammo', 1, 0, 1, 300),
('WEAPON_AUTOSHOTGUN', 'Auto Shotgun', 1, 0, 1, 17500),
('WEAPON_AUTOSHOTGUN_AMMO', 'Auto Shotgun Ammo', 1, 0, 1, 200),
('WEAPON_CARBINERIFLE', 'Carbine Rifle', 1, 0, 1, 16500),
('WEAPON_CARBINERIFLE_AMMO', 'Carbin Rifle Ammo', 1, 0, 1, 200),
('WEAPON_COMBATPISTOL', 'Combat Pistol', 1, 0, 1, 1000),
('WEAPON_COMBATPISTOL_AMMO', 'Combat Pistol Ammo', 1, 0, 1, 100),
('WEAPON_PISTOL', 'Pistol', 1, 0, 1, 7500),
('WEAPON_PISTOL_AMMO', '9mm Rounds', 1, 0, 1, 100),
('WEAPON_PUMPSHOTGUN', 'Pump Shotgun', 1, 0, 1, 12500),
('WEAPON_PUMPSHOTGUN_AMMO', 'Pump Shotgun Ammo', 1, 0, 1, 200),
('WEAPON_SMG', 'SMG', 1, 0, 1, 15000),
('WEAPON_SMG_AMMO', 'Shotgun Shells', 1, 0, 1, 300);
