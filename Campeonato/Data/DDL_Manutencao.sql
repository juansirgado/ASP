--------------------------------------------------------------------------------
-- DROP do Banco de Dados Campeonato;
--------------------------------------------------------------------------------

-- DROP das Tabelas, Indices e Restições
--------------------------------------------------------------------------------
DROP TABLE conexao       CASCADE CONSTRAINTS;
DROP TABLE palpite       CASCADE CONSTRAINTS;
DROP TABLE classificacao CASCADE CONSTRAINTS;
DROP TABLE aposta        CASCADE CONSTRAINTS;
DROP TABLE pessoa        CASCADE CONSTRAINTS;
DROP TABLE parametro     CASCADE CONSTRAINTS;
DROP TABLE jogo          CASCADE CONSTRAINTS;
DROP TABLE equipe        CASCADE CONSTRAINTS;
DROP TABLE fase          CASCADE CONSTRAINTS;
DROP TABLE grupo         CASCADE CONSTRAINTS;
DROP TABLE local         CASCADE CONSTRAINTS;
DROP TABLE resultado     CASCADE CONSTRAINTS;
DROP TABLE estado        CASCADE CONSTRAINTS;
DROP TABLE campeonato    CASCADE CONSTRAINTS;
--------------------------------------------------------------------------------

-- DROP das Seqüências
--------------------------------------------------------------------------------
DROP SEQUENCE sq_cd_aposta;
DROP SEQUENCE sq_cd_campeonato;
DROP SEQUENCE sq_cd_classificacao;
DROP SEQUENCE sq_cd_conexao;
DROP SEQUENCE sq_cd_equipe;
DROP SEQUENCE sq_cd_erro;
DROP SEQUENCE sq_cd_estado;
DROP SEQUENCE sq_cd_fase;
DROP SEQUENCE sq_cd_grupo;
DROP SEQUENCE sq_cd_jogo;
DROP SEQUENCE sq_cd_local;
DROP SEQUENCE sq_cd_palpite;
DROP SEQUENCE sq_cd_parametro;
DROP SEQUENCE sq_cd_pessoa;
--------------------------------------------------------------------------------

-- DROP dos Pacotes, Procedimentos e Funções.
--------------------------------------------------------------------------------
DROP PACKAGE pkgclassificacao;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Manutenções diversas do Banco de Dados Campeonato;
--------------------------------------------------------------------------------
DROP TABLE erro CASCADE CONSTRAINTS;
TRUNCATE TABLE conexao;
ALTER TABLE equipe DROP   COLUMN equ_cd_estado;
ALTER TABLE Jogo   DROP   COLUMN jog_nm_estadio;
ALTER TABLE Jogo   DROP   COLUMN jog_nm_cidade;
ALTER TABLE Jogo   DROP   COLUMN jog_cd_estado;
ALTER TABLE equipe MODIFY est_cd_estado     NOT NULL;
ALTER TABLE erro   MODIFY cam_cd_campeonato NOT NULL;
ALTER TABLE local  ADD    loc_ds_local      VARCHAR2(500);
ALTER TABLE aposta ADD    apo_nm_aposta     VARCHAR2(50) NOT NULL;
ALTER TABLE erro   ADD    cam_cd_campeonato NUMBER(5);
--------------------------------------------------------------------------------
INSERT INTO Campeonato.Aposta        (SELECT * FROM System.Aposta);
INSERT INTO Campeonato.Campeonato    (SELECT * FROM System.Campeonato);
INSERT INTO Campeonato.Classificacao (SELECT * FROM System.Classificacao);
INSERT INTO Campeonato.Conexao       (SELECT * FROM System.Conexao);
INSERT INTO Campeonato.Equipe        (SELECT * FROM System.Equipe);
INSERT INTO Campeonato.Erro          (SELECT * FROM System.Erro);
INSERT INTO Campeonato.Fase          (SELECT * FROM System.Fase);
INSERT INTO Campeonato.Grupo         (SELECT * FROM System.Grupo);
INSERT INTO Campeonato.Jogo          (SELECT * FROM System.Jogo);
INSERT INTO Campeonato.Palpite       (SELECT * FROM System.Palpite);
INSERT INTO Campeonato.Parametro     (SELECT * FROM System.Parametro);
INSERT INTO Campeonato.Pessoa        (SELECT * FROM System.Pessoa);
INSERT INTO Campeonato.Resultado     (SELECT * FROM System.Resultado);
--------------------------------------------------------------------------------
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('00', '*Não se aplica');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('AC', 'Acre');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('AL', 'Alagoas');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('AM', 'Amazonas');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('AP', 'Amapá');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('BA', 'Bahia');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('CE', 'Ceará');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('DF', 'Distrito Federal');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('ES', 'Espírito Santo');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('GO', 'Goiás');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('MA', 'Maranhão');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('MG', 'Minas Gerais');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('MS', 'Mato Grosso do Sul');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('MT', 'Mato Grosso');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('PA', 'Pará');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('PB', 'Paraíba');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('PE', 'Pernambuco');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('PI', 'Piauí');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('PR', 'Paraná');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('RJ', 'Rio de Janeiro');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('RN', 'Rio Grande do Norte');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('RO', 'Rondônia');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('RR', 'Roraima');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('RS', 'Rio Grande do Sul');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('SC', 'Santa Catarina');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('SE', 'Sergipe');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('SP', 'São Paulo');
INSERT INTO Estado (est_cd_estado, est_nm_estado) VALUES('TO', 'Tocantins');
--------------------------------------------------------------------------------
INSERT INTO Equipe (equ_cd_equipe, equ_nm_equipe, equ_ds_equipe, est_cd_estado) VALUES (0, '*Pendente de definição', ' ', '00');
--------------------------------------------------------------------------------
INSERT INTO Resultado (res_cd_resultado, res_nm_resultado) VALUES (0, '*Pendente');
INSERT INTO Resultado (res_cd_resultado, res_nm_resultado) VALUES (1, 'Errado');
INSERT INTO Resultado (res_cd_resultado, res_nm_resultado) VALUES (2, 'Parcial');
INSERT INTO Resultado (res_cd_resultado, res_nm_resultado) VALUES (3, 'Correto');
--------------------------------------------------------------------------------
Select Distinct 'insert into Local (loc_cd_local, loc_nm_local, loc_nm_cidade, est_cd_estado) values (sq_cd_local.nextval, ''' || JOG_NM_ESTADIO || ''', ''' || JOG_NM_CIDADE || ''', ''' || JOG_CD_ESTADO || ''');' from jogo;
Select 'update jogo set loc_cd_local=' || loc_cd_local || ' where jog_nm_estadio = ''' || loc_nm_local || ''';' from local
--------------------------------------------------------------------------------