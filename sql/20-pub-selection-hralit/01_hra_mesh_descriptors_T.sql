-- Creates and loads MeSH Descriptor data sets.

DROP TABLE IF EXISTS hra_meshd_anatomy CASCADE;

CREATE TABLE IF NOT EXISTS hra_meshd_anatomy
(	descriptor character varying COLLATE pg_catalog."default" NOT NULL,
    ui character varying COLLATE pg_catalog."default" NOT NULL,
    label character varying COLLATE pg_catalog."default"
   )
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

DROP TABLE IF EXISTS hra_meshd_methods CASCADE;

CREATE TABLE IF NOT EXISTS hra_meshd_methods
(	descriptor character varying COLLATE pg_catalog."default" NOT NULL,
    ui character varying COLLATE pg_catalog."default" NOT NULL,
    label character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;
