-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema salaoSenac
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema salaoSenac
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `salaoSenac` DEFAULT CHARACTER SET utf8 ;
USE `salaoSenac` ;

-- -----------------------------------------------------
-- Table `salaoSenac`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaoSenac`.`Cliente` (
  `email` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  PRIMARY KEY (`email`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) INVISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaoSenac`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaoSenac`.`Funcionario` (
  `cpf` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `estadoCivil` VARCHAR(15) NOT NULL,
  `especialidade` VARCHAR(60) NOT NULL,
  `dataNasc` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `salario` DECIMAL(7,2) NOT NULL,
  `comissao` DECIMAL(6,2) NOT NULL,
  `dataAdm` DATETIME NOT NULL,
  `dataDem` DATETIME NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaoSenac`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaoSenac`.`Telefone` (
  `idTelefone` INT(11) NOT NULL,
  `numero` VARCHAR(15) NOT NULL,
  `Cliente_email` VARCHAR(45) NULL,
  `Funcionario_cpf` VARCHAR(14) NULL,
  PRIMARY KEY (`idTelefone`),
  INDEX `fk_Telefone_Cliente1_idx` (`Cliente_email` ASC) VISIBLE,
  INDEX `fk_Telefone_Funcionario1_idx` (`Funcionario_cpf` ASC) VISIBLE,
  UNIQUE INDEX `numero_UNIQUE` (`numero` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone_Cliente1`
    FOREIGN KEY (`Cliente_email`)
    REFERENCES `salaoSenac`.`Cliente` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Telefone_Funcionario1`
    FOREIGN KEY (`Funcionario_cpf`)
    REFERENCES `salaoSenac`.`Funcionario` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaoSenac`.`EnderecoCli`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaoSenac`.`EnderecoCli` (
  `uf` CHAR(2) NOT NULL,
  `cidade` VARCHAR(60) NOT NULL,
  `bairro` VARCHAR(60) NOT NULL,
  `rua` VARCHAR(70) NOT NULL,
  `numero` VARCHAR(11) NOT NULL,
  `cep` VARCHAR(9) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `Cliente_email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cliente_email`),
  CONSTRAINT `fk_Endereco_Cliente`
    FOREIGN KEY (`Cliente_email`)
    REFERENCES `salaoSenac`.`Cliente` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaoSenac`.`Servico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaoSenac`.`Servico` (
  `idServico` INT(11) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `valor` DECIMAL(7,2) NOT NULL,
  PRIMARY KEY (`idServico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaoSenac`.`Agendamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaoSenac`.`Agendamento` (
  `idAgendamento` INT(11) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `hora` TIME NOT NULL,
  `data` DATE NOT NULL,
  `Cliente_email` VARCHAR(45) NOT NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  `Servico_idServico` INT(11) NOT NULL,
  PRIMARY KEY (`idAgendamento`),
  INDEX `fk_Agendamento_Cliente1_idx` (`Cliente_email` ASC) VISIBLE,
  INDEX `fk_Agendamento_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  INDEX `fk_Agendamento_Servico1_idx` (`Servico_idServico` ASC) VISIBLE,
  CONSTRAINT `fk_Agendamento_Cliente1`
    FOREIGN KEY (`Cliente_email`)
    REFERENCES `salaoSenac`.`Cliente` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Agendamento_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `salaoSenac`.`Funcionario` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Agendamento_Servico1`
    FOREIGN KEY (`Servico_idServico`)
    REFERENCES `salaoSenac`.`Servico` (`idServico`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaoSenac`.`FormaPag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaoSenac`.`FormaPag` (
  `idFormaPag` INT(11) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `valor` DECIMAL(6,2) NOT NULL,
  `data` DATETIME NOT NULL,
  `Agendamento_idAgendamento` INT(11) NOT NULL,
  PRIMARY KEY (`idFormaPag`),
  INDEX `fk_FormaPag_Agendamento1_idx` (`Agendamento_idAgendamento` ASC) VISIBLE,
  CONSTRAINT `fk_FormaPag_Agendamento1`
    FOREIGN KEY (`Agendamento_idAgendamento`)
    REFERENCES `salaoSenac`.`Agendamento` (`idAgendamento`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salaoSenac`.`EnderecoFunc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `salaoSenac`.`EnderecoFunc` (
  `uf` CHAR(2) NOT NULL,
  `cidade` VARCHAR(60) NOT NULL,
  `bairro` VARCHAR(60) NOT NULL,
  `rua` VARCHAR(70) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `cep` VARCHAR(9) NOT NULL,
  `complemento` VARCHAR(45) NULL,
  `Funcionario_CPF` VARCHAR(14) NOT NULL,
  INDEX `fk_EnderecoFunc_Funcionario1_idx` (`Funcionario_CPF` ASC) VISIBLE,
  PRIMARY KEY (`Funcionario_CPF`),
  CONSTRAINT `fk_EnderecoFunc_Funcionario1`
    FOREIGN KEY (`Funcionario_CPF`)
    REFERENCES `salaoSenac`.`Funcionario` (`cpf`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
