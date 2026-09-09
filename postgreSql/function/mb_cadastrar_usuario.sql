-- Função para cadastrar novo usuário no MercadoBox
-- Verifica duplicidade de email, insere usuário e vincula permissão padrão (ID 2)

CREATE OR REPLACE FUNCTION public.mb_cadastrar_usuario(
    p_nome character varying,
    p_email character varying,
    p_senha character varying
)
RETURNS TABLE(id integer, sucesso boolean, mensagem character varying)
LANGUAGE plpgsql
AS $$
DECLARE
    v_usuario_id integer;
    v_email_existe boolean;
BEGIN
    -- Verificar se e-mail já existe
    SELECT EXISTS (
        SELECT 1 FROM public.usuarios u WHERE u.email = p_email
    ) INTO v_email_existe;

    IF v_email_existe THEN
        RETURN QUERY SELECT 0::integer, false, 'E-mail já cadastrado.'::character varying;
        RETURN;
    END IF;

    -- Inserir novo usuário
    INSERT INTO public.usuarios (nome, email, senha, ativo, criado_em)
    VALUES (p_nome, p_email, p_senha, true, now())
    RETURNING public.usuarios.id INTO v_usuario_id;

    -- Vincular permissão padrão de Usuário Comum (ID = 2)
    INSERT INTO public.usuarios_permissoes (usuario_id, permissao_id)
    VALUES (v_usuario_id, 2);

    RETURN QUERY SELECT v_usuario_id, true, 'Usuário cadastrado com sucesso.'::character varying;
END;
$$;
