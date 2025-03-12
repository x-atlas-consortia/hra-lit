-- View: hra_dates
DROP MATERIALIZED VIEW IF EXISTS hra_dates CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_dates AS
SELECT
  pml.pmid,
  COALESCE(
    TO_DATE((ad.article_year || '-' || ad.article_month || '-' || ad.article_day), 'YYYY-MM-DD'),
    TO_DATE((mas.pub_year || '-01-01'), 'YYYY-MM-DD')
  ) AS "date_published"
FROM
  hra_pmid AS pml
  INNER JOIN medline_master AS mas ON (pm1.pmid = mas.pmid)
  LEFT JOIN medline_article_date AS ad ON (pml.pmid = ad.pmid)
WITH
  DATA;