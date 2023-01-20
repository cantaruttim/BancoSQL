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

		
		A seleção trás um						Tudo o que quero ver 					Falamos de JOIN
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
	

mysql> SELECT NOME, EMAIL, IDCLIENTE FROM CLIENTE; 				
+----------+--------------------+-----------+					
| NOME     | EMAIL              | IDCLIENTE |
+----------+--------------------+-----------+					
| JOÃO     | JOÃO@GMAIL.COM     |         1 |				
| CARLOS   | CARLOS@GMAIL.COM   |         2 |
| CLARA    | CLARA@GMAIL.COM    |         3 |
| PEDRO    | PEDRO@GMAIL.COM    |         5 |
| GIOVANNA | GIOVANNA@GMAIL.COM |         6 |
| FELIPE   | FELIPE@GMAIL.COM   |         7 |
| LUCAS    | LUCAS@GMAIL.COM    |         8 |
+----------+--------------------+-----------+
7 rows in set (0.00 sec)
mysql> select ID_CLIENTE, BAIRRO, CIDADE FROM ENDERECO;
+------------+-----------------+----------------+
| ID_CLIENTE | BAIRRO          | CIDADE         |
+------------+-----------------+----------------+
|          1 | CASA VERDE      | SÃO PAULO      |
|          2 | MOOCA           | SÃO PAULO      |
|          3 | COPACABANA      | RIO DE JANEIRO |
|          5 | MOINHO VELHO    | SÃO PAULO      |
|          6 | ABC             | SÃO PAULO      |
|          7 | MORUMBI         | SÃO PAULO      |
|          8 | CERQUEIRA CESAR | SÃO PAULO      |
+------------+-----------------+----------------+
7 rows in set (0.00 sec)


select nome, sexo, bairro, cidade
from cliente, endereco
where idcliente = id_cliente; -- condição que une duas tabelas (claúsula de seleção)

+----------+------+-----------------+----------------+
| nome     | sexo | bairro          | cidade         |
+----------+------+-----------------+----------------+
| JOÃO     | M    | CASA VERDE      | SÃO PAULO      |
| CARLOS   | M    | MOOCA           | SÃO PAULO      |
| CLARA    | M    | COPACABANA      | RIO DE JANEIRO |
| PEDRO    | M    | MOINHO VELHO    | SÃO PAULO      |
| GIOVANNA | F    | ABC             | SÃO PAULO      |
| FELIPE   | M    | MORUMBI         | SÃO PAULO      |
| LUCAS    | M    | CERQUEIRA CESAR | SÃO PAULO      |
+----------+------+-----------------+----------------+
7 rows in set (0.00 sec)

select nome, sexo, bairro, cidade
from cliente, endereco
where idcliente = id_cliente -- sempre verdade
and sexo = 'M';

+--------+------+-----------------+----------------+
| nome   | sexo | bairro          | cidade         |
+--------+------+-----------------+----------------+
| JOÃO   | M    | CASA VERDE      | SÃO PAULO      |
| CARLOS | M    | MOOCA           | SÃO PAULO      |
| CLARA  | M    | COPACABANA      | RIO DE JANEIRO |
| PEDRO  | M    | MOINHO VELHO    | SÃO PAULO      |
| FELIPE | M    | MORUMBI         | SÃO PAULO      |
| LUCAS  | M    | CERQUEIRA CESAR | SÃO PAULO      |
+--------+------+-----------------+----------------+
6 rows in set (0.00 sec)

select nome, sexo, bairro, cidade
from cliente
inner join endereco
on idcliente = id_cliente;

+----------+------+-----------------+----------------+
| nome     | sexo | bairro          | cidade         |
+----------+------+-----------------+----------------+
| JOÃO     | M    | CASA VERDE      | SÃO PAULO      |
| CARLOS   | M    | MOOCA           | SÃO PAULO      |
| CLARA    | M    | COPACABANA      | RIO DE JANEIRO |
| PEDRO    | M    | MOINHO VELHO    | SÃO PAULO      |
| GIOVANNA | F    | ABC             | SÃO PAULO      |
| FELIPE   | M    | MORUMBI         | SÃO PAULO      |
| LUCAS    | M    | CERQUEIRA CESAR | SÃO PAULO      |
+----------+------+-----------------+----------------+
7 rows in set (0.00 sec)



select nome, sexo, bairro, cidade
from cliente
	inner join endereco
	on idcliente = id_cliente
where sexo = 'F';

+----------+------+--------+-----------+
| nome     | sexo | bairro | cidade    |
+----------+------+--------+-----------+
| GIOVANNA | F    | ABC    | SÃO PAULO |
+----------+------+--------+-----------+
1 row in set (0.00 sec)



-- ex 2

-- relacionamento 1xN

select nome, sexo, email, tipo, numero
from cliente
	inner join telefone
where idcliente = id_cliente;	

+--------+------+------------------+------+----------+
| nome   | sexo | email            | tipo | numero   |
+--------+------+------------------+------+----------+
| JOÃO   | M    | JOÃO@GMAIL.COM   | Cel  | 54569876 |
| JOÃO   | M    | JOÃO@GMAIL.COM   | Res  | 54328976 |
| CARLOS | M    | CARLOS@GMAIL.COM | Res  | 54326676 |
| CLARA  | M    | CLARA@GMAIL.COM  | Res  | 54009876 |
| PEDRO  | M    | PEDRO@GMAIL.COM  | Cel  | 54329876 |
| FELIPE | M    | FELIPE@GMAIL.COM | Com  | 54377876 |
| LUCAS  | M    | LUCAS@GMAIL.COM  | Cel  | 54329996 |
+--------+------+------------------+------+----------+
7 rows in set (0.00 sec)


/* nome, sexo, bairro, cidade, tipo, numero */

select nome, sexo, bairro, cidade, tipo, numero
from cliente 
	inner join endereco
on idcliente = id_cliente
	inner join telefone
on idcliente = id_cliente;

-- >> ERROR 1052 (23000): Column 'id_cliente' in on clause is ambiguous


-- corrigindo

select cliente.nome, cliente.sexo, endereco.bairro, endereco.cidade, telefone.tipo, telefone.numero
from cliente 
	inner join endereco
on cliente.idcliente = endereco.id_cliente
	inner join telefone
on cliente.idcliente = telefone.id_cliente;

+--------+------+-----------------+----------------+------+----------+
| nome   | sexo | bairro          | cidade         | tipo | numero   |
+--------+------+-----------------+----------------+------+----------+
| JOÃO   | M    | CASA VERDE      | SÃO PAULO      | Cel  | 54569876 |
| JOÃO   | M    | CASA VERDE      | SÃO PAULO      | Res  | 54328976 |
| CARLOS | M    | MOOCA           | SÃO PAULO      | Res  | 54326676 |
| CLARA  | M    | COPACABANA      | RIO DE JANEIRO | Res  | 54009876 |
| PEDRO  | M    | MOINHO VELHO    | SÃO PAULO      | Cel  | 54329876 |
| FELIPE | M    | MORUMBI         | SÃO PAULO      | Com  | 54377876 |
| LUCAS  | M    | CERQUEIRA CESAR | SÃO PAULO      | Cel  | 54329996 |
+--------+------+-----------------+----------------+------+----------+
7 rows in set (0.00 sec)

-- outra maneira de fazer a query (utilizando ponteramento):


select c.nome, c.sexo, e.bairro, e.cidade, t.tipo, t.numero
from cliente c
	inner join endereco e
on c.idcliente = e.id_cliente
	inner join telefone t
on c.idcliente = t.id_cliente;

+--------+------+-----------------+----------------+------+----------+
| nome   | sexo | bairro          | cidade         | tipo | numero   |
+--------+------+-----------------+----------------+------+----------+
| JOÃO   | M    | CASA VERDE      | SÃO PAULO      | Cel  | 54569876 |
| JOÃO   | M    | CASA VERDE      | SÃO PAULO      | Res  | 54328976 |
| CARLOS | M    | MOOCA           | SÃO PAULO      | Res  | 54326676 |
| CLARA  | M    | COPACABANA      | RIO DE JANEIRO | Res  | 54009876 |
| PEDRO  | M    | MOINHO VELHO    | SÃO PAULO      | Cel  | 54329876 |
| FELIPE | M    | MORUMBI         | SÃO PAULO      | Com  | 54377876 |
| LUCAS  | M    | CERQUEIRA CESAR | SÃO PAULO      | Cel  | 54329996 |
+--------+------+-----------------+----------------+------+----------+
7 rows in set (0.00 sec)


-- ######################################################################

/* COMANDO DE DML 
sql (linguagem de quarta geração)

DML - DATA MANIPULATION LANGUAGE
		- MANIPULAÇÃO DE DADOS
		
		insert
		select * from
		update
		
			confirme o registro antes de realizar o comando
		
			select * from cliente
			where idcliente = 7;
	
		

DDL - DATA DEFINITION LANGUAGEM
		- CONTROLE DE ACESSO AOS DADOS
		
		definimos o tipo de dado 
		
		ex nome : varchar
		
	CREATE TABLE PRODUTO(
		IDPRODUTO INT PRIMARY KEY AUTO_INCREMENT,
		NOME_PRODUTO VARCHAR(30) NOT NULL,
		PRECO INT,
		FRETE FLOAT(10,2) NOT NULL	
	);	
		
	Neste comando, estamos alterando a tabela produto, 
	definindo outro tipo de dado para a coluna preco:	
	
	ALTER TABLE PRODUTO
	CHANGE PRECO VALOR_UNITARIO INT NOT NULL;	
			
	
	Alterando apenas o tipo do dado da tabela produto:
	
	ALTER TABLE PRODUTO
	CHANGE VALOR_UNITARIO VALOR_UNITARIO INT;
	
	
	Aqui estamos alterando apenas o tipo:
	(perceba a diferença desse comando com o change)
	
	alter table produto
	modify valor_unitario varchar(50) not null;

	
	ADICIONANDO COLUNAS:
	
	alter table produto
	add peso float(10,2) not null;
	-- por padrão é adicionada na última posição
	
	add entre o nome_produto e valor unitario
	
	alter table produto
	add column peso float(10,2) not NULL
	after nome_produto;
	
	alter table produto
	add column peso float(10,2) not NULL
	first;
	
	
	alter table produto
	drop COLUMN peso;
	

	
DCL - DATA CONTROL LANGUAGEM
		- ATOMICIDADE DO BANO


TCL - TRANSACTION CONTROL LANGUAGE


*/


-- Exercícios de DDL

INSERT INTO CLIENTE VALUES(NULL,'FLAVIO','M','FLAVIO@IG.COM','4657765');
INSERT INTO CLIENTE VALUES(NULL,'ANDRE','M','ANDRE@GLOBO.COM','7687567');
INSERT INTO CLIENTE VALUES(NULL,'GIOVANA','F',NULL,'0876655');
INSERT INTO CLIENTE VALUES(NULL,'KARLA','M','KARLA@GMAIL.COM','545676778');
INSERT INTO CLIENTE VALUES(NULL,'DANIELE','M','DANIELE@GMAIL.COM','43536789');
INSERT INTO CLIENTE VALUES(NULL,'LORENA','M',NULL,'774557887');
INSERT INTO CLIENTE VALUES(NULL,'EDUARDO','M',NULL,'54376457');
INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','F','ANTONIO@IG.COM','12436767');
INSERT INTO CLIENTE VALUES(NULL,'ANTONIO','M','ANTONIO@UOL.COM','3423565');
INSERT INTO CLIENTE VALUES(NULL,'ELAINE','M','ELAINE@GLOBO.COM','32567763');
INSERT INTO CLIENTE VALUES(NULL,'CARMEM','M','CARMEM@IG.COM','787832213');
INSERT INTO CLIENTE VALUES(NULL,'ADRIANA','F','ADRIANA@GMAIL.COM','88556942');
INSERT INTO CLIENTE VALUES(NULL,'JOICE','F','JOICE@GMAIL.COM','55412256');


DESC CLIENTE;

+-----------+---------------+------+-----+---------+----------------+
| Field     | Type          | Null | Key | Default | Extra          |
+-----------+---------------+------+-----+---------+----------------+
| IDCLIENTE | int           | NO   | PRI | NULL    | auto_increment |
| NOME      | varchar(30)   | NO   |     | NULL    |                |
| SEXO      | enum('M','F') | NO   |     | NULL    |                |
| EMAIL     | varchar(50)   | YES  | UNI | NULL    |                |
| CPF       | varchar(15)   | YES  | UNI | NULL    |                |
+-----------+---------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)


DESC ENDERECO;

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
6 rows in set (0.00 sec)


DESC TELEFONE;

+------------+-------------------------+------+-----+---------+----------------+
| Field      | Type                    | Null | Key | Default | Extra          |
+------------+-------------------------+------+-----+---------+----------------+
| IDTELEFONE | int                     | NO   | PRI | NULL    | auto_increment |
| TIPO       | enum('Res','Cel','Com') | NO   |     | NULL    |                |
| NUMERO     | varchar(10)             | NO   |     | NULL    |                |
| ID_CLIENTE | int                     | YES  | MUL | NULL    |                |
+------------+-------------------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)



/* RELATORIO GERAL DE TODOS OS CLIENTES */

SELECT * FROM CLIENTE;

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
|         9 | FLAVIO   | M    | FLAVIO@IG.COM      | 4657765     |
|        10 | ANDRE    | M    | ANDRE@GLOBO.COM    | 7687567     |
|        11 | GIOVANA  | F    | NULL               | 0876655     |
|        12 | KARLA    | M    | KARLA@GMAIL.COM    | 545676778   |
|        13 | DANIELE  | M    | DANIELE@GMAIL.COM  | 43536789    |
|        14 | LORENA   | M    | NULL               | 774557887   |
|        15 | EDUARDO  | M    | NULL               | 54376457    |
|        16 | ANTONIO  | F    | ANTONIO@IG.COM     | 12436767    |
|        17 | ANTONIO  | M    | ANTONIO@UOL.COM    | 3423565     |
|        18 | ELAINE   | M    | ELAINE@GLOBO.COM   | 32567763    |
|        19 | CARMEM   | M    | CARMEM@IG.COM      | 787832213   |
|        20 | ADRIANA  | F    | ADRIANA@GMAIL.COM  | 88556942    |
|        21 | JOICE    | F    | JOICE@GMAIL.COM    | 55412256    |
+-----------+----------+------+--------------------+-------------+
20 rows in set (0.00 sec)


/* RELATORIO GERAL DE TODOS OS CLIENTES (TELEFONE E ENDERECO) */

select c.nome, c.sexo, c.email, t.numero, e.rua, e.bairro, e.cidade, e.estado
from cliente c 
inner join telefone t
	on c.idcliente = t.id_cliente
inner join endereco e
	on c.idcliente = e.id_cliente;
	
+---------+------+-------------------+----------+--------------------+-----------------+----------------+--------+
| nome    | sexo | email             | numero   | rua                | bairro          | cidade         | estado |
+---------+------+-------------------+----------+--------------------+-----------------+----------------+--------+
| JOÃO    | M    | JOÃO@GMAIL.COM    | 54569876 | RUA FREGUESIA      | CASA VERDE      | SÃO PAULO      | SP     |
| JOÃO    | M    | JOÃO@GMAIL.COM    | 54328976 | RUA FREGUESIA      | CASA VERDE      | SÃO PAULO      | SP     |
| CARLOS  | M    | CARLOS@GMAIL.COM  | 54326676 | RUA PITANGUEIRAS   | MOOCA           | SÃO PAULO      | SP     |
| CLARA   | M    | CLARA@GMAIL.COM   | 54009876 | AV. ATLANTICA      | COPACABANA      | RIO DE JANEIRO | RJ     |
| PEDRO   | M    | PEDRO@GMAIL.COM   | 54329876 | RUA VERGUEIRO      | MOINHO VELHO    | SÃO PAULO      | SP     |
| FELIPE  | M    | FELIPE@GMAIL.COM  | 54377876 | AV MORUMBI         | MORUMBI         | SÃO PAULO      | SP     |
| LUCAS   | M    | LUCAS@GMAIL.COM   | 54329996 | RUA ALAMEDA SANTOS | CERQUEIRA CESAR | SÃO PAULO      | SP     |
| FLAVIO  | M    | FLAVIO@IG.COM     | 68976565 | RUA GUEDES         | CASCADURA       | B. HORIZONTE   | MG     |
| FLAVIO  | M    | FLAVIO@IG.COM     | 99656675 | RUA GUEDES         | CASCADURA       | B. HORIZONTE   | MG     |
| GIOVANA | F    | NULL              | 33567765 | RUA VISCONDESSA    | CENTRO          | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | NULL              | 88668786 | RUA VISCONDESSA    | CENTRO          | RIO DE JANEIRO | RJ     |
| GIOVANA | F    | NULL              | 55689654 | RUA VISCONDESSA    | CENTRO          | RIO DE JANEIRO | RJ     |
| KARLA   | M    | KARLA@GMAIL.COM   | 88687979 | RUA NELSON MANDELA | COPACABANA      | RIO DE JANEIRO | RJ     |
| DANIELE | M    | DANIELE@GMAIL.COM | 88965676 | RUA ARAUJO LIMA    | CENTRO          | VITORIA        | ES     |
| EDUARDO | M    | NULL              | 89966809 | AV CAPITAO ANTUNES | CENTRO          | CURITIBA       | PR     |
| ANTONIO | F    | ANTONIO@IG.COM    | 88679978 | AV CARLOS BARROSO  | JARDINS         | SAO PAULO      | SP     |
| ANTONIO | M    | ANTONIO@UOL.COM   | 99655768 | ALAMEDA SAMPAIO    | BOM RETIRO      | CURITIBA       | PR     |
| ELAINE  | M    | ELAINE@GLOBO.COM  | 89955665 | RUA DA LAPA        | LAPA            | SAO PAULO      | SP     |
| CARMEM  | M    | CARMEM@IG.COM     | 77455786 | RUA GERONIMO       | CENTRO          | RIO DE JANEIRO | RJ     |
| CARMEM  | M    | CARMEM@IG.COM     | 89766554 | RUA GERONIMO       | CENTRO          | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | 77755785 | RUA GOMES FREIRE   | CENTRO          | RIO DE JANEIRO | RJ     |
| ADRIANA | F    | ADRIANA@GMAIL.COM | 44522578 | RUA GOMES FREIRE   | CENTRO          | RIO DE JANEIRO | RJ     |
+---------+------+-------------------+----------+--------------------+-----------------+----------------+--------+
22 rows in set (0.00 sec)



/* RELATORIO DE HOMENS */

select nome, sexo 
from cliente
where sexo = 'M';


+---------+------+
| nome    | sexo |
+---------+------+
| JOÃO    | M    |
| CARLOS  | M    |
| CLARA   | M    | -- temos Mulheres cadastradas como Homens
| PEDRO   | M    |
| FELIPE  | M    |
| LUCAS   | M    |
| FLAVIO  | M    |
| ANDRE   | M    |
| KARLA   | M    | -- temos Mulheres cadastradas como Homens
| DANIELE | M    | -- temos Mulheres cadastradas como Homens
| LORENA  | M    | -- temos Mulheres cadastradas como Homens
| EDUARDO | M    |
| ANTONIO | M    |
| ELAINE  | M    | -- temos Mulheres cadastradas como Homens
| CARMEM  | M    | -- temos Mulheres cadastradas como Homens
+---------+------+
15 rows in set (0.00 sec)


select nome, sexo 
from cliente
where sexo = 'F';

+----------+------+
| nome     | sexo |
+----------+------+
| GIOVANNA | F    |
| GIOVANA  | F    |
| ANTONIO  | F    | -- temos um Homem cadastrado como Mulher
| ADRIANA  | F    |
| JOICE    | F    |
+----------+------+
5 rows in set (0.00 sec)

-- atualizando os registros errados





/* RELATORIO DE MULHERES */










/* QUANTIDADE DE HOMENS E MULHERES */









/* IDS E EMAIL DAS MULHERES QUE MOREM NO CENTRO DO RIO DE JANEIRO E 
NAO TENHAM CELULAR */
























