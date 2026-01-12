CREATE OR REPLACE FUNCTION public.mb_getprodutobyid(
	p_id integer)
    RETURNS TABLE(id integer, codigo character varying, nome character varying, categoriaid integer, categorianome character varying, descricao character varying, ativo boolean) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1

AS $BODY$
    SELECT 
        p.id AS id,
        p.codigo AS codigo,
        p.nome AS nome,
        p.categoria_id AS categoriaid,
        c.nome AS categorianome,
        p.descricao AS descricao,
        p.ativo AS ativo
    FROM produtos p
    INNER JOIN categorias c ON p.categoria_id = c.id
    WHERE p.id = p_id;
$BODY$;