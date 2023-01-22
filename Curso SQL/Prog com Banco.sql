/* PROGRAMAÇÃO EM BANCO DE DADOS:


; : Delimitador do banco de dados
Portando o ; separa os blocos de comando do MySQL


STATUS
Using Delimiter : precisamos mudar o delimitador

muda o delimitador para $ por exemplo (podemos fazer qualquer outro comando)
DELIMITER $

Uptime : Tempo referente ao tempo que o seu banco está de pé, desde a 
ultima vez que ele executor


###############################

STORED PROCEDURES:

-- Blocos anônimos e Armazenados (possuem nome)

Toda vez que alguém logar no banco, precisamos mostrar o nome da empresa
-- A mudança do delimitador é importante, pois caso não haja a mudança
o procedure não irá acontecer, ou o código será lido de forma incompleta.

DELIMITER $

CREATE PROCEDURE NOME()
BEGIN

	<
	
	
	
	bloco de código 
	
	
	
	
	>	

END
$



 */
 
DELIMITER $
 
CREATE PROCEDURE NOME_EMPRESA()
BEGIN

	SELECT 'UNIVERSIDADE DOS DADOS' AS EMPRESA;
	SELECT NOW();
	
END
$

-- Chamando a PROCEDURE

CALL NOME_EMPRESA()$

-- DELETEANDO UMA PROCEDURE

DROP PROCEDURE NOME_EMPRESA;

DELIMITER ;

-- passando parâmetros:

CREATE PROCEDURE CONTA(NUMERO1 INT, NUMERO2 INT)
BEGIN

	SELECT NUMERO1 + NUMERO2 AS CONTA;
	
END
$

CALL CONTA(25, 150)$
CALL CONTA(5, 20)$



