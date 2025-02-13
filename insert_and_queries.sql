-- Inserir Clientes
INSERT INTO Cliente (nome, telefone, email) VALUES 
('Maria Luiza', '22399999999', 'Luiza@email.com'),
('Ana Souza', '11888888888', 'ana@email.com');

-- Inserir Veículos
INSERT INTO Veiculo (placa, marca, modelo, ano, id_cliente) VALUES 
('SOD1234', 'Hyundai', 'HB20', 2017, 1),
('XYZ5678', 'Honda', 'Civic', 2023, 2);

-- Inserir Serviços
INSERT INTO Servico (descricao, preco) VALUES 
('Troca de óleo', 100.00),
('Alinhamento', 120.00),
('Troca de pastilhas de freio', 300.00);

-- Inserir Mecânicos
INSERT INTO Mecanico (nome, especialidade) VALUES 
('João Vitor', 'Mecânica geral'),
('Rodolfo Sergio', 'Suspensão e freios');

-- Inserir Ordem de Serviço
INSERT INTO OrdemServico (data_entrada, status, id_veiculo, id_cliente) VALUES 
('2024-02-01', 'Em andamento', 1, 1),
('2024-02-02', 'Em andamento', 2, 2);

select*from OrdemServico;
desc OrdemServico;

desc Itens_OS;
-- Inserir Itens de OS
INSERT INTO Itens_OS (id_os, id_servico, quantidade) VALUES 
(1, 1, 1),
(1, 3, 1),
(2, 2, 1);

-- Associar Mecânicos às OS
INSERT INTO Mecanico_OS (id_os, id_mecanico) VALUES 
(1, 1),
(1, 2),
(2, 1);

-- Queries SQL 

-- selecionar todas as ordens de serviço com especificação do CLiente e veiculo
SELECT os.id_os, os.data_entrada, os.status, c.nome AS cliente, v.placa, v.modelo
FROM OrdemServico os
JOIN Cliente c ON os.id_cliente = c.id_cliente
JOIN Veiculo v ON os.id_veiculo = v.id_veiculo;

-- busca da ordem de serviço de uma cliente em específico 
SELECT os.id_os, os.data_entrada, os.status
FROM OrdemServico os
JOIN Cliente c ON os.id_cliente = c.id_cliente
WHERE c.nome = 'Maria Luiza';

-- Listagem dos serviços mais caros 
SELECT descricao, preco
FROM Servico
ORDER BY preco DESC
LIMIT 3;

-- Ordem de serviços acima de 150 reais 

SELECT os.id_os, SUM(s.preco * ios.quantidade) AS total
FROM OrdemServico os
JOIN Itens_OS ios ON os.id_os = ios.id_os
JOIN Servico s ON ios.id_servico = s.id_servico
GROUP BY os.id_os
HAVING total > 145;
