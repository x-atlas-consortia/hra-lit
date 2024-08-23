-- View: ml_author_aff
DROP MATERIALIZED VIEW IF EXISTS ml_author_aff CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS ml_author_aff
TABLESPACE pg_default
AS
 SELECT c.pmid,
    ROW(c.pmid, c.author_ctr)::text AS auth_id,
    ROW(c.pmid, c.author_ctr, c.affiliation_ctr)::text AS aff_id,
    c.affiliation,
    g.source,
    g.identifier
   FROM medline_author_affiliation c
     LEFT JOIN medline_author_affiliation_identifier g ON ROW(c.pmid, c.author_ctr, c.affiliation_ctr)::text = ROW(g.pmid, g.author_ctr, g.affiliation_ctr)::text
  WHERE (g.source::text = ANY (ARRAY['GRID'::character varying::text, 'ISNI'::character varying::text, 'ROR'::character varying::text])) OR g.source IS NULL
WITH DATA;

