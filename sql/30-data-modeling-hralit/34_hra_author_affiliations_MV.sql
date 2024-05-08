-- View: public.hra_author_affiliations
DROP MATERIALIZED VIEW IF EXISTS public.hra_author_affiliations CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_author_affiliations
TABLESPACE pg_default
AS
 SELECT hra.pmid,
    f.auth_id,
    f.affiliation,
    f.source,
    'isni:'::text || f.identifier::text AS identifier
   FROM ml_author_aff f
     RIGHT JOIN hra_pmid hra ON hra.pmid::text = f.pmid::text
  WHERE f.source::text = 'ISNI'::text
UNION
 SELECT hra.pmid,
    h.auth_id,
    h.affiliation,
    h.source,
    h.identifier
   FROM ml_author_aff h
     RIGHT JOIN hra_pmid hra ON hra.pmid::text = h.pmid::text
  WHERE h.source::text <> 'ISNI'::text
UNION
 SELECT hra.pmid,
    h.auth_id,
    h.affiliation,
    h.source,
    h.identifier
   FROM ml_author_aff h
     RIGHT JOIN hra_pmid hra ON hra.pmid::text = h.pmid::text
  WHERE h.source::text IS NULL
WITH DATA;
