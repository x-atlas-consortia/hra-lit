-- View: hra_author_names
DROP MATERIALIZED VIEW IF EXISTS hra_author_names CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_author_names TABLESPACE pg_default AS
SELECT
  hra.pmid,
  ROW (a_1.pmid, a_1.author_ctr)::TEXT AS auth_id,
  ((a_1.fore_name::TEXT || ' '::TEXT) || a_1.last_name::TEXT)::CHARACTER VARYING AS NAME,
  'Person'::CHARACTER VARYING AS author_type,
  a_1.initials,
  a_1.fore_name,
  a_1.last_name,
  a_1.suffix,
  REPLACE(orc.identifier, 'http:'::TEXT, 'https:'::TEXT) AS orcid
FROM
  medline_author a_1
  RIGHT JOIN hra_pmid hra ON hra.pmid::TEXT = a_1.pmid::TEXT
  LEFT JOIN ml_author_orcid orc ON ROW (a_1.pmid, a_1.author_ctr)::TEXT = orc.auth_id
WHERE
  a_1.collective_name IS NULL
  AND a_1.author_valid::TEXT = 'Y'::TEXT
UNION
SELECT
  hra.pmid,
  ROW (a_2.pmid, a_2.author_ctr)::TEXT AS auth_id,
  a_2.collective_name AS NAME,
  'Organization'::CHARACTER VARYING AS author_type,
  a_2.initials,
  a_2.fore_name,
  a_2.last_name,
  a_2.suffix,
  NULL::TEXT AS orcid
FROM
  medline_author a_2
  RIGHT JOIN hra_pmid hra ON hra.pmid::TEXT = a_2.pmid::TEXT
WHERE
  a_2.last_name IS NULL
  AND a_2.author_valid::TEXT = 'Y'::TEXT
WITH
  DATA;