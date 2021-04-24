CREATE TABLE `owned_vehicles` (
  `owner` varchar(40) NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) NOT NULL DEFAULT 'civ',
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `modelname` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
