-- TRIGGERS







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








