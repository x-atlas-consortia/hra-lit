-- View: public.hra_jid
DROP MATERIALIZED VIEW IF EXISTS public.hra_jid CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hra_jid
TABLESPACE pg_default
AS
 WITH jid AS (
         SELECT DISTINCT a.pmid,
            'https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text AS id,
            'Periodical'::text AS type,
            a.journal_nlmuniqueid AS identifier
           FROM medline_master a
        UNION
         SELECT DISTINCT a.pmid,
            (('https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text) || '_'::text) || a.volume::text AS id,
            'PublicationVolume'::text AS type,
            (a.journal_nlmuniqueid::text || '_'::text) || a.volume::text AS identifier
           FROM medline_master a
        UNION
         SELECT DISTINCT a.pmid,
            (((('https://purl.humanatlas.io/graph/hra-lit/v0.6#'::text || a.journal_nlmuniqueid::text) || '_'::text) || a.volume::text) || '_'::text) || a.issue::text AS id,
            'PublicationIssue'::text AS type,
            (((a.journal_nlmuniqueid::text || '_'::text) || a.volume::text) || '_'::text) || a.issue::text AS identifier
           FROM medline_master a
        )
 SELECT jid.pmid,
    jid.id AS "@id",
    jid.type AS "@type",
    jid.identifier
   FROM jid
     LEFT JOIN medline_article_date ad ON jid.pmid::text = ad.pmid::text
  WHERE ad.article_year::integer > 2009 AND jid.identifier IS NOT NULL
WITH DATA;