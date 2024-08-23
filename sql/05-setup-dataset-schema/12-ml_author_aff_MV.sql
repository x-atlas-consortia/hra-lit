-- View: ml_author_aff
DROP MATERIALIZED VIEW IF EXISTS ml_author_aff CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  ml_author_aff TABLESPACE pg_default AS
SELECT
  c.pmid,
  ROW (c.pmid, c.author_ctr)::TEXT AS auth_id,
  ROW (c.pmid, c.author_ctr, c.affiliation_ctr)::TEXT AS aff_id,
  c.affiliation,
  g.source,
  g.identifier
FROM
  medline_author_affiliation c
  LEFT JOIN medline_author_affiliation_identifier g ON ROW (c.pmid, c.author_ctr, c.affiliation_ctr)::TEXT = ROW (g.pmid, g.author_ctr, g.affiliation_ctr)::TEXT
WHERE
  (
    g.source::TEXT = ANY (ARRAY['GRID'::CHARACTER VARYING::TEXT, 'ISNI'::CHARACTER VARYING::TEXT, 'ROR'::CHARACTER VARYING::TEXT])
  )
  OR g.source IS NULL
WITH
  DATA;

CREATE INDEX ON ml_author_aff ((pmid::TEXT));