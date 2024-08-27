-- View: hra_mesh_terms
DROP MATERIALIZED VIEW IF EXISTS hra_mesh_all CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_mesh_terms TABLESPACE pg_default AS
SELECT DISTINCT
  ('http://id.nlm.nih.gov/mesh/'::TEXT || mh.ui::TEXT) AS id,
  mh.descriptor_name as NAME
FROM
  hra_pmid pml
  LEFT JOIN medline_mesh_heading mh ON pml.pmid::TEXT = mh.pmid::TEXT
WITH
  DATA;
