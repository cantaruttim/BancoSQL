/* TRIGGERS */

DELIMITER $

CREATE TRIGGER NOME
BEFORE/AFTER INSERT/DELETE/UPDATE ON <TABELA> -- ANTES OU DEPOIS DE UMA DESSAS AÇÕES
	FOR EACH ROW
BEGIN 

	<CÓDIGO SQL>;
	
END
$


use information_schema;
show tables;

DESC TRIGGERS;