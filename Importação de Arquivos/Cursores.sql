/* Declaramos o cursor (refcursos)
   Abrimos o cursor
   Acessamos os dados (fetch/move)
   Fechamos o cursos a partir do cliente. */
   
/* */    
   
   
/* Ex: 2 - Escreva um cursor que exibe todos os nomes dos youtubers em ordem reversa. */ 
     
DO $$
DECLARE
	cur_youtuber_reverso CURSOR FOR
		SELECT youtuber FROM tb_top_youtubers
			ORDER BY youtuber;
	tupla RECORD;
	resultado TEXT DEFAULT '';
BEGIN
	OPEN cur_youtuber_reverso;
	FETCH ABSOLUTE 1000 FROM cur_youtuber_reverso INTO tupla; -- POSICIONANDO NA ÚLTIMA TUPLA

	WHILE FOUND LOOP
		resultado := resultado || tupla.youtuber || ' , ' || E'\n';
		FETCH BACKWARD FROM cur_youtuber_reverso INTO tupla; -- PEGANDO O VALOR ANTERIOR

	END LOOP;	
	CLOSE cur_youtuber_reverso;
	RAISE NOTICE '%', resultado;
END; $$

--- Exemplo 2 

DO $$
DECLARE
	cur_youtuber_reverso REFCURSOR;
	tupla RECORD;
BEGIN
	OPEN cur_youtuber_reverso SCROLL FOR
		SELECT * FROM tb_top_youtubers;
	
	LOOP 
		FETCH cur_youtuber_reverso INTO tupla;
		EXIT WHEN NOT FOUND;
	END LOOP;
 
 	LOOP
		FETCH BACKWARD FROM cur_youtuber_reverso INTO tupla;
		EXIT WHEN NOT FOUND; 
		RAISE NOTICE '%', tupla.youtuber || E'\n';
	END LOOP;

	CLOSE cur_youtuber_reverso;	
END; $$


   
   
/* Ex: 1 - Escreva um cursor que exiba as variáveis rank e youtuber de toda tupla que tiver video_count 
pelo menos igual a 1000 e cuja category seja igual a Sports ou Music. 

Para sabermos qual deve ser testado primeiro para não dar sobrecarga no banco, podemos utilizar o comando a seguir

SELECT category, COUNT(*) FROM tb_top_youtubers
WHERE video_count > 1000
GROUP BY category, tb_top_youtubers.category; 
-- MUSIC = 68 ; Sports = 6

*/

DO $$
DECLARE
	-- declarando o cursor
	cur_rank_e_youtuber CURSOR FOR 
		SELECT rank, youtuber , video_count FROM  tb_top_youtubers
			WHERE video_count >= 1000
				AND (category LIKE '%Music' 
				OR category LIKE '%Sports');
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


/* Remove todas as tuplas em que video_count é desconhecido e exiba as tuplas remancescentes na tabela, de baixo para cima */

DO $$
DECLARE
	cur_delete REFCURSOR; -- unbounding
	tupla RECORD;
BEGIN
	OPEN cur_delete SCROLL FOR 
		SELECT * FROM tb_top_youtubers;
	LOOP
		FETCH cur_delete INTO tupla;
		EXIT WHEN NOT FOUND;
		
		IF tupla.video_count IS NULL   THEN		
			DELETE FROM tb_top_youtubers
			WHERE CURRENT OF cur_delete;			
		END IF;		
	END LOOP;
	
	LOOP
		FETCH BACKWARD FROM cur_delete INTO tupla;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', tupla || E'\n';	
	END LOOP;
	
	CLOSE cur_delete;
END; $$

SELECT * FROM tb_top_youtubers
WHERE video_count IS NULL;
-- sem registros

/* parâmetros com nome e pela ordem */

DO $$
DECLARE
	v_ano INT := 2010;
	V_inscritos INT := 60000000;
	-- declarando o cursor (bound) com parâmetros.
	cur_ano_inscritos CURSOR (ano INT, inscritos INT) FOR
		SELECT youtuber FROM tb_top_youtubers
		WHERE started >= ano 
			AND subscribers >= inscritos;
	v_youtuber VARCHAR(200);
BEGIN
	-- abrir o cursor
	OPEN cur_ano_inscritos(v_ano, v_inscritos);
	LOOP
		-- recuperando os dados
		FETCH cur_ano_inscritos INTO v_youtuber;
		EXIT WHEN NOT FOUND;
		RAISE NOTICE '%', v_youtuber;
	END LOOP;
	-- fechando o cursor	
	CLOSE cur_ano_inscritos;
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

-- MUSIC = 68 ; Sports = 6
SELECT category, COUNT(*) FROM tb_top_youtubers
WHERE video_count > 1000
GROUP BY category, tb_top_youtubers.category;

SELECT rank AS Rank, youtuber AS Youtuber, video_count AS Visualizações FROM  tb_top_youtubers
WHERE video_count >= 1000
AND category LIKE '%Music' OR category LIKE '%Sports';

SELECT rank AS Rank, youtuber AS Youtuber, video_count AS Visualizações FROM  tb_top_youtubers
WHERE video_count >= 2000000;

SELECT rank , youtuber , video_count FROM tb_top_youtubers
ORDER BY video_count DESC;

-- Alterando o tipo dos dados para um tipo numérico
UPDATE tb_top_youtubers SET subscribers = REPLACE(subscribers, ',', '');
ALTER TABLE tb_top_youtubers ALTER COLUMN subscribers TYPE INTEGER USING subscribers::INT;

UPDATE tb_top_youtubers SET video_views = REPLACE(video_views, ',', '');
ALTER TABLE tb_top_youtubers ALTER COLUMN video_views TYPE BIGINT USING video_views::BIGINT;

UPDATE tb_top_youtubers SET video_count = REPLACE(video_count, ',', '');
ALTER TABLE tb_top_youtubers ALTER COLUMN video_count TYPE INTEGER USING video_count::INT;
