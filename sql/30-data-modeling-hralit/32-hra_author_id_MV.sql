-- View: hra_author_id
DROP MATERIALIZED VIEW IF EXISTS hra_author_id CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_author_id TABLESPACE pg_default AS
SELECT DISTINCT
  ON (a.name, a.orcid) '#p-'::TEXT || ROW_NUMBER() OVER () AS ident,
  a.name,
  a.orcid
FROM
  hra_author_names a
WHERE
  a.author_type::TEXT = 'Person'::TEXT
UNION
SELECT DISTINCT
  ON (a.name, a.orcid) '#o-'::TEXT || ROW_NUMBER() OVER () AS ident,
  a.name,
  a.orcid
FROM
  hra_author_names a
WHERE
  a.author_type::TEXT = 'Organization'::TEXT
WITH
  DATA;