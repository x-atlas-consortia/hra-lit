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