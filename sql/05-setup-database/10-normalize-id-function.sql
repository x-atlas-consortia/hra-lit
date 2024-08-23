CREATE OR REPLACE FUNCTION normalize_id(str text) RETURNS text
	AS $$ SELECT '#' || regexp_replace(regexp_replace(lower(str), '\W+', '-', 'g'), '[^a-z0-9-]+', '', 'g'); $$
	LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT;
