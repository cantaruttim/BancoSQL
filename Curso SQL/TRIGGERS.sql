/* TRIGGERS 

DELIMITER $

CREATE TRIGGER NOME
BEFORE/AFTER INSERT/DELETE/UPDATE ON <TABELA> -- ANTES OU DEPOIS DE UMA DESSAS AÇÕES
	FOR EACH ROW
BEGIN 

	<CÓDIGO SQL>;
	
END
$


Obs¹: Temos 6 momentos em que podemos colocar uma TRIGGER
para disparar no banco. Para cada operação (INSERT,DELETE,UPDATE) Antes e Depois.
Com isso não podemos ter mais de uma trigger olhando para o mesmo momento em uma mesma tabela!

Obs²: Os dados que estão sendo inseridos são 'novos', NEW.
Já os dados que já estão armazenados na tabela são 'velhos', OLD.

*/
use information_schema;
show tables;

DESC TRIGGERS;


CREATE DATABASE ATRIGGGERS;
USE ATRIGGGERS;


CREATE TABLE USUARIO(
	IDUSUARIO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30),
	SENHA VARCHAR(100)
);

-- QUERO FAZER UM BACKUP IMEDIATO APÓS A EXCLUSÃO DE QQ USUÁRIO


CREATE TABLE BKP_USUARIO(
	IDBKUP INT PRIMARY KEY AUTO_INCREMENT,
	IDUSUARIO INT,
	NOME VARCHAR(30),
	LOGIN VARCHAR(30)
);


-- CRIANDO A TRIGGER

DELIMITER $

CREATE TRIGGER BACKUP_USUARIO 
BEFORE DELETE ON  USUARIO
	FOR EACH ROW
BEGIN 

	
	
END
$