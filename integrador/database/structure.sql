DROP DATABASE IF EXISTS `db_ead`;
CREATE DATABASE db_ead;
USE db_ead;

DROP TABLE IF EXISTS `tb_usuario`;
CREATE TABLE tb_usuario(
  id INT NOT NULL AUTO_INCREMENT,
  usuario VARCHAR(200) NOT NULL,
  senha VARCHAR(32) NOT NULL,
  PRIMARY KEY (id)
)engine InnoDB;

DROP TABLE IF EXISTS `tb_endereco`;    
CREATE TABLE tb_endereco(
	id int auto_increment primary key,
    logradouro varchar(40),
    numero int,
    complemento varchar(40),
    bairro varchar(50),
    cep varchar(15),
    cidade varchar(50),
    estado varchar(50)
)engine InnoDB;

DROP TABLE IF EXISTS `tb_contato`;
CREATE TABLE tb_contato(
	id int auto_increment primary key,
    email varchar(50),
    celular varchar(30)
)engine InnoDB;


DROP TABLE IF EXISTS `tb_aluno`;
CREATE TABLE tb_aluno(
	id int auto_increment primary key,
    ra int unique not null,
    nome varchar(100) not null,
    cpf varchar(15) not null,
    dt_nasc date not null,
    id_usuario int not null unique,
    id_end int not null,
    id_contato int not null,
	constraint fk_usuario_pk_aluno foreign key (id_usuario) references tb_usuario(id),
	constraint fk_end_pk_aluno foreign key (id_end) references tb_endereco(id),
    constraint fk_ct_pk_aluno foreign key (id_contato) references tb_contato(id)
)engine InnoDB;

DROP TABLE IF EXISTS `tb_curso`;
CREATE TABLE tb_curso(
	id int auto_increment,
    nome varchar(70) not null,
    descricao text,
    nota_minima decimal (5,2),
    PRIMARY KEY(id)
)engine InnoDB;


DROP TABLE IF EXISTS `tb_aula`;
CREATE TABLE tb_aula(
	id int auto_increment PRIMARY KEY,
	nome varchar(50) not null,
    descricao text,
	id_curso int not null,
	constraint fk_curso_pk_aula foreign key (id_curso) references tb_curso(id)
)engine InnoDB;

DROP TABLE IF EXISTS `tb_matricula`;
CREATE TABLE tb_matricula(
	id int auto_increment PRIMARY KEY,
    data_matricula timestamp default current_timestamp(),
	id_aluno int not null,
	id_curso int not null,
	constraint fk_aluno_pk_matri foreign key (id_aluno) references tb_aluno(id),
	constraint fk_curso_pk_matri foreign key (id_curso) references tb_curso(id)
)engine InnoDB;


DROP TABLE IF EXISTS `tb_questao`;
CREATE TABLE tb_questao(
	id int auto_increment PRIMARY KEY,
    questao varchar(250),
    id_curso int not null,
    constraint fk_curso_pk_questao foreign key (id_curso) references tb_curso(id)
)engine InnoDB;


DROP TABLE IF EXISTS `tb_alternativa`;
CREATE TABLE tb_alternativa(
	id int auto_increment PRIMARY KEY,
    at_1 varchar (255), 
    at_2 varchar (255), 
    at_3 varchar (255), 
    at_4 varchar (255), 
    at_correta varchar (10), 
	id_questao int not null,	
    constraint fk_questao_pk_at foreign key (id_questao) references tb_questao(id)
)engine InnoDB;

DROP TABLE IF EXISTS `tb_avaliacao`;
CREATE TABLE tb_avaliacao(
	id int auto_increment PRIMARY KEY,
    data_av timestamp default current_timestamp(),
    nota_final decimal (5,2),
	id_aluno int not null,
    id_curso int not null,
	constraint fk_aluno_pk_av foreign key (id_aluno) references tb_aluno(id),
	constraint fk_curso_pk_av foreign key (id_curso) references tb_curso(id)
)engine InnoDB;



