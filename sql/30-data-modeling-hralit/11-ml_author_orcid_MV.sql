-- View: ml_author_orcid
DROP MATERIALIZED VIEW IF EXISTS ml_author_orcid CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS
  ml_author_orcid TABLESPACE pg_default AS
WITH
  gp36 AS (
    SELECT DISTINCT
      ROW (a.pmid, a.author_ctr)::TEXT AS auth_id,
      a.source,
      BTRIM(a.identifier::TEXT) AS identifier,
      LENGTH(BTRIM(a.identifier::TEXT)) AS len_id
    FROM
      medline_author_identifier a
    WHERE
      LENGTH(BTRIM(a.identifier::TEXT)) = 36
      AND NOT a.identifier::TEXT ~ 'http://orcid.org/'::TEXT
      AND a.identifier::TEXT <> 'https://orcid.org/rinku ghimire 1982'::TEXT
  ),
  gp37 AS (
    SELECT DISTINCT
      ROW (a.pmid, a.author_ctr)::TEXT AS auth_id,
      a.source,
      BTRIM(a.identifier::TEXT) AS identifier,
      LENGTH(BTRIM(a.identifier::TEXT)) AS len_id
    FROM
      medline_author_identifier a
    WHERE
      LENGTH(BTRIM(a.identifier::TEXT)) = 37
      AND NOT a.identifier::TEXT ~ 'https://orcid.org/000'::TEXT
      AND (
        a.identifier::TEXT <> ALL (
          ARRAY[
            'https://orcid.org/https://orcid.org/0'::CHARACTER VARYING,
            'https://orcid.org/doi/10.1101/7787853'::CHARACTER VARYING,
            'https://orcid.org/7746-7474-0001-0000'::CHARACTER VARYING,
            'https://orcid.org/6536-4433-4015-0462'::CHARACTER VARYING,
            'https://orcid.org/4177-2543-0002-0000'::CHARACTER VARYING,
            'https://orcid.org/2547-5967-0001-0000'::CHARACTER VARYING
          ]::TEXT[]
        )
      )
  )
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, 'org0000'::TEXT, 'org/0000'::TEXT) AS identifier
FROM
  gp36 a
WHERE
  a.identifier ~ 'org0000'::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, ':/o'::TEXT, '://o'::TEXT) AS identifier
FROM
  gp36 a
WHERE
  a.identifier ~ ':/o'::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, 'ORCID'::TEXT, 'orcid'::TEXT) AS identifier
FROM
  gp36 a
WHERE
  a.identifier ~ 'ORCID'::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, 'org/000-'::TEXT, 'org/0000-'::TEXT) AS identifier
FROM
  gp36 a
WHERE
  a.identifier ~ 'org/000-'::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, 'https//orcid'::TEXT, 'https://orcid'::TEXT) AS identifier
FROM
  gp36 a
WHERE
  a.identifier ~ 'https//orcid'::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  a.identifier || '0'::TEXT AS identifier
FROM
  gp36 a
WHERE
  a.identifier ~ 'https://orcid.org/0009-000'::TEXT
  OR a.identifier ~ 'https://orcid.org/0000-0001-\d{4}-'::TEXT
  OR a.identifier ~ 'https://orcid.org/0000-0003-\d{4}-'::TEXT
  OR a.identifier ~ 'https://orcid.org/0000-0002-\d{4}-'::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, "left" (a.identifier, 17), 'https://orcid.org/'::TEXT) AS identifier
FROM
  gp36 a
WHERE
  a.identifier ~ 'http://orcid.org.'::TEXT
  OR a.identifier ~ 'http://orcid.org8'::TEXT
  OR a.identifier ~ 'https://ocid.org.'::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, 'htpp://orcid.org/'::TEXT, 'https://orcid.org/'::TEXT) AS identifier
FROM
  gp36 a
WHERE
  a.identifier ~ 'htpp://orcid.org/'::TEXT
UNION
SELECT DISTINCT
  ROW (a.pmid, a.author_ctr)::TEXT AS auth_id,
  a.source,
  BTRIM(a.identifier::TEXT) AS identifier
FROM
  medline_author_identifier a
WHERE
  LENGTH(BTRIM(a.identifier::TEXT)) = 36
  AND a.identifier::TEXT ~ 'http://orcid.org/'::TEXT
  AND (
    a.identifier::TEXT <> ALL (
      ARRAY[
        'http://orcid.org/9153-2615-8198-4310'::CHARACTER VARYING,
        'http://orcid.org/5050-5050-5050-5050'::CHARACTER VARYING,
        'http://orcid.org/1991-0710-1991-710X'::CHARACTER VARYING,
        'http://orcid.org/1982-1982-2014-0402'::CHARACTER VARYING,
        'http://orcid.org/1978-0427-1980-126X'::CHARACTER VARYING,
        'http://orcid.org/1234-5678-0000-0002'::CHARACTER VARYING,
        'http://orcid.org/0586-9181-7500-7156'::CHARACTER VARYING,
        'http://orcid.org/0000-0000-0000-0000'::CHARACTER VARYING
      ]::TEXT[]
    )
  )
UNION
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, ' '::TEXT, ''::TEXT) AS identifier
FROM
  gp37 a
WHERE
  a.identifier ~ ' '::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, "left" (a.identifier, 18), 'https://orcid.org/'::TEXT) AS identifier
FROM
  gp37 a
WHERE
  a.identifier ~ 'http://:orcid.org/'::TEXT
  OR a.identifier ~ 'http://orcid.org//'::TEXT
  OR a.identifier ~ 'http://orcid.org/l'::TEXT
  OR a.identifier ~ 'https;//orcid.org/'::TEXT
  OR a.identifier ~ 'https://orcid.org-'::TEXT
  OR a.identifier ~ 'httpS://orcid.org/'::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, "left" (a.identifier, 17), 'https://orcid.org/'::TEXT) AS identifier
FROM
  gp37 a
WHERE
  a.identifier ~ 'https://orcid.org0'::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, "left" (a.identifier, 19), 'https://orcid.org/'::TEXT) AS identifier
FROM
  gp37 a
WHERE
  a.identifier ~ 'https://orcid.org//'::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  "left" (a.identifier, 36) AS identifier
FROM
  gp37 a
WHERE
  a.identifier ~ '2208X'::TEXT
  OR a.identifier ~ '7295:'::TEXT
UNION
SELECT
  a.auth_id,
  a.source,
  REPLACE(a.identifier, '+'::TEXT, ''::TEXT) AS identifier
FROM
  gp37 a
WHERE
  a.identifier ~ '\+'::TEXT
UNION
SELECT DISTINCT
  ROW (a.pmid, a.author_ctr)::TEXT AS auth_id,
  a.source,
  BTRIM(a.identifier::TEXT) AS identifier
FROM
  medline_author_identifier a
WHERE
  LENGTH(BTRIM(a.identifier::TEXT)) = 37
  AND a.identifier::TEXT ~ 'https://orcid.org/000'::TEXT
  AND (
    a.identifier::TEXT <> ALL (
      ARRAY[
        'https://orcid.org/https://orcid.org/0'::CHARACTER VARYING,
        'https://orcid.org/doi/10.1101/7787853'::CHARACTER VARYING,
        'https://orcid.org/7746-7474-0001-0000'::CHARACTER VARYING,
        'https://orcid.org/6536-4433-4015-0462'::CHARACTER VARYING,
        'https://orcid.org/4177-2543-0002-0000'::CHARACTER VARYING,
        'https://orcid.org/2547-5967-0001-0000'::CHARACTER VARYING,
        'https://orcid.org/0000-0000-0000-0000'::CHARACTER VARYING
      ]::TEXT[]
    )
  )
UNION
SELECT DISTINCT
  ROW (a.pmid, a.author_ctr)::TEXT AS auth_id,
  a.source,
  'https://orcid.org/'::TEXT || BTRIM(a.identifier::TEXT) AS identifier
FROM
  medline_author_identifier a
WHERE
  LENGTH(BTRIM(a.identifier::TEXT)) = 19
  AND (
    a.identifier::TEXT <> ALL (
      ARRAY[
        'smsenf@phhp.ufl.edu'::CHARACTER VARYING,
        'https://orcid.org/0'::CHARACTER VARYING,
        'http://orcid.org/MD'::CHARACTER VARYING,
        'VINOD.JNU@GMAIL.COM'::CHARACTER VARYING,
        'Dieg-Dieg-Dieg-Dieg'::CHARACTER VARYING,
        'Amai-Amai-Amai-Amai'::CHARACTER VARYING,
        'Larr-Larr-larr-larr'::CHARACTER VARYING,
        '4444-5555-6666-7777'::CHARACTER VARYING,
        '3729-0220-8208-0404'::CHARACTER VARYING,
        '3333-4444-5555-6666'::CHARACTER VARYING,
        '3316-5999-0001-0000'::CHARACTER VARYING,
        '2708-1975-2001-2009'::CHARACTER VARYING,
        '2575-6680-7374-3236'::CHARACTER VARYING,
        '2313-3232-1233-4332'::CHARACTER VARYING,
        '2222-3333-4444-5555'::CHARACTER VARYING,
        '2222-3333-4444-5555'::CHARACTER VARYING,
        '1993-3991-9931-9319'::CHARACTER VARYING,
        '1595-9263-7351-2345'::CHARACTER VARYING,
        '1522-8040-8501-5228'::CHARACTER VARYING,
        '1234-4566-6667-7888'::CHARACTER VARYING,
        '1234-1234-1234-1238'::CHARACTER VARYING,
        '1111-2222-3333-4444'::CHARACTER VARYING,
        '1111-2222-3333-4444'::CHARACTER VARYING,
        '1000-0001-6759-8658'::CHARACTER VARYING,
        '1000-0001-6759-8658'::CHARACTER VARYING,
        '1000-0001-6759-8658'::CHARACTER VARYING,
        '1000-0001-0815-5942'::CHARACTER VARYING,
        '0730-1990-0609-0604'::CHARACTER VARYING,
        '0300-0003-2352-3915'::CHARACTER VARYING,
        '0208-0208-0208-020X'::CHARACTER VARYING,
        '0088-0000-8800-8800'::CHARACTER VARYING,
        '0043-1404-0066-8400'::CHARACTER VARYING,
        '5555-6666-7777-8888'::CHARACTER VARYING,
        '7777-7777-7777-7777'::CHARACTER VARYING,
        '0000-0002-8369-1104'::CHARACTER VARYING,
        '0000-0000-0000-0000'::CHARACTER VARYING
      ]::TEXT[]
    )
  )
WITH
  DATA;