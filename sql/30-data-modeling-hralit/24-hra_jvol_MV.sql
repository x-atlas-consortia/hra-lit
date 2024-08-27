-- View: hra_jvol
DROP MATERIALIZED VIEW IF EXISTS hra_jvol CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_jvol TABLESPACE pg_default AS
SELECT DISTINCT
  normalize_id ('JV-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT) AS "@id",
  'PublicationVolume'::TEXT AS "@type",
  normalize_identifier ('JV-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT) AS identifier,
  NULL::CHARACTER VARYING AS NAME,
  NULL::CHARACTER VARYING AS "alternateName",
  NULL::CHARACTER VARYING AS country,
  NULL::CHARACTER VARYING[] AS issn,
  NULL::date AS "publicationDate",
  NULL::CHARACTER VARYING AS publisher,
  a.volume AS "volumeNumber",
  NULL::CHARACTER VARYING AS "issueNumber",
  NULL::CHARACTER VARYING AS "pageStart",
  NULL::CHARACTER VARYING AS "pageEnd",
  normalize_id ('J-'::TEXT || a.journal_nlmuniqueid::TEXT) AS "isPartOf",
  vpt.has_part AS "hasPart"
FROM
  medline_master a
  RIGHT JOIN hra_pmid hra ON a.pmid::TEXT = hra.pmid::TEXT
  LEFT JOIN hra_vparts vpt ON ('JV-'::TEXT || a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT) = vpt.volume_id
WHERE
  a.volume IS NOT NULL
ORDER BY
  normalize_id ('J-'::TEXT || a.journal_nlmuniqueid::TEXT),
  a.volume
WITH
  DATA;