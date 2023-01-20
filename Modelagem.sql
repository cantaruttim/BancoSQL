-- MODELAGEM

SELECT sexo, COUNT(*) as QTD 
FROM cliente
GROUP BY sexo;


-- PRIMEIRA FORMA NORMAL  (1FN)

/* 
1. Todo campo vetorizado se tornará outra tabela
	pertencem a mesma 'família'
	
	Ex: Telefone


2. Todo campo multivalorado se tornará outra tabela
	Quando o campo for divisível 
	
	Ex: Endereço  >>> Rua, Bairro, Cidade, Estado


*/