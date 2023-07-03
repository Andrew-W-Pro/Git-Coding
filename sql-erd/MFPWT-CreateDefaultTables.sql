CREATE TABLE IF NOT EXISTS `MFPWT2023`.`sweep_schedule` (
  `truck` VARCHAR(50) NOT NULL,
  `monday` TINYINT NULL,
  `tuesday` TINYINT NULL,
  `wednesday` TINYINT NULL,
  `thursday` TINYINT NULL,
  `friday` TINYINT NULL,
  `sweep_time` TIME NOT NULL,
  PRIMARY KEY (`truck`));

CREATE TABLE IF NOT EXISTS `MFPWT2023`.`sweep_exceptions` (
  `holiday` DATE NOT NULL,
  `truck` VARCHAR(50) NOT NULL,
  `sweep_change` DATETIME NOT NULL,
  PRIMARY KEY (`holiday`),
  INDEX `truck_idx` (`truck` ASC) VISIBLE,
  CONSTRAINT `truck_exp`
    FOREIGN KEY (`truck`)
    REFERENCES `MFPWT2023`.`sweep_schedule` (`truck`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS `MFPWT2023`.`zip_codes` (
  `zip_code` INT NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `county` VARCHAR(50) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `config_center` CHAR(3) NOT NULL,
  `truck` VARCHAR(50) NOT NULL,
  `last_updated` TIMESTAMP NULL,
  `last_updated_by` VARCHAR(50) NULL,
  PRIMARY KEY (`zip_code`),
  INDEX `truck_idx` (`truck` ASC) VISIBLE,
  CONSTRAINT `truck_zip`
    FOREIGN KEY (`truck`)
    REFERENCES `MFPWT2023`.`sweep_schedule` (`truck`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `MFPWT2023`.`onhand` (
  `project_num` INT NOT NULL,
  `config_center` CHAR(3) NULL,
  `order_num` INT NULL,
  `line_num` INT NULL,
  `customer_accept` DATE NULL,
  `release_date` DATE NULL,
  `req_num` INT NULL,
  `customer_name` VARCHAR(50) NULL,
  `city` VARCHAR(50) NULL,
  `state` CHAR(2) NULL,
  `zip_code` INT NULL,
  `model` VARCHAR(20) NULL,
  `shipping_notes` TEXT NULL,
  `cserial` CHAR(9) NULL,
  `scheduler` VARCHAR(50) NULL,
  `highlight_flag` TINYINT NULL,
  `specials_flag` TINYINT NULL,
  `ps_flag` TINYINT NULL,
  `sweep_date` DATE NULL,
  `sweep_time` TIME NULL,
  PRIMARY KEY (`project_num`),
  UNIQUE INDEX `project_num_UNIQUE` (`project_num` ASC) VISIBLE,
  INDEX `zip_code_idx` (`zip_code` ASC) VISIBLE,
  CONSTRAINT `zip_code_onhand`
    FOREIGN KEY (`zip_code`)
    REFERENCES `MFPWT2023`.`zip_codes` (`zip_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE IF NOT EXISTS `MFPWT2023`.`users` (
  `user_id` VARCHAR(20) NOT NULL,
  `password` VARCHAR(64) NOT NULL,
  `pass_reset` TINYINT NOT NULL,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `config_center` CHAR(3) NOT NULL,
  `access` INT NOT NULL,
  `dept` VARCHAR(20) NOT NULL,
  `position` VARCHAR(20) NOT NULL,
  `color` INT NOT NULL,
  `userscol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE);
  
  CREATE TABLE IF NOT EXISTS `MFPWT2023`.`released` (
  `project_num` INT NOT NULL,
  `config_center` CHAR(3) NULL,
  `order_num` INT NULL,
  `line_num` INT NULL,
  `hat_num` INT NULL,
  `customer_accept` DATE NULL,
  `release_date` DATE NULL,
  `multi_release` CHAR(3) NULL,
  `req_num` INT NULL,
  `customer_name` VARCHAR(50) NULL,
  `city` VARCHAR(50) NULL,
  `state` CHAR(2) NULL,
  `zip_code` INT NULL,
  `model` VARCHAR(50) NULL,
  `shipping_notes` TEXT NULL,
  `cserial` CHAR(9) NULL,
  `scheduler` VARCHAR(50) NULL,
  `highlight_flag` TINYINT NULL,
  `specials_flag` TINYINT NULL,
  `ps_flag` TINYINT NULL,
  `hot_flag` TINYINT NULL,
  `sweep_date` DATE NULL,
  `sweep_time` TIME NULL,
  `user_id` VARCHAR(20) NULL,
  `wip_completed` TINYINT NULL,
  PRIMARY KEY (`project_num`),
  UNIQUE INDEX `project_num_UNIQUE` (`project_num` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `user_id_released`
    FOREIGN KEY (`user_id`)
    REFERENCES `MFPWT2023`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE TABLE IF NOT EXISTS `MFPWT2023`.`notes_log` (
  `note_index` INT NOT NULL AUTO_INCREMENT,
  `project_num` INT NOT NULL,
  `time_added` TIMESTAMP NULL,
  `user_id` VARCHAR(20) NULL,
  `dept` VARCHAR(20) NULL,
  `added_note` TEXT NULL,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  PRIMARY KEY (`note_index`),
  UNIQUE INDEX `note_index_UNIQUE` (`note_index` ASC) VISIBLE,
  INDEX `project_num_idx` (`project_num` ASC) VISIBLE,
  CONSTRAINT `user_id_notes`
    FOREIGN KEY (`user_id`)
    REFERENCES `MFPWT2023`.`users` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `project_num_notes`
    FOREIGN KEY (`project_num`)
    REFERENCES `MFPWT2023`.`released` (`project_num`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);
    
CREATE TABLE IF NOT EXISTS `MFPWT2023`.`specials_list` (
  `spec_name` VARCHAR(50) NOT NULL,
  `addl_name` TEXT NULL,
  `active` TINYINT NOT NULL,
  `highlighted` TINYINT NULL,
  `eid_only` TINYINT NULL,
  `atremote` TINYINT NULL,
  `printer_spec` TINYINT NULL,
  `field_only` TINYINT NULL,
  `spec_notes` TEXT NULL,
  UNIQUE INDEX `spec_name_UNIQUE` (`spec_name` ASC));
  
  CREATE TABLE IF NOT EXISTS `MFPWT2023`.`ps_list` (
  `ps_name` VARCHAR(50) NOT NULL,
  `addl_names` TEXT NULL,
  `active` TINYINT NOT NULL,
  `solution` VARCHAR(20) NULL,
  `cr_only` TINYINT NULL,
  `ps_shop_instruct` TEXT NULL,
  `ps_notes` TEXT NULL,
  UNIQUE INDEX `ps_name_UNIQUE` (`ps_name` ASC));
  
  CREATE TABLE IF NOT EXISTS `MFPWT2023`.`updates_log` (
  `release_updated` TIMESTAMP NULL,
  `release_user` VARCHAR(20) NULL,
  `onhand_updated` TIMESTAMP NULL,
  `onhand_user` VARCHAR(20) NULL,
  `specials_updated` TIMESTAMP NULL,
  `specials_user` VARCHAR(20) NULL,
  `ps_updated` TIMESTAMP NULL,
  `ps_user` VARCHAR(20) NULL);