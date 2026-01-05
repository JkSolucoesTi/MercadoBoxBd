-- FUNCTION: public.mb_atualizar_mercado(integer, character varying, character varying, character varying, character varying, character varying, character varying, boolean)

-- DROP FUNCTION IF EXISTS public.mb_atualizar_mercado(integer, character varying, character varying, character varying, character varying, character varying, character varying, boolean);

CREATE OR REPLACE FUNCTION public.mb_atualizar_mercado(
	p_id_mercado integer,
	p_nome character varying,
	p_enderco character varying,
	p_cidade character varying,
	p_estado character varying,
	p_cnpj character varying,
	p_telefone character varying,
	p_ativo boolean)
    RETURNS void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
BEGIN
    UPDATE mercado
    SET 
        nome = p_nome,
        enderco = p_enderco,
        cidade = p_cidade,
        estado = p_estado,
        cnpj = p_cnpj,
        telefone = p_telefone,
        ativo = p_ativo
    WHERE id = p_id_mercado;
END;
$BODY$;

ALTER FUNCTION public.mb_atualizar_mercado(integer, character varying, character varying, character varying, character varying, character varying, character varying, boolean)
    OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.mb_atualizar_mercado(integer, character varying, character varying, character varying, character varying, character varying, character varying, boolean) TO PUBLIC;

GRANT EXECUTE ON FUNCTION public.mb_atualizar_mercado(integer, character varying, character varying, character varying, character varying, character varying, character varying, boolean) TO mercadobox_user;

GRANT EXECUTE ON FUNCTION public.mb_atualizar_mercado(integer, character varying, character varying, character varying, character varying, character varying, character varying, boolean) TO postgres;

