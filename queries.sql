-- quais são os veículos da marca "Fiat" cadastrados e quem são seus donos?
SELECT 
    v.Model, 
    v.Year, 
    CONCAT(c.Fname, ' ', c.Lname) AS OwnerName
FROM Vehicles v
JOIN Clients c ON v.idClient = c.idClient
WHERE v.Brand = 'Fiat';

-- listar todas as ordens de serviço que estão "Finalizadas" ordenadas pela data de conclusão mais recente
SELECT 
    os.idOS,
    c.Fname AS Client,
    v.Model AS Car,
    os.CompletionDate,
    os.Status
FROM ServiceOrder os
INNER JOIN Vehicles v ON os.idVehicle = v.idVehicle
INNER JOIN Clients c ON v.idClient = c.idClient
WHERE os.Status = 'Finalizado'
ORDER BY os.CompletionDate DESC;

--Qual o custo total estimado de peças para cada OS (sem contar a mão de obra)?
SELECT 
    os.idOS,
    SUM(p.UnitPrice * osp.Quantity) AS TotalPartsCost
FROM ServiceOrder os
INNER JOIN OS_Parts osp ON os.idOS = osp.idOS
INNER JOIN PartsStorage p ON osp.idPart = p.idPart
GROUP BY os.idOS;

-- quais clientes possuem mais de um veículo cadastrado na oficina?
SELECT 
    c.Fname, 
    COUNT(v.idVehicle) AS QtyVehicles
FROM Clients c
INNER JOIN Vehicles v ON c.idClient = v.idClient
GROUP BY c.idClient
HAVING QtyVehicles > 1;

--Gere um relatório completo da OS nº 1, listando o serviço feito, as peças usadas e calculando o valor final total (Mão de Obra + Peças) dinamicamente.
SELECT 
    os.idOS,
    v.Model,
    sr.ServiceName,
    sr.StandardLaborPrice AS LaborCost,
    p.PartName,
    p.UnitPrice,
    (p.UnitPrice + sr.StandardLaborPrice) AS TotalItemCost -- Exemplo simples de soma por linha
FROM ServiceOrder os
JOIN Vehicles v ON os.idVehicle = v.idVehicle
JOIN OS_Services oss ON os.idOS = oss.idOS
JOIN ServiceReference sr ON oss.idServiceRef = sr.idServiceRef
LEFT JOIN OS_Parts osp ON os.idOS = osp.idOS
LEFT JOIN PartsStorage p ON osp.idPart = p.idPart
WHERE os.idOS = 1;

