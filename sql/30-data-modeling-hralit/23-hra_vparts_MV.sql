-- View: hra_vparts
DROP MATERIALIZED VIEW IF EXISTS hra_vparts CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_vparts TABLESPACE pg_default AS
SELECT DISTINCT
  normalize_id ('JV-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT) AS volume_id,
  ARRAY_AGG(DISTINCT normalize_id ('JVI-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT || '_'::TEXT || a.issue::TEXT)) AS has_part
FROM
  medline_master a
  RIGHT JOIN hra_pmid hra ON a.pmid::TEXT = hra.pmid::TEXT
WHERE
  a.volume IS NOT NULL
  AND ('JVI-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT || '_'::TEXT || a.issue::TEXT) IS NOT NULL
GROUP BY
  ('JV-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT)
WITH
  DATA;