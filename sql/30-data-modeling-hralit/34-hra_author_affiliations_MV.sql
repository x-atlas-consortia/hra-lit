-- View: hra_author_affiliations
DROP MATERIALIZED VIEW IF EXISTS hra_author_affiliations CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_author_affiliations TABLESPACE pg_default AS
SELECT
  hra.pmid,
  f.auth_id,
  f.affiliation,
  f.source,
  'isni:'::TEXT || f.identifier::TEXT AS identifier
FROM
  hra_author_aff f
  RIGHT JOIN hra_pmid hra ON hra.pmid::TEXT = f.pmid::TEXT
WHERE
  f.source::TEXT = 'ISNI'::TEXT
UNION
SELECT
  hra.pmid,
  h.auth_id,
  h.affiliation,
  h.source,
  h.identifier
FROM
  hra_author_aff h
  RIGHT JOIN hra_pmid hra ON hra.pmid::TEXT = h.pmid::TEXT
WHERE
  h.source::TEXT <> 'ISNI'::TEXT
UNION
SELECT
  hra.pmid,
  h.auth_id,
  h.affiliation,
  h.source,
  h.identifier
FROM
  hra_author_aff h
  RIGHT JOIN hra_pmid hra ON hra.pmid::TEXT = h.pmid::TEXT
WHERE
  h.source::TEXT IS NULL
WITH
  DATA;