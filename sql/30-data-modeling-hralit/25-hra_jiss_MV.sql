-- View: hra_jiss
DROP MATERIALIZED VIEW IF EXISTS hra_jiss CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_jiss
TABLESPACE pg_default
AS
 SELECT DISTINCT REPLACE(('https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text || '_'::text || a.volume::text || '_'::text || a.issue::text), ' ', '%20') AS "@id",
    'PublicationIssue'::text AS "@type",
    REPLACE((a.journal_nlmuniqueid::text || '_'::text || a.volume::text || '_'::text || a.issue::text), ' ', '%20' ) AS identifier,
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
    REPLACE(('https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text || '_'::text || a.volume::text), ' ', '%20') AS "isPartOf",
    NULL::text[] AS "hasPart"
   FROM medline_master a
     RIGHT JOIN hra_pmid hra ON a.pmid::text = hra.pmid::text
  WHERE a.issue IS NOT NULL
  ORDER BY REPLACE(('https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text || '_'::text || a.volume::text), ' ', '%20') 
WITH DATA;