CREATE TABLE IF NOT EXISTS public.categorias
(
    id integer NOT NULL DEFAULT nextval('categorias_id_seq'::regclass),
    nome character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT categorias_pkey PRIMARY KEY (id)
)
