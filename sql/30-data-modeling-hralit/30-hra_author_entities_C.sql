-- View: hra_author_names
DROP MATERIALIZED VIEW IF EXISTS hra_author_names CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_author_names TABLESPACE pg_default AS
SELECT
  hra.pmid,
  ROW (a_1.pmid, a_1.author_ctr)::TEXT AS auth_id,
  (a_1.fore_name::TEXT || ' '::TEXT || a_1.last_name::TEXT)::CHARACTER VARYING AS NAME,
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

-- View: hra_author_id
DROP MATERIALIZED VIEW IF EXISTS hra_author_id CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_author_id TABLESPACE pg_default AS
SELECT DISTINCT
  ON (a.name, a.orcid) '#person_'::TEXT || ROW_NUMBER() OVER () AS ident,
  a.name,
  a.orcid
FROM
  hra_author_names a
WHERE
  a.author_type::TEXT = 'Person'::TEXT
UNION
SELECT DISTINCT
  ON (a.name, a.orcid) '#organization_'::TEXT || ROW_NUMBER() OVER () AS ident,
  a.name,
  a.orcid
FROM
  hra_author_names a
WHERE
  a.author_type::TEXT = 'Organization'::TEXT
WITH
  DATA;

-- View: hra_authors
DROP MATERIALIZED VIEW IF EXISTS hra_authors CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_authors TABLESPACE pg_default AS
SELECT
  hra.pmid,
  hra.auth_id,
  i.ident,
  hra.name,
  hra.initials,
  hra.fore_name,
  hra.last_name,
  hra.suffix,
  hra.orcid,
  hra.author_type
FROM
  hra_author_names hra
  LEFT JOIN hra_author_id i ON hra.name::TEXT = i.name::TEXT
  AND hra.orcid = i.orcid
WHERE
  hra.orcid IS NOT NULL
  AND i.orcid IS NOT NULL
UNION
SELECT
  hra.pmid,
  hra.auth_id,
  i.ident,
  hra.name,
  hra.initials,
  hra.fore_name,
  hra.last_name,
  hra.suffix,
  hra.orcid,
  hra.author_type
FROM
  hra_author_names hra
  LEFT JOIN hra_author_id i ON hra.name::TEXT = i.name::TEXT
WHERE
  hra.orcid IS NULL
  AND i.orcid IS NULL
WITH
  DATA;

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
  ml_author_aff f
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
  ml_author_aff h
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
  ml_author_aff h
  RIGHT JOIN hra_pmid hra ON hra.pmid::TEXT = h.pmid::TEXT
WHERE
  h.source::TEXT IS NULL
WITH
  DATA;