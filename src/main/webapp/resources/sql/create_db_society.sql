CREATE DATABASE  IF NOT EXISTS `web_payment_tracker`;

USE `web_payment_tracker`;

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` nvarchar(150) DEFAULT NULL,
  `last_name` nvarchar(150) DEFAULT NULL,
  `email` nvarchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `payment`;

CREATE TABLE `payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_customer` int(11),
  `date` date default NULL, 
  `money` decimal(13, 2),
  `coin` nvarchar(30) DEFAULT 'NIS',
  KEY `FK_CUSTOMERS_idx` (`id_customer`),
  CONSTRAINT `FK_CUSTOMER` FOREIGN KEY (`id_customer`) 
  REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

