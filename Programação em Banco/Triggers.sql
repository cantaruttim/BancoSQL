-- TRIGGERS

DROP TABLE IF EXISTS tb_pessoa;
CREATE TABLE IF NOT EXISTS tb_pessoa(
	cod_pessoa SERIAL PRIMARY KEY,
	nome VARCHAR(200) NOT NULL,
	idade INT NOT NULL,
	saldo NUMERIC(10,2) NOT NULL
);

DROP TABLE IF EXISTS tb_auditoria;
CREATE TABLE IF NOT EXISTS tb_auditoria(
	cod_auditoria SERIAL PRIMARY KEY,
	cod_pessoa INT NOT NULL,
	idade INT NOT NULL,
	saldo_antigo NUMERIC(10,2),
	saldo_atual NUMERIC(10,2)
);

CREATE OR REPLACE FUNCTION fn_validador_de_saldo()
RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN

	/*
	SE O SALDO DO NEW FOR PWLO MENOS ZERO CONFIRMO APENAS (OU SEJA, DEVOLVO NEW)
	SE NÃO, FACO UM RAISE E DEVOLVO NULL
	*/
	
	IF NEW.saldo >= 0 THEN
		RETURN NEW;
	ELSE
		RAISE NOTICE 'Valor de Saldo R$% inválido', NEW.saldo;
		RETURN NULL;
	END IF;	
	
END; $$

CREATE TRIGGER tg_validador_de_saldo
BEFORE INSERT OR UPDATE ON tb_pessoa
FOR EACH ROW
	EXECUTE PROCEDURE fn_validador_de_saldo();


INSERT INTO tb_pessoa(nome, idade, saldo) VALUES
	('João', 20, 100),
	('Pedro', 22, -100), -- não foi inserido na tabela
	('Marta', 22, 450);

SELECT * FROM tb_pessoa;

--- ... --- 

--Variávei especiais
-- removendo dados da trigger

DELETE FROM tb_teste_trigger;
SELECT * FROM tb_teste_trigger;

--visualizar detalhes do sequence usado na geração de valores para a tabela
SELECT * FROM tb_teste_trigger_cod_teste_trigger_seq;

ALTER SEQUENCE tb_teste_trigger_cod_teste_trigger_seq
RESTART WITH 1;

SELECT * FROM tb_teste_trigger_cod_teste_trigger_seq;
-- iniciando com 1 novamente

-- Removendo os dois triggers
DROP TRIGGER IF EXISTS tg_antes_do_insert2 ON tb_teste_trigger;
DROP TRIGGER IF EXISTS tg_depois_do_insert2 ON tb_teste_trigger;

DROP TRIGGER IF EXISTS tg_antes_do_insert ON tb_teste_trigger;
CREATE OR REPLACE FUNCTION fn_antes_de_um_insert() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	
	RAISE NOTICE 'Estamos no trigger before';
	RAISE NOTICE 'OLD: %', OLD;
	RAISE NOTICE 'NEW: %', NEW;
	RAISE NOTICE 'OLD.texto: %', OLD.texto;
	RAISE NOTICE 'NEW.texto, %', NEW.texto;
	RAISE NOTICE 'TG_NAME: %', TG_NAME;
	RAISE NOTICE 'TG_LEVEL: %', TG_LEVEL;
	RAISE NOTICE 'TG_WHEN: %', TG_WHEN;
	RAISE NOTICE 'TG_TABLE_NAME: %', TG_TABLE_NAME;
	RAISE NOTICE 'TG_NARGS: %', TG_NARGS;
	
	FOR i IN 0..TG_NARGS - 1 LOOP
		RAISE NOTICE '%', TG_ARGV[i];
	END LOOP;
	
	-- RETURN NULL;
	RETURN NEW;
	
END ; $$

-- criando o trigger (vínculo entre a trigger e a tabela)	
DROP TRIGGER tg_antes_do_insert ON tb_teste_trigger;
CREATE OR REPLACE TRIGGER tg_antes_do_insert
BEFORE INSERT OR UPDATE ON tb_teste_trigger
FOR EACH ROW
	EXECUTE PROCEDURE fn_antes_de_um_insert('Antes: V1', 'Antes: V2');






DROP TRIGGER IF EXISTS tg_depois_de_um_insert ON tb_teste_trigger;
CREATE OR REPLACE FUNCTION fn_depois_de_um_insert()
RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN

	RAISE NOTICE 'Estamos no trigger after';
	RAISE NOTICE 'OLD: %', OLD;
	RAISE NOTICE 'NEW: %', NEW;
	RAISE NOTICE 'OLD.texto: %', OLD.texto;
	RAISE NOTICE 'NEW.texto, %', NEW.texto;
	RAISE NOTICE 'TG_NAME: %', TG_NAME;
	RAISE NOTICE 'TG_LEVEL: %', TG_LEVEL;
	RAISE NOTICE 'TG_WHEN: %', TG_WHEN;
	RAISE NOTICE 'TG_TABLE_NAME: %', TG_TABLE_NAME;
	RAISE NOTICE 'TG_NARGS: %', TG_NARGS;
	
	FOR i IN 0..TG_NARGS - 1 LOOP
		RAISE NOTICE '%', TG_ARGV[i];
	END LOOP;
	
	-- RETURN NULL;
	RETURN NEW;
	
END; $$

DROP TRIGGER tg_depois_de_um_insert ON tb_teste_trigger;
CREATE OR REPLACE TRIGGER tg_depois_de_um_insert
AFTER INSERT OR UPDATE ON tb_teste_trigger
FOR ROW 
	EXECUTE FUNCTION fn_depois_de_um_insert('Depois: V1', 'Depois: V2', 'Depois: V3');

UPDATE tb_teste_trigger SET texto = 'Novo Texto' WHERE cod_teste_trigger = 1;
INSERT INTO tb_teste_trigger(texto) VALUES ('Um novo texto para triggers');

SELECT * FROM tb_teste_trigger;

--- ... --- 

INSERT INTO tb_teste_trigger
(texto)
VALUES ('yes another test ... ');

SELECT * FROM tb_teste_trigger;

CREATE OR REPLACE TRIGGER tg_depois_do_insert2
AFTER INSERT ON tb_teste_trigger
FOR EACH STATEMENT 
	EXECUTE FUNCTION fn_depois_de_um_insert();


CREATE OR REPLACE TRIGGER tg_antes_do_insert2
BEFORE INSERT ON tb_teste_trigger
FOR EACH STATEMENT 
	EXECUTE PROCEDURE fn_antes_de_um_insert();

--- ... --- 



CREATE OR REPLACE FUNCTION fn_depois_de_um_insert()
RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN
	RAISE NOTICE 'Trigger foi chamado depois do insert';
	RETURN NULL;
END; $$

CREATE OR REPLACE TRIGGER tg_depois_de_um_insert
AFTER INSERT ON tb_teste_trigger
FOR STATEMENT 
	EXECUTE FUNCTION fn_depois_de_um_insert();
	
INSERT INTO tb_teste_trigger(texto) VALUES ('teste tg');
SELECT * FROM tb_teste_trigger;

-- ... -- 


DROP TABLE IF EXISTS tb_teste_trigger; 
CREATE TABLE tb_teste_trigger(
	cod_teste_trigger SERIAL PRIMARY KEY,
	texto VARCHAR(200)
);

CREATE OR REPLACE FUNCTION fn_antes_de_um_insert() RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	RAISE NOTICE 'Trigger foi chamado antes de um insert';
	RETURN NULL;
END ; $$

-- criando o trigger (vínculo entre a trigger e a tabela)	
CREATE OR REPLACE TRIGGER tg_antes_do_insert
BEFORE INSERT ON tb_teste_trigger
FOR EACH STATEMENT 
	EXECUTE PROCEDURE fn_antes_de_um_insert(); -- function/procedure

INSERT INTO tb_teste_trigger(texto) VALUES ('testando trigger ... ') ;
SELECT * FROM tb_teste_trigger;
