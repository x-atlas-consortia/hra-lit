-- View: hra_abs
DROP MATERIALIZED VIEW IF EXISTS hra_abs CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_abs TABLESPACE pg_default AS
WITH
  ABS AS (
    SELECT
      *
    FROM
      medline_abstract_text AS a
    ORDER BY
      a.pmid,
      a.abstract_ctr::INTEGER
  )
SELECT
  hra.pmid,
  STRING_AGG(ABS.abstract_ctr::TEXT, ' '::TEXT) AS abstract_ct,
  STRING_AGG(ABS.abstract_text::TEXT, ' '::TEXT) AS abstract
FROM
  hra_pmid2 hra
  LEFT JOIN ABS ABS ON hra.pmid::TEXT = ABS.pmid::TEXT
GROUP BY
  hra.pmid
WITH
  DATA;