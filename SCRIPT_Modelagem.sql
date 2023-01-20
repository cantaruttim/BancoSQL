-- MODELAGEM

SELECT sexo, COUNT(*) as QTD 
FROM cliente
GROUP BY sexo;

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



DESC CLIENTE;


INSERT INTO CLIENTE VALUES(NULL, 'JOÃO', 'M', 'JOÃO@GMAIL.COM', '12332123212');
INSERT INTO CLIENTE VALUES(NULL, 'CARLOS', 'M', 'CARLOS@GMAIL.COM', '12332987612');
INSERT INTO CLIENTE VALUES(NULL, 'CLARA', 'M', 'CLARA@GMAIL.COM', '12334323212');
INSERT INTO CLIENTE VALUES(NULL, 'ANA', 'M', NULL, '12332123212');
INSERT INTO CLIENTE VALUES(NULL, 'PEDRO', 'M', 'PEDRO@GMAIL.COM', '12332432162');
INSERT INTO CLIENTE VALUES(NULL, 'GIOVANNA', 'F', 'GIOVANNA@GMAIL.COM', '12332123567');
INSERT INTO CLIENTE VALUES(NULL, 'FELIPE', 'M', 'FELIPE@GMAIL.COM', '79032123212');
INSERT INTO CLIENTE VALUES(NULL, 'LUCAS', 'M', 'LUCAS@GMAIL.COM', '1239873212');

SELECT * FROM CLIENTE;

select * from cliente;


-- ########################################################################

INSERT INTO ENDERECO VALUES(NULL, 'RUA FREGUESIA', 'CASA VERDE', 'SÃO PAULO', 'SP', 1);
INSERT INTO ENDERECO VALUES(NULL, 'RUA PITANGUEIRAS', 'MOOCA', 'SÃO PAULO', 'SP', 2);
INSERT INTO ENDERECO VALUES(NULL, 'AV. ATLANTICA', 'COPACABANA', 'RIO DE JANEIRO', 'RJ', 3);
INSERT INTO ENDERECO VALUES(NULL, 'RUA BARATA RIBEIRO', 'COPACABANA', 'RIO DE JANEIRO', 'RJ', 4);
INSERT INTO ENDERECO VALUES(NULL, 'RUA VERGUEIRO', 'MOINHO VELHO', 'SÃO PAULO', 'SP', 5);
INSERT INTO ENDERECO VALUES(NULL, 'RUA ALEGRA', 'ABC', 'SÃO PAULO', 'SP', 6);
INSERT INTO ENDERECO VALUES(NULL, 'AV MORUMBI', 'MORUMBI', 'SÃO PAULO', 'SP', 7);
INSERT INTO ENDERECO VALUES(NULL, 'RUA ALAMEDA SANTOS', 'CERQUEIRA CESAR', 'SÃO PAULO', 'SP', 8);


SELECT * FROM ENDERECO;




INSERT INTO TELEFONE VALUES(NULL, 'CEL', '54569876', 1);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '54328976', 1);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '54009876', 3);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '54329876', 5);
INSERT INTO TELEFONE VALUES(NULL, 'RES', '54326676', 2);
INSERT INTO TELEFONE VALUES(NULL, 'COM', '54377876', 7);
INSERT INTO TELEFONE VALUES(NULL, 'CEL', '54329996', 8);



SELECT NOME, EMAIL, IDCLIENTE FROM CLIENTE; 				
				


select ID_CLIENTE, BAIRRO, CIDADE FROM ENDERECO;



select nome, sexo, bairro, cidade
from cliente, endereco
where idcliente = id_cliente; -- condição que une duas tabelas (claúsula de seleção)


select nome, sexo, bairro, cidade
from cliente, endereco
where idcliente = id_cliente -- sempre verdade
and sexo = 'M';



select nome, sexo, bairro, cidade
from cliente
inner join endereco
on idcliente = id_cliente;


select nome, sexo, bairro, cidade
from cliente
	inner join endereco
	on idcliente = id_cliente
where sexo = 'F';

-- ex 2

-- relacionamento 1xN

select nome, sexo, email, tipo, numero
from cliente
	inner join telefone
where idcliente = id_cliente;	

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


-- outra maneira de fazer a query (utilizando ponteramento):

select c.nome, c.sexo, e.bairro, e.cidade, t.tipo, t.numero
from cliente c
	inner join endereco e
on c.idcliente = e.id_cliente
	inner join telefone t
on c.idcliente = t.id_cliente;


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


/* RELATORIO GERAL DE TODOS OS CLIENTES */
/* RELATORIO GERAL DE TODOS OS CLIENTES (TELEFONE E ENDERECO) */

select c.nome, c.sexo, c.email, c.cpf, 
t.tipo, t.numero, 
e.rua, e.bairro, e.cidade, e.estado

from cliente c 
inner join telefone t
	on c.idcliente = t.id_cliente
inner join endereco e
	on c.idcliente = e.id_cliente;

/* RELATORIO DE HOMENS */

select c.idcliente, c.nome, c.sexo, c.email, c.cpf, 
t.tipo, t.numero, 
e.rua, e.bairro, e.cidade, e.estado

from cliente c 
inner join telefone t
	on c.idcliente = t.id_cliente
inner join endereco e
	on c.idcliente = e.id_cliente
where c.sexo = 'M';

-- update : idcliente = 3, 12, 13, 18, 19

SELECT * FROM CLIENTE
WHERE idcliente in (3,12,13,18,19);

update cliente set sexo = 'F'
WHERE idcliente in (3,12,13,14, 18,19);

update cliente set sexo = 'M'
WHERE idcliente = 16;

select idcliente, nome, sexo from cliente;

/* RELATORIO DE MULHERES */




















/* IDS E EMAIL DAS MULHERES QUE MOREM NO CENTRO DO RIO DE JANEIRO E 
NAO TENHAM CELULAR */
























