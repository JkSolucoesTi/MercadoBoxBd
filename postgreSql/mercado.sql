CREATE TABLE IF NOT EXISTS public.mercado
(
    id integer NOT NULL DEFAULT nextval('mercado_id_seq'::regclass),
    nome character varying(150) COLLATE pg_catalog."default" NOT NULL,
    enderco character varying(150) COLLATE pg_catalog."default" NOT NULL,
    cidade character varying(50) COLLATE pg_catalog."default" NOT NULL,
    estado character varying(50) COLLATE pg_catalog."default" NOT NULL,
    cnpj character varying(20) COLLATE pg_catalog."default" NOT NULL,
    telefone character varying(20) COLLATE pg_catalog."default" NOT NULL,
    ativo boolean DEFAULT false,
    CONSTRAINT mercado_pkey PRIMARY KEY (id)
)
