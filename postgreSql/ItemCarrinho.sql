CREATE TABLE IF NOT EXISTS public.itemcarrinho
(
    id integer NOT NULL DEFAULT nextval('itemcarrinho_id_seq'::regclass),
    compraid integer NOT NULL,
    produtoid integer NOT NULL,
    quantidade integer NOT NULL,
    valorunitario numeric(18,2) NOT NULL,
    promocao boolean,
    valorpromocional numeric(18,2) NOT NULL,
    CONSTRAINT itemcarrinho_pkey PRIMARY KEY (id),
    CONSTRAINT fk_itemcarrinho_compra FOREIGN KEY (compraid)
        REFERENCES public.compra (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_itemcarrinho_produtos FOREIGN KEY (produtoid)
        REFERENCES public.produtos (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)