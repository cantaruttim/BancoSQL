// Lista de Exercício 1:

-- 1. Faça um programa que gere um valor inteiro e o exiba

DO
$$

DECLARE
	-- declarando um valor inteiro (Números inteiros: [1, 100])
	n1 INTEGER;
	li INTEGER := 1;
	ls INTEGER := 100;
BEGIN
	n1 := FLOOR(li + random() * (ls - li + 1));
	RAISE NOTICE '%', n1;
END;
$$

-- 2. Faça um programa que gere um valor real e o exiba (Números reais: [1, 10])

DO
$$

DECLARE
	n2 NUMERIC (5,2);
	li INTEGER := 1;
	ls INTEGER := 10;
BEGIN
	n2 := FLOOR(li + random() * (ls - li + 1));
	RAISE NOTICE '%', n2;
END;
$$