-- view: hra_jid - Journal Entity Identifiers for articles
DROP MATERIALIZED VIEW IF EXISTS hra_jid CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_jid TABLESPACE pg_default AS
WITH
  jid AS (
    SELECT DISTINCT
      a.pmid,
      normalize_id (a.journal_nlmuniqueid::TEXT) AS id,
      'Periodical'::TEXT AS
    TYPE,
    a.journal_nlmuniqueid AS identifier
    FROM
      medline_master a
    UNION
    SELECT DISTINCT
      a.pmid,
      normalize_id (a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT) AS id,
      'PublicationVolume'::TEXT AS
    TYPE,
    normalize_identifier (a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT) AS identifier
    FROM
      medline_master a
    UNION
    SELECT DISTINCT
      a.pmid,
      normalize_id (a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT || '_'::TEXT || a.issue::TEXT) AS id,
      'PublicationIssue'::TEXT AS
    TYPE,
    normalize_identifier (a.journal_nlmuniqueid::TEXT || '_'::TEXT || a.volume::TEXT || '_'::TEXT || a.issue::TEXT) AS identifier
    FROM
      medline_master a
  )
SELECT
  jid.pmid,
  jid.id AS "@id",
  jid.type AS "@type",
  jid.identifier
FROM
  jid
  LEFT JOIN medline_article_date ad ON jid.pmid::TEXT = ad.pmid::TEXT
WHERE
  ad.article_year::INTEGER > 2009
  AND jid.identifier IS NOT NULL
WITH
  DATA;

-- View: hra_titles
DROP MATERIALIZED VIEW IF EXISTS hra_titles CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_titles TABLESPACE pg_default AS
SELECT
  hra.pmid,
  a.article_title AS title
FROM
  hra_pmid hra
  LEFT JOIN medline_master a ON hra.pmid::TEXT = a.pmid::TEXT
WHERE
  a.article_title IS NOT NULL
UNION
SELECT
  hra.pmid,
  a.vernacular_title AS title
FROM
  hra_pmid hra
  LEFT JOIN medline_master a ON hra.pmid::TEXT = a.pmid::TEXT
WHERE
  a.article_title IS NULL
  AND a.vernacular_title IS NOT NULL
WITH
  DATA;

-- View: hra_abs
DROP MATERIALIZED VIEW IF EXISTS hra_abs CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_abs TABLESPACE pg_default AS
WITH
  ABS AS (
    SELECT
      *
    FROM
      medline_abstract_text AS a
    ORDER BY
      a.pmid,
      a.abstract_ctr::INTEGER
  )
SELECT
  hra.pmid,
  STRING_AGG(ABS.abstract_ctr::TEXT, ' '::TEXT) AS abstract_ct,
  STRING_AGG(ABS.abstract_text::TEXT, ' '::TEXT) AS abstract
FROM
  hra_pmid2 hra
  LEFT JOIN ABS ABS ON hra.pmid::TEXT = ABS.pmid::TEXT
GROUP BY
  hra.pmid
WITH
  DATA;

-- View: hra_dates
DROP MATERIALIZED VIEW IF EXISTS hra_dates CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_dates AS
SELECT
  pml.pmid,
  TO_DATE((ad.article_year || '_' || ad.article_month || '_' || ad.article_day), 'YYYY-MM-DD') AS "date_published"
FROM
  hra_pmid AS pml
  LEFT JOIN medline_article_date AS ad ON (pml.pmid = ad.pmid)
WITH
  DATA;

-- View: hra_doi
DROP MATERIALIZED VIEW IF EXISTS hra_doi CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_doi TABLESPACE pg_default AS
SELECT
  pml.pmid,
  'https://doi.org/'::TEXT || ei.elocation::TEXT AS doi
FROM
  hra_pmid pml
  LEFT JOIN medline_elocationid ei ON pml.pmid::TEXT = ei.pmid::TEXT
WHERE
  ei.eid_type::TEXT = 'doi'::TEXT
  AND ei.eid_valid::TEXT = 'Y'::TEXT
WITH
  DATA;

-- View: hra_mesh_all
DROP MATERIALIZED VIEW IF EXISTS hra_mesh_all CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  hra_mesh_all TABLESPACE pg_default AS
SELECT
  pml.pmid,
  ARRAY_AGG('http://id.nlm.nih.gov/mesh/'::TEXT || mh.ui::TEXT) AS about
FROM
  hra_pmid pml
  LEFT JOIN medline_mesh_heading mh ON pml.pmid::TEXT = mh.pmid::TEXT
GROUP BY
  pml.pmid
WITH
  DATA;