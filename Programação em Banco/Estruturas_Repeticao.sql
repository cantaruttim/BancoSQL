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


-- Podemos sair do loop sem a necessidade de um contador

DO $$
DECLARE
	contador INT := 1;
BEGIN
	LOOP
		RAISE NOTICE '%', contador;
		contador := contador + 1;
		EXIT WHEN contador > 10;
	END LOOP;
END; $$ 


-- Utilizando o IF/CONTINUE
DO $$
DECLARE
	contador INT := 1;
BEGIN
	LOOP
		RAISE NOTICE '%', contador;
		contador := contador + 1;
		EXIT WHEN contador > 100;
		
	 	IF contador % 7 = 0 THEN
			CONTINUE; -- podemos altera o CONTINUE por EXIT para entender o comportamento.
		END IF;
		
		CONTINUE WHEN contador % 11 = 0;
		RAISE NOTICE '%', contador;
	END LOOP;
END; $$ 


-- utilizando Rótulos

DO $$
DECLARE
	j INT;
	i INT;
BEGIN
	i := 0;
	<<externo>> -- rótulo externo
	LOOP 
		i := i + 1;
		EXIT WHEN i > 10;
		j := 1;
		
		<<interno>> -- rótulo interno
		LOOP 
			RAISE NOTICE '% %', i, j;
			j := j + 1;
			EXIT WHEN j > 10;
			EXIT externo WHEN j > 5; -- mencionamos o rótulo externo 
		END LOOP;
	END LOOP;	
END; $$



-------------------------------------------------------------
CREATE OR REPLACE FUNCTION valor_aleatorio_entre(
lim_inferior INT, lim_superio INT) RETURNS INT AS 
$$
BEGIN
	RETURN FLOOR(lim_inferior + random() * (lim_superior - lim_inferior + 1))::INT;
END; $$ LANGUAGE plpgsql;
