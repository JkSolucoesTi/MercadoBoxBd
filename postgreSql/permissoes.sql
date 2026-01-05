CREATE TABLE IF NOT EXISTS public.permissoes
(
    id integer NOT NULL DEFAULT nextval('permissoes_id_seq'::regclass),
    nome character varying(100) COLLATE pg_catalog."default" NOT NULL,
    descricao character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT permissoes_pkey PRIMARY KEY (id),
    CONSTRAINT permissoes_nome_key UNIQUE (nome)
)