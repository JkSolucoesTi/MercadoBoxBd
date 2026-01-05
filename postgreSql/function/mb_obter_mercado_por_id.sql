-- FUNCTION: public.mb_obter_mercado_por_id(integer)

-- DROP FUNCTION IF EXISTS public.mb_obter_mercado_por_id(integer);

CREATE OR REPLACE FUNCTION public.mb_obter_mercado_por_id(
	p_id_mercado integer)
    RETURNS TABLE(id integer, nome character varying, enderco character varying, cidade character varying, estado character varying, cnpj character varying, telefone character varying, ativo boolean) 
    LANGUAGE 'sql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
SELECT 
id as Id,
nome as Nome,
enderco as Endereco,
cidade as Cidade,
estado as Estado,
cnpj as Cnpj,
telefone as Telefone,
ativo as Ativo
FROM MERCADO
where id = p_id_mercado and ativo = TRUE
ORDER BY NOME
$BODY$;

ALTER FUNCTION public.mb_obter_mercado_por_id(integer)
    OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.mb_obter_mercado_por_id(integer) TO PUBLIC;

GRANT EXECUTE ON FUNCTION public.mb_obter_mercado_por_id(integer) TO mercadobox_user;

GRANT EXECUTE ON FUNCTION public.mb_obter_mercado_por_id(integer) TO postgres;

