-- Creates and loads MeSH Descriptor data sets.

DROP TABLE IF EXISTS public.hra_meshd_anatomy;

CREATE TABLE IF NOT EXISTS public.hra_meshd_anatomy
(	descriptor character varying COLLATE pg_catalog."default" NOT NULL,
    ui character varying COLLATE pg_catalog."default" NOT NULL,
    label character varying COLLATE pg_catalog."default"
   )
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;
ALTER TABLE IF EXISTS public.hra_meshd_anatomy
    OWNER to mginda;
GRANT ALL ON TABLE public.hra_meshd_anatomy TO bherr;
GRANT ALL ON TABLE public.hra_meshd_anatomy TO gallantm;
GRANT ALL ON TABLE public.hra_meshd_anatomy TO mginda;

DROP TABLE IF EXISTS public.hra_meshd_methods;

CREATE TABLE IF NOT EXISTS public.hra_meshd_methods
(	descriptor character varying COLLATE pg_catalog."default" NOT NULL,
    ui character varying COLLATE pg_catalog."default" NOT NULL,
    label character varying COLLATE pg_catalog."default"
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

\copy public.hra_meshd_anatomy from './raw-data/v0.6.0/reports/ad-hoc/mesh_anatomy_set.csv' WITH DELIMITER ',' CSV HEADER;

\copy public.hra_meshd_methods from './raw-data/v0.6.0/reports/ad-hoc/mesh_method_set.csv' WITH DELIMITER ',' CSV HEADER;