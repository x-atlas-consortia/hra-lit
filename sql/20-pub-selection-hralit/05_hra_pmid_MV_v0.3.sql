-- View: public.hra_pmid

DROP MATERIALIZED VIEW IF EXISTS public.hra_pmid CASCADE;

CREATE OR REPLACE MATERIALIZED VIEW IF NOT EXISTS public.hra_pmid
TABLESPACE pg_default
AS
 
 WITH 
  pm1 AS (
 	SELECT DISTINCT mh.pmid
    FROM medline_mesh_heading mh
    RIGHT JOIN hra_meshd_anatomy hra 
	  ON mh.ui::text = hra.ui::text
	WHERE mh.pmid IS NOT NULL
 ),
  pm2 AS (
	SELECT DISTINCT mh.pmid
    FROM medline_mesh_heading mh
    RIGHT JOIN hra_meshd_methods hrm 
	  ON mh.ui::text = hrm.ui::text
	WHERE mh.pmid IS NOT NULL
)
 
 		
 SELECT DISTINCT pm1.pmid, dat.article_year
 FROM pm1 AS pm1
 INNER JOIN pm2 AS pm2
	ON pm1.pmid = pm2.pmid
 LEFT JOIN medline_article_date as dat
 	ON pm1.pmid = dat.pmid
 WHERE dat.article_year::integer > 2013
 
WITH DATA;