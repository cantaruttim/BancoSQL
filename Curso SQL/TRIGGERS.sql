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


CREATE DATABASE loja;
use loja;
CREATE TABLE produto(
	idproduto INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(30),
	valor FLOAT(10,2)
);

INSERT INTO PRODUTO VALUES(NULL, 'LIVRO MODELAGEM',50.00);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO PYTHON', 99.80);
INSERT INTO PRODUTO VALUES(NULL, 'LIVRO SQL PARA DADOS', 180.00);

/*
SELECT * FROM produto;
+-----------+----------------------+--------+
| idproduto | nome                 | valor  |
+-----------+----------------------+--------+
|         1 | LIVRO MODELAGEM      |  50.00 |
|         2 | LIVRO PYTHON         |  99.80 |
|         3 | LIVRO SQL PARA DADOS | 180.00 |
+-----------+----------------------+--------+
3 rows in set (0.00 sec)

*/

CREATE DATABASE backup;

CREATE TABLE BKP_PRODUTO(
	idbkp INT PRIMARY KEY AUTO_INCREMENT,
	idproduto INT,
	nome VARCHAR(30),
	valor_original FLOAT(10,2),
	valor_alterado FLOAT(10,2),
	data DATETIME,
	usuario VARCHAR(30),
	evento CHAR(1)
);


/* Quando e Quem ~ fez alguma coisa no banco */
SELECT NOW();
SELECT CURRENT_USER();

DELIMITER ~

CREATE TRIGGER audit_prod
AFTER UPDATE ON produto FOR EACH ROW
BEGIN

	INSERT INTO backup.bkp_produto VALUES(NULL, OLD.idproduto, OLD.nome, OLD.valor, NEW.valor,
	NOW(), CURRENT_USER(), 'U');


END
~


DELIMITER ;


-- Alterando 0 valor do livro
UPDATE produto SET VALOR = 110.00 WHERE idproduto = 3;

-- Visualizando o backup do produto 

SELECT * FROM backup.bkp_produto;

/*
+-------+-----------+----------------------+----------------+----------------+---------------------+----------------+--------+
| idbkp | idproduto | nome                 | valor_original | valor_alterado | data                | usuario        | evento |
+-------+-----------+----------------------+----------------+----------------+---------------------+----------------+--------+
|     1 |         3 | LIVRO SQL PARA DADOS |         180.00 |         110.00 | 2023-01-25 16:30:03 | root@localhost | U      |
+-------+-----------+----------------------+----------------+----------------+---------------------+----------------+--------+
1 row in set (0.00 sec)

*/

SELECT C.NOME AS CURSO,
	   C.VALOR AS VALOR,
	   C.HORAS AS CARGA,
	   IFNULL(P.NOME, '----') AS PREREQ
FROM CURSOS C LEFT JOIN CURSOS P
	ON P.IDCURSO = C.ID_PREREQ; 	   



-- Cursores


CREATE DATABASE cursores;
USE cursores;

DROP TABLE Vendedores;
CREATE TABLE Vendedores(
	idvendedores int primary key auto_increment,
	nome varchar(30),
	JAN INT,
	FEV INT,
	MAR INT,
	Total INT,
	Media INT
);


INSERT INTO vendedores VALUES (null, 'Matheus', 2533, 5244, 8596);
INSERT INTO vendedores VALUES (null, 'Gabriella', 12533, 54244, 82596);
INSERT INTO vendedores VALUES (null, 'Fernando', 12533, 15244, 328596);
INSERT INTO vendedores VALUES (null, 'Pedro', 12533, 15244, 18596);


SELECT NOME, (JAN+FEV+MAR) AS TOTAL FROM VENDEDORES;

/*
+-----------+--------+
| NOME      | TOTAL  |
+-----------+--------+
| Matheus   |  16373 |
| Gabriella | 149373 |
| Fernando  | 356373 |
| Pedro     |  46373 |
+-----------+--------+
4 rows in set (0.00 sec)

*/


DELIMITER ~

CREATE PROCEDURE INSEREDADOS()
BEGIN 



END
~ 