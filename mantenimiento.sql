-- MySQL Script generated by MySQL Workbench
-- dom 22 abr 2018 20:05:39 CST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mantenimientoTpi
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mantenimientoTpi
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mantenimientoTpi` DEFAULT CHARACTER SET utf8 ;
USE `mantenimientoTpi` ;

-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`MARCA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`MARCA` (
  `ID` INT NOT NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `ACTIVO` TINYINT(1) NOT NULL,
  `OBSERVACIONES` VARCHAR(300) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `NOMBRE_UNIQUE` (`NOMBRE` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`MODELO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`MODELO` (
  `ID` INT NOT NULL,
  `ID_MARCA` INT NOT NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `OBSERVACIONES` VARCHAR(300) NULL,
  PRIMARY KEY (`ID`, `ID_MARCA`),
  INDEX `FK_ID_MARCA_idx` (`ID_MARCA` ASC),
  CONSTRAINT `FK_ID_MARCA`
    FOREIGN KEY (`ID_MARCA`)
    REFERENCES `mantenimientoTpi`.`MARCA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`AREA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`AREA` (
  `ID` INT NOT NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `OBSERVACIONES` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`EQUIPO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`EQUIPO` (
  `ID` INT NOT NULL,
  `ID_MODELO` INT NOT NULL,
  `ID_AREA` INT NOT NULL,
  `NO_SERIE` INT NULL,
  `NO_INVENTARIO` INT NULL,
  `OS` VARCHAR(45) NOT NULL,
  `LICENCIA` TINYINT(1) NOT NULL,
  `USUARIO` VARCHAR(45) NULL,
  `OBSERVACIONES` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_ID_MODELO_idx1` (`ID_MODELO` ASC),
  INDEX `FK_ID_AREA_idx` (`ID_AREA` ASC),
  CONSTRAINT `FK_ID_MODELO_EQ`
    FOREIGN KEY (`ID_MODELO`)
    REFERENCES `mantenimientoTpi`.`MODELO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ID_AREA`
    FOREIGN KEY (`ID_AREA`)
    REFERENCES `mantenimientoTpi`.`AREA` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`HARDWARE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`HARDWARE` (
  `ID` INT NOT NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `UNIDAD_MEDIDA` VARCHAR(45) NULL,
  `OBSERVACIONES` VARCHAR(300) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`DETALLE_EQUIPO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`DETALLE_EQUIPO` (
  `ID_EQUIPO` INT NOT NULL,
  `ID_HARDWARE` INT NOT NULL,
  `ID_MODELO` INT NOT NULL,
  `NO_INVENTARIO` INT NULL,
  `NO_SERIE` INT NULL,
  `TAMANIO` INT NULL,
  `OBSERVACIONES` VARCHAR(300) NULL,
  PRIMARY KEY (`ID_EQUIPO`, `ID_HARDWARE`),
  INDEX `FK_ID_HARDWARE_idx` (`ID_HARDWARE` ASC),
  INDEX `FK_ID_MODELO_idx` (`ID_MODELO` ASC),
  CONSTRAINT `FK_ID_EQUIPO`
    FOREIGN KEY (`ID_EQUIPO`)
    REFERENCES `mantenimientoTpi`.`EQUIPO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ID_HARDWARE`
    FOREIGN KEY (`ID_HARDWARE`)
    REFERENCES `mantenimientoTpi`.`HARDWARE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ID_MODELO`
    FOREIGN KEY (`ID_MODELO`)
    REFERENCES `mantenimientoTpi`.`MODELO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`PERSONAL_MANTENIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`PERSONAL_MANTENIMIENTO` (
  `DUI` INT NOT NULL,
  `NOMBRES` VARCHAR(50) NOT NULL,
  `APELLIDOS` VARCHAR(50) NOT NULL,
  `TELEFONO` VARCHAR(8) NOT NULL,
  `EMAIL` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`DUI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`TIPO_MANTENIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`TIPO_MANTENIMIENTO` (
  `ID` INT NOT NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `DESCRIPCION` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`ORIGEN_PETICION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`ORIGEN_PETICION` (
  `ID` INT NOT NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`PETICION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`PETICION` (
  `ID` INT NOT NULL,
  `ID_ORIGEN` INT NOT NULL,
  `FECHA` DATE NOT NULL,
  `OBSERVACIONES` VARCHAR(300) NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_ID_ORIGEN_idx` (`ID_ORIGEN` ASC),
  CONSTRAINT `FK_ID_ORIGEN`
    FOREIGN KEY (`ID_ORIGEN`)
    REFERENCES `mantenimientoTpi`.`ORIGEN_PETICION` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`DETALLE_PETICION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`DETALLE_PETICION` (
  `ID` INT NOT NULL,
  `ID_PETICION` INT NOT NULL,
  `ID_EQUIPO` INT NOT NULL,
  `OBSERVACIONES` VARCHAR(300) NULL,
  INDEX `FK_ID_EQUIPO_idx` (`ID_EQUIPO` ASC),
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_ID_PETICION_DP`
    FOREIGN KEY (`ID_PETICION`)
    REFERENCES `mantenimientoTpi`.`PETICION` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ID_EQUIPO_DP`
    FOREIGN KEY (`ID_EQUIPO`)
    REFERENCES `mantenimientoTpi`.`EQUIPO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`ESTADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`ESTADO` (
  `ID` INT NOT NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `DESCRIPCION` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`ORDEN_TRABAJO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`ORDEN_TRABAJO` (
  `ID` INT NOT NULL,
  `ID_DETALLE_PETICION` INT NOT NULL,
  `FECHA_ENTRADA` DATE NOT NULL,
  `FECHA_SALIDA` DATE NULL,
  `ID_ENCARGADO_MANTENIMIENTO` INT NOT NULL,
  `ID_TIPO_MANTENIMIENTO` INT NOT NULL,
  `ID_ESTADO` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `FK_ID_ENCARGADO_MTTO_idx` (`ID_ENCARGADO_MANTENIMIENTO` ASC),
  INDEX `FK_ID_TIPO_MTTO_idx` (`ID_TIPO_MANTENIMIENTO` ASC),
  INDEX `FK_ID_ESTADO_idx` (`ID_ESTADO` ASC),
  INDEX `FK_ID_DETALLE_PETICION_idx` (`ID_DETALLE_PETICION` ASC),
  CONSTRAINT `FK_ID_ENCARGADO_MTTO`
    FOREIGN KEY (`ID_ENCARGADO_MANTENIMIENTO`)
    REFERENCES `mantenimientoTpi`.`PERSONAL_MANTENIMIENTO` (`DUI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ID_TIPO_MTTO`
    FOREIGN KEY (`ID_TIPO_MANTENIMIENTO`)
    REFERENCES `mantenimientoTpi`.`TIPO_MANTENIMIENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ID_ESTADO`
    FOREIGN KEY (`ID_ESTADO`)
    REFERENCES `mantenimientoTpi`.`ESTADO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ID_DETALLE_PETICION`
    FOREIGN KEY (`ID_DETALLE_PETICION`)
    REFERENCES `mantenimientoTpi`.`DETALLE_PETICION` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`PROCEDIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`PROCEDIMIENTO` (
  `ID` INT NOT NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `DESCRIPCION` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`DIAGNOSTICO_SOFTWARE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`DIAGNOSTICO_SOFTWARE` (
  `ID_ORDEN_TRABAJO` INT NOT NULL,
  `DIAGNOSTICO` VARCHAR(300) NOT NULL,
  `ID_PROCEDIMIENTO_APLICADO` INT NOT NULL,
  `OBSERVACIONES` VARCHAR(300) NULL,
  PRIMARY KEY (`ID_ORDEN_TRABAJO`),
  INDEX `FK_APPLIED_PROCEDURE_idx` (`ID_PROCEDIMIENTO_APLICADO` ASC),
  CONSTRAINT `FK_ID_ORDEN_TRABAJO`
    FOREIGN KEY (`ID_ORDEN_TRABAJO`)
    REFERENCES `mantenimientoTpi`.`ORDEN_TRABAJO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_APPLIED_PROCEDURE_SW`
    FOREIGN KEY (`ID_PROCEDIMIENTO_APLICADO`)
    REFERENCES `mantenimientoTpi`.`PROCEDIMIENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`DIAGNOSTICO_HARDWARE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`DIAGNOSTICO_HARDWARE` (
  `ID_ORDEN_TRABAJO` INT NOT NULL,
  `ID_HARDWARE` INT NOT NULL,
  `DIAGNOSTICO` VARCHAR(300) NOT NULL,
  `ID_PROCEDIMIENTO_APLICADO` INT NOT NULL,
  `OBSERVACIONES` VARCHAR(300) NULL,
  PRIMARY KEY (`ID_ORDEN_TRABAJO`),
  INDEX `FK_ID_HARDWARE_idx` (`ID_HARDWARE` ASC),
  INDEX `FK_ID_APPLIED_PROCEDURE_idx` (`ID_PROCEDIMIENTO_APLICADO` ASC),
  CONSTRAINT `FK_ID_ORDEN_TRABAJO_DH`
    FOREIGN KEY (`ID_ORDEN_TRABAJO`)
    REFERENCES `mantenimientoTpi`.`ORDEN_TRABAJO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ID_HARDWARE_DH`
    FOREIGN KEY (`ID_HARDWARE`)
    REFERENCES `mantenimientoTpi`.`HARDWARE` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ID_APPLIED_PROCEDURE_HW`
    FOREIGN KEY (`ID_PROCEDIMIENTO_APLICADO`)
    REFERENCES `mantenimientoTpi`.`PROCEDIMIENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`PASOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`PASOS` (
  `ID` INT NOT NULL,
  `NOMBRE` VARCHAR(45) NOT NULL,
  `DESCRIPCION` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`PASOS_PROCEDIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`PASOS_PROCEDIMIENTO` (
  `ID_PROCEDIMIENTO` INT NOT NULL,
  `ID_PASO` INT NOT NULL,
  `CORRELATIVO` INT NOT NULL,
  PRIMARY KEY (`ID_PROCEDIMIENTO`),
  INDEX `FK_ID_PASO_idx` (`ID_PASO` ASC),
  CONSTRAINT `FK_ID_PROCEDIMIENTO`
    FOREIGN KEY (`ID_PROCEDIMIENTO`)
    REFERENCES `mantenimientoTpi`.`PROCEDIMIENTO` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_ID_PASO`
    FOREIGN KEY (`ID_PASO`)
    REFERENCES `mantenimientoTpi`.`PASOS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`EXCEPCION_CALENDARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`EXCEPCION_CALENDARIO` (
  `FECHA` DATE NOT NULL,
  `DESCRIPCION` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`FECHA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mantenimientoTpi`.`CALENDARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mantenimientoTpi`.`CALENDARIO` (
  `FECHA` DATE NOT NULL,
  `ID_EQUIPO` INT NOT NULL,
  PRIMARY KEY (`FECHA`, `ID_EQUIPO`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
