-- View: hra_journals
DROP MATERIALIZED VIEW IF EXISTS hra_journals CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_journals TABLESPACE pg_default AS
WITH
  pm_journals AS (
    SELECT DISTINCT
      a_1.journal_nlmuniqueid,
      a_1.issn
    FROM
      medline_master a_1
    WHERE
      a_1.issn IS NOT NULL
    UNION
    SELECT DISTINCT
      c.journal_nlmuniqueid,
      c.journal_issnlinking AS issn
    FROM
      medline_master c
    WHERE
      c.journal_issnlinking IS NOT NULL
    ORDER BY
      1
  )
SELECT DISTINCT
  normalize_id (a.journal_nlmuniqueid::TEXT) AS "@id",
  'Periodical'::TEXT AS "@type",
  a.journal_nlmuniqueid AS identifier,
  a.journal_title AS NAME,
  a.journal_medline_ta AS "alternateName",
  a.journal_country AS country,
  ARRAY_AGG(DISTINCT pmj.issn) AS issn,
  NULL::date AS "publicationDate",
  NULL::CHARACTER VARYING AS publisher,
  NULL::CHARACTER VARYING AS "volumeNumber",
  NULL::CHARACTER VARYING AS "issueNumber",
  NULL::CHARACTER VARYING AS "pageStart",
  NULL::CHARACTER VARYING AS "pageEnd",
  NULL::TEXT AS "isPartOf",
  prt.has_part AS "hasPart"
FROM
  medline_master a
  RIGHT JOIN hra_pmid hra ON a.pmid::TEXT = hra.pmid::TEXT
  LEFT JOIN pm_journals pmj ON a.journal_nlmuniqueid::TEXT = pmj.journal_nlmuniqueid::TEXT
  LEFT JOIN hra_jparts prt ON a.journal_nlmuniqueid::TEXT = prt.journal_nlmuniqueid::TEXT
GROUP BY
  a.journal_nlmuniqueid,
  a.journal_title,
  a.journal_medline_ta,
  a.journal_country,
  prt.has_part
ORDER BY
  a.journal_nlmuniqueid
WITH
  DATA;