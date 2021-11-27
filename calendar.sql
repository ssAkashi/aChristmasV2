CREATE TABLE `calendar` (
  `identifier` varchar(100) NOT NULL,
  `gift` varchar(50) NOT NULL,
  `days` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `calendar`
  ADD PRIMARY KEY (`identifier`);