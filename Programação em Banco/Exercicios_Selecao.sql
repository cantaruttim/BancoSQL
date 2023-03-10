-- Exercícios

-- 1. Faça um programa que mostre se o número é multiplo de 3 (três) [M = n . k, k E Z]

DO $$
DECLARE
	n INTEGER := valor_aleatorio_entre(0,5);
	m INTEGER := valor_aleatorio_entre(0,5);
	k INTEGER;
BEGIN
	RAISE NOTICE 'Os valores gerados de m e n são : %, % respectivamente', m, n;
	k := m * n;
	RAISE NOTICE 'A multiplicação entre % e % é = %', m, n, k;
	
	IF (k/m) <> 0 THEN
		-- Se (k / m) = n dizemos que o valor é multiplo 
		IF (k/m) = 3 THEN
			RAISE NOTICE 'Multiplo de 3';
		ELSE
			RAISE NOTICE 'Não é multiplo de 3';
		END IF;
	END IF;
END; $$

-- 2. Faça um programa que exibe se um número inteiro é multiplo de 3 ou de 5.

DO $$
DECLARE 

BEGIN

END; $$

/* 3. Faça um programa que opere de acordo com o seguinte menu
	1 - Soma
	2 - Subtração
	3 - Multiplicação
	4 - Divisão
*/

CREATE OR REPLACE FUNCTION valor_aleatorio_entre (
	lim_inferior INT, lim_superior INT
) RETURNS INT AS
$$
BEGIN
	RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;