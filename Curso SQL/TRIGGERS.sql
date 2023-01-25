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

	INSERT INTO BKP_USUARIO VALUES
	(NULL,OLD.IDUSUARIO, OLD.NOME,OLD.LOGIN);

END
$

DELIMITER ;

-- TESTANDO

INSERT INTO USUARIO VALUES(NULL, 'ANDRADE', 'ANDRADE2009', 'HEXACAMPEAO');
DELETE FROM USUARIO WHERE IDUSUARIO = 1;


SELECT * FROM BKP_USUARIO;

-- Comunicação entre bancos
CREATE DATABASE LOJA;

CREATE TABLE PRODUTO(
	IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
);

CREATE DATABASE back_up;

CREATE TABLE BK_PRODUTO(
	IDBKP INT PRIMARY KEY AUTO_INCREMENT,
	IDPRODUTO INT,
	NOME VARCHAR(30),
	VALOR FLOAT(10,2)
);


-- ADD VALORES DO BANCO PRODUTO, DENTRO DA TABELA BK_PRODUTO DO BANCO BACK_UP:
INSERT INTO BACK_UP.BK_PRODUTO VALUES(NULL, 1000, 'TESTE', 0.0);

/*				BANCO	  TABELA    */

SELECT * FROM BACK_UP.BK_PRODUTO ;

+-------+-----------+-------+-------+
| IDBKP | IDPRODUTO | NOME  | VALOR |
+-------+-----------+-------+-------+
|     1 |      1000 | TESTE |  0.00 |
+-------+-----------+-------+-------+
1 row in set (0.00 sec)

-- SINCRONIZANDO AS OS BANCOS

DELIMITER $

DROP TRIGGER BACKUP_PRODUTO;
DROP TRIGGER BACKUP_PRODUTO2;

CREATE TRIGGER BACKUP_PRODUTO2
BEFORE INSERT ON PRODUTO
FOR EACH ROW
BEGIN 
	
	
	INSERT INTO BACK_UP.BK_PRODUTO VALUES(NULL,NEW.IDPRODUTO, NEW.NOME, NEW.VALOR);


END
$



DELIMITER ;


INSERT INTO PRODUTO VALUES(NULL, 'LIVRO MODELAGEM',50.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO PYTHON', 99.80);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO SQL PARA DADOS', 180.00);

SELECT * FROM PRODUTO;

SELECT * FROM BACK_UP.BK_PRODUTO ; 

/* AUDITORIA COM TRIGGER */


USE loja;

drop database loja;
drop database back_up;


