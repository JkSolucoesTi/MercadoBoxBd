CREATE OR REPLACE FUNCTION public.mb_listar_produtos_paginado(
	p_page integer DEFAULT 1,
	p_page_size integer DEFAULT 10,
	p_filtro text DEFAULT NULL::text)
    RETURNS TABLE(id integer, codigo character varying, nome character varying, categoria_id integer, descricao character varying, ativo boolean, total_registros bigint) 
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
        p.descricao,
        p.ativo,
        total.total_count AS total_registros
    FROM produtos p
    CROSS JOIN (
        SELECT COUNT(*) AS total_count
        FROM produtos p2
        WHERE 
            p2.ativo = TRUE
            AND (
                p_filtro IS NULL
                OR LOWER(p2.nome) LIKE LOWER('%' || p_filtro || '%')
                OR LOWER(p2.codigo) LIKE LOWER('%' || p_filtro || '%')
            )
    ) total
    WHERE 
        p.ativo = TRUE
        AND (
            p_filtro IS NULL
            OR LOWER(p.nome) LIKE LOWER('%' || p_filtro || '%')
            OR LOWER(p.codigo) LIKE LOWER('%' || p_filtro || '%')
        )
    ORDER BY p.nome
    LIMIT p_page_size
    OFFSET (p_page - 1) * p_page_size;
END;
$BODY$;
