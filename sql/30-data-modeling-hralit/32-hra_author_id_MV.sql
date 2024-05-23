-- View: public.hra_author_id
DROP MATERIALIZED VIEW IF EXISTS public.hra_author_id CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_author_id
TABLESPACE pg_default
AS
 SELECT DISTINCT ON (a.name, a.orcid) 'https://perl.humanatlas.io/graph/hra-lit/v0.6#person_'::text || row_number() OVER () AS ident,
    a.name,
    a.orcid
   FROM hra_author_names a
  WHERE a.author_type::text = 'Person'::text
UNION
 SELECT DISTINCT ON (a.name, a.orcid) 'https://perl.humanatlas.io/graph/hra-lit/v0.6#organization_'::text || row_number() OVER () AS ident,
    a.name,
    a.orcid
   FROM hra_author_names a
  WHERE a.author_type::text = 'Organization'::text
WITH DATA;