CREATE TABLE `departments` (
  `idDepartment` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idDepartment`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

CREATE TABLE `genders` (
  `idGender` int(11) NOT NULL AUTO_INCREMENT,
  `Sex` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idGender`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `students` (
  `idStudent` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `middleName` varchar(45) DEFAULT NULL,
  `sex` varchar(45) DEFAULT NULL,
  `idDepartment` int(11) NOT NULL,
  `Genders_idGender` int(11) NOT NULL,
  PRIMARY KEY (`idStudent`,`idDepartment`,`Genders_idGender`),
  KEY `fk_Students_Departments_idx` (`idDepartment`),
  KEY `fk_Students_Genders1_idx` (`Genders_idGender`),
  CONSTRAINT `fk_Students_Departments` FOREIGN KEY (`idDepartment`) REFERENCES `departments` (`iddepartment`),
  CONSTRAINT `fk_Students_Genders1` FOREIGN KEY (`Genders_idGender`) REFERENCES `genders` (`idgender`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `theuniversity` (
  `Name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

