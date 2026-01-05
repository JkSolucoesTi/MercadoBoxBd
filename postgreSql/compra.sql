CREATE TABLE IF NOT EXISTS public.compra
(
    id integer NOT NULL DEFAULT nextval('compra_id_seq'::regclass),
    mercado_id integer NOT NULL,
    data timestamp without time zone NOT NULL,
    status integer NOT NULL,
    guid uuid NOT NULL,
    idusuario integer DEFAULT 0,
    CONSTRAINT compra_pkey PRIMARY KEY (id),
    CONSTRAINT fk_compra_mercado FOREIGN KEY (mercado_id)
        REFERENCES public.mercado (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
