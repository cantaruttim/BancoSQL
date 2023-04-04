CREATE OR REPLACE PROCEDURE sp_acha_maior(IN valor1 INT, valor2 INT)
LANGUAGE plpgsql AS $$ 
BEGIN 
	IF valor1 > valor2 THEN
 		RAISE NOTICE '% é o maior', $1;
 	ELSE
 		RAISE NOTICE '% é o maior', $2;
 	END IF;
END; $$
CALL sp_acha_maior(5,8);

-- CREATE OR REPLACE PROCEDURE sp_ola_usuario(nome VARCHAR(200)) LANGUAGE plpgsql AS $$
-- BEGIN
-- 	RAISE NOTICE 'olá, %', nome;
-- 	RAISE NOTICE 'olá, %', $1;
-- END; $$
-- --
-- CALL sp_ola_usuario('Matheus');

-- -- criar o procedimento 
-- CREATE OR REPLACE PROCEDURE sp_ola_procedures () LANGUAGE plpgsql AS $$
-- BEGIN
-- 	RAISE NOTICE 'Olá, procedures';
-- END; $$
-- -- chamar (colocar em execução)
-- CALL sp_ola_procedures();
