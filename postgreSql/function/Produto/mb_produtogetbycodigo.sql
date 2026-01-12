CREATE OR REPLACE FUNCTION public.mb_produtogetbycodigo(
	p_codigo character varying)
    RETURNS TABLE(id integer, codigo character varying, nome character varying, categoriaid integer, descricao character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT 
        p.id,
        p.codigo,
        p.nome,
        p.categoria_id,
        p.descricao
    FROM produtos AS p
    WHERE p.codigo = p_codigo;
END;
$BODY$;