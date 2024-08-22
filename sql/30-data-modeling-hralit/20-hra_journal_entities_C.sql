-- View: public.hra_jparts
DROP MATERIALIZED VIEW IF EXISTS public.hra_jparts CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_jparts
TABLESPACE pg_default
AS
 SELECT DISTINCT a.journal_nlmuniqueid,
   array_agg(DISTINCT REPLACE(('https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text || '_'::text || a.volume::text),' ', '%20')) AS has_part
 FROM medline_master a
   RIGHT JOIN hra_pmid hra ON a.pmid::text = hra.pmid::text
 GROUP BY a.journal_nlmuniqueid
WITH DATA;

-- View: public.hra_journals
DROP MATERIALIZED VIEW IF EXISTS public.hra_journals CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_journals
TABLESPACE pg_default
AS
 WITH pm_journals AS (
         SELECT DISTINCT a_1.journal_nlmuniqueid,
            a_1.issn
           FROM medline_master a_1
          WHERE a_1.issn IS NOT NULL
        UNION
         SELECT DISTINCT c.journal_nlmuniqueid,
            c.journal_issnlinking AS issn
           FROM medline_master c
          WHERE c.journal_issnlinking IS NOT NULL
  ORDER BY 1
        )
 SELECT DISTINCT 'https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text AS "@id",
    'Periodical'::text AS "@type",
    a.journal_nlmuniqueid AS identifier,
    a.journal_title AS name,
    a.journal_medline_ta AS "alternateName",
    a.journal_country AS country,
    array_agg(DISTINCT pmj.issn) AS issn,
    NULL::date AS "publicationDate",
    NULL::character varying AS publisher,
    NULL::character varying AS "volumeNumber",
    NULL::character varying AS "issueNumber",
    NULL::character varying AS "pageStart",
    NULL::character varying AS "pageEnd",
    NULL::text AS "isPartOf",
    prt.has_part AS "hasPart"
   FROM medline_master a
     RIGHT JOIN hra_pmid hra ON a.pmid::text = hra.pmid::text
     LEFT JOIN pm_journals pmj ON a.journal_nlmuniqueid::text = pmj.journal_nlmuniqueid::text
     LEFT JOIN hra_jparts prt ON a.journal_nlmuniqueid::text = prt.journal_nlmuniqueid::text
  GROUP BY a.journal_nlmuniqueid, a.journal_title, a.journal_medline_ta, a.journal_country, prt.has_part
  ORDER BY a.journal_nlmuniqueid
WITH DATA;

-- View: public.hra_vparts
DROP MATERIALIZED VIEW IF EXISTS public.hra_vparts CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_vparts
TABLESPACE pg_default
AS
 SELECT DISTINCT REPLACE((a.journal_nlmuniqueid::text || '_'::text || a.volume::text),' ','%20') AS volume_id,
   array_agg(DISTINCT REPLACE(('https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text || '_'::text || a.volume::text || '_'::text || a.issue::text),' ','%20')) AS has_part
 FROM medline_master a
     RIGHT JOIN hra_pmid hra ON a.pmid::text = hra.pmid::text
 WHERE a.volume IS NOT NULL AND ((((a.journal_nlmuniqueid::text || '_'::text) || a.volume::text) || '_'::text) || a.issue::text) IS NOT NULL
 GROUP BY ((a.journal_nlmuniqueid::text || '_'::text) || a.volume::text)
WITH DATA;

-- View: public.hra_jvol
DROP MATERIALIZED VIEW IF EXISTS public.hra_jvol CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_jvol
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

-- View: public.hra_jiss
DROP MATERIALIZED VIEW IF EXISTS public.hra_jiss CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_jiss
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