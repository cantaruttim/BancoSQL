/* Declaramos o cursos (refcursos)
   Abrimos o cursos
   Acessamos os dados (fetch/move)
   Fechamos o cursos a partir do cliente. */

DROP TABLE tb_top_youtubers;
CREATE TABLE tb_top_youtubers(
	cod_top_youtubers SERIAL PRIMARY KEY,
	rank INT,
	youtuber VARCHAR(200),
	subscribers VARCHAR(200),
	video_views VARCHAR(200),
	video_count INT,
	category VARCHAR(200),
	started INT
);

















