CREATE DATABASE Livraria;

/* criando o tabela */
CREATE TABLE livros (
	nome_livro VARCHAR(100),
	nome_autor VARCHAR(100),
    sexo_autor CHAR(1),
    numero_pagina integer(5),
    nome_editora VARCHAR(30),
    valor_livro FLOAT(10,2), /* 10 casas, com 2 decimais*/
    UF CHAR(2),
    ano_publicacao integer(4)
    
);

USE Livraria;
SHOW DATABASES;









