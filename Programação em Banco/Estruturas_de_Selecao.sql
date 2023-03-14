/* Dado um valor entre 1 e 10, decidir se ele é par ou ímpar.
Para tal, use a estrutura CASE valor WHEN valor THEN ELSE */

-- DO 
-- $$
-- DECLARE
-- 	valor INT;
-- 	mensagem VARCHAR(200);

-- BEGIN --vamos admitir alguns valores fora do intervalo para ver o que acontece quando não há case previsto
-- 	valor := valor_aleatorio_entre (1, 12);
-- 	RAISE NOTICE 'O valor gerado é: %', valor;
-- 	CASE valor
		
-- 	WHEN 1 THEN 
-- 		mensagem := 'Ímpar';
-- 	WHEN 3 THEN
-- 		mensagem := 'Ímpar';
-- 	WHEN 5 THEN
-- 		mensagem := 'Ímpar';
-- 	WHEN 7 THEN
-- 		mensagem := 'Ímpar';
-- 	WHEN 9 THEN
-- 		mensagem := 'Ímpar';
-- 	WHEN 2 THEN
-- 		mensagem := 'Par';
-- 	WHEN 4 THEN
-- 		mensagem := 'Par';
-- 	WHEN 6 THEN
-- 		mensagem := 'Par';
-- 	WHEN 8 THEN
-- 		mensagem := 'Par';
-- 	WHEN 10 THEN
-- 		mensagem := 'Par';
-- Exceção CASE_NOT_FOUND 
-- 	ELSE mensagem := 'Valor fora do intervalo';

-- 	END CASE;
-- 	RAISE NOTICE '%', mensagem;

-- END;$$








/* Dados valores a,b e c desempenhando o papel de coeficientes 
de uma potencial equação do segundo grau, calcule as potenciais raízes. 
Considere que qualquer um dos coeficientes pode ser igual a zero */

DO
$$
DECLARE
	a INT := valor_aleatorio_entre(1,5);
	b INT := valor_aleatorio_entre(1,5);
	c INT := valor_aleatorio_entre(1,5);
	delta NUMERIC(10,2);
	
	raizUm NUMERIC(10,2);
	raizDois NUMERIC(10,2);
BEGIN
	RAISE NOTICE 'Os valores de a, b e c são: %, % e %, respectivamente', a,b,c;
	RAISE NOTICE 'Com a Equação da reta : %x% + %x + % = 0', a, U&'\00B2', b, c;
	
	delta := b ^ 2 - 4 * a * c;
	RAISE NOTICE 'Valor de delta: %', delta;
	
	IF a = 0 THEN
		RAISE NOTICE 'Essa equação não é uma equação do segundo grau';
	ELSE 
			IF delta < 0 THEN
				RAISE NOTICE 'Não há raízes reais';
			ELSEIF delta = 0 THEN
				raizUm := ((-b + |/ delta) / (2 * a));
				RAISE NOTICE 'Há apenas uma raíz real, %', raizUm;
			ELSE
				raizUm := ((-b + |/ delta) / (2 * a));
				raizDois := ((-b - |/ delta) / (2 * a));
				RAISE NOTICE 'Há duas raízes reais e diferentes, % e %', raizUm, raizDois;
			END IF;
	END IF;
		
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