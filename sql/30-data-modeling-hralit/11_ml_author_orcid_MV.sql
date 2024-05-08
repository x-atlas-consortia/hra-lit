-- View: public.ml_author_orcid
DROP MATERIALIZED VIEW IF EXISTS public.ml_author_orcid CASCADE;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.ml_author_orcid
TABLESPACE pg_default
AS
 WITH gp36 AS (
         SELECT DISTINCT ROW(a.pmid, a.author_ctr)::text AS auth_id,
            a.source,
            btrim(a.identifier::text) AS identifier,
            length(btrim(a.identifier::text)) AS len_id
           FROM medline_author_identifier a
          WHERE length(btrim(a.identifier::text)) = 36 AND NOT a.identifier::text ~ 'http://orcid.org/'::text AND a.identifier::text <> 'https://orcid.org/rinku ghimire 1982'::text
        ), gp37 AS (
         SELECT DISTINCT ROW(a.pmid, a.author_ctr)::text AS auth_id,
            a.source,
            btrim(a.identifier::text) AS identifier,
            length(btrim(a.identifier::text)) AS len_id
           FROM medline_author_identifier a
          WHERE length(btrim(a.identifier::text)) = 37 AND NOT a.identifier::text ~ 'https://orcid.org/000'::text AND (a.identifier::text <> ALL (ARRAY['https://orcid.org/https://orcid.org/0'::character varying, 'https://orcid.org/doi/10.1101/7787853'::character varying, 'https://orcid.org/7746-7474-0001-0000'::character varying, 'https://orcid.org/6536-4433-4015-0462'::character varying, 'https://orcid.org/4177-2543-0002-0000'::character varying, 'https://orcid.org/2547-5967-0001-0000'::character varying]::text[]))
        )
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, 'org0000'::text, 'org/0000'::text) AS identifier
   FROM gp36 a
  WHERE a.identifier ~ 'org0000'::text
UNION
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, ':/o'::text, '://o'::text) AS identifier
   FROM gp36 a
  WHERE a.identifier ~ ':/o'::text
UNION
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, 'ORCID'::text, 'orcid'::text) AS identifier
   FROM gp36 a
  WHERE a.identifier ~ 'ORCID'::text
UNION
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, 'org/000-'::text, 'org/0000-'::text) AS identifier
   FROM gp36 a
  WHERE a.identifier ~ 'org/000-'::text
UNION
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, 'https//orcid'::text, 'https://orcid'::text) AS identifier
   FROM gp36 a
  WHERE a.identifier ~ 'https//orcid'::text
UNION
 SELECT a.auth_id,
    a.source,
    a.identifier || '0'::text AS identifier
   FROM gp36 a
  WHERE a.identifier ~ 'https://orcid.org/0009-000'::text OR a.identifier ~ 'https://orcid.org/0000-0001-\d{4}-'::text OR a.identifier ~ 'https://orcid.org/0000-0003-\d{4}-'::text OR a.identifier ~ 'https://orcid.org/0000-0002-\d{4}-'::text
UNION
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, "left"(a.identifier, 17), 'https://orcid.org/'::text) AS identifier
   FROM gp36 a
  WHERE a.identifier ~ 'http://orcid.org.'::text OR a.identifier ~ 'http://orcid.org8'::text OR a.identifier ~ 'https://ocid.org.'::text
UNION
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, 'htpp://orcid.org/'::text, 'https://orcid.org/'::text) AS identifier
   FROM gp36 a
  WHERE a.identifier ~ 'htpp://orcid.org/'::text
UNION
 SELECT DISTINCT ROW(a.pmid, a.author_ctr)::text AS auth_id,
    a.source,
    btrim(a.identifier::text) AS identifier
   FROM medline_author_identifier a
  WHERE length(btrim(a.identifier::text)) = 36 AND a.identifier::text ~ 'http://orcid.org/'::text AND (a.identifier::text <> ALL (ARRAY['http://orcid.org/9153-2615-8198-4310'::character varying, 'http://orcid.org/5050-5050-5050-5050'::character varying, 'http://orcid.org/1991-0710-1991-710X'::character varying, 'http://orcid.org/1982-1982-2014-0402'::character varying, 'http://orcid.org/1978-0427-1980-126X'::character varying, 'http://orcid.org/1234-5678-0000-0002'::character varying, 'http://orcid.org/0586-9181-7500-7156'::character varying, 'http://orcid.org/0000-0000-0000-0000'::character varying]::text[]))
UNION
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, ' '::text, ''::text) AS identifier
   FROM gp37 a
  WHERE a.identifier ~ ' '::text
UNION
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, "left"(a.identifier, 18), 'https://orcid.org/'::text) AS identifier
   FROM gp37 a
  WHERE a.identifier ~ 'http://:orcid.org/'::text OR a.identifier ~ 'http://orcid.org//'::text OR a.identifier ~ 'http://orcid.org/l'::text OR a.identifier ~ 'https;//orcid.org/'::text OR a.identifier ~ 'https://orcid.org-'::text OR a.identifier ~ 'httpS://orcid.org/'::text
UNION
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, "left"(a.identifier, 17), 'https://orcid.org/'::text) AS identifier
   FROM gp37 a
  WHERE a.identifier ~ 'https://orcid.org0'::text
UNION
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, "left"(a.identifier, 19), 'https://orcid.org/'::text) AS identifier
   FROM gp37 a
  WHERE a.identifier ~ 'https://orcid.org//'::text
UNION
 SELECT a.auth_id,
    a.source,
    "left"(a.identifier, 36) AS identifier
   FROM gp37 a
  WHERE a.identifier ~ '2208X'::text OR a.identifier ~ '7295:'::text
UNION
 SELECT a.auth_id,
    a.source,
    replace(a.identifier, '+'::text, ''::text) AS identifier
   FROM gp37 a
  WHERE a.identifier ~ '\+'::text
UNION
 SELECT DISTINCT ROW(a.pmid, a.author_ctr)::text AS auth_id,
    a.source,
    btrim(a.identifier::text) AS identifier
   FROM medline_author_identifier a
  WHERE length(btrim(a.identifier::text)) = 37 AND a.identifier::text ~ 'https://orcid.org/000'::text AND (a.identifier::text <> ALL (ARRAY['https://orcid.org/https://orcid.org/0'::character varying, 'https://orcid.org/doi/10.1101/7787853'::character varying, 'https://orcid.org/7746-7474-0001-0000'::character varying, 'https://orcid.org/6536-4433-4015-0462'::character varying, 'https://orcid.org/4177-2543-0002-0000'::character varying, 'https://orcid.org/2547-5967-0001-0000'::character varying, 'https://orcid.org/0000-0000-0000-0000'::character varying]::text[]))
UNION
 SELECT DISTINCT ROW(a.pmid, a.author_ctr)::text AS auth_id,
    a.source,
    'https://orcid.org/'::text || btrim(a.identifier::text) AS identifier
   FROM medline_author_identifier a
  WHERE length(btrim(a.identifier::text)) = 19 AND (a.identifier::text <> ALL (ARRAY['smsenf@phhp.ufl.edu'::character varying, 'https://orcid.org/0'::character varying, 'http://orcid.org/MD'::character varying, 'VINOD.JNU@GMAIL.COM'::character varying, 'Dieg-Dieg-Dieg-Dieg'::character varying, 'Amai-Amai-Amai-Amai'::character varying, 'Larr-Larr-larr-larr'::character varying, '4444-5555-6666-7777'::character varying, '3729-0220-8208-0404'::character varying, '3333-4444-5555-6666'::character varying, '3316-5999-0001-0000'::character varying, '2708-1975-2001-2009'::character varying, '2575-6680-7374-3236'::character varying, '2313-3232-1233-4332'::character varying, '2222-3333-4444-5555'::character varying, '2222-3333-4444-5555'::character varying, '1993-3991-9931-9319'::character varying, '1595-9263-7351-2345'::character varying, '1522-8040-8501-5228'::character varying, '1234-4566-6667-7888'::character varying, '1234-1234-1234-1238'::character varying, '1111-2222-3333-4444'::character varying, '1111-2222-3333-4444'::character varying, '1000-0001-6759-8658'::character varying, '1000-0001-6759-8658'::character varying, '1000-0001-6759-8658'::character varying, '1000-0001-0815-5942'::character varying, '0730-1990-0609-0604'::character varying, '0300-0003-2352-3915'::character varying, '0208-0208-0208-020X'::character varying, '0088-0000-8800-8800'::character varying, '0043-1404-0066-8400'::character varying, '5555-6666-7777-8888'::character varying, '7777-7777-7777-7777'::character varying, '0000-0002-8369-1104'::character varying, '0000-0000-0000-0000'::character varying]::text[]))
WITH DATA;

