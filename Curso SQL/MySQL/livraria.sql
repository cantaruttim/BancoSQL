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
/* inserindo valor dentro da tabela livros */ 
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
SELECT nome_livro as "Nome do Livro", nome_editora as "Editora" 
FROM livros;

/* Trazer o nome do livro e a UF dos livros publicados por autores do sexo masculino */
SELECT nome_livro, UF FROM livros
WHERE sexo_autor = 'M';

/*  Trazer o nome do livro e o número de páginas dos livros publicados por autores do sexo feminino */ 
SELECT nome_livro, numero_pagina FROM livros
WHERE sexo_autor = 'F';

/* Trazer os valores dos livros das editoras de São Paulo. */
SELECT nome_livro, valor_livro, UF FROM livros
WHERE UF = 'SP';

/* Trazer os dados dos autores do sexo masculino que tiveram livros publicados por São Paulo ou Rio de Janeiro (Questão Desafio). */ 
SELECT nome_autor, sexo_autor FROM livros
WHERE sexo_autor = 'M'
AND UF='RJ'
OR UF = 'SP';

/* Esse código a baixo é diferente do código acima por conta da Tabela Verdade */

SELECT nome_autor, sexo_autor FROM livros
WHERE sexo_autor = 'M'
AND UF='SP'
OR UF = 'RJ';

/* Retonar apenas os registros do sexo Masculino*/

SELECT nome_autor, sexo_autor FROM livros
WHERE sexo_autor = 'M' AND (UF = 'SP' OR UF = 'RJ');

