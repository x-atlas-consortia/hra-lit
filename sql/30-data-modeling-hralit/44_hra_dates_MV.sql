-- View: public.hra_dates
DROP MATERIALIZED VIEW IF EXISTS public.hra_dates CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_dates
AS
SELECT pml.pmid, 
	to_date((ad.article_year||'_'||ad.article_month||'_'||ad.article_day), 'YYYY-MM-DD') AS "date_published"
FROM public.hra_pmid AS pml 
LEFT JOIN public.medline_article_date AS ad 
	ON (pml.pmid = ad.pmid)
WITH DATA;