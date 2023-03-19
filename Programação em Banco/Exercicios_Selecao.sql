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


-- Usando o CASE

DO $$
DECLARE
	n INTEGER := valor_aleatorio_entre(0,5);
	m INTEGER := valor_aleatorio_entre(0,5);
	k INTEGER;
	
	valor INTEGER;
	mensagem VARCHAR(200);
BEGIN
	RAISE NOTICE 'Os valores de m e n gerados são: % e % ', m, n;
	k := m * n;
	RAISE NOTICE 'A multiplicação entre % e % é = %', m, n, k;
	
	valor := k / m;
		
	CASE valor 
		WHEN 3 THEN
			mensagem := 'Multiplo de 3';
		
		ELSE 
			mensagem := 'Não é multiplo de 3';
	END CASE;
		RAISE NOTICE '%', mensagem;
END; $$

-- 2. Faça um programa que exibe se um número inteiro é multiplo de 3 ou de 5.

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
		IF (k/m) = 3 OR (k/m) = 5 THEN
			RAISE NOTICE 'Multiplo de 3 ou 5';
		ELSE
			RAISE NOTICE 'Não é multiplo de 3 ou de 5';
		END IF;
	END IF;
END; $$

-- Usando o CASE

DO $$
DECLARE
	n INTEGER := valor_aleatorio_entre(0,5);
	m INTEGER := valor_aleatorio_entre(0,5);
	k INTEGER;
	
	valor INTEGER;
	mensagem VARCHAR(200);
BEGIN
	RAISE NOTICE 'Os valores de m e n gerados são: % e % ', m, n;
	k := m * n;
	RAISE NOTICE 'A multiplicação entre % e % é = %', m, n, k;
	
	valor := k / m;
		
	CASE valor 
		WHEN 3 THEN
			mensagem := 'Multiplo de 3 ou de 5';
		
		ELSE 
			mensagem := 'Não é multiplo de 3 ou de 5';
	END CASE;
		RAISE NOTICE '%', mensagem;
END; $$



/* 3. Faça um programa que opere de acordo com o seguinte menu
	1 - Soma 2 - Subtração 3 - Multiplicação 4 - Divisão */



-- Usando o CASE

DO $$
DECLARE 
	n1 INT := valor_aleatorio_entre (1,5);
	n2 INT := valor_aleatorio_entre (1,5);
	mensagem VARCHAR(30);
	
	-- menu % resultado
	valor INT;
	res_soma INT;
	res_subtracao INT;
	res_divisao INT;
	res_multiplicacao INT;
BEGIN
	RAISE NOTICE 'Os valores de n1 e n2 são : % e %', n1, n2;
	valor := valor_aleatorio_entre(1,4);
	-- resultado deve ser apresentado como n1 op n2 = res
	
	CASE valor
		WHEN 1 THEN
			mensagem := 'Opção 1';
			res_soma := n1 + n2;
			RAISE NOTICE '%', res_soma;
		WHEN 2 THEN
			mensagem := 'Opção 2';
			res_subtracao := n1 - n2;
			RAISE NOTICE '%', res_subtracao;
		WHEN 3 THEN
			mensagem := 'Opção 3';
			res_divisao := n1 / n2;
			RAISE NOTICE '%', res_divisao;
		WHEN 4 THEN
			mensagem := 'Opção 4';
			res_multiplicacao := n1 * n2;
			RAISE NOTICE '%', res_multiplicacao;
			
		ELSE 
			mensagem := 'Valor fora do intervalo';
	END CASE;
	RAISE NOTICE '% : %', mensagem, res_soma;
	RAISE NOTICE '% : %', mensagem, res_subtracao;
	RAISE NOTICE '% : %', mensagem, res_divisao;
	RAISE NOTICE '% : %', mensagem, res_multiplicacao;

	
END; $$

/* 4. Um comerciante comprou um produto e quer vendê-lo com um lucro de 45%
se o valor da compra for menor que R$ 20. Caso contrário, ele deseja lucro de 30%. Faça
um programa que, dado o valor do produto, calcula o valor da venda */

DO $$
DECLARE
	produto INTEGER := valor_aleatorio_entre(0,100);
	lucro_primario NUMERIC (5,2) := 0.45;
	lucro_secundario NUMERIC (5,2) := 0.30;
	
	venda NUMERIC (5,2);
BEGIN

	IF produto < 20 THEN
		venda = produto * (1 + lucro_primario);
		RAISE NOTICE 'O preço do produto é R$ %. O valor da venda com ajuste  R$ é %', produto, venda;
	
	ELSE  
		venda = produto * (1 + lucro_secundario);
		RAISE NOTICE 'O preço do produto é R$ %. O valor da venda com ajuste R$ é %', produto, venda;
	
	END IF;

END; $$

-- Usando o CASE

DO $$
DECLARE
	produto INTEGER := valor_aleatorio_entre(0,100);
	lucro_primario NUMERIC (5,2) := 0.45;
	lucro_secundario NUMERIC (5,2) := 0.30;
	
	venda NUMERIC (5,2);
BEGIN

	CASE produto
		WHEN 20 THEN
			venda := produto * (1 + lucro_primario);
			RAISE NOTICE 'O valor da venda será de R$ %', venda;
		ELSE 
			venda := produto * (1 + lucro_secundario);
			RAISE NOTICE 'O valor da venda será de R$ %', venda;
	END CASE;
	

END; $$


------------------------------------------------------------

CREATE OR REPLACE FUNCTION valor_aleatorio_entre (
	lim_inferior INT, lim_superior INT
) RETURNS INT AS
$$
BEGIN
	RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;