-- FUNCTION: public.mb_obter_mercados()

-- DROP FUNCTION IF EXISTS public.mb_obter_mercados();

CREATE OR REPLACE FUNCTION public.mb_obter_mercados(
	)
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
Where ativo = TRUE
ORDER BY NOME
$BODY$;

ALTER FUNCTION public.mb_obter_mercados()
    OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.mb_obter_mercados() TO PUBLIC;

GRANT EXECUTE ON FUNCTION public.mb_obter_mercados() TO mercadobox_user;

GRANT EXECUTE ON FUNCTION public.mb_obter_mercados() TO postgres;

