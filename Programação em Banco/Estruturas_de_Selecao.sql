/* Dados valores a,b e c desempenhando o papel de coeficientes 
de uma potencial equação do segundo grau, calcule as potenciais raízes. 
Considere que qualquer um dos coeficientes pode ser igual a zero */

DO
$$
DECLARE
	a INT := valor_aleatorio_entre(1,10);
	b INT := valor_aleatorio_entre(1,10);
	c INT := valor_aleatorio_entre(1,10);
	
	delta NUMERIC(10,2);
	raizUm NUMERIC(10,2);
	raizDois NUMERIC(10,2);
BEGIN
	RAISE NOTICE 'Os valores de a, b e c são: %, % e %, respectivamente', a,b,c;
	RAISE NOTICE 'Com a Equação da reta : %x% + %x + % = 0', a, U&'\00B2', b, c;

END;
$$

--------------------------------------------------------------------- 

/* Dado um número inteiro, exiba se ele é par ou ímpar */

DO
$$
DECLARE
	valor INT := valor_aleatorio_entre(1,100);
BEGIN
	RAISE NOTICE 'O valor gerado é o %', valor;
	IF valor % 2 = 0 THEN
		RAISE NOTICE 'Esse número é par';
	ELSE
		RAISE NOTICE 'Esse número é ímpar';
	END IF;
END;
$$

/*  Dado um número inteiro, exiba metade de seu valor caso seja maior que 20 */

DO
$$
DECLARE
	valor INT;
BEGIN
	valor := valor_aleatorio_entre(1,100);
	RAISE NOTICE 'O valor gerado é o %', valor;
	
	IF valor <= 20 THEN
		RAISE NOTICE 'A metade do valor % é de %', valor, valor/2::FLOAT;
	END IF;
END;
$$

------------------------------------------------------

SELECT valor_aleatorio_entre (2,10);

CREATE OR REPLACE FUNCTION valor_aleatorio_entre (
	lim_inferior INT, lim_superior INT
) RETURNS INT AS
$$
BEGIN
	RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;