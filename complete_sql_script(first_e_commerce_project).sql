-- MariaDB Compatible Script
-- Converted from MySQL Workbench generated script
-- Changes made:
--   1. Removed VISIBLE keyword from all index definitions (not supported in MariaDB)
--   2. Removed MySQL-specific SQL_MODE setting (incompatible with MariaDB)

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8;
USE `mydb`;

-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `id_customer` INT NOT NULL,
  `name` VARCHAR(45) NULL COMMENT 'This is only necessary for promotional purposes, to use customers name to get close to them!',
  `contact_phone_number` VARCHAR(30) NULL,
  `contact_email` VARCHAR(45) NULL,
  UNIQUE INDEX `ID_customer_UNIQUE` (`id_customer` ASC),
  PRIMARY KEY (`id_customer`),
  UNIQUE INDEX `contact_UNIQUE` (`contact_phone_number` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `id_product` INT NOT NULL,
  `made_in` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `price` DECIMAL(6,2) NULL DEFAULT 99,
  UNIQUE INDEX `id_product_UNIQUE` (`id_product` ASC),
  PRIMARY KEY (`id_product`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supplier` (
  `id_supplier` INT NOT NULL,
  `contact` INT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_supplier`),
  UNIQUE INDEX `id_supplier_UNIQUE` (`id_supplier` ASC),
  UNIQUE INDEX `contact_UNIQUE` (`contact` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Courier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Courier` (
  `id_courier` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id_courier`),
  UNIQUE INDEX `id_courier_UNIQUE` (`id_courier` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Customer_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer_address` (
  `id_customer_address` INT NOT NULL,
  `id_customer` INT NULL,
  `street` VARCHAR(40) NULL,
  `city` VARCHAR(45) NULL,
  `zip` VARCHAR(10) NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`id_customer_address`),
  UNIQUE INDEX `id_customer_address_UNIQUE` (`id_customer_address` ASC),
  INDEX `fk_CA_customer_idx` (`id_customer` ASC),
  CONSTRAINT `fk_CA_customer`
    FOREIGN KEY (`id_customer`)
    REFERENCES `mydb`.`Customer` (`id_customer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order` (
  `id_order` INT NOT NULL,
  `purchase_date` DATETIME NULL,
  `total_price` DECIMAL NULL,
  `id_customer` INT NOT NULL,
  `id_customer_address` INT NULL,
  `status` ENUM('CART', 'PLACED', 'SHIPPED', 'DELIVERED', 'CANCELLED') NULL,
  PRIMARY KEY (`id_order`),
  UNIQUE INDEX `id_order_UNIQUE` (`id_order` ASC),
  INDEX `fk_order_customer_idx` (`id_customer` ASC),
  INDEX `fk_order_CA_idx` (`id_customer_address` ASC),
  CONSTRAINT `fk_order_customer`
    FOREIGN KEY (`id_customer`)
    REFERENCES `mydb`.`Customer` (`id_customer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_CA`
    FOREIGN KEY (`id_customer_address`)
    REFERENCES `mydb`.`Customer_address` (`id_customer_address`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Category` (
  `id_category` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_category`),
  UNIQUE INDEX `id_category_UNIQUE` (`id_category` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Warehouse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Warehouse` (
  `id_warehouse` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `location` VARCHAR(45) NULL,
  PRIMARY KEY (`id_warehouse`),
  UNIQUE INDEX `id_warehouse_UNIQUE` (`id_warehouse` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Inventory` (
  `id_product` INT NOT NULL,
  `quantiry` INT NULL,
  `id_warehouse` INT NOT NULL,
  PRIMARY KEY (`id_product`, `id_warehouse`),
  INDEX `fk_inventory_product_idx` (`id_product` ASC),
  INDEX `fk_inventory_warehouse_idx` (`id_warehouse` ASC),
  CONSTRAINT `fk_inventory_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `mydb`.`Product` (`id_product`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inventory_warehouse`
    FOREIGN KEY (`id_warehouse`)
    REFERENCES `mydb`.`Warehouse` (`id_warehouse`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Review` (
  `id_review` INT NOT NULL,
  `rating` ENUM('1', '2', '3', '4', '5') NULL,
  `id_product` INT NULL,
  `id_customer` INT NULL,
  `comment` VARCHAR(500) NULL,
  `review_date` DATETIME NULL,
  PRIMARY KEY (`id_review`),
  UNIQUE INDEX `id_review_UNIQUE` (`id_review` ASC),
  INDEX `fk_review_product_idx` (`id_product` ASC),
  INDEX `fk_review_customer_idx` (`id_customer` ASC),
  UNIQUE INDEX `id_customer_UNIQUE` (`id_customer` ASC),
  UNIQUE INDEX `id_product_UNIQUE` (`id_product` ASC),
  CONSTRAINT `fk_review_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `mydb`.`Product` (`id_product`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_review_customer`
    FOREIGN KEY (`id_customer`)
    REFERENCES `mydb`.`Customer` (`id_customer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Product_category_specification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_category_specification` (
  `id_category` INT NOT NULL,
  `id_product` INT NOT NULL,
  INDEX `fk_PCS_product_idx` (`id_product` ASC),
  PRIMARY KEY (`id_category`, `id_product`),
  CONSTRAINT `fk_PCS_category`
    FOREIGN KEY (`id_category`)
    REFERENCES `mydb`.`Category` (`id_category`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PCS_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `mydb`.`Product` (`id_product`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order_item` (
  `id_product` INT NOT NULL,
  `id_order` INT NOT NULL,
  `quantity` INT NULL,
  `unit_price_at_purchase` DECIMAL NULL,
  `discount` DECIMAL NULL,
  INDEX `fk_OI_order_idx` (`id_order` ASC),
  PRIMARY KEY (`id_product`, `id_order`),
  CONSTRAINT `fk_OI_order`
    FOREIGN KEY (`id_order`)
    REFERENCES `mydb`.`Order` (`id_order`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_OI_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `mydb`.`Product` (`id_product`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Product_supply_chain`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_supply_chain` (
  `id_product` INT NOT NULL,
  `id_supplier` INT NOT NULL,
  `size` VARCHAR(45) NULL,
  INDEX `fk_PSC_supplier_idx` (`id_supplier` ASC),
  PRIMARY KEY (`id_product`, `id_supplier`),
  CONSTRAINT `fk_PSC_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `mydb`.`Product` (`id_product`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PSC_supplier`
    FOREIGN KEY (`id_supplier`)
    REFERENCES `mydb`.`Supplier` (`id_supplier`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Billing_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Billing_address` (
  `id_billing_address` INT NOT NULL,
  `id_customer` INT NULL,
  `street` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `zip` VARCHAR(10) NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`id_billing_address`),
  UNIQUE INDEX `id_billing_address_UNIQUE` (`id_billing_address` ASC),
  INDEX `fk_BA_customer_idx` (`id_customer` ASC),
  CONSTRAINT `fk_BA_customer`
    FOREIGN KEY (`id_customer`)
    REFERENCES `mydb`.`Customer` (`id_customer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Shipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Shipment` (
  `id_shipment` INT NOT NULL,
  `id_order` INT NULL,
  `id_courier` INT NULL,
  `status` ENUM('PENDING', 'SHIPPED', 'DELIVERED', 'CANCELLED') NULL,
  `tracking_number` VARCHAR(45) NULL,
  `shipped_date` DATETIME NULL,
  `delivered_date` DATETIME NULL,
  PRIMARY KEY (`id_shipment`),
  UNIQUE INDEX `id_shipment_UNIQUE` (`id_shipment` ASC),
  UNIQUE INDEX `tracking_number_UNIQUE` (`tracking_number` ASC),
  INDEX `fk_shipment_order_idx` (`id_order` ASC),
  INDEX `fk_shipment_courier_idx` (`id_courier` ASC),
  CONSTRAINT `fk_shipment_order`
    FOREIGN KEY (`id_order`)
    REFERENCES `mydb`.`Order` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipment_courier`
    FOREIGN KEY (`id_courier`)
    REFERENCES `mydb`.`Courier` (`id_courier`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `id_payment` INT NOT NULL,
  `id_order` INT NULL,
  `method` VARCHAR(45) NULL,
  `amount` DECIMAL NULL,
  `status` ENUM('PAID', 'PENDING', 'FAILED', 'REFUNDED') NULL,
  `date` DATETIME NULL,
  `id_billing_address` INT NULL,
  PRIMARY KEY (`id_payment`),
  UNIQUE INDEX `id_payment_UNIQUE` (`id_payment` ASC),
  INDEX `fk_payment_order_idx` (`id_order` ASC),
  INDEX `fk_payment_BA_idx` (`id_billing_address` ASC),
  CONSTRAINT `fk_payment_order`
    FOREIGN KEY (`id_order`)
    REFERENCES `mydb`.`Order` (`id_order`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_BA`
    FOREIGN KEY (`id_billing_address`)
    REFERENCES `mydb`.`Billing_address` (`id_billing_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- line 320 and 321 (change them into "CASCADE")