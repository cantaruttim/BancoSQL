CREATE DATABASE Livraria;

/* criando o tabela */
CREATE TABLE livros (
	nome_livro VARCHAR(100),
	nome_autor VARCHAR(100),
    sexo_autor CHAR(1),
    numero_pagina INT(5),
    nome_editora VARCHAR(30),
    valor_livro FLOAT(10,2), /* 10 casas, com 2 decimais*/
    UF CHAR(2),
    ano_publicacao INT(4)
);

USE Livraria;
SHOW TABLES;

INSERT INTO livros VALUES('Cavaleiro Real','Ana Claudia','F',465,'Atlas',49.9,'RJ',2009);
INSERT INTO livros VALUES('SQL para leigos','João Nunes','M',450,'Addison',98,'SP',2018);
INSERT INTO livros VALUES('Receitas Caseiras','Celia Tavares','F',210,'Atlas',45,'RJ',2008);
INSERT INTO livros VALUES('Pessoas Efetivas','Eduardo Santos','M',390,'Beta',78,'RJ',2018);
INSERT INTO livros VALUES('Habitos Saudáveis','Eduardo Santos','M',630,'Beta',150,'RJ',2019);
INSERT INTO livros VALUES('A Casa Marrom','Hermes Macedo','M',250,'Bubba',60,'MG',2016);
INSERT INTO livros VALUES('Estacio Querido','Geraldo Francisco','M',310,'Insignia',100,'ES',2015);
INSERT INTO livros VALUES('Pra sempre amigas','Leda Silva','F',510,'Insignia',78,'ES',2011);
INSERT INTO livros VALUES('Copas Inesqueciveis','Marco Alcantara','M',200,'Larson',130,'RS',2018);
INSERT INTO livros VALUES('O poder da mente','Clara Mafra','F',120,'Continental',56,'SP',2017);

/* retornando todos os registros */
SELECT * FROM livros;

/* Trazer o nome do livro e o nome da editora */
SELECT nome_livro, nome_editora FROM livros;

/* Trazer o nome do livro e a UF dos livros publicados por autores do sexo masculino */
SELECT nome_livro, UF FROM livros
WHERE sexo_autor = 'M';

/*  Trazer o nome do livro e o número de páginas dos livros publicados por autores do sexo feminino */ 
SELECT nome_livro, numero_pagina FROM livros
WHERE sexo_autor = 'F';

/* Trazer os valores dos livros das editoras de São Paulo. */





