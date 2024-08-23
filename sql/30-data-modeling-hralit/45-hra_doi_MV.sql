-- View: hra_doi
DROP MATERIALIZED VIEW IF EXISTS hra_doi CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_doi
TABLESPACE pg_default
AS
 SELECT pml.pmid,
    'https://doi.org/'::text || ei.elocation::text AS doi
   FROM hra_pmid pml
     LEFT JOIN medline_elocationid ei ON pml.pmid::text = ei.pmid::text
  WHERE ei.eid_type::text = 'doi'::text AND ei.eid_valid::text = 'Y'::text
WITH DATA;