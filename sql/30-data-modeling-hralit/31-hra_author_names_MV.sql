-- View: public.hra_author_names

DROP MATERIALIZED VIEW IF EXISTS public.hra_author_names CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_author_names
TABLESPACE pg_default
AS
 SELECT hra.pmid,
    ROW(a_1.pmid, a_1.author_ctr)::text AS auth_id,
    ((a_1.fore_name::text || ' '::text) || a_1.last_name::text)::character varying AS name,
    'Person'::character varying AS author_type,
    a_1.initials,
    a_1.fore_name,
    a_1.last_name,
    a_1.suffix,
    replace(orc.identifier, 'http:'::text, 'https:'::text) AS orcid
   FROM medline_author a_1
     RIGHT JOIN hra_pmid hra ON hra.pmid::text = a_1.pmid::text
     LEFT JOIN ml_author_orcid orc ON ROW(a_1.pmid, a_1.author_ctr)::text = orc.auth_id
  WHERE a_1.collective_name IS NULL AND a_1.author_valid::text = 'Y'::text
UNION
 SELECT hra.pmid,
    ROW(a_2.pmid, a_2.author_ctr)::text AS auth_id,
    a_2.collective_name AS name,
    'Organization'::character varying AS author_type,
    a_2.initials,
    a_2.fore_name,
    a_2.last_name,
    a_2.suffix,
    NULL::text AS orcid
   FROM medline_author a_2
     RIGHT JOIN hra_pmid hra ON hra.pmid::text = a_2.pmid::text
  WHERE a_2.last_name IS NULL AND a_2.author_valid::text = 'Y'::text
WITH DATA;