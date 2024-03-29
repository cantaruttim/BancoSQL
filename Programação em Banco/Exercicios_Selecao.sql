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
	
	IF (k % m) <> 0 THEN
		-- Se (k / m) = n dizemos que o valor é multiplo 
		IF (k % m) = 3 THEN
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
	
	valor := k % m;
		
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
	
	IF (k % m) <> 0 THEN
		-- Se (k / m) = n dizemos que o valor é multiplo 
		IF (k % m) = 3 OR (k % m) = 5 THEN
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
	
	valor := k % m;
		
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

DO $$
DECLARE
	n1 INT := valor_aleatorio_entre (1,5);
	n2 INT := valor_aleatorio_entre (1,5);
	
	valor INT := valor_aleatorio_entre (1,4);
	res_soma INT;
	res_subtracao INT;
	res_divisao INT;
	res_multiplicacao INT;
BEGIN
	IF valor <> 0 THEN
		IF valor = 1 THEN
			res_soma := n1 + n2;
			RAISE NOTICE 'Opção Soma: % e %, Resultado = %', n1, n2, res_soma;
		ELSEIF valor = 2 THEN
			res_subtracao := n1 - n2;
			RAISE NOTICE 'Opção Subtração :  % e %, Resultado = %', n1, n2, res_subtracao;
		ELSEIF valor = 3 THEN
			res_divisao := n1 / n2;
			RAISE NOTICE 'Opção Divisão :  % e %, Resultado = %', n1, n2, res_divisao;
		ELSEIF valor = 4 THEN
			res_multiplicacao := n1 * n2;
			RAISE NOTICE 'Opção Multiplicação :  % e %, Resultado = %', n1, n2, res_multiplicacao;
		ELSE
			RAISE NOTICE 'Valor fora das Opções de Menu';
		END IF;
	END IF;

END; $$


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
		RAISE NOTICE 'O preço do produto é R$ %. O valor da venda com ajuste R$ é %',  produto, venda;
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


/* 5. The company ABC decided to give a salary increase to its employees, according to the following table:
Salary					Readjustment Rate
0 - 400.00						15%
400.01 - 800.00					12%
800.01 - 1200.00				10%
1200.01 - 2000.00				7%
Above 2000.00					4%

Print 3 messages followed by the corresponding numbers (see example) informing the new salary, 
- the among of money earned (both must be shown with 2 decimal places) 
- the percentual obtained by the employee. Note:

Novo salario:  means "New Salary"
Reajuste ganho: means "Money earned"
Em percentual: means "In percentage" 						*/ 


DO $$
DECLARE
	salario NUMERIC (10,2) := valor_aleatorio_entre(0,3500);
	novo_salario NUMERIC (10,2);
	
	reajuste_ganho NUMERIC(10,2);
	percentual NUMERIC(10,2);
BEGIN
	RAISE NOTICE 'O salário é de R$ %', salario;
	
	IF salario > 2000 THEN
		novo_salario := salario * (1 + 0.04);
		reajuste_ganho := novo_salario - salario;
		percentual := 0.04 * 100;
		RAISE NOTICE 'O novo salário será de R$ %, com um reajuste de R$ %. Correspondendo um percentual de %', 
		novo_salario, reajuste_ganho, percentual;
	ELSE 
		 IF salario BETWEEN 1200.01 AND 2000 THEN
			novo_salario := salario * (1 + 0.07);
			reajuste_ganho := novo_salario - salario;
			percentual := 0.07 * 100;
			RAISE NOTICE 'O novo salário será de R$ %, com um reajuste de R$ %. Correspondendo um percentual de %', 
			novo_salario, reajuste_ganho, percentual;
			
		ELSEIF salario BETWEEN SYMMETRIC 1200 AND 800 THEN
			novo_salario := salario * (1 + 0.10);
			reajuste_ganho := novo_salario - salario;
			percentual := 0.10 * 100;
			RAISE NOTICE 'O novo salário será de R$ %, com um reajuste de R$ %. Correspondendo um percentual de %', 
			novo_salario, reajuste_ganho, percentual;
		ELSEIF salario BETWEEN 400 AND 800 THEN
			novo_salario := salario * (1 + 0.12);
			reajuste_ganho := novo_salario - salario;
			percentual := 0.12 * 100;
			RAISE NOTICE 'O novo salário será de R$ %, com um reajuste de R$ %. Correspondendo um percentual de %', 
			novo_salario, reajuste_ganho, percentual;
		ELSE 
			novo_salario := salario * (1 + 0.15);
			reajuste_ganho := novo_salario - salario;
			percentual := 0.15 * 100;
			RAISE NOTICE 'O novo salário será de R$ %, com um reajuste de R$ %. Correspondendo um percentual de %', 
			novo_salario, reajuste_ganho, percentual;
		END IF;
	END IF;
	

END; $$


-- Usando o CASE
DO $$
DECLARE
	salario NUMERIC (10,2) := valor_aleatorio_entre(0,3500);
	novo_salario NUMERIC (10,2);
	
	reajuste_ganho NUMERIC(10,2);
	percentual NUMERIC(10,2);
-- 	mensagem VARCHAR(500);
BEGIN
	RAISE NOTICE 'O salário é de R$ %', salario;
	
	CASE salario
		WHEN 2000 THEN
			novo_salario := salario * (1 + 0.04);
			reajuste_ganho := novo_salario - salario;
			percentual := 0.04 * 100;
			RAISE NOTICE 'O novo salário será de R$ %, com um reajuste de R$ %. Correspondendo um percentual de %', 
			novo_salario, reajuste_ganho, percentual;
		WHEN 1200.01 THEN
			novo_salario := salario * (1 + 0.07);
			reajuste_ganho := novo_salario - salario;
			percentual := 0.07 * 100;
			RAISE NOTICE 'O novo salário será de R$ %, com um reajuste de R$ %. Correspondendo um percentual de %', 
			novo_salario, reajuste_ganho, percentual;
		WHEN 800 THEN
			novo_salario := salario * (1 + 0.10);
			reajuste_ganho := novo_salario - salario;
			percentual := 0.10 * 100;
			RAISE NOTICE 'O novo salário será de R$ %, com um reajuste de R$ %. Correspondendo um percentual de %', 
			novo_salario, reajuste_ganho, percentual;
			
		WHEN 400 THEN
			novo_salario := salario * (1 + 0.12);
			reajuste_ganho := novo_salario - salario;
			percentual := 0.12 * 100;
			RAISE NOTICE 'O novo salário será de R$ %, com um reajuste de R$ %. Correspondendo um percentual de %', 
			novo_salario, reajuste_ganho, percentual;
		ELSE 
			novo_salario := salario * (1 + 0.15);
			reajuste_ganho := novo_salario - salario;
			percentual := 0.15 * 100;
			RAISE NOTICE 'O novo salário será de R$ %, com um reajuste de R$ %. Correspondendo um percentual de %', 
			novo_salario, reajuste_ganho, percentual;
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
