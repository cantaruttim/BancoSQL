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

3. Toda tabela necessita de pelo menos um campo que identique
todo o registro como sendo único (Chave Primária, Primary Key)

	registro : tupla (ou a linha)
	campo (COLUNA)
	
	
	Ex: O CPF demonstraria que aquele registro (ou tupla) seja única
	
	
Obs¹ O CPF não é uma boa maneira para identificarmos os registros como único.
Pois modelando o banco com base em negócios, caso haja alguma mudança extra-processual
seu banco, automaticamente será "perdido".


Chaves Naturais (inerente ao registro), Chaves Artificiais (criamos)	
	
	
	
-- CARDINALIDADE














*/