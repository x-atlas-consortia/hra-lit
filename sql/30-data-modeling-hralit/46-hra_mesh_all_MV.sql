-- View: hra_mesh_all
DROP MATERIALIZED VIEW IF EXISTS hra_mesh_all CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_mesh_all TABLESPACE pg_default AS
SELECT
  pml.pmid,
  ARRAY_AGG('http://id.nlm.nih.gov/mesh/'::TEXT || mh.ui::TEXT) AS about
FROM
  hra_pmid pml
  LEFT JOIN medline_mesh_heading mh ON pml.pmid::TEXT = mh.pmid::TEXT
GROUP BY
  pml.pmid
WITH
  DATA;