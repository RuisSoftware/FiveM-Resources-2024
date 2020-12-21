CREATE TABLE IF NOT EXISTS `inventory_glovebox` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`plate` varchar(8) NOT NULL,
	`data` text NOT NULL,
	`owned` int(11) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `plate` (`plate`)
);

CREATE TABLE IF NOT EXISTS `inventory_trunk` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`plate` varchar(8) NOT NULL,
	`data` text NOT NULL,
	`owned` int(11) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE KEY `plate` (`plate`)
);

CREATE TABLE IF NOT EXISTS `ammunition` (
    `id` bigint unsigned auto_increment PRIMARY KEY,
    `owner` text null,
	`original_owner` text not null,
    `hash` text not null,
	`weapon_id` char(60) NOT NULL,
    `count` int default 0 not null,
    `attach` text not null default '[]',
	UNIQUE KEY (`weapon_id`)
);

CREATE TABLE IF NOT EXISTS `inventory_hotbar` (
    `owner` text not null,
    `item` text not null,
    `slot` int default 0 not null
);

CREATE TABLE IF NOT EXISTS `inventory_lockers` (
  `owner` varchar(50) NOT NULL,
  `lockerName` varchar(50) NOT NULL
);

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('bag_black_money', 'Bag Black Money ', 0),
	('bag_money', 'Bag Money ', 0),
	('society_police_black_money', 'Police black money ', 1),
	('society_police_money', 'Police money ', 1),
	('locker',	'Locker',	0)
;
ALTER TABLE addon_account_data
MODIFY owner VARCHAR(60);
ALTER TABLE addon_inventory_items
MODIFY owner VARCHAR(60);

INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('bag', 'Bag Inventory', 0),
	('locker',	'Locker',	0)
;

INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('bag', 'Bag Datastore', 0),
	('locker',	'Locker',	0)
;

-- ONLY ADD MORE WEAPONS IF YOU ARE SURE! ALSO ADD THE NEW WEAPONS IN CONFIG
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
	('mag', 'Magazine', 2),
	('drummag', 'Drum Magazine', 2),
	('grip', 'Grip', 2),
	('scope', 'Scope', 2),
	('skin', 'Stock weapon spray', 2),
	('skin1', 'Dark green weapon spray', 2),
	('skin2', 'Gold weapon spray', 2),
	('skin3', 'Pink and white weapon spray', 2),
	('skin4', 'Beige weapon spray', 2),
	('skin5', 'Dark blue weapon spray', 2),
	('skin6', 'Orange and black weapon spray', 2),
	('skin7', 'Light grey weapon spray', 2),
	('suppressor', 'Suppressor', 2),
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
	('ammunition_fireextinguisher', 'Fire Extinguisher Fuel', 10),
	('bag', 'Bag', 1)
;
