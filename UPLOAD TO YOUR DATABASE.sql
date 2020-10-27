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

-- ONLY ADD MORE WEAPONS IF YOU ARE SURE! ALSO ADD THE NEW WEAPONS IN DISC-AMMO
INSERT INTO `items` (`name`, `label`, `weight`) VALUES 
('WEAPON_FLASHLIGHT', 'Flashlight', 1),
('WEAPON_STUNGUN', 'Taser', 100),
('WEAPON_KNIFE', 'Knife', 100),
('WEAPON_BAT', 'Baseball Bat', 1),
('WEAPON_ADVANCEDRIFLE', 'Advanced Rifle', 1),
('WEAPON_APPISTOL', 'AP Pistol', 1),
('WEAPON_ASSAULTRIFLE', 'Assault Rifle', 1),
('WEAPON_ASSAULTSHOTGUN', 'Assault Shotgun', 1),
('WEAPON_ASSAULTSMG', 'Assault SMG', 1),
('WEAPON_AUTOSHOTGUN', 'Auto Shotgun', 1),
('WEAPON_CARBINERIFLE', 'Carbine Rifle', 1),
('WEAPON_COMBATPISTOL', 'Combat Pistol', 1),
('WEAPON_PISTOL', 'Pistol', 1),
('WEAPON_PUMPSHOTGUN', 'Pump Shotgun', 1),
('WEAPON_SMG', 'SMG', 1),
('flashlight', 'Flashlight', 2),
('grip', 'Grip', 2),
('scope', 'Scope', 2),
('skin', 'Skin', 2),
('supressor', 'Suppressor', 2),
('ammunition_pistol', 'Pistol Ammo', 10),
('ammunition_pistol_large', 'Pistol Ammo Large', 10),
('ammunition_rifle', 'Rifle Ammo', 10),
('ammunition_rifle_large', 'Rifle Ammo Large', 10),
('ammunition_shotgun', 'Shotgun Shells', 10),
('ammunition_shotgun_large', 'Shotgun Shells Large', 10),
('ammunition_smg', 'SMG Ammo', 10),
('ammunition_smg_large', 'SMG Ammo Large', 10),
('ammunition_snp', 'Sniper Ammo', 10),
('ammunition_snp_large', 'Sniper Ammo Large', 10),
('ammunition_fireextinguisher', 'Fire Extinguisher Fuel', 10);

create table ammunition
(
    id bigint unsigned auto_increment PRIMARY KEY,
    owner text not null,
    hash text not null,
    count int default 0 not null,
    attach` TEXT NOT NULL DEFAULT '[]',
    constraint id
        unique (id)
);