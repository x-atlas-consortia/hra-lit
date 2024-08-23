-- View: hra_jiss
DROP MATERIALIZED VIEW IF EXISTS hra_jiss CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_jiss TABLESPACE pg_default AS
SELECT DISTINCT
  normalize_id (a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT || '_'::TEXT || a.issue::TEXT) AS "@id",
  'PublicationIssue'::TEXT AS "@type",
  normalize_identifier (a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT || '_'::TEXT || a.issue::TEXT) AS identifier,
  NULL::CHARACTER VARYING AS NAME,
  NULL::CHARACTER VARYING AS "alternateName",
  NULL::CHARACTER VARYING AS country,
  NULL::CHARACTER VARYING[] AS issn,
  NULL::date AS "publicationDate",
  NULL::CHARACTER VARYING AS publisher,
  NULL::CHARACTER VARYING AS "volumeNumber",
  a.issue AS "issueNumber",
  NULL::CHARACTER VARYING AS "pageStart",
  NULL::CHARACTER VARYING AS "pageEnd",
  normalize_id (a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT) AS "isPartOf",
  NULL::TEXT[] AS "hasPart"
FROM
  medline_master a
  RIGHT JOIN hra_pmid hra ON a.pmid::TEXT = hra.pmid::TEXT
WHERE
  a.issue IS NOT NULL
ORDER BY
  normalize_id (a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT)
WITH
  DATA;