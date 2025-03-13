-- View: hraa
DROP MATERIALIZED VIEW IF EXISTS hraa;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hraa TABLESPACE pg_default AS
SELECT DISTINCT
  'https://identifiers.org/pubmed:'::TEXT || pml.pmid::TEXT AS "@id",
  'ScholarlyArticle'::TEXT AS "@type",
  'PMID:'::TEXT || pml.pmid::TEXT AS identifier,
  att.title AS NAME,
  ad.date_published AS "datePublished",
  ab.abstract,
  ARRAY_AGG(DISTINCT au.ident) AS author,
  ARRAY_AGG(DISTINCT jid."@id") AS "isPartOf",
  a.pagination,
  ei.doi AS "sameAs",
  mh.about
FROM
  hra_pmid pml
  LEFT JOIN medline_publicationtype pt ON pml.pmid::TEXT = pt.pmid::TEXT
  LEFT JOIN medline_master a ON pml.pmid::TEXT = a.pmid::TEXT
  LEFT JOIN hra_titles att ON pml.pmid::TEXT = att.pmid::TEXT
  LEFT JOIN hra_dates ad ON pml.pmid::TEXT = ad.pmid::TEXT
  LEFT JOIN hra_abs ab ON pml.pmid::TEXT = ab.pmid::TEXT
  LEFT JOIN hra_authors au ON pml.pmid::TEXT = au.pmid::TEXT
  LEFT JOIN hra_jid jid ON pml.pmid::TEXT = jid.pmid::TEXT
  LEFT JOIN hra_doi ei ON pml.pmid::TEXT = ei.pmid::TEXT
  LEFT JOIN hra_mesh_all mh ON pml.pmid::TEXT = mh.pmid::TEXT
GROUP BY
  pml.pmid,
  att.title,
  ad.date_published,
  ab.abstract,
  a.pagination,
  ei.doi,
  mh.about
WITH
  DATA;