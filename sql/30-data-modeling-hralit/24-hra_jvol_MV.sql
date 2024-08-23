-- View: hra_jvol
DROP MATERIALIZED VIEW IF EXISTS hra_jvol CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_jvol
TABLESPACE pg_default
AS
 SELECT DISTINCT REPLACE(('https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text || '_'::text || a.volume::text),' ','%20') AS "@id",
    'PublicationVolume'::text AS "@type",
    (a.journal_nlmuniqueid::text || '_'::text) || a.volume::text AS identifier,
    NULL::character varying AS name,
    NULL::character varying AS "alternateName",
    NULL::character varying AS country,
    NULL::character varying[] AS issn,
    NULL::date AS "publicationDate",
    NULL::character varying AS publisher,
    a.volume AS "volumeNumber",
    NULL::character varying AS "issueNumber",
    NULL::character varying AS "pageStart",
    NULL::character varying AS "pageEnd",
    'https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text AS "isPartOf",
    vpt.has_part AS "hasPart"
   FROM medline_master a
     RIGHT JOIN hra_pmid hra ON a.pmid::text = hra.pmid::text
     LEFT JOIN hra_vparts vpt ON ((a.journal_nlmuniqueid::text || '_'::text) || a.volume::text) = vpt.volume_id
  WHERE a.volume IS NOT NULL
  ORDER BY ('https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text), a.volume
WITH DATA;