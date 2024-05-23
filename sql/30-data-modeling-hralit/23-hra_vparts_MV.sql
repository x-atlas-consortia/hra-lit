-- View: public.hra_vparts
DROP MATERIALIZED VIEW IF EXISTS public.hra_vparts CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_vparts
TABLESPACE pg_default
AS
 SELECT DISTINCT (a.journal_nlmuniqueid::text || '_'::text) || a.volume::text AS volume_id,
    array_agg(DISTINCT (((('https://perl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text) || '_'::text) || a.volume::text) || '_'::text) || a.issue::text) AS has_part
   FROM medline_master a
     RIGHT JOIN hra_pmid hra ON a.pmid::text = hra.pmid::text
  WHERE a.volume IS NOT NULL AND ((((a.journal_nlmuniqueid::text || '_'::text) || a.volume::text) || '_'::text) || a.issue::text) IS NOT NULL
  GROUP BY ((a.journal_nlmuniqueid::text || '_'::text) || a.volume::text)
WITH DATA;