-- MODELAGEM

SELECT sexo, COUNT(*) as QTD 
FROM cliente
GROUP BY sexo;





-- PRIMEIRA FORMA NORMAL  (1FN)

/* 
1. Todo campo vetorizado se tornará outra tabela
	pertencem a mesma 'família'
	
	Ex: Telefone


2. Todo campo multivalorado se tornará outra tabela
	Quando o campo for divisível 
	
	Ex: Endereço  >>> Rua, Bairro, Cidade, Estado

3. Toda tabela necessita de pelo menos um campo que identique
todo o registro como sendo único (Chave Primária, Primary Key)

	registro : tupla (ou a linha)
	campo (COLUNA)
	
	
	Ex: O CPF demonstraria que aquele registro (ou tupla) seja única
	
	
Obs¹: O CPF não é uma boa maneira para identificarmos os registros como único.
Pois modelando o banco com base em negócios, caso haja alguma mudança extra-processual
seu banco, automaticamente será "perdido".


Chaves Naturais (inerente ao registro), Chaves Artificiais (criamos)	
	
	
	
-- CARDINALIDADE

CLIENTE
	- ID CLIENTE
	- NOME
	- CPF
	- SEXO
	- EMAIL
	
TELEFONE
	- ID TELEFONE
	- NUMERO
	- TIPO (COMERCIAL, PESSOAL)

ENDERECO
	- ID ENDERECO
	- RUA
	- BAIRRO
	- CIDADE
	- ESTADO

Relacionamento 

Cardinalidade e Obrigatoriedade

Obrigatoriedade		cardinalidade
0        ,			n
1		 ,			1
0		 ,			1
0		 ,			n

Já a obrigatoriedade refere se a ocorrência vai ou não acontecer
A Cardinalidade defini o máximo 



CLIENTE 1,1 <POSSUI> 0,n  TELEFONE
CLIENTE 1,1 <POSSUI> 1,1 ENDERECO

*** Nós lemos de acordo com o segundo 
número dos relacionamentos

CLIENTE 1 <POSSUI> n  TELEFONE
CLIENTE 1 <POSSUI> 1 ENDERECO



* Endereço é obrigatório
* Telefone não é obrigatório, mas posso
	cadastrar mais de um
	
	
Obs²: FK é a PK de uma tabela que vai até a outra
tabela para fazer REFERÊNCIA entre registros


Temos que saber ler a cardinalidade para entendermos mais
sobre a FK (Regras: 1xN, 1X1, NxN).


- Em relacionamentos 1x1 a FK fica na tabela mais fraca

- Em relacionamentos 1xN a FK sempre ficará na cardinalidade N










*/



CREATE DATABASE Comercio;
USE Comercio;


CREATE TABLE CLIENTE(
	IDCLIENTE INT PRIMARY KEY AUTO_INCREMENT,
	NOME VARCHAR(30) NOT NULL,
	-- Domínio. Informações Fixas
	SEXO ENUM('M', 'F') NOT NULL,
	-- Email único mas não é obrigatório
	EMAIL VARCHAR(50) UNIQUE,
	CPF VARCHAR(15) UNIQUE
);


CREATE TABLE ENDERECO(
	IDENDERECO INT PRIMARY KEY AUTO_INCREMENT,
	RUA VARCHAR(30) NOT NULL,
	BAIRRO VARCHAR(30) NOT NULL,
	CIDADE VARCHAR(30) NOT NULL, 
	ESTADO CHAR(2) NOT NULL,
	-- Reforça que o relacionamento é 1x1 (tendo um endereço para cada endereço)
	ID_CLIENTE INT UNIQUE,
	-- FK
	FOREIGN KEY(ID_CLIENTE)
	REFERENCES CLIENTE(IDCLIENTE)
);



CREATE TABLE TELEFONE(
	IDTELEFONE INT PRIMARY KEY AUTO_INCREMENT,
	TIPO ENUM('Res', 'Cel', 'Com') NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CLIENTE INT,
	-- FK
	FOREIGN KEY(ID_CLIENTE) 
	REFERENCES CLIENTE(IDCLIENTE)
);

-- DROP TABLE <nome_da_tabela>
-- CONSTRAINTS (REGRA)



mysql> DESC CLIENTE;
+-----------+---------------+------+-----+---------+----------------+
| Field     | Type          | Null | Key | Default | Extra          |
+-----------+---------------+------+-----+---------+----------------+
| IDCLIENTE | int           | NO   | PRI | NULL    | auto_increment |
| NOME      | varchar(30)   | NO   |     | NULL    |                |
| SEXO      | enum('M','F') | NO   |     | NULL    |                |
| EMAIL     | varchar(50)   | YES  | UNI | NULL    |                |
| CPF       | varchar(15)   | YES  | UNI | NULL    |                |
+-----------+---------------+------+-----+---------+----------------+
5 rows in set (0.01 sec)



INSERT INTO CLIENTE VALUES(NULL, 'JOÃO', 'M', 'JOÃO@GMAIL.COM', '12332123212');
INSERT INTO CLIENTE VALUES(NULL, 'CARLOS', 'M', 'CARLOS@GMAIL.COM', '12332987612');
INSERT INTO CLIENTE VALUES(NULL, 'CLARA', 'M', 'CLARA@GMAIL.COM', '12334323212');
INSERT INTO CLIENTE VALUES(NULL, 'ANA', 'M', NULL, '12332123212');
INSERT INTO CLIENTE VALUES(NULL, 'PEDRO', 'M', 'PEDRO@GMAIL.COM', '12332432162');
INSERT INTO CLIENTE VALUES(NULL, 'GIOVANNA', 'F', 'GIOVANNA@GMAIL.COM', '12332123567');
INSERT INTO CLIENTE VALUES(NULL, 'FELIPE', 'M', 'FELIPE@GMAIL.COM', '79032123212');
INSERT INTO CLIENTE VALUES(NULL, 'LUCAS', 'M', 'LUCAS@GMAIL.COM', '1239873212');

SELECT * FROM CLIENTE;

mysql> select * from cliente;
+-----------+----------+------+--------------------+-------------+
| IDCLIENTE | NOME     | SEXO | EMAIL              | CPF         |
+-----------+----------+------+--------------------+-------------+
|         1 | JOÃO     | M    | JOÃO@GMAIL.COM     | 12332123212 |
|         2 | CARLOS   | M    | CARLOS@GMAIL.COM   | 12332987612 |
|         3 | CLARA    | M    | CLARA@GMAIL.COM    | 12334323212 |
|         5 | PEDRO    | M    | PEDRO@GMAIL.COM    | 12332432162 |
|         6 | GIOVANNA | F    | GIOVANNA@GMAIL.COM | 12332123567 |
|         7 | FELIPE   | M    | FELIPE@GMAIL.COM   | 79032123212 |
|         8 | LUCAS    | M    | LUCAS@GMAIL.COM    | 1239873212  |
+-----------+----------+------+--------------------+-------------+
7 rows in set (0.00 sec)

-- ########################################################################

-- Tabela Endereco

+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| IDENDERECO | int         | NO   | PRI | NULL    | auto_increment |
| RUA        | varchar(30) | NO   |     | NULL    |                |
| BAIRRO     | varchar(30) | NO   |     | NULL    |                |
| CIDADE     | varchar(30) | NO   |     | NULL    |                |
| ESTADO     | char(2)     | NO   |     | NULL    |                |
| ID_CLIENTE | int         | YES  | UNI | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
6 rows in set (0.01 sec)



INSERT INTO ENDERECO VALUES(NULL, 'RUA FREGUESIA', 'CASA VERDE', 'SÃO PAULO', 'SP', 1);
INSERT INTO ENDERECO VALUES(NULL, 'RUA PITANGUEIRAS', 'MOOCA', 'SÃO PAULO', 'SP', 2);
INSERT INTO ENDERECO VALUES(NULL, 'AV. ATLANTICA', 'COPACABANA', 'RIO DE JANEIRO', 'RJ', 3);
INSERT INTO ENDERECO VALUES(NULL, 'RUA BARATA RIBEIRO', 'COPACABANA', 'RIO DE JANEIRO', 'RJ', 4);
INSERT INTO ENDERECO VALUES(NULL, 'RUA VERGUEIRO', 'MOINHO VELHO', 'SÃO PAULO', 'SP', 5);
INSERT INTO ENDERECO VALUES(NULL, 'RUA ALEGRA', 'ABC', 'SÃO PAULO', 'SP', 6);
INSERT INTO ENDERECO VALUES(NULL, 'AV MORUMBI', 'MORUMBI', 'SÃO PAULO', 'SP', 7);
INSERT INTO ENDERECO VALUES(NULL, 'RUA ALAMEDA SANTOS', 'CERQUEIRA CESAR', 'SÃO PAULO', 'SP', 8);


mysql> SELECT * FROM ENDERECO;
+------------+--------------------+-----------------+----------------+--------+------------+
| IDENDERECO | RUA                | BAIRRO          | CIDADE         | ESTADO | ID_CLIENTE |
+------------+--------------------+-----------------+----------------+--------+------------+
|          1 | RUA FREGUESIA      | CASA VERDE      | SÃO PAULO      | SP     |          1 |
|          2 | RUA PITANGUEIRAS   | MOOCA           | SÃO PAULO      | SP     |          2 |
|          3 | AV. ATLANTICA      | COPACABANA      | RIO DE JANEIRO | RJ     |          3 |
|          5 | RUA VERGUEIRO      | MOINHO VELHO    | SÃO PAULO      | SP     |          5 |
|          6 | RUA ALEGRA         | ABC             | SÃO PAULO      | SP     |          6 |
|          7 | AV MORUMBI         | MORUMBI         | SÃO PAULO      | SP     |          7 |
|          8 | RUA ALAMEDA SANTOS | CERQUEIRA CESAR | SÃO PAULO      | SP     |          8 |
+------------+--------------------+-----------------+----------------+--------+------------+
7 rows in set (0.00 sec)



-- ##############################################################################################


-- TABELA TELEFONE

+------------+-------------------------+------+-----+---------+----------------+
| Field      | Type                    | Null | Key | Default | Extra          |
+------------+-------------------------+------+-----+---------+----------------+
| IDTELEFONE | int                     | NO   | PRI | NULL    | auto_increment |
| TIPO       | enum('Res','Cel','Com') | NO   |     | NULL    |                |
| NUMERO     | varchar(10)             | NO   |     | NULL    |                |
| ID_CLIENTE | int                     | YES  | MUL | NULL    |                |
+------------+-------------------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

INSERT INTO TELEFONE VALUES(NULL, 'CEL', '54569876', 1);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '54328976', 1);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '54009876', 3);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '54329876', 5);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '54326676', 2);
INSERT INTO TELEFONE VALUES(NULL, 'COM', '54377876', 7);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '54329996', 8);

-- RELACIONAMENTO 1xN
+------------+------+----------+------------+
| IDTELEFONE | TIPO | NUMERO   | ID_CLIENTE |
+------------+------+----------+------------+
|          1 | Cel  | 54329876 |          5 |
|          2 | Cel  | 54569876 |          1 |   -- AUSENCIA DE UNIQUE
|          3 | Res  | 54328976 |          1 | 	-- AUSENCIA DE UNIQUE
|          4 | Res  | 54009876 |          3 |
|          7 | Res  | 54326676 |          2 |
|          8 | Com  | 54377876 |          7 |
|          9 | Cel  | 54329996 |          8 |
+------------+------+----------+------------+
7 rows in set (0.00 sec)



/* 			selecção 								projeção								junção 

		
		A seleção trás um						Tudo o que quero ver 
		subconjunto de um conjunto				na tela (será mostrado)
		total																		
												o resultado do:
		* subconjunto de telefone				SELECT * FROM <tabela>	
		select numero from telefone 
		where tipo ='cel';						é uma projeção
												

									



Obs¹ SELECT <nome_coluna> >>> seleção
	 FROM				  >>> oriegem ('de onde vem os dados')
	 WHERE 				  >>>> seleção



*/
	

