CREATE TABLE IF NOT EXISTS public.produtos
(
    id integer NOT NULL DEFAULT nextval('produtos_id_seq'::regclass),
    codigo character varying(50) COLLATE pg_catalog."default" NOT NULL,
    nome character varying(200) COLLATE pg_catalog."default" NOT NULL,
    categoria_id integer NOT NULL,
    descricao character varying(500) COLLATE pg_catalog."default",
    CONSTRAINT produtos_pkey PRIMARY KEY (id),
    CONSTRAINT fk_produtos_categorias FOREIGN KEY (categoria_id)
        REFERENCES public.categorias (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)