/* Declaramos o cursor (refcursos)
   Abrimos o cursor
   Acessamos os dados (fetch/move)
   Fechamos o cursos a partir do cliente. */
   
/* Escreva um cursor que exiba as variáveis rank e youtuber de toda tupla que tiver video_count 
pelo menos igual a 1000 e cuja category seja igual a Sports ou Music. */
-- MUSIC = 222 ; Sports = 10

DO $$
DECLARE
	-- declarando o cursor
	cur_rank_e_youtuber CURSOR FOR 
		SELECT rank, youtuber , video_count FROM  tb_top_youtubers
			WHERE video_count >= '1,000.00'
				AND category LIKE '%Music' 
				OR category LIKE '%Sports';
	tupla RECORD;
	resultado TEXT DEFAULT '';
BEGIN

	OPEN cur_rank_e_youtuber;
	FETCH cur_rank_e_youtuber INTO tupla;
	
	WHILE FOUND LOOP
		resultado := resultado || tupla.rank || ': ' || tupla.youtuber || ', ' || tupla.video_count || E'\n';
		FETCH cur_rank_e_youtuber INTO tupla;
	END LOOP;
	
	CLOSE cur_rank_e_youtuber;
	RAISE NOTICE '%', resultado;

END; $$

   
   
-- Concatenando nome e número de inscritos (Bound)

DO $$
DECLARE
	cur_nomes_e_inscritos CURSOR FOR 
		SELECT youtuber, subscribers FROM tb_top_youtubers;
	tupla RECORD;
	resultado TEXT DEFAULT '';
BEGIN

	OPEN cur_nomes_e_inscritos;
	
	FETCH cur_nomes_e_inscritos INTO tupla;
	WHILE FOUND LOOP
		resultado := resultado || tupla.youtuber || ': ' || tupla.subscribers || E'\n';
	
		FETCH cur_nomes_e_inscritos INTO tupla;
	END LOOP;

	CLOSE cur_nomes_e_inscritos;
	RAISE NOTICE '%', resultado;
END ; $$


-- Exibindo os nomes dos youtubers que começaram a partir de um ano específico
DO $$
DECLARE
	-- 1. Declaração
	cur_nomes_a_partir_de REFCURSOR;
	v_youtuber VARCHAR(200);
	v_ano INT := 2008;
	v_nome_tabela VARCHAR(200) := 'tb_top_youtubers';
BEGIN
	-- 2. Abrindo o cursor
	OPEN cur_nomes_a_partir_de FOR EXECUTE(
		
		format(
			'
				SELECT youtuber FROM %s 
				WHERE started >= $1 
			', 
			v_nome_tabela
		)
		
	) USING v_ano;
	
	LOOP
		-- 3. Obtendo os dados de interesse
		FETCH cur_nomes_a_partir_de INTO v_youtuber;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', v_youtuber;
	END LOOP;
	
	-- 4. Fechando o cursor
	CLOSE cur_nomes_a_partir_de;
	
END; $$



DO $$
DECLARE
	-- 1. declaração do cursor (unbound, não vinculado). Ele foi declarado sem que um comando fosse associado a ele
	
	cur_nomes_youtubers REFCURSOR;
	v_youtuber VARCHAR(200);
	
BEGIN
	-- 2. Aabrindo o cursor
	OPEN cur_nomes_youtubers FOR
		SELECT youtuber FROM tb_top_youtubers;
	
	LOOP
		-- 3. Operando com o Cursor. Recuperação dos dados de interesse.
		FETCH cur_nomes_youtubers INTO v_youtuber; -- acessamos o primeiro valor 
			-- Verificando se houve um resultado com o FETCH	
			EXIT WHEN NOT FOUND;
			RAISE NOTICE '%', v_youtuber;
	END LOOP;
	
	-- 4. Fechando o cursor
	CLOSE cur_nomes_youtubers;

END; $$
 
   
   
   

DROP TABLE tb_top_youtubers;
CREATE TABLE tb_top_youtubers(
	cod_top_youtubers SERIAL PRIMARY KEY,
	rank INT,
	youtuber VARCHAR(200),
	subscribers VARCHAR(200),
	video_views VARCHAR(200),
	video_count VARCHAR(200),
	category VARCHAR(200),
	started INT
);

SELECT * FROM tb_top_youtubers;

-- MUSIC = 222 ; Sports = 10
SELECT category, COUNT(*) FROM tb_top_youtubers
WHERE video_count > '1,000.00'
GROUP BY category, tb_top_youtubers.category;

SELECT rank AS Rank, youtuber AS Youtuber, video_count AS Visualizações FROM  tb_top_youtubers
WHERE video_count >= '1,000.00'
AND category LIKE '%Music' OR category LIKE '%Sports';
