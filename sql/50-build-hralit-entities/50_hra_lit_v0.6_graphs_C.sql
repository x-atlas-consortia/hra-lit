-- View: public.hrap - person graph
DROP MATERIALIZED VIEW IF EXISTS public.hrap;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.hrap
TABLESPACE pg_default
AS
 SELECT DISTINCT ON (a.ident) a.ident AS "@id",
    replace(a.orcid, 'https://orcid.org/'::text, 'orcid:'::text) AS identifier,
    a.name,
    a.fore_name AS "givenName",
    a.last_name AS "familyName",
    a.suffix AS "honorificSuffix",
    a.author_type AS "@type",
    a.orcid AS "sameAs",
    array_agg(DISTINCT g.affiliation) AS affiliation,
    array_agg(DISTINCT g.identifier) AS aff_id
   FROM hra_authors a
     LEFT JOIN hra_author_affiliations g ON a.auth_id = g.auth_id
  WHERE a.author_type::text = 'Person'::text
  GROUP BY a.ident, a.name, a.initials, a.fore_name, a.last_name, a.suffix, a.author_type, a.orcid
WITH DATA

-- view: hrao - organization graph
DROP MATERIALIZED VIEW IF EXISTS public.hrao;

CREATE MATERIALIZED VIEW hrao AS
SELECT DISTINCT ON (ident)
    a.ident AS "@id",
    a.name AS "name",
    a.author_type AS "@type"
FROM public.hra_authors AS a
WHERE a.author_type = 'Organization';

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

-- view: hraa - article graph
DROP MATERIALIZED VIEW IF EXISTS public.hraa;

CREATE MATERIALIZED VIEW hraa AS
SELECT DISTINCT
	'https://identifiers.org/pubmed:'||pml.pmid AS "@id",
	'ScholarlyArticle' as "@type",
	'PMID:' || pml.pmid AS identifier,
	att.title AS "name",
	ad.date_published AS "datePublished",
	ab.abstract AS "abstract",
	ARRAY_AGG(DISTINCT(au.ident)) AS "author",
	ARRAY_AGG(DISTINCT(jid."@id"::text)) AS "isPartOf",
	a.pagination AS "pagination",
	ei.doi AS "sameAs",
	mh.about AS "about"
FROM public.hra_pmid AS pml
LEFT JOIN public.medline_publicationtype AS pt
	ON (pml.pmid = pt.pmid)
LEFT JOIN public.medline_master AS a 
	ON (pml.pmid = a.pmid)
LEFT JOIN public.hra_titles AS att
	ON (pml.pmid = att.pmid)	
LEFT JOIN public.hra_dates AS ad 
	ON (pml.pmid = ad.pmid)
LEFT JOIN public.hra_abs AS ab
	ON (pml.pmid = ab.pmid)
LEFT JOIN public.hra_authors AS au
	ON (pml.pmid = au.pmid)
LEFT JOIN public.hra_jid AS jid
	ON (pml.pmid = jid.pmid)
LEFT JOIN public.hra_doi AS ei
	ON (pml.pmid= ei.pmid)
LEFT JOIN public.hra_mesh_all AS mh
	ON (pml.pmid = mh.pmid)
WHERE pml.pmid = a.pmid
  AND pt.publicationtype = 'Journal Article'
  AND pt.publicationtype NOT IN ('Published Erratum','Retraction of Publication','Editorial','News','Newspaper Article','Comment') 
GROUP BY pml.pmid, att.title, ad.date_published, ab.abstract, a.pagination, ei.doi, mh.about;
