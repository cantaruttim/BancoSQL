-- loop

DO $$
DECLARE 
	contador INT := 1;
BEGIN
	LOOP
		RAISE NOTICE 'Testando o loop simples ... ';
		contador := contador + 1;
		IF contador > 10 THEN
			EXIT;
		END IF;
	END LOOP;
END; $$




-------------------------------------------------------------
CREATE OR REPLACE FUNCTION valor_aleatorio_entre(
lim_inferior INT, lim_superio INT) RETURNS INT AS 
$$
BEGIN
	RETURN FLOOR(lim_inferior + random() * (lim_superior - lim_inferior + 1))::INT;
END; $$ LANGUAGE plpgsql;