-- View: hra_jparts
DROP MATERIALIZED VIEW IF EXISTS hra_jparts CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_jparts TABLESPACE pg_default AS
SELECT DISTINCT
  a.journal_nlmuniqueid,
  ARRAY_AGG(DISTINCT normalize_id ('JV-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT)) AS has_part
FROM
  medline_master a
  RIGHT JOIN hra_pmid hra ON a.pmid::TEXT = hra.pmid::TEXT
GROUP BY
  a.journal_nlmuniqueid
WITH
  DATA;