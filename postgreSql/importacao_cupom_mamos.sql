-- ==============================================================================
-- Script de Importação dos Produtos do Cupom Fiscal (MAMOS LJ 5 - AV ITINGUÇU)
-- Data: 20/08/2026
-- ==============================================================================

-- 1. Garante que o Mercado está cadastrado (Mamos Loja 5)
INSERT INTO mercado (nome, enderco, cidade, estado, cnpj, telefone, ativo)
VALUES (
    'Mamos Supermercados - Loja 5',
    'Av. Itinguçu, 1476 - Vila Ré',
    'São Paulo',
    'SP',
    '10.251.138/0003-89',
    '(11) 2672-7272',
    true
)
ON CONFLICT DO NOTHING;

-- 2. Inserção / Atualização dos Produtos extraídos do cupom
INSERT INTO produtos (codigo, nome, categoria_id, descricao) VALUES
('07892840823207', 'Fofura Presunto 60g', 10, 'Salgadinho Fofura Sabor Presunto 60g'),
('07896239994301', 'Sacola Verde', 6, 'Sacola Plástica Biodegradável Verde'),
('07898994194514', 'Piraquê Biscoito Redondo 70g', 10, 'Biscoito Redondo Piraquê 70g'),
('07896326100219', 'Guaraviton Açaí 500ml', 1, 'Bebida Mista de Guaraná e Açaí Guaraviton 500ml'),
('07898416780011', 'Biscoito de Polvilho Salgado 40g', 10, 'Biscoito de Polvilho Sal 40g'),
('68117', 'Batata Mister Potato Original', 10, 'Batata Frita Mister Potato Sabor Original'),
('07892840822644', 'Salgadinho Torcida Queijo 60g', 10, 'Salgadinho Torcida Sabor Queijo 60g'),
('07896312108021', 'Pirulito Pop Kiss Framboesa', 10, 'Pirulito Pop Kiss Sabor Framboesa'),
('07891008121827', 'Chocolate Talento Amêndoas e Passas', 10, 'Chocolate Garoto Talento Amêndoas e Passas'),
('07896423419276', 'M&Ms Tubo Colorido', 10, 'Chocolate Confeitado M&Ms Tubo Color'),
('07896321041586', 'Goma Urso Flopi', 10, 'Bala de Goma Formato Urso Flopi'),
('07896306625275', 'Chocolate Trento Dark', 10, 'Wafer Recheado Trento Dark'),
('07896451902580', 'Bala Docigoma Mini', 10, 'Bala de Goma Docigoma Mini Docile'),
('07898591450709', 'Gelatina Minhocas', 10, 'Bala de Gelatina Formato Minhocas'),
('41883', 'Pastilha Tic Tac Frutas 14.5g', 10, 'Pastilhas Tic Tac Sabores Frutas 14.5g'),
('07895800304235', 'Goma de Mascar Trident Canela', 10, 'Chiclete Trident Sem Açúcar Sabor Canela'),
('07896306623318', 'Bala Tribala Morango', 10, 'Bala Mastigável Tribala Sabor Morango'),
('07896306623295', 'Bala Tribala Frutas Vermelhas', 10, 'Bala Mastigável Tribala Sabor Frutas Vermelhas'),
('41856', 'Goma de Mascar Trident Frutas Cereja', 10, 'Chiclete Trident Sabor Cereja')
ON CONFLICT (codigo) DO UPDATE 
SET nome = EXCLUDED.nome,
    categoria_id = EXCLUDED.categoria_id,
    descricao = EXCLUDED.descricao;
