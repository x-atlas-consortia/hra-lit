-- View: hrao
DROP MATERIALIZED VIEW IF EXISTS hrao; 

CREATE MATERIALIZED VIEW IF NOT EXISTS hrao
TABLESPACE pg_default
AS
 SELECT DISTINCT ON (a.ident) a.ident AS "@id",
    a.name,
    a.author_type AS "@type"
   FROM hra_authors a
  WHERE a.author_type::text = 'Organization'::text
WITH DATA;