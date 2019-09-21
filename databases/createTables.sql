-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema flightBooking
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema flightBooking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `flightBooking` DEFAULT CHARACTER SET utf8 ;
USE `flightBooking` ;

-- -----------------------------------------------------
-- Table `flightBooking`.`Passengers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flightBooking`.`Passengers` (
  `passenger_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`passenger_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flightBooking`.`FlightClasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flightBooking`.`FlightClasses` (
  `flight_class_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  PRIMARY KEY (`flight_class_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flightBooking`.`Airline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flightBooking`.`Airline` (
  `airline_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  PRIMARY KEY (`airline_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flightBooking`.`Flights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flightBooking`.`Flights` (
  `flight_id` INT NOT NULL AUTO_INCREMENT,
  `flight_number` VARCHAR(50) NOT NULL,
  `departure_DateTime` DATETIME NOT NULL,
  `arrival_DateTime` DATETIME NOT NULL,
  `duration_InMinutes` INT NOT NULL,
  `distanceInMiles` INT NOT NULL,
  `airline_id` INT NOT NULL,
  PRIMARY KEY (`flight_id`),
  INDEX `fk_Flights_Airline1_idx` (`airline_id` ASC) VISIBLE,
  CONSTRAINT `fk_Flights_Airline1`
    FOREIGN KEY (`airline_id`)
    REFERENCES `flightBooking`.`Airline` (`airline_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flightBooking`.`Tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flightBooking`.`Tickets` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `ticket_number` VARCHAR(50) NOT NULL,
  `price` DECIMAL(7,2) NOT NULL,
  `confirmation_number` VARCHAR(50) NOT NULL,
  `passenger_id` INT NOT NULL,
  `flight_class_id` INT NOT NULL,
  `flight_id` INT NOT NULL,
  PRIMARY KEY (`ticket_id`),
  INDEX `fk_Tickets_Passengers_idx` (`passenger_id` ASC) VISIBLE,
  INDEX `fk_Tickets_FlightClasses1_idx` (`flight_class_id` ASC) VISIBLE,
  INDEX `fk_Tickets_Flights1_idx` (`flight_id` ASC) VISIBLE,
  CONSTRAINT `fk_Tickets_Passengers`
    FOREIGN KEY (`passenger_id`)
    REFERENCES `flightBooking`.`Passengers` (`passenger_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tickets_FlightClasses`
    FOREIGN KEY (`flight_class_id`)
    REFERENCES `flightBooking`.`FlightClasses` (`flight_class_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Tickets_Flights`
    FOREIGN KEY (`flight_id`)
    REFERENCES `flightBooking`.`Flights` (`flight_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flightBooking`.`Airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flightBooking`.`Airport` (
  `airport_id` INT NOT NULL AUTO_INCREMENT,
  `IATAcode` VARCHAR(50) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`airport_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flightBooking`.`Airport_has_Flights`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flightBooking`.`Airport_has_Flights` (
  `airport_id` INT NOT NULL,
  `flight_id` INT NOT NULL,
  PRIMARY KEY (`airport_id`, `flight_id`),
  INDEX `fk_Airport_has_Flights_Flights1_idx` (`flight_id` ASC) VISIBLE,
  INDEX `fk_Airport_has_Flights_Airport1_idx` (`airport_id` ASC) VISIBLE,
  CONSTRAINT `fk_Airport_has_Flights_Airport1`
    FOREIGN KEY (`airport_id`)
    REFERENCES `flightBooking`.`Airport` (`airport_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Airport_has_Flights_Flights1`
    FOREIGN KEY (`flight_id`)
    REFERENCES `flightBooking`.`Flights` (`flight_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
