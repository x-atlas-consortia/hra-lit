-- View: hram
DROP MATERIALIZED VIEW IF EXISTS hram;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hram TABLESPACE pg_default AS
SELECT DISTINCT
  id AS "@id",
  'http://id.nlm.nih.gov/mesh/vocab#TopicalDescriptor'::TEXT AS "@type",
  NAME
FROM
  hra_mesh_terms
WITH
  DATA;