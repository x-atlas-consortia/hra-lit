-- View: hra_jid
DROP MATERIALIZED VIEW IF EXISTS hra_jid CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_jid TABLESPACE pg_default AS
WITH
  jid AS (
    SELECT DISTINCT
      a.pmid,
      normalize_id ('J-'::TEXT || a.journal_nlmuniqueid::TEXT) AS id,
      'Periodical'::TEXT AS
    TYPE,
    a.journal_nlmuniqueid AS identifier
    FROM
      medline_master a
      RIGHT JOIN hra_pmid hra ON a.pmid::TEXT = hra.pmid::TEXT
    UNION
    SELECT DISTINCT
      a.pmid,
      normalize_id ('JV-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT) AS id,
      'PublicationVolume'::TEXT AS
    TYPE,
    normalize_identifier ('JV-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT) AS identifier
    FROM
      medline_master a
      RIGHT JOIN hra_pmid hra ON a.pmid::TEXT = hra.pmid::TEXT
    UNION
    SELECT DISTINCT
      a.pmid,
      normalize_id ('JVI-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT || '_'::TEXT || a.issue::TEXT) AS id,
      'PublicationIssue'::TEXT AS
    TYPE,
    normalize_identifier ('JVI-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT || '_'::TEXT || a.issue::TEXT) AS identifier
    FROM
      medline_master a
      RIGHT JOIN hra_pmid hra ON a.pmid::TEXT = hra.pmid::TEXT
  )
SELECT
  jid.pmid,
  jid.id AS "@id",
  jid.type AS "@type",
  jid.identifier
FROM
  jid
  LEFT JOIN medline_article_date ad ON jid.pmid::TEXT = ad.pmid::TEXT
WHERE
  ad.article_year::INTEGER > 2009
  AND jid.identifier IS NOT NULL
WITH
  DATA;