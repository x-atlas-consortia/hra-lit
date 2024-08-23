-- View: hrap 
DROP MATERIALIZED VIEW IF EXISTS hrap;

CREATE MATERIALIZED VIEW IF NOT EXISTS hrap
TABLESPACE pg_default
AS
 SELECT DISTINCT ON (a.ident) a.ident AS "@id",
    replace(a.orcid, 'https://orcid.org/'::text, 'orcid:'::text) AS identifier,
    a.name,
    a.fore_name AS "givenName",
    a.last_name AS "familyName",
    a.suffix AS "honorificSuffix",
    a.author_type AS "@type",
    a.orcid AS "url",
    array_agg(DISTINCT g.affiliation) AS affiliation,
    array_agg(DISTINCT g.identifier) AS aff_id
   FROM hra_authors a
     LEFT JOIN hra_author_affiliations g ON a.auth_id = g.auth_id
  WHERE a.author_type::text = 'Person'::text
  GROUP BY a.ident, a.name, a.initials, a.fore_name, a.last_name, a.suffix, a.author_type, a.orcid
WITH DATA;
