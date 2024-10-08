-- View: hra_pmid
DROP MATERIALIZED VIEW IF EXISTS hra_pmid CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_pmid TABLESPACE pg_default AS
WITH
  pm1 AS (
    SELECT DISTINCT
      mh.pmid
    FROM
      medline_mesh_heading mh
      RIGHT JOIN hra_meshd_anatomy hra ON mh.ui::TEXT = hra.ui::TEXT
    WHERE
      mh.pmid IS NOT NULL
  )
SELECT DISTINCT
  pm1.pmid,
  dat.article_year
FROM
  pm1 AS pm1
  LEFT JOIN medline_article_date AS dat ON pm1.pmid = dat.pmid
WHERE
  dat.article_year::INTEGER > 1899
  -- AND dat. -- KEEP ONLY RESEARCH ARTICLES --
ORDER BY
  dat.article_year DESC
WITH
  DATA;

CREATE INDEX ON hra_pmid ((pmid::TEXT));