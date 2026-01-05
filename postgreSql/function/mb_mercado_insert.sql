-- FUNCTION: public.mb_mercado_insert(character varying, character varying, character varying, character varying, character varying, character varying, boolean)

-- DROP FUNCTION IF EXISTS public.mb_mercado_insert(character varying, character varying, character varying, character varying, character varying, character varying, boolean);

CREATE OR REPLACE FUNCTION public.mb_mercado_insert(
	p_nome character varying,
	p_endereco character varying DEFAULT NULL::character varying,
	p_cidade character varying DEFAULT NULL::character varying,
	p_estado character varying DEFAULT NULL::character varying,
	p_cnpj character varying DEFAULT NULL::character varying,
	p_telefone character varying DEFAULT NULL::character varying,
	p_ativo boolean DEFAULT false)
    RETURNS integer
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    v_id INTEGER;
BEGIN
    INSERT INTO mercado (nome, enderco, cidade, estado, cnpj, telefone, ativo)
    VALUES (p_nome, p_endereco, p_cidade, p_estado, p_cnpj, p_telefone, p_ativo)
    RETURNING id INTO v_id;

    RETURN v_id;
END;
$BODY$;

ALTER FUNCTION public.mb_mercado_insert(character varying, character varying, character varying, character varying, character varying, character varying, boolean)
    OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.mb_mercado_insert(character varying, character varying, character varying, character varying, character varying, character varying, boolean) TO PUBLIC;

GRANT EXECUTE ON FUNCTION public.mb_mercado_insert(character varying, character varying, character varying, character varying, character varying, character varying, boolean) TO mercadobox_user;

GRANT EXECUTE ON FUNCTION public.mb_mercado_insert(character varying, character varying, character varying, character varying, character varying, character varying, boolean) TO postgres;

