-- Criação do BD no contexto de oficina 
CREATE DATABASE IF NOT EXISTS Oficina;
USE Oficina;

-- Tabela de Clientes
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE
);

-- Tabela de Veículos
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    ano INT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela de Serviços
CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    preco DECIMAL(10,2) NOT NULL
);

-- Tabela de Ordens de Serviço (OS)
CREATE TABLE OrdemServico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    data_entrada DATE NOT NULL,
    data_saida DATE,
    status ENUM('Aberto', 'Em andamento', 'Finalizado') NOT NULL,
    id_veiculo INT, 
    id_cliente INT, 
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela de Itens da OS (Serviços aplicados à OS)
CREATE TABLE Itens_OS (
    id_itens_os INT AUTO_INCREMENT PRIMARY KEY,
    id_os INT,
    id_servico INT,
    quantidade INT NOT NULL,
    FOREIGN KEY (id_os) REFERENCES OrdemServico(id_os),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

-- Tabela de Mecânicos

CREATE TABLE Mecanico (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(60)
);

-- Relacionamento Mecânicos e OS (Mecânico realiza serviços em uma OS)
CREATE TABLE Mecanico_OS (
    id_mecanico_os INT AUTO_INCREMENT PRIMARY KEY,
    id_os INT,
    id_mecanico INT,
    FOREIGN KEY (id_os) REFERENCES OrdemServico(id_os),
    FOREIGN KEY (id_mecanico) REFERENCES Mecanico(id_mecanico)
);