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
	-- -----------------------------------------------------
	-- Schema new_schema1
	-- -----------------------------------------------------
	USE `mydb` ;

	-- -----------------------------------------------------
	-- Table `mydb`.`Producto`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
	  `id` INT NOT NULL,
	  `nombre` VARCHAR(60) NOT NULL,
	  `precio` VARCHAR(45) NOT NULL,
	  `categoria` ENUM('pizza', 'panzarotti', 'bebidas', 'postres') NOT NULL,
	  `disponible` ENUM('si', 'no') NOT NULL,
	  `elaborado` ENUM('si', 'no') NOT NULL,
	  PRIMARY KEY (`id`))
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `mydb`.`Ingredientes`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `mydb`.`Ingredientes` (
	  `id` INT NOT NULL,
	  `nombre` VARCHAR(100) NULL,
	  `cantidad` VARCHAR(100) NULL,
	  PRIMARY KEY (`id`))
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `mydb`.`Ingredientes_has_Producto`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `mydb`.`Ingredientes_has_Producto` (
	  `Ingredientes_id` INT NOT NULL,
	  `Producto_id` INT NOT NULL,
	  `id` INT NOT NULL,
	  PRIMARY KEY (`Ingredientes_id`, `Producto_id`, `id`),
	  INDEX `fk_Ingredientes_has_Producto_Producto1_idx` (`Producto_id` ASC) VISIBLE,
	  INDEX `fk_Ingredientes_has_Producto_Ingredientes_idx` (`Ingredientes_id` ASC) VISIBLE,
	  CONSTRAINT `fk_Ingredientes_has_Producto_Ingredientes`
		FOREIGN KEY (`Ingredientes_id`)
		REFERENCES `mydb`.`Ingredientes` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	  CONSTRAINT `fk_Ingredientes_has_Producto_Producto1`
		FOREIGN KEY (`Producto_id`)
		REFERENCES `mydb`.`Producto` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `mydb`.`Combo`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `mydb`.`Combo` (
	  `id` INT NOT NULL,
	  `nombre` VARCHAR(45) NOT NULL,
	  `descripcion` VARCHAR(150) NOT NULL,
	  `precio` INT NOT NULL,
	  PRIMARY KEY (`id`))
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `mydb`.`CombosProductos`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `mydb`.`CombosProductos` (
	  `idCombosProductos` INT NOT NULL,
	  `cantidad` INT NOT NULL,
	  `Combo_id` INT NOT NULL,
	  `Producto_id` INT NOT NULL,
	  PRIMARY KEY (`idCombosProductos`, `Combo_id`, `Producto_id`),
	  INDEX `fk_CombosProductos_Combo1_idx` (`Combo_id` ASC) VISIBLE,
	  INDEX `fk_CombosProductos_Producto1_idx` (`Producto_id` ASC) VISIBLE,
	  CONSTRAINT `fk_CombosProductos_Combo1`
		FOREIGN KEY (`Combo_id`)
		REFERENCES `mydb`.`Combo` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	  CONSTRAINT `fk_CombosProductos_Producto1`
		FOREIGN KEY (`Producto_id`)
		REFERENCES `mydb`.`Producto` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `mydb`.`Cliente`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
	  `id` INT NOT NULL,
	  `nombre` VARCHAR(100) NOT NULL,
	  `telefono` VARCHAR(45) NOT NULL,
	  PRIMARY KEY (`id`))
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `mydb`.`Pedido`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
	  `id` INT NOT NULL,
	  `fecha` DATETIME NULL,
	  `metodoPago` ENUM('efectivo', 'transferencia', 'tarjeta') NULL,
	  `modalidadPedido` ENUM('mesa', 'domicilio') NULL,
	  `Cliente_id` INT NOT NULL,
	  PRIMARY KEY (`id`, `Cliente_id`),
	  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_id` ASC) VISIBLE,
	  CONSTRAINT `fk_Pedido_Cliente1`
		FOREIGN KEY (`Cliente_id`)
		REFERENCES `mydb`.`Cliente` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `mydb`.`Adicionales`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `mydb`.`Adicionales` (
	  `id` INT NOT NULL,
	  `nombre` VARCHAR(45) NOT NULL,
	  `precio` INT NOT NULL,
	  PRIMARY KEY (`id`))
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `mydb`.`AdicionalesPedido`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `mydb`.`AdicionalesPedido` (
	  `id` INT NOT NULL,
	  `cantidad` INT NULL,
	  `Adicionales_id1` INT NOT NULL,
	  `Pedido_id` INT NOT NULL,
	  PRIMARY KEY (`id`, `Adicionales_id1`, `Pedido_id`),
	  INDEX `fk_AdicionalesPedido_Adicionales1_idx` (`Adicionales_id1` ASC) VISIBLE,
	  INDEX `fk_AdicionalesPedido_Pedido1_idx` (`Pedido_id` ASC) VISIBLE,
	  CONSTRAINT `fk_AdicionalesPedido_Adicionales1`
		FOREIGN KEY (`Adicionales_id1`)
		REFERENCES `mydb`.`Adicionales` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	  CONSTRAINT `fk_AdicionalesPedido_Pedido1`
		FOREIGN KEY (`Pedido_id`)
		REFERENCES `mydb`.`Pedido` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `mydb`.`ProductoPedido`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `mydb`.`ProductoPedido` (
	  `Producto_id` INT NOT NULL,
	  `Pedido_id` INT NOT NULL,
	  `cantidad` INT NOT NULL,
	  `id` INT NOT NULL,
	  PRIMARY KEY (`Producto_id`, `Pedido_id`, `id`),
	  INDEX `fk_Producto_has_Pedido_Pedido1_idx` (`Pedido_id` ASC) VISIBLE,
	  INDEX `fk_Producto_has_Pedido_Producto1_idx` (`Producto_id` ASC) VISIBLE,
	  CONSTRAINT `fk_Producto_has_Pedido_Producto1`
		FOREIGN KEY (`Producto_id`)
		REFERENCES `mydb`.`Producto` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	  CONSTRAINT `fk_Producto_has_Pedido_Pedido1`
		FOREIGN KEY (`Pedido_id`)
		REFERENCES `mydb`.`Pedido` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `mydb`.`ComboPedidos`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `mydb`.`ComboPedidos` (
	  `id` INT NOT NULL,
	  `cantidad` INT NOT NULL,
	  `Combo_id` INT NOT NULL,
	  `Pedido_id` INT NOT NULL,
	  PRIMARY KEY (`id`, `Combo_id`, `Pedido_id`),
	  INDEX `fk_ComboPedidos_Combo1_idx` (`Combo_id` ASC) VISIBLE,
	  INDEX `fk_ComboPedidos_Pedido1_idx` (`Pedido_id` ASC) VISIBLE,
	  CONSTRAINT `fk_ComboPedidos_Combo1`
		FOREIGN KEY (`Combo_id`)
		REFERENCES `mydb`.`Combo` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	  CONSTRAINT `fk_ComboPedidos_Pedido1`
		FOREIGN KEY (`Pedido_id`)
		REFERENCES `mydb`.`Pedido` (`id`)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;


	SET SQL_MODE=@OLD_SQL_MODE;
	SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
	SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;