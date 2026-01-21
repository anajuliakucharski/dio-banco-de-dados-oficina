-- Criação do Banco de Dados para Oficina Mecânica
CREATE DATABASE IF NOT EXISTS oficina_dio;
USE oficina_dio;

-- 1. Tabela Clientes
CREATE TABLE Clients (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(50) NOT NULL,
    Lname VARCHAR(50) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    Address VARCHAR(255),
    Contact VARCHAR(15)
);

-- 2. Tabela Mecânicos/Equipe
-- Simplificação: Uma equipe tem um código e pode ter vários mecânicos, mas aqui focamos no cadastro do profissional
CREATE TABLE Mechanics (
    idMechanic INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    Specialty ENUM('Motor', 'Suspensão', 'Elétrica', 'Geral') DEFAULT 'Geral'
);

-- 3. Tabela Veículos
CREATE TABLE Vehicles (
    idVehicle INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    LicensePlate CHAR(7) NOT NULL UNIQUE,
    Brand VARCHAR(30),
    Model VARCHAR(30),
    Year CHAR(4),
    CONSTRAINT fk_vehicle_client FOREIGN KEY (idClient) REFERENCES Clients(idClient)
);

-- 4. Tabela de Referência de Mão de Obra (Serviços)
CREATE TABLE ServiceReference (
    idServiceRef INT AUTO_INCREMENT PRIMARY KEY,
    ServiceName VARCHAR(100) NOT NULL,
    StandardLaborPrice FLOAT NOT NULL -- Preço tabelado da mão de obra
);

-- 5. Tabela de Estoque de Peças
CREATE TABLE PartsStorage (
    idPart INT AUTO_INCREMENT PRIMARY KEY,
    PartName VARCHAR(100) NOT NULL,
    UnitPrice FLOAT NOT NULL,
    QuantityInStock INT DEFAULT 0
);

-- 6. Ordem de Serviço (OS) - Tabela Central
CREATE TABLE ServiceOrder (
    idOS INT AUTO_INCREMENT PRIMARY KEY,
    idVehicle INT,
    idMechanicLead INT, -- Mecânico responsável
    IssueDate DATE,
    CompletionDate DATE,
    Status ENUM('Em Análise', 'Aprovado', 'Em Execução', 'Finalizado', 'Cancelado') DEFAULT 'Em Análise',
    TotalValue FLOAT DEFAULT 0, -- Atributo que será calculado via query ou procedure
    CONSTRAINT fk_os_vehicle FOREIGN KEY (idVehicle) REFERENCES Vehicles(idVehicle),
    CONSTRAINT fk_os_mechanic FOREIGN KEY (idMechanicLead) REFERENCES Mechanics(idMechanic)
);

-- 7. Relacionamento OS - Peças Utilizadas
CREATE TABLE OS_Parts (
    idOS INT,
    idPart INT,
    Quantity INT DEFAULT 1,
    PRIMARY KEY (idOS, idPart),
    CONSTRAINT fk_osparts_os FOREIGN KEY (idOS) REFERENCES ServiceOrder(idOS),
    CONSTRAINT fk_osparts_part FOREIGN KEY (idPart) REFERENCES PartsStorage(idPart)
);

-- 8. Relacionamento OS - Serviços Realizados
CREATE TABLE OS_Services (
    idOS INT,
    idServiceRef INT,
    Quantity INT DEFAULT 1, -- Pode haver repetição do mesmo serviço (ex: retífica de 4 cilindros)
    PRIMARY KEY (idOS, idServiceRef),
    CONSTRAINT fk_osservices_os FOREIGN KEY (idOS) REFERENCES ServiceOrder(idOS),
    CONSTRAINT fk_osservices_service FOREIGN KEY (idServiceRef) REFERENCES ServiceReference(idServiceRef)
);