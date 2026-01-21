-- Inserindo Clientes
INSERT INTO Clients (Fname, Lname, CPF, Address, Contact) VALUES
('Ana', 'Silva', '12345678901', 'Rua das Flores, 10', '41999999999'),
('Bruno', 'Souza', '98765432100', 'Av. Central, 500', '11988888888'),
('Carlos', 'Pereira', '45678912345', 'Rua Nova, 22', '21977777777');

-- Inserindo Mecânicos
INSERT INTO Mechanics (Name, Specialty) VALUES
('João da Chave', 'Motor'),
('Pedro Elétrico', 'Elétrica'),
('Mário Geral', 'Geral');

-- Inserindo Veículos
INSERT INTO Vehicles (idClient, LicensePlate, Brand, Model, Year) VALUES
(1, 'ABC1234', 'Fiat', 'Uno', '2015'),
(2, 'XYZ9876', 'Volkswagen', 'Gol', '2018'),
(1, 'DEF5678', 'Honda', 'Civic', '2020');

-- Inserindo Tabela de Preços (Serviços e Peças)
INSERT INTO ServiceReference (ServiceName, StandardLaborPrice) VALUES
('Troca de Óleo', 50.00),
('Alinhamento e Balanceamento', 120.00),
('Revisão Elétrica', 200.00),
('Retífica de Motor', 1500.00);

INSERT INTO PartsStorage (PartName, UnitPrice, QuantityInStock) VALUES
('Óleo 5w30', 45.00, 100),
('Filtro de Óleo', 25.00, 50),
('Pastilha de Freio', 180.00, 30),
('Bateria 60Ah', 450.00, 10);

-- Criando Ordens de Serviço (OS)
-- OS 1: Troca de óleo para o Uno da Ana (Finalizado)
INSERT INTO ServiceOrder (idVehicle, idMechanicLead, IssueDate, CompletionDate, Status, TotalValue) 
VALUES (1, 3, '2023-10-01', '2023-10-01', 'Finalizado', 165.00);

-- Itens da OS 1
INSERT INTO OS_Services (idOS, idServiceRef, Quantity) VALUES (1, 1, 1); -- Mão de obra troca
INSERT INTO OS_Parts (idOS, idPart, Quantity) VALUES (1, 1, 1), (1, 2, 1); -- 1 Oleo + 1 Filtro

-- OS 2: Revisão Elétrica no Gol do Bruno (Em Execução)
INSERT INTO ServiceOrder (idVehicle, idMechanicLead, IssueDate, Status) 
VALUES (2, 2, '2023-10-05', 'Em Execução');

INSERT INTO OS_Services (idOS, idServiceRef, Quantity) VALUES (2, 3, 1);
INSERT INTO OS_Parts (idOS, idPart, Quantity) VALUES (2, 4, 1); -- Bateria

-- OS 3: Civic da Ana (Em Análise)
INSERT INTO ServiceOrder (idVehicle, idMechanicLead, IssueDate, Status) 
VALUES (3, 1, '2023-10-06', 'Em Análise');