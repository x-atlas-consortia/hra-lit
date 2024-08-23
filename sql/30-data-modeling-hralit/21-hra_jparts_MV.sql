-- View: hra_jparts
DROP MATERIALIZED VIEW IF EXISTS hra_jparts CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_jparts
TABLESPACE pg_default
AS
 SELECT DISTINCT a.journal_nlmuniqueid,
   array_agg(DISTINCT normalize_id(a.journal_nlmuniqueid::text || '_'::text || a.volume::text)) AS has_part
 FROM medline_master a
   RIGHT JOIN hra_pmid hra ON a.pmid::text = hra.pmid::text
 GROUP BY a.journal_nlmuniqueid
WITH DATA;