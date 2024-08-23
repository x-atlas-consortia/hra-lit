-- View: hraa 

DROP MATERIALIZED VIEW IF EXISTS hraa;

CREATE MATERIALIZED VIEW IF NOT EXISTS hraa
TABLESPACE pg_default
AS
 SELECT DISTINCT 'https://identifiers.org/pubmed:'::text || pml.pmid::text AS "@id",
    'ScholarlyArticle'::text AS "@type",
    'PMID:'::text || pml.pmid::text AS identifier,
    att.title AS name,
    ad.date_published AS "datePublished",
    ab.abstract,
    array_agg(DISTINCT au.ident) AS author,
    array_agg(DISTINCT jid."@id") AS "isPartOf",
    a.pagination,
    ei.doi AS "sameAs",
    mh.about
   FROM hra_pmid pml
     LEFT JOIN medline_publicationtype pt ON pml.pmid::text = pt.pmid::text
     LEFT JOIN medline_master a ON pml.pmid::text = a.pmid::text
     LEFT JOIN hra_titles att ON pml.pmid::text = att.pmid::text
     LEFT JOIN hra_dates ad ON pml.pmid::text = ad.pmid::text
     LEFT JOIN hra_abs ab ON pml.pmid::text = ab.pmid::text
     LEFT JOIN hra_authors au ON pml.pmid::text = au.pmid::text
     LEFT JOIN hra_jid jid ON pml.pmid::text = jid.pmid::text
     LEFT JOIN hra_doi ei ON pml.pmid::text = ei.pmid::text
     LEFT JOIN hra_mesh_all mh ON pml.pmid::text = mh.pmid::text
  WHERE pml.pmid::text = a.pmid::text AND pt.publicationtype::text = 'Journal Article'::text 
    AND (pt.publicationtype::text <> ALL (ARRAY['Published Erratum'::character varying, 'Retraction of Publication'::character varying, 'Editorial'::character varying, 'News'::character varying, 'Newspaper Article'::character varying, 'Comment'::character varying]::text[]))
  GROUP BY pml.pmid, att.title, ad.date_published, ab.abstract, a.pagination, ei.doi, mh.about
WITH DATA;