CREATE OR REPLACE FUNCTION public.mb_obter_produtos(
	)
    RETURNS TABLE(id integer, codigo character varying, nome character varying, categoriaid integer, categorianome character varying, descricao character varying) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
    SELECT 
        p.id AS Id,
        p.codigo AS Codigo,
        p.nome AS Nome,
        p.categoria_id AS CategoriaId,
        c.nome AS CategoriaNome,
        p.descricao AS Descricao
    FROM produtos AS p
    INNER JOIN categorias AS c ON p.categoria_id = c.id
    ORDER BY p.nome;
$BODY$;