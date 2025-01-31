-- MySQL Script generated by MySQL Workbench
-- Sat Aug  5 16:17:32 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema geren_p1
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `geren_p1` ;

-- -----------------------------------------------------
-- Schema geren_p1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `geren_p1` DEFAULT CHARACTER SET utf8 ;
USE `geren_p1` ;

-- -----------------------------------------------------
-- Table `geren_p1`.`Empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `geren_p1`.`Empleados` ;

CREATE TABLE IF NOT EXISTS `geren_p1`.`Empleados` (
  `ID_Empleado` INT NOT NULL,
  `Nombre` VARCHAR(100) NOT NULL,
  `Edad` INT NOT NULL,
  `Titulo` VARCHAR(100) NOT NULL,
  `Fecha_Contratacion` DATE NOT NULL,
  `Productividad_Diaria` INT NOT NULL,
  `Horas_Trabajadas` DECIMAL NOT NULL,
  PRIMARY KEY (`ID_Empleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `geren_p1`.`Evaluaciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `geren_p1`.`Evaluaciones` ;

CREATE TABLE IF NOT EXISTS `geren_p1`.`Evaluaciones` (
  `ID_Evaluacion` INT NOT NULL AUTO_INCREMENT,
  `ID_Empleado` INT NOT NULL,
  `Evaluacion_Mensual` DECIMAL NOT NULL,
  `Evaluacion_Anual` DECIMAL NOT NULL,
  INDEX `fk_Evaluaciones_Empleados1_idx` (`ID_Empleado` ASC) VISIBLE,
  PRIMARY KEY (`ID_Evaluacion`),
  CONSTRAINT `fk_Evaluaciones_Empleados1`
    FOREIGN KEY (`ID_Empleado`)
    REFERENCES `geren_p1`.`Empleados` (`ID_Empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `geren_p1`.`Ventas_Productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `geren_p1`.`Ventas_Productos` ;

CREATE TABLE IF NOT EXISTS `geren_p1`.`Ventas_Productos` (
  `ID_Producto` INT NOT NULL,
  `Nombre_Producto` LONGTEXT) NOT NULL,
  `Cantidad_Vendida` INT NOT NULL,
  `Precio_Unitario` INT NOT NULL,
  `Total_Ventas` INT NOT NULL,
  `ID_Empleado` INT NOT NULL,
  PRIMARY KEY (`ID_Producto`),
  INDEX `fk_Ventas_Productos_Empleados1_idx` (`ID_Empleado` ASC) VISIBLE,
  CONSTRAINT `fk_Ventas_Productos_Empleados1`
    FOREIGN KEY (`ID_Empleado`)
    REFERENCES `geren_p1`.`Empleados` (`ID_Empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


DROP PROCEDURE IF EXISTS obtenertop3;
DELIMITER //
CREATE PROCEDURE obtenertop3()
BEGIN
SELECT e.Nombre, MAX(e.Productividad_Diaria) AS MaxProductividad, MAX(ev.Evaluacion_Anual) AS MaxEvaluacion, SUM(v.Total_Ventas) AS SumaTotalVentas
FROM empleados e 
JOIN ventas_productos v ON e.ID_Empleado = v.ID_Empleado 
JOIN evaluaciones ev ON e.ID_Empleado = ev.ID_Empleado 
GROUP BY e.Nombre
ORDER BY MaxProductividad DESC, MaxEvaluacion DESC, SumaTotalVentas DESC LIMIT 3;

END //
DELIMITER ;

DROP PROCEDURE IF EXISTS obtenertop5;
DELIMITER //
CREATE PROCEDURE obtenertop5()
BEGIN
SELECT e.Nombre, MAX(e.Productividad_Diaria) AS MaxProductividad, MAX(ev.Evaluacion_Anual) AS MaxEvaluacion, SUM(v.Total_Ventas) AS SumaTotalVentas
FROM empleados e 
JOIN ventas_productos v ON e.ID_Empleado = v.ID_Empleado 
JOIN evaluaciones ev ON e.ID_Empleado = ev.ID_Empleado 
GROUP BY e.Nombre
ORDER BY MaxProductividad ASC, MaxEvaluacion ASC, SumaTotalVentas ASC LIMIT 5;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS topgen;
DELIMITER //
CREATE PROCEDURE topgen()
BEGIN
SELECT e.Nombre,e.Fecha_Contratacion, MAX(e.Productividad_Diaria) AS MaxProductividad, MAX(ev.Evaluacion_Anual) AS MaxEvaluacion, SUM(v.Total_Ventas) AS SumaTotalVentas
FROM empleados e 
JOIN ventas_productos v ON e.ID_Empleado = v.ID_Empleado 
JOIN evaluaciones ev ON e.ID_Empleado = ev.ID_Empleado 
GROUP BY e.Nombre, e.Fecha_Contratacion
ORDER BY MaxProductividad DESC, SumaTotalVentas DESC, MaxEvaluacion DESC;

END //
DELIMITER ;
