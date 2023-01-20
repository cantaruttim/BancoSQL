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




