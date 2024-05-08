-- View: public.hra_jiss
DROP MATERIALIZED VIEW IF EXISTS public.hra_jiss CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_jiss
TABLESPACE pg_default
AS
 SELECT DISTINCT (((('https://perl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text) || '_'::text) || a.volume::text) || '_'::text) || a.issue::text AS "@id",
    'PublicationIssue'::text AS "@type",
    (((a.journal_nlmuniqueid::text || '_'::text) || a.volume::text) || '_'::text) || a.issue::text AS identifier,
    NULL::character varying AS name,
    NULL::character varying AS "alternateName",
    NULL::character varying AS country,
    NULL::character varying[] AS issn,
    NULL::date AS "publicationDate",
    NULL::character varying AS publisher,
    NULL::character varying AS "volumeNumber",
    a.issue AS "issueNumber",
    NULL::character varying AS "pageStart",
    NULL::character varying AS "pageEnd",
    (('https://perl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text) || '_'::text) || a.volume::text AS "isPartOf",
    NULL::text[] AS "hasPart"
   FROM medline_master a
     RIGHT JOIN hra_pmid hra ON a.pmid::text = hra.pmid::text
  WHERE a.issue IS NOT NULL
  ORDER BY ((('https://perl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text) || '_'::text) || a.volume::text)
WITH DATA;