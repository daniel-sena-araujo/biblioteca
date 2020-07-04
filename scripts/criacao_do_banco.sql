CREATE DATABASE db_biblioteca;
GO

USE db_biblioteca;
GO

CREATE TABLE tb_leitor(
	codigo INT IDENTITY,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR(50) NOT NULL,
	telefone VARCHAR(11) NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	data_nascimento DATE NULL,
	estado_civil TINYINT NOT NULL,
	ativo TINYINT NOT NULL,
	escolaridade TINYINT NOT NULL,
	CONSTRAINT pk_leitor PRIMARY KEY(codigo)
);
GO

CREATE INDEX in_leitor_nome
  ON tb_leitor(nome);
GO

CREATE TABLE tb_livro(
	codigo INT IDENTITY,
	titulo VARCHAR(50) NOT NULL,
	autor VARCHAR(50) NOT NULL,
	editora VARCHAR(50) NOT NULL,
	CONSTRAINT pk_livro PRIMARY KEY(codigo)
);
GO

CREATE TABLE tb_exemplar(
	codigo INT IDENTITY,
	codigo_livro INT NOT NULL,
	serie INT NOT NULL,
	data_compra DATE NULL,
	CONSTRAINT pk_exemplar PRIMARY KEY(codigo),
	CONSTRAINT fk_exemplar_livro FOREIGN KEY(codigo_livro) REFERENCES tb_livro(codigo)
);
GO

CREATE TABLE tb_emprestimo(
	codigo INT IDENTITY,
	codigo_leitor INT NOT NULL,
	data_emprestimo DATE NOT NULL,
	data_previsao DATE NOT NULL,
	data_devolucao DATE NULL,
	CONSTRAINT pk_emprestimo PRIMARY KEY(codigo),
	CONSTRAINT fk_emprestimo_leitor FOREIGN KEY(codigo_leitor) REFERENCES tb_leitor(codigo)
);
GO

CREATE TABLE tb_exemplar_emprestimo(
	codigo INT IDENTITY,
	codigo_emprestimo INT NOT NULL,
	codigo_exemplar INT NOT NULL,
	CONSTRAINT pk_exemplar_emprestimo PRIMARY KEY(codigo),
	CONSTRAINT fk_exemplar_emprestimo_emprestimo FOREIGN KEY(codigo_emprestimo) REFERENCES tb_emprestimo(codigo),
	CONSTRAINT fk_exemplar_emprestimo_exemplar FOREIGN KEY(codigo_exemplar) REFERENCES tb_exemplar(codigo)
);
GO