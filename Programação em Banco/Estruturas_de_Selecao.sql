/* Operadores Lógicos (14/03)
-- AND OR NOT */

SELECT 2 > 3 AS "Teste Lógico";
SELECT 2 < 3 AS "Teste Lógico";
SELECT 3 = 3 AS "Teste Lógico";
SELECT 1 <= 2 AS "Teste Lógico";
SELECT 1 >= 2 AS "Teste Lógico";
SELECT 1 <> 2 AS "Teste Lógico";

SELECT 2 BETWEEN 1 AND 3 AS "INTERVALO";
SELECT 2 BETWEEN SYMMETRIC 3 AND 1 AS "INTERVALO"; -- Igual a 1 à 3 
SELECT 2 IS DISTINCT FROM NULL; -- Valores diferentes de "desconhecido"
SELECT 2 ISNULL;
SELECT 2 NOTNULL;

-- Estruturas de De Seleção







