use projeto;

show tables;

// criando a tabela cliente
CREATE TABLE cliente (
	nome varchar(30),
	sexo char(1),
	email varchar(30),
	cpf varchar(11),
	telefone varchar(30),
	endereco varchar(100)
);

desc cliente;

# INSERINDO DADOS NA TABELA
INSERT INTO CLIENTE VALUES ('JOÃO', 'M', 'JOAO@GMAIL.COM', '758589757', 22554488, 'R. MARIA LACERDA - RIO DE JANEIRO - RJ');


# Podemos inserir os dados tbm da seguinte maneira. Passando as tabelas após o nome da coluna, na ordem que eu desejar. Omitindo outras (Ex. Email)
INSERT INTO CLIENTE(nome, sexo, endereco, telefone, cpf) VALUES ('Lilian', 'F', 'Senador Soares - Tijuca, RJ', 85659955, '758354712');

INSERT INTO CLIENTE VALUES ('ANA', 'F', 'ANA@GMAIL.COM', '857485962', 85429563, 'R. MARIA DA PENHA - RIO DE JANEIRO - RJ'),
							('PAULA', 'F', 'PAULA@GMAIL.COM', '895157584', 87546598, 'R. PIETRA DA GLÓRIA - RIO DE JANEIRO - RJ');
							



