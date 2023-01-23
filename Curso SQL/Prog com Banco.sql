/* PROGRAMAÇÃO EM BANCO DE DADOS:


; : Delimitador do banco de dados
Portando o ; separa os blocos de comando do MySQL


STATUS
Using Delimiter : precisamos mudar o delimitador

muda o delimitador para $ por exemplo (podemos fazer qualquer outro comando)
DELIMITER $

Uptime : Tempo referente ao tempo que o seu banco está de pé, desde a 
ultima vez que ele executor


###############################

STORED PROCEDURES:

-- Blocos anônimos e Armazenados (possuem nome)

Toda vez que alguém logar no banco, precisamos mostrar o nome da empresa
-- A mudança do delimitador é importante, pois caso não haja a mudança
o procedure não irá acontecer, ou o código será lido de forma incompleta.

DELIMITER $

CREATE PROCEDURE NOME()
BEGIN

	<
	
	
	
	bloco de código 
	
	
	
	
	>	

END
$



 */
 
DELIMITER $
 
CREATE PROCEDURE NOME_EMPRESA()
BEGIN

	SELECT 'UNIVERSIDADE DOS DADOS' AS EMPRESA;
	SELECT NOW();
	
END
$

-- Chamando a PROCEDURE

CALL NOME_EMPRESA()$

-- DELETEANDO UMA PROCEDURE

DROP PROCEDURE NOME_EMPRESA;

DELIMITER ;

-- passando parâmetros:

CREATE PROCEDURE CONTA(NUMERO1 INT, NUMERO2 INT)
BEGIN

	SELECT NUMERO1 + NUMERO2 AS CONTA;
	
END
$

CALL CONTA(25, 150)$
CALL CONTA(5, 20)$


-------------------------------------

CREATE TABLE VENDEDORES(
	IDVENDEDOR INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30),
	SEXO CHAR(1),
	JANEIRO FLOAT(10,2),
	FEVEREIRO FLOAT(10,2),
	MARCO FLOAT(10,2)	
);

INSERT INTO VENDEDORES VALUES(NULL, 'CARLOS', 'M', 76234.78, 88346.45, 95555.80);
INSERT INTO VENDEDORES VALUES(NULL, 'MARIA', 'F', 176234.78, 288346.45, 495555.80);
INSERT INTO VENDEDORES VALUES(NULL, 'JOÃO', 'M', 74234.78, 83446.45, 92255.80);
INSERT INTO VENDEDORES VALUES(NULL, 'FLÁVIA', 'F', 176234.78, 388346.45, 945555.80);
INSERT INTO VENDEDORES VALUES(NULL, 'PEDRO', 'M', 45674.78, 12345.45, 232145.80);
INSERT INTO VENDEDORES VALUES(NULL, 'LETÍCIA', 'F', 32134.78, 123456.45, 542344.80);
INSERT INTO VENDEDORES VALUES(NULL, 'THEO', 'M', 123546.78, 1231446.45, 12314215.80);
INSERT INTO VENDEDORES VALUES(NULL, 'GABRIELLA', 'F', 12176234.78, 345346.45, 941235.80);


-- 1
SELECT MAX(FEVEREIRO) AS MAIOR_FEV FROM VENDEDORES;

+-----------+
| MAIOR_FEV |
+-----------+
| 388346.44 |
+-----------+
1 row in set (0.00 sec)


-- 2
SELECT MIN(FEVEREIRO) AS MENOR_FEV FROM VENDEDORES;

+-----------+
| MAIOR_FEV |
+-----------+
|  83446.45 |
+-----------+
1 row in set (0.00 sec)

-- 3

SELECT AVG(FEVEREIRO) AS MEDIA_FEV FROM VENDEDORES;

+---------------+
| MEDIA_FEV     |
+---------------+
| 212121.445312 |
+---------------+
1 row in set (0.00 sec)

SELECT MAX(JANEIRO) AS MAX_JANEIRO,
     MIN(JANEIRO) as MIN_JANEIRO,
     AVG(JANEIRO) AS MEDIA_JANEIRO
     FROM VENDEDORES;

+-------------+-------------+---------------+
| MAX_JANEIRO | MIN_JANEIRO | MEDIA_JANEIRO |
+-------------+-------------+---------------+
|   176234.78 |    74234.78 | 125734.781250 |
+-------------+-------------+---------------+
1 row in set (0.00 sec)


-- Utilizando a função TRUNCATE
SELECT MAX(JANEIRO) AS MAX_JANEIRO,
     MIN(JANEIRO) as MIN_JANEIRO,
     TRUNCATE(AVG(JANEIRO), 2) AS MEDIA_JANEIRO
     FROM VENDEDORES;

+-------------+-------------+---------------+
| MAX_JANEIRO | MIN_JANEIRO | MEDIA_JANEIRO |
+-------------+-------------+---------------+
|   176234.78 |    74234.78 |     125734.78 |
+-------------+-------------+---------------+
1 row in set (0.00 sec)


-- função SUM

SELECT SUM(JANEIRO) AS SOMA_JANEIRO FROM VENDEDORES;

+--------------+
| SOMA_JANEIRO |
+--------------+
|    502939.12 |
+--------------+
1 row in set (0.00 sec)

SELECT SUM(JANEIRO) AS SOMA_JANEIRO,
	   SUM(FEVEREIRO) AS SOMA_FEVEREIRO,
	   SUM(MARCO) AS SOMA_MARCO
FROM VENDEDORES;


+--------------+----------------+------------+
| SOMA_JANEIRO | SOMA_FEVEREIRO | SOMA_MARCO |
+--------------+----------------+------------+
|    502939.12 |      848485.78 | 1628923.22 |
+--------------+----------------+------------+
1 row in set (0.00 sec)


SELECT SEXO, SUM(MARCO) AS TOTAL_MARCO
FROM VENDEDORES
GROUP BY 1;

+------+-------------+
| SEXO | TOTAL_MARCO |
+------+-------------+
| M    |   187811.59 |
| F    |  1441111.62 |
+------+-------------+
2 rows in set (0.01 sec)

-- Utilizando SUBQUERIES
-- DEVOLVA O VENDEDOR QUE VENDEU MENOS EM MARCO E O SEU NOME

SELECT NOME, MIN(MARCO) FROM VENDEDORES;

+--------+------------+
| NOME   | MIN(MARCO) |
+--------+------------+
| CARLOS |   92255.80 |
+--------+------------+
1 row in set (0.00 sec)


SELECT NOME, MAX(MARCO) FROM VENDEDORES;

+--------+-------------+
| NOME   | MAX(MARCO)  |
+--------+-------------+
| CARLOS | 12314216.00 |
+--------+-------------+
1 row in set (0.00 sec)

SELECT NOME, MARCO FROM VENDEDORES
WHERE MARCO > (SELECT AVG(MARCO) FROM VENDEDORES);

+------+-------------+
| NOME | MARCO       |
+------+-------------+
| THEO | 12314216.00 |
+------+-------------+
1 row in set (0.00 sec)


SELECT NOME, MARCO FROM VENDEDORES
WHERE MARCO < (SELECT AVG(MARCO) FROM VENDEDORES);

+-----------+-----------+
| NOME      | MARCO     |
+-----------+-----------+
| CARLOS    |  95555.80 |
| MARIA     | 495555.81 |
| JOÃO      |  92255.80 |
| FLÁVIA    | 945555.81 |
| PEDRO     | 232145.80 |
| LETÍCIA   | 542344.81 |
| GABRIELLA | 941235.81 |
+-----------+-----------+
7 rows in set (0.00 sec)



-- Operações em Linhas:

SELECT * FROM VENDEDORES;


SELECT NOME,
		JANEIRO ,
		FEVEREIRO,
		MARCO,
		(JANEIRO+FEVEREIRO+MARCO) AS "TOTAL",
		TRUNCATE((JANEIRO+FEVEREIRO+MARCO)/3,2) AS "MÉDIA" 
		FROM VENDEDORES;

+-----------+-------------+------------+-------------+-------------+------------+
| NOME      | JANEIRO     | FEVEREIRO  | MARCO       | TOTAL       | MÉDIA      |
+-----------+-------------+------------+-------------+-------------+------------+
| CARLOS    |    76234.78 |   88346.45 |    95555.80 |   260137.03 |   86712.34 |
| MARIA     |   176234.78 |  288346.44 |   495555.81 |   960137.03 |  320045.67 |
| JOÃO      |    74234.78 |   83446.45 |    92255.80 |   249937.03 |   83312.34 |
| FLÁVIA    |   176234.78 |  388346.44 |   945555.81 |  1510137.03 |  503379.01 |
| PEDRO     |    45674.78 |   12345.45 |   232145.80 |   290166.03 |      96722 |
| LETÍCIA   |    32134.78 |  123456.45 |   542344.81 |   697936.04 |  232645.34 |
| THEO      |   123546.78 | 1231446.50 | 12314216.00 | 13669209.28 | 4556403.09 |
| GABRIELLA | 12176235.00 |  345346.44 |   941235.81 | 13462817.25 | 4487605.75 |
+-----------+-------------+------------+-------------+-------------+------------+
8 rows in set (0.00 sec)


-- APLICANDO PORCENTAGEM


SELECT NOME,
		JANEIRO ,
		FEVEREIRO,
		MARCO,
		(JANEIRO+FEVEREIRO+MARCO) AS "TOTAL",
		(JANEIRO+FEVEREIRO+MARCO) * .25 AS "DESCONTO",

		TRUNCATE((JANEIRO+FEVEREIRO+MARCO)/3,2) AS "MÉDIA" 
		FROM VENDEDORES;

+-----------+-------------+------------+-------------+-------------+------------+------------+
| NOME      | JANEIRO     | FEVEREIRO  | MARCO       | TOTAL       | DESCONTO   | MÉDIA      |
+-----------+-------------+------------+-------------+-------------+------------+------------+
| CARLOS    |    76234.78 |   88346.45 |    95555.80 |   260137.03 |   65034.26 |   86712.34 |
| MARIA     |   176234.78 |  288346.44 |   495555.81 |   960137.03 |  240034.26 |  320045.67 |
| JOÃO      |    74234.78 |   83446.45 |    92255.80 |   249937.03 |   62484.26 |   83312.34 |
| FLÁVIA    |   176234.78 |  388346.44 |   945555.81 |  1510137.03 |  377534.26 |  503379.01 |
| PEDRO     |    45674.78 |   12345.45 |   232145.80 |   290166.03 |   72541.51 |      96722 |
| LETÍCIA   |    32134.78 |  123456.45 |   542344.81 |   697936.04 |  174484.01 |  232645.34 |
| THEO      |   123546.78 | 1231446.50 | 12314216.00 | 13669209.28 | 3417302.32 | 4556403.09 |
| GABRIELLA | 12176235.00 |  345346.44 |   941235.81 | 13462817.25 | 3365704.31 | 4487605.75 |
+-----------+-------------+------------+-------------+-------------+------------+------------+
8 rows in set (0.00 sec)


/* ALTERANDO ESTRUTURA DA TABELA */

CREATE TABLE TABELA(
	COL1 VARCHAR(30),
	COL2 VARCHAR(30),
	COL3 VARCHAR(30)
);


-- ADD UMA PK

-- Quando fazemos desta forma, não temos
-- como adicionar o incremeto automático

ALTER TABLE TABELA
ADD PRIMARY KEY (COL1);

-- ADD UMA COLUNA 

ALTER TABLE TABELA
ADD COLUNA_ADDED VARCHAR(30);

ALTER TABLE TABELA
ADD COLUNA_100ADDED INT;

-- ESCOLHENDO A POSIÇÃO DA COLUNA

ALTER TABLE TABELA 
ADD COLUMN COLUNA4 VARCHAR(30) NOT NULL UNIQUE
AFTER COL3;

-- MODIFICANDO O TIPO DO CAMPO

ALTER TABLE TABELA MODIFY COL2 DATE NOT NULL;


-- RENOMEANDO O NOME DA TABELA

ALTER TABLE TABELA
RENAME PESSOA;


-- ADD UMA FK A UMA TABELA JÁ EXISTENTE

CREATE TABLE TIME(
	IDTIME INT PRIMARY KEY AUTO_INCREMENT,
	TIME VARCHAR(30),
	ID_PESSOA VARCHAR (30)
);


-- ADD A FK
ALTER TABLE TIME 
ADD FOREIGN KEY(ID_PESSOA)
REFERENCES PESSOA(COL1);


-- VERIFICAR AS CHAVES

SHOW CREATE TABLE TIME;



-- ORGANIZAÇÃO DE CHAVES:

CREATE TABLE JOGADOR(






);









