-- View: hra_titles
DROP MATERIALIZED VIEW IF EXISTS hra_titles CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_titles
TABLESPACE pg_default
AS
 SELECT hra.pmid,
    a.article_title AS title
   FROM hra_pmid hra
     LEFT JOIN medline_master a ON hra.pmid::text = a.pmid::text
  WHERE a.article_title IS NOT NULL
UNION
 SELECT hra.pmid,
    a.vernacular_title AS title
   FROM hra_pmid hra
     LEFT JOIN medline_master a ON hra.pmid::text = a.pmid::text
  WHERE a.article_title IS NULL AND a.vernacular_title IS NOT NULL
WITH DATA;