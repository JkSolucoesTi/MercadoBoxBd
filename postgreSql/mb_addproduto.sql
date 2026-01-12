CREATE OR REPLACE FUNCTION public.mb_addproduto(
	p_codigo character varying,
	p_nome character varying,
	p_categoriaid integer,
	p_descricao character varying DEFAULT NULL::character varying)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    new_id INTEGER;
BEGIN
    INSERT INTO produtos (codigo, nome, categoria_id, descricao)

    VALUES (p_codigo, p_nome, p_categoriaId, p_descricao)
    RETURNING id INTO new_id;

    RETURN new_id;
END;
$BODY$;