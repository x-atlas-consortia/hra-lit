-- View: hra_doi
DROP MATERIALIZED VIEW IF EXISTS hra_doi CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_doi TABLESPACE pg_default AS
SELECT
  pml.pmid,
  'https://doi.org/'::TEXT || ei.elocation::TEXT AS doi
FROM
  hra_pmid pml
  LEFT JOIN medline_elocationid ei ON pml.pmid::TEXT = ei.pmid::TEXT
WHERE
  ei.eid_type::TEXT = 'doi'::TEXT
  AND ei.eid_valid::TEXT = 'Y'::TEXT
WITH
  DATA;