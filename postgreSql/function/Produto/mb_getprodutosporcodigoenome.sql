CREATE OR REPLACE FUNCTION public.mb_getprodutosporcodigoenome(
	p_codigo character varying,
	p_nome character varying)
    RETURNS TABLE(id integer, codigo character varying, nome character varying, categoriaid integer, descricao character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY
    SELECT p.id,
           p.codigo,
           p.nome,
           p.categoria_id,
           p.descricao
    FROM produtos p
    WHERE p.codigo ILIKE '%' || p_codigo || '%'
	OR p.nome ILIKE '%' || p_nome || '%'
ORDER BY p.nome
    LIMIT 20;
END;
$BODY$;
