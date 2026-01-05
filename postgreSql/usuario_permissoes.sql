CREATE TABLE IF NOT EXISTS public.usuarios_permissoes
(
    usuario_id integer NOT NULL,
    permissao_id integer NOT NULL,
    CONSTRAINT usuarios_permissoes_pkey PRIMARY KEY (usuario_id, permissao_id),
    CONSTRAINT usuarios_permissoes_permissao_id_fkey FOREIGN KEY (permissao_id)
        REFERENCES public.permissoes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT usuarios_permissoes_usuario_id_fkey FOREIGN KEY (usuario_id)
        REFERENCES public.usuarios (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)
