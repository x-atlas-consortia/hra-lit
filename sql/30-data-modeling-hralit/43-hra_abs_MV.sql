-- View: hra_abs
DROP MATERIALIZED VIEW IF EXISTS hra_abs CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_abs TABLESPACE pg_default AS
WITH
  ABS AS (
    SELECT
      a.pmid,
      abstract_ctr,
      abstract_text
    FROM
      medline_abstract_text AS a
      RIGHT JOIN hra_pmid hra ON a.pmid::TEXT = hra.pmid::TEXT
    ORDER BY
      a.pmid,
      a.abstract_ctr::INTEGER
  )
SELECT
  hra.pmid,
  STRING_AGG(abstract_ctr::TEXT, ' '::TEXT) AS abstract_ct,
  STRING_AGG(abstract_text::TEXT, ' '::TEXT) AS abstract
FROM
  hra_pmid hra
  LEFT JOIN ABS ON hra.pmid::TEXT = ABS.pmid::TEXT
GROUP BY
  hra.pmid
WITH
  DATA;