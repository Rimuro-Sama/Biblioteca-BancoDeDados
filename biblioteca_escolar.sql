-- =====================================================================
-- PROJETO FINAL - BANCO DE DADOS | FATEC
-- Banco: biblioteca_escolar (MySQL / MariaDB / phpMyAdmin)
-- =====================================================================


-- =====================================================================
-- ETAPA 3 - CRIACAO DO BANCO E DAS TABELAS
-- =====================================================================
CREATE DATABASE biblioteca_escolar;
USE biblioteca_escolar;

CREATE TABLE leitor (
    id_leitor INT AUTO_INCREMENT PRIMARY KEY,
    nome      VARCHAR(100) NOT NULL,
    email     VARCHAR(100),
    turma     VARCHAR(30)
);

CREATE TABLE livro (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo   VARCHAR(150) NOT NULL,
    autor    VARCHAR(100) NOT NULL,
    ano      INT
);

CREATE TABLE emprestimo (
    id_emprestimo   INT AUTO_INCREMENT PRIMARY KEY,
    id_leitor       INT  NOT NULL,
    id_livro        INT  NOT NULL,
    data_emprestimo DATE NOT NULL,
    data_devolucao  DATE,
    FOREIGN KEY (id_leitor) REFERENCES leitor (id_leitor),
    FOREIGN KEY (id_livro)  REFERENCES livro (id_livro)
);

SHOW TABLES;
DESCRIBE leitor;
DESCRIBE livro;
DESCRIBE emprestimo;


-- =====================================================================
-- ETAPA 4 - INSERCAO DE REGISTROS (3 leitores, 4 livros, 5 emprestimos)
-- =====================================================================
INSERT INTO leitor (nome, email, turma) VALUES
    ('Ana Souza',    'ana.souza@escola.com',    '1o Ano A'),
    ('Bruno Lima',   'bruno.lima@escola.com',   '2o Ano B'),
    ('Carla Mendes', 'carla.mendes@escola.com', '3o Ano C');

INSERT INTO livro (titulo, autor, ano) VALUES
    ('Dom Casmurro',                    'Machado de Assis',  1899),
    ('O Cortico',                       'Aluisio Azevedo',   1890),
    ('Capitaes da Areia',               'Jorge Amado',       1937),
    ('Memorias Postumas de Bras Cubas', 'Machado de Assis',  1881);

INSERT INTO emprestimo (id_leitor, id_livro, data_emprestimo, data_devolucao) VALUES
    (1, 1, '2026-10-01', '2026-10-15'),
    (1, 3, '2026-10-05', '2026-10-19'),
    (2, 1, '2026-10-20', NULL),          -- mesmo livro (1) emprestado em outro momento
    (3, 2, '2026-10-22', NULL),
    (2, 4, '2026-10-25', NULL);

-- Consulta 1: listar todos os leitores
SELECT * FROM leitor;

-- Consulta 2: filtrar registros com WHERE (emprestimos ainda nao devolvidos)
SELECT * FROM emprestimo WHERE data_devolucao IS NULL;

-- Consulta 3: ordenar resultados com ORDER BY (livros por titulo)
SELECT * FROM livro ORDER BY titulo ASC;

-- Consulta extra: emprestimos com nome do leitor e titulo do livro (JOIN)
SELECT e.id_emprestimo, l.nome AS leitor, v.titulo AS livro,
       e.data_emprestimo, e.data_devolucao
FROM emprestimo e
JOIN leitor l ON l.id_leitor = e.id_leitor
JOIN livro  v ON v.id_livro  = e.id_livro
ORDER BY e.id_emprestimo;


-- =====================================================================
-- ETAPA 5 - ALTERACOES E EXCLUSAO
-- =====================================================================

-- 5.1 ALTER TABLE: adicionar coluna telefone em leitor
ALTER TABLE leitor ADD COLUMN telefone VARCHAR(20);
DESCRIBE leitor;

-- 5.2 UPDATE com WHERE: conferir a condicao antes de alterar
SELECT * FROM leitor WHERE id_leitor = 2;
UPDATE leitor SET telefone = '(11) 99999-1234' WHERE id_leitor = 2;
SELECT * FROM leitor;

-- 5.3 DELETE com WHERE: conferir a condicao antes de excluir
SELECT * FROM emprestimo WHERE id_emprestimo = 5;
DELETE FROM emprestimo WHERE id_emprestimo = 5;

-- 5.4 SELECT para mostrar o resultado final
SELECT * FROM emprestimo;
