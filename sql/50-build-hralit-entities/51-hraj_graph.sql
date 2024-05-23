-- View: public.hraj - journal graph 
DROP MATERIALIZED VIEW IF EXISTS public.hraj;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hraj
TABLESPACE pg_default
AS
 SELECT hra_journals."@id",
    hra_journals."@type",
    hra_journals.identifier,
    hra_journals.name,
    hra_journals."alternateName",
    hra_journals.country,
    hra_journals.issn,
    hra_journals."publicationDate",
    hra_journals.publisher,
    hra_journals."volumeNumber",
    hra_journals."issueNumber",
    hra_journals."pageStart",
    hra_journals."pageEnd",
    hra_journals."isPartOf",
    hra_journals."hasPart"
   FROM hra_journals
UNION
 SELECT hra_jvol."@id",
    hra_jvol."@type",
    hra_jvol.identifier,
    hra_jvol.name,
    hra_jvol."alternateName",
    hra_jvol.country,
    hra_jvol.issn,
    hra_jvol."publicationDate",
    hra_jvol.publisher,
    hra_jvol."volumeNumber",
    hra_jvol."issueNumber",
    hra_jvol."pageStart",
    hra_jvol."pageEnd",
    hra_jvol."isPartOf",
    hra_jvol."hasPart"
   FROM hra_jvol
UNION
 SELECT hra_jiss."@id",
    hra_jiss."@type",
    hra_jiss.identifier,
    hra_jiss.name,
    hra_jiss."alternateName",
    hra_jiss.country,
    hra_jiss.issn,
    hra_jiss."publicationDate",
    hra_jiss.publisher,
    hra_jiss."volumeNumber",
    hra_jiss."issueNumber",
    hra_jiss."pageStart",
    hra_jiss."pageEnd",
    hra_jiss."isPartOf",
    hra_jiss."hasPart"
   FROM hra_jiss
  ORDER BY 3
WITH DATA;