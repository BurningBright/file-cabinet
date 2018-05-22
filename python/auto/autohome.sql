create table `auto_series`(
    `Id` INT NOT NULL,
    `Name` VARCHAR(50) NOT NULL,
    `DrivingModeName` VARCHAR(20) NOT NULL,
    `Transmission` VARCHAR(20) NOT NULL,
    `Price` DOUBLE(10,3) NOT NULL,
    `Price2Sc` VARCHAR(30) NOT NULL,
    `Price2Sc_from` DOUBLE(10,3) NOT NULL,
    `Price2Sc_to` DOUBLE(10,3) NOT NULL,
    `Link2Sc` VARCHAR(100) NOT NULL,
    `State` INT NOT NULL,
    `ShowParas` tinyint(1) NOT NULL,
    `ShowTaxRelief` tinyint(1) NOT NULL,
    `ShowPreferential` tinyint(1) NOT NULL,
    `videoid` INT NOT NULL,
    `GroupName` VARCHAR(40) NOT NULL,
    PRIMARY KEY ( `id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table `auto_series`(
    `id` INT NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `driving_mode_name` VARCHAR(20),
    `transmission` VARCHAR(20),
    `price` DOUBLE(10,3),
    `link_2sc` VARCHAR(100),
    `status` INT NOT NULL,
    `show_paras` tinyint(1) NOT NULL,
    `show_tax_relief` tinyint(1) NOT NULL,
    `show_preferential` tinyint(1) NOT NULL,
    `videoid` INT NOT NULL,
    `group_name` VARCHAR(40) NOT NULL,
    `age` INT NOT NULL,
    PRIMARY KEY ( `id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;




create table `auto_series`(
    `Id` INT NOT NULL,
    `Name` VARCHAR(50) NOT NULL,
    `DrivingModeName` VARCHAR(20),
    `Transmission` VARCHAR(20),
    `Price` DOUBLE(10,4),
    `Link2Sc` VARCHAR(100),
    `Status` INT NOT NULL,
    `ShowParas` tinyint(1) NOT NULL,
    `ShowTaxRelief` tinyint(1) NOT NULL,
    `ShowPreferential` tinyint(1) NOT NULL,
    `VideoId` INT NOT NULL,
    `GroupName` VARCHAR(40) NOT NULL,
    `Age` INT NOT NULL,
    PRIMARY KEY ( `id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table `auto_series_2sc` (
    `Id` INT NOT NULL,
    `Price2Sc_From` DOUBLE(10,4) NOT NULL,
    `Price2Sc_To` DOUBLE(10,4),
    `CreateDate` DATETIME NOT NULL,
    UNIQUE (Id, CreateDate),
    FOREIGN KEY (Id) REFERENCES auto_series(Id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;