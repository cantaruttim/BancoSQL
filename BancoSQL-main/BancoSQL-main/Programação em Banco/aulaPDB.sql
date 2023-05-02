CREATE TABLE tb_livro (
	cod_livro INTEGER PRIMARY KEY,
	titulo VARCHAR(200),
	autor VARCHAR(200)
);

INSERT INTO tb_livro (cod_livro, titulo, autor) VALUES (1, 'Concrete Mathematics','Donald Knuth');
INSERT INTO tb_livro (cod_livro, titulo, autor) VALUES (2, 'introduction to algorithms','Thomas H. Cormen');
INSERT INTO tb_livro VALUES (3, 'Mathematics and Its History','John Stillwell');

SELECT * FROM tb_livro;

-- Select 
SELECT titulo
FROM tb_livro;

SELECT titulo
FROM tb_livro
WHERE autor LIKE '%H.%';

-- --------------------

-- BLOCOS ANÔNIMOS

-- valores aleatórios
-- funçao random: 0 <= n < 1
DO
$$
DECLARE
	n1 NUMERIC (5,2);
	n2 INTEGER;
	limite_inferior INTEGER := 5;
	limite_superior INTEGER := 17;
BEGIN
	n1 := random(); -- 0 <= n1 < 1
	RAISE NOTICE '%', n1;
	
	-- auterando o valor do limite inferior
	n1 := random() * 10;
	RAISE NOTICE '%', n1;
	
	--
	
	n2 := FLOOR(random() * 10 + 1)::int;
	RAISE NOTICE '%', n2;
	
	-- gerando um valor aleatório entre os limites.
	n2 := FLOOR(limite_inferior + random() * (limite_superior - limite_inferior + 1));
	RAISE NOTICE '%', n2;
	
END;
$$








-- -- operadores aritméticos (https://www.postgresql.org/docs/9.0/functions-math.html)
-- DO
-- $$
-- DECLARE
-- 	n1 INTEGER := 5;
-- 	n2 INTEGER := 2;
-- 	n3 NUMERIC (5,2) := 5;
-- 	n4 INTEGER := -5;
-- BEGIN
-- 	-- adição
-- 	RAISE NOTICE '% + % = %', n1, n4, n1 + n4;
-- 	-- subtração 
-- 	RAISE NOTICE '% - % = %', n1, n2, n1 - n2;
-- 	RAISE NOTICE '% - % = %', n1, n4, n1 - n4;
-- 	RAISE NOTICE '%, %', -n4, -n2;
-- 	-- multiplicação
-- 	RAISE NOTICE '% * % = %', n1, n4, n1 * n4;
-- 	-- divisão
-- 	RAISE NOTICE '% / % = %', n1, n2, n1 / n2;
-- 	RAISE NOTICE '% / % = %', n3, n2, to_char(n3 / n2, '99.99');
-- 	-- resto da divisão
-- 	RAISE NOTICE '% %% % = %', n3, n2, to_char(n3 % n2, '99.99');
-- 	--exponenciação
-- 	RAISE NOTICE '% ^ % = %', n2,n1, n2 ^ n1;
-- 	-- raiz quadrada
-- 	RAISE NOTICE '|/ % = %', n1, |/ n1;
-- 	-- raiz cúbica
-- 	RAISE NOTICE '||/ % = %', n1, |/ n1;
-- 	-- valor absoluto 
-- 	RAISE NOTICE '@% = % e @% = %', n1, @n1, n4, @n4;
-- END;
-- $$


-- variáveis
-- DO
-- $$
-- DECLARE -- declara as variáveis
-- 	codigo INTEGER  := 1; -- atribui o valor a uma variável
-- 	nome_completo VARCHAR(200) := 'João Santos';
-- 	salario NUMERIC (11, 2) := 2000.57;
-- BEGIN
-- 	RAISE NOTICE 'Meu código é %, meu nome é % e eu ganho %', codigo, nome_completo, salario;
-- END;
-- $$


-- PLACEHOLDERS

-- DO
-- $$
-- BEGIN
-- 	-- 2 + 2 = 4
-- 	RAISE NOTICE '% + % = %', 2,2, 2 + 2;
-- END;
-- $$

-- DO
-- $$
-- BEGIN
-- 	RAISE NOTICE 'Meu primeiro bloco anônimo';
-- END;
-- $$















