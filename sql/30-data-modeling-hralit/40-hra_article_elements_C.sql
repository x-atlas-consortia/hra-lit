-- view: hra_jid - Journal Entity Identifiers for articles
DROP MATERIALIZED VIEW IF EXISTS hra_jid CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_jid
TABLESPACE pg_default
AS
 WITH jid AS (
         SELECT DISTINCT a.pmid,
            normalize_id(a.journal_nlmuniqueid::text) AS id,
            'Periodical'::text AS type,
            a.journal_nlmuniqueid AS identifier
           FROM medline_master a
        UNION
         SELECT DISTINCT a.pmid,
            normalize_id(a.journal_nlmuniqueid::text || '_'::text || a.volume::text) AS id,
            'PublicationVolume'::text AS type,
            a.journal_nlmuniqueid::text || '_'::text || a.volume::text) AS identifier
           FROM medline_master a
        UNION
         SELECT DISTINCT a.pmid,
            normalize_id(a.journal_nlmuniqueid::text) || '_'::text || a.volume::text || '_'::text || a.issue::text) AS id,
            'PublicationIssue'::text AS type,
            a.journal_nlmuniqueid::text || '_'::text || a.volume::text || '_'::text || a.issue::text AS identifier
           FROM medline_master a
        )
 SELECT jid.pmid,
    jid.id AS "@id",
    jid.type AS "@type",
    jid.identifier
   FROM jid
     LEFT JOIN medline_article_date ad ON jid.pmid::text = ad.pmid::text
  WHERE ad.article_year::integer > 2009 AND jid.identifier IS NOT NULL
WITH DATA;

-- View: hra_titles
DROP MATERIALIZED VIEW IF EXISTS hra_titles CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_titles
TABLESPACE pg_default
AS
 SELECT hra.pmid,
    a.article_title AS title
   FROM hra_pmid hra
     LEFT JOIN medline_master a ON hra.pmid::text = a.pmid::text
  WHERE a.article_title IS NOT NULL
UNION
 SELECT hra.pmid,
    a.vernacular_title AS title
   FROM hra_pmid hra
     LEFT JOIN medline_master a ON hra.pmid::text = a.pmid::text
  WHERE a.article_title IS NULL AND a.vernacular_title IS NOT NULL
WITH DATA;

-- View: hra_abs
DROP MATERIALIZED VIEW IF EXISTS hra_abs CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_abs
TABLESPACE pg_default
AS
	WITH abs AS (
		SELECT * 
		FROM medline_abstract_text AS a
		ORDER BY a.pmid, a.abstract_ctr::integer
	)

	SELECT hra.pmid,
		   string_agg(abs.abstract_ctr::text, ' '::text) AS abstract_ct,
		   string_agg(abs.abstract_text::text, ' '::text) AS abstract
	FROM hra_pmid2 hra
	LEFT JOIN abs abs ON hra.pmid::text = abs.pmid::text
	GROUP BY hra.pmid
WITH DATA;

-- View: hra_dates
DROP MATERIALIZED VIEW IF EXISTS hra_dates CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_dates
AS
SELECT pml.pmid, 
	to_date((ad.article_year||'_'||ad.article_month||'_'||ad.article_day), 'YYYY-MM-DD') AS "date_published"
FROM hra_pmid AS pml 
LEFT JOIN medline_article_date AS ad 
	ON (pml.pmid = ad.pmid)
WITH DATA;

-- View: hra_doi
DROP MATERIALIZED VIEW IF EXISTS hra_doi CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_doi
TABLESPACE pg_default
AS
 SELECT pml.pmid,
    'https://doi.org/'::text || ei.elocation::text AS doi
   FROM hra_pmid pml
     LEFT JOIN medline_elocationid ei ON pml.pmid::text = ei.pmid::text
  WHERE ei.eid_type::text = 'doi'::text AND ei.eid_valid::text = 'Y'::text
WITH DATA;

-- View: hra_mesh_all
DROP MATERIALIZED VIEW IF EXISTS hra_mesh_all CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS hra_mesh_all
TABLESPACE pg_default
AS
 SELECT pml.pmid,
    array_agg('http://id.nlm.nih.gov/mesh/'::text || mh.ui::text) AS about
   FROM hra_pmid pml
     LEFT JOIN medline_mesh_heading mh ON pml.pmid::text = mh.pmid::text
  GROUP BY pml.pmid
WITH DATA;