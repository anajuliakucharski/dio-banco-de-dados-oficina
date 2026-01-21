# Oficina Mecânica - Database Project

Este projeto contém a modelagem lógica e a implementação SQL de um banco de dados para uma **Oficina Mecânica**. Faz parte do desafio "Projeto Lógico de Banco de Dados" e demonstra conceitos de modelagem relacional, DDL/DML e consultas SQL.

## 📋 Descrição do cenário

O objetivo é criar um esquema robusto para gerenciar as operações de uma oficina, cobrindo:

- **Clientes e Veículos**: relacionamento 1:N (um cliente pode ter vários veículos).
- **Mecânicos e Equipes**: cadastro de especialistas e atribuição de equipes responsáveis pelos serviços.
- **Ordens de Serviço (OS)**: entidade central que conecta veículo, equipe e itens consumidos.
- **Peças e Serviços**: separação entre peças (estoque) e mão de obra (tabela de referência), permitindo composições de custos na OS.

## 🚀 Tecnologias utilizadas

- MySQL — Sistema Gerenciador de Banco de Dados.
- SQL (DDL & DML) — criação de estruturas e manipulação de dados.
- Modelagem relacional — uso de chaves primárias (PK), estrangeiras (FK) e normalização.

## 📂 Estrutura do projeto

O script SQL está dividido em três partes principais:

1. **DDL (Data Definition Language)**  
   Criação do banco, tabelas e relacionamentos.  
   Tabelas principais: `Clients`, `Vehicles`, `Mechanics`, `ServiceOrder`, `PartsStorage`, `ServiceReference`.  
   Tabelas associativas: `OS_Parts`, `OS_Services` (resolvendo relacionamentos N:M).

2. **DML (Data Manipulation Language)**  
   Inserção de dados fictícios para testes e validação das regras de negócio.

3. **Queries (DQL)**  
   Consultas para relatórios e insights sobre as operações da oficina.

## 📊 Funcionalidades implementadas (queries)

Foram criadas queries que demonstram:

- ✅ Recuperações simples (`SELECT *` e projeção de colunas).  
- ✅ Filtros e ordenação (`WHERE`, `ORDER BY`) para relatórios por data e status.  
- ✅ Junções (`INNER JOIN`) conectando múltiplas tabelas para visualizar a OS completa.  
- ✅ Atributos derivados — cálculo dinâmico de valores (preço unitário × quantidade + mão de obra) diretamente no SQL.  
- ✅ Agregações e grupos — uso de `GROUP BY` e `HAVING` para, por exemplo, listar clientes com múltiplos veículos.

## ▶️ Como executar

1. Abra seu cliente MySQL (MySQL Workbench, DBeaver, CLI, etc.).  
2. Importe/execute o script DDL para criar o esquema.  
3. Execute o DML para popular com dados de exemplo.  
4. Rode as queries de DQL para gerar relatórios e validar as regras de negócio.
