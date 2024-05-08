-- View: public.hra_abs
DROP MATERIALIZED VIEW IF EXISTS public.hra_abs CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_abs
TABLESPACE pg_default
AS
	WITH abs AS (
		SELECT * 
		FROM medline_abstract_text AS a
		ORDER BY a.pmid, a.abstract_ctr::integer
	)

	SELECT hra.pmid,
		   string_agg(abs.abstract_ctr::text, ' '::text) AS abstract_ct,
		   string_agg(abs.abstract_text::text, ' '::text) AS abstract
	FROM hra_pmid2 hra
	LEFT JOIN abs abs ON hra.pmid::text = abs.pmid::text
	GROUP BY hra.pmid
WITH DATA;