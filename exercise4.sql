-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Doctor` (
  `Doctor_id` INT(5) NOT NULL,
  `Name` VARCHAR(50) NULL,
  `Date_of_birth` DATE NULL,
  `Address` VARCHAR(255) NULL,
  `phone_number` INT NULL,
  `Salary` VARCHAR(45) NULL,
  PRIMARY KEY (`Doctor_id`),
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medical`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Medical` (
  `Overtime_id` INT(5) ZEROFILL NOT NULL,
  `Overtime_rate` INT UNSIGNED NULL,
  `Doctor_id` INT(5) NOT NULL,
  PRIMARY KEY (`Overtime_id`),
  INDEX `fk-doctor_id_Medic_idx` (`Doctor_id` ASC) VISIBLE,
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk-doctor_id_Medic`
    FOREIGN KEY (`Doctor_id`)
    REFERENCES `mydb`.`Doctor` (`Doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specialist` (
  `Field_id` INT(3) NOT NULL,
  `Field_area` VARCHAR(50) NOT NULL,
  `Doctor_id` INT(5) NOT NULL,
  PRIMARY KEY (`Field_id`),
  INDEX `fk_Doctor_id_idx` (`Doctor_id` ASC) VISIBLE,
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Doctor_id`
    FOREIGN KEY (`Doctor_id`)
    REFERENCES `mydb`.`Doctor` (`Doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `Patient_id` INT(4) NOT NULL,
  `Name` VARCHAR(50) NULL,
  `Address` VARCHAR(255) NULL,
  `phone_number` INT NULL,
  `Birth_date` DATE NULL,
  PRIMARY KEY (`Patient_id`),
  UNIQUE INDEX `Patient_id_UNIQUE` (`Patient_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Appointments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Appointments` (
  `Appointment_id` INT NOT NULL,
  `Date` INT NOT NULL,
  `Time` VARCHAR(45) NOT NULL,
  `Patient_id` INT(4) NOT NULL,
  `Doctor_id` INT(5) NOT NULL,
  PRIMARY KEY (`Appointment_id`),
  INDEX `fk_Appointments_1_idx` (`Doctor_id` ASC) VISIBLE,
  INDEX `fk_Appointments_2_idx` (`Patient_id` ASC) VISIBLE,
  UNIQUE INDEX `Appointment_id_UNIQUE` (`Appointment_id` ASC) VISIBLE,
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE,
  UNIQUE INDEX `Patient_id_UNIQUE` (`Patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Appointments_1`
    FOREIGN KEY (`Doctor_id`)
    REFERENCES `mydb`.`Doctor` (`Doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Appointments_2`
    FOREIGN KEY (`Patient_id`)
    REFERENCES `mydb`.`Patient` (`Patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `Payment_id` INT NOT NULL,
  `Details` VARCHAR(255) NULL,
  `Method` VARCHAR(45) NULL,
  `Patient_id` INT(4) NOT NULL,
  `Doctor_id` INT(5) NOT NULL,
  PRIMARY KEY (`Payment_id`),
  INDEX `fk_Payment_1_idx` (`Patient_id` ASC) VISIBLE,
  UNIQUE INDEX `Payment_id_UNIQUE` (`Payment_id` ASC) VISIBLE,
  UNIQUE INDEX `Patient_id_UNIQUE` (`Patient_id` ASC) VISIBLE,
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_1`
    FOREIGN KEY (`Patient_id`)
    REFERENCES `mydb`.`Patient` (`Patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bill` (
  `Bill_id` INT NOT NULL,
  `Total` INT NOT NULL,
  `Doctor_id` INT(5) NOT NULL,
  PRIMARY KEY (`Bill_id`),
  UNIQUE INDEX `Bill_id_UNIQUE` (`Bill_id` ASC) VISIBLE,
  UNIQUE INDEX `Doctor_id_UNIQUE` (`Doctor_id` ASC) VISIBLE,
  CONSTRAINT `fk_Bill_1`
    FOREIGN KEY (`Doctor_id`)
    REFERENCES `mydb`.`Doctor` (`Doctor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cross-ref`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cross-ref` (
  `Cross-ref_id` INT NOT NULL,
  `Payment_id` INT NOT NULL,
  `Bill_id` INT NOT NULL,
  PRIMARY KEY (`Cross-ref_id`),
  UNIQUE INDEX `Payment_id_UNIQUE` (`Payment_id` ASC) VISIBLE,
  UNIQUE INDEX `Bill_id_UNIQUE` (`Bill_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cross-ref_1`
    FOREIGN KEY (`Payment_id`)
    REFERENCES `mydb`.`Payment` (`Payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cross-ref_2`
    FOREIGN KEY (`Bill_id`)
    REFERENCES `mydb`.`Bill` (`Bill_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
