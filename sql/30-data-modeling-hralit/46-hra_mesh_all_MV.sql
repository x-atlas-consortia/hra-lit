-- View: hra_mesh_all
DROP MATERIALIZED VIEW IF EXISTS hra_mesh_all CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_mesh_all
TABLESPACE pg_default
AS
 SELECT pml.pmid,
    array_agg('http://id.nlm.nih.gov/mesh/'::text || mh.ui::text) AS about
   FROM hra_pmid pml
     LEFT JOIN medline_mesh_heading mh ON pml.pmid::text = mh.pmid::text
  GROUP BY pml.pmid
WITH DATA;