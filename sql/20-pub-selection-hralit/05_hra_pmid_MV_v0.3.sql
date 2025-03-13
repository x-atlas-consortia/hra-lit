-- View: hra_pmid
DROP MATERIALIZED VIEW IF EXISTS hra_pmid CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_pmid TABLESPACE pg_default AS
WITH
  pml AS (
    SELECT DISTINCT
      mh.pmid
    FROM
      medline_mesh_heading mh
      RIGHT JOIN hra_meshd_anatomy hra ON mh.ui::TEXT = hra.ui::TEXT
    WHERE
      mh.pmid IS NOT NULL
  )
SELECT DISTINCT
  pml.pmid,
  COALESCE(dat.article_year, mas.pub_year)::INTEGER AS article_year
FROM
  pml AS pml
  INNER JOIN medline_master AS mas ON pml.pmid = mas.pmid
  LEFT JOIN medline_article_date AS dat ON pml.pmid = dat.pmid
  LEFT JOIN medline_publicationtype pt ON pml.pmid::TEXT = pt.pmid::TEXT
WHERE
  pt.publicationtype::TEXT = 'Journal Article'::TEXT
  AND (
    pt.publicationtype::TEXT <> ALL (
      ARRAY[
        'Published Erratum'::CHARACTER VARYING,
        'Retraction of Publication'::CHARACTER VARYING,
        'Editorial'::CHARACTER VARYING,
        'News'::CHARACTER VARYING,
        'Newspaper Article'::CHARACTER VARYING,
        'Comment'::CHARACTER VARYING
      ]::TEXT[]
    )
  )
ORDER BY
  article_year DESC
WITH
  DATA;

CREATE INDEX ON hra_pmid ((pmid::TEXT));