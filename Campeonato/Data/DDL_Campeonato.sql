/*
   -------------------------------------------------------------
   Program      : PkgClassificacao.sql
   Description  : Criação da Base de Dados do sistema Campeonato
   Version      : 1.0
   Date         : 24/06/2005
   Author       : Juan Sirgado y Antico
   Copyright(c) 2005 by JSyA Informática. All Rights Reserved.
   -------------------------------------------------------------
   Version      :
   Date         :
   Author       :
   -------------------------------------------------------------
*/

-- PCTFREE 8 INITRANS 2 MAXTRANS 255
-- STORAGE (INITIAL 1m NEXT 1m MINEXTENTS 1 MAXEXTENTS 255 PCTINCREASE 0 FREELISTS 1)

--------------------------------------------------------------------------------
CREATE TABLESPACE ts_campeonato_data
  datafile 'D:\oracle\product\10.2.0\oradata\orahome\Campeonato\data.dbf'
  size 64m autoextend on
  next 32m maxsize 2048m
  extent management local
  logging;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLESPACE ts_campeonato_index
  datafile 'D:\oracle\product\10.2.0\oradata\orahome\Campeonato\index.dbf'
  size 32m autoextend on
  next 16m maxsize 1024m
  extent management local
  logging;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Aposta
      (apo_cd_aposta      NUMBER(5)    NOT NULL, -- (PK)
       apo_nm_aposta      VARCHAR2(50) NOT NULL,
       apo_qt_errado      NUMBER(3)    NOT NULL,
       apo_qt_parcial     NUMBER(3)    NOT NULL,
       apo_qt_correto     NUMBER(3)    NOT NULL,
       apo_qt_pontos      NUMBER(5)    NOT NULL,
       apo_dt_ultima_alt  DATE         NOT NULL,
       apo_cd_usuario_alt VARCHAR2(50) NOT NULL,
       apo_nu_ip_alt      VARCHAR2(50) NOT NULL,
       cam_cd_campeonato  NUMBER(5)    NOT NULL, -- (FK)
       pes_cd_pessoa      NUMBER(5)    NOT NULL) -- (FK)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Campeonato
      (cam_cd_campeonato    NUMBER(5)     NOT NULL, -- (PK)
       cam_nm_campeonato    VARCHAR2(50)  NOT NULL,
       cam_ds_campeonato    VARCHAR2(500) NOT NULL,
       cam_dt_inicio        DATE          NOT NULL,
       cam_dt_termino       DATE          NOT NULL,
       cam_vl_aposta        NUMBER(11,2)  NOT NULL,
       cam_in_classificacao NUMBER(1)     NOT NULL)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE CamEqu
      (rce_cd_cam_equ       NUMBER(9)     NOT NULL, -- (PK)
       cam_cd_campeonato    NUMBER(5)     NOT NULL, -- (FK)
       equ_cd_equipe        NUMBER(5)     NOT NULL) -- (FK)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Classificacao
      (cla_cd_classificacao NUMBER(5) NOT NULL, -- (PK)
       cla_qt_vitoria       NUMBER(3) NOT NULL,
       cla_qt_empate        NUMBER(3) NOT NULL,
       cla_qt_derrota       NUMBER(3) NOT NULL,
       cla_qt_gol_pro       NUMBER(5) NOT NULL,
       cla_qt_gol_contra    NUMBER(5) NOT NULL,
       cla_qt_cartao_am     NUMBER(5) NOT NULL,
       cla_qt_cartao_vr     NUMBER(5) NOT NULL,
       cla_qt_pontos        NUMBER(9) NOT NULL,
       cam_cd_campeonato    NUMBER(5) NOT NULL, -- (FK)
       equ_cd_equipe        NUMBER(5) NOT NULL) -- (FK)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Conexao
      (con_cd_conexao        NUMBER(9)    NOT NULL, -- (PK)
       con_dt_inicio_conexao DATE         NOT NULL,
       con_dt_fim_conexao    DATE             NULL,
       con_cd_usuario        VARCHAR2(50) NOT NULL,
       con_cd_sessao         NUMBER(15)   NOT NULL)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Equipe
      (equ_cd_equipe     NUMBER(5)     NOT NULL, -- (PK)
       equ_nm_equipe     VARCHAR2(50)  NOT NULL,
       equ_ds_equipe     VARCHAR2(500) NOT NULL,
       est_cd_estado     CHAR(2)       NOT NULL) -- (FK)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Erro
      (err_cd_erro       NUMBER(5)     NOT NULL, -- (PK)
       err_dt_erro       DATE          NOT NULL,
       err_nm_processo   VARCHAR2(50)  NOT NULL,
       err_cd_mensagem   VARCHAR2(25)  NOT NULL,
       err_ds_mensagem   VARCHAR2(500) NOT NULL,
       cam_cd_campeonato NUMBER(5)     NOT NULL) -- (FK)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Estado
      (est_cd_estado     CHAR(2)      NOT NULL, -- (PK)
       est_nm_estado     VARCHAR2(50) NOT NULL)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Fase
      (fas_cd_fase       NUMBER(5)    NOT NULL, -- (PK)
       fas_nm_fase       VARCHAR2(50) NOT NULL,
       cam_cd_campeonato NUMBER(5)    NOT NULL) -- (FK)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Grupo
      (gru_cd_grupo      NUMBER(5)    NOT NULL, -- (PK)
       gru_nm_grupo      VARCHAR2(50) NOT NULL,
       cam_cd_campeonato NUMBER(5)    NOT NULL) -- (FK)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Jogo
      (jog_cd_jogo        NUMBER(5)     NOT NULL, -- (PK)
       jog_dt_jogo        DATE          NOT NULL,
       jog_ds_jogo        VARCHAR2(500) NOT NULL,
       equ_cd_equipe_1    NUMBER(5)     NOT NULL, -- (FK)
       equ_cd_equipe_2    NUMBER(5)     NOT NULL, -- (FK)
       jog_qt_gol90_equ_1 NUMBER(3)         NULL,
       jog_qt_gol90_equ_2 NUMBER(3)         NULL,
       jog_qt_gol_equ_1   NUMBER(3)         NULL,
       jog_qt_gol_equ_2   NUMBER(3)         NULL,
       jog_qt_cartao_am_1 NUMBER(2)         NULL,
       jog_qt_cartao_am_2 NUMBER(2)         NULL,
       jog_qt_cartao_vr_1 NUMBER(2)         NULL,
       jog_qt_cartao_vr_2 NUMBER(2)         NULL,
       cam_cd_campeonato  NUMBER(5)     NOT NULL, -- (FK)
       fas_cd_fase        NUMBER(5)     NOT NULL, -- (FK)
       gru_cd_grupo       NUMBER(5)     NOT NULL, -- (FK)
       loc_cd_local       NUMBER(5)     NOT NULL) -- (FK)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Local
      (loc_cd_local         NUMBER(5)     NOT NULL, -- (PK)
       loc_nm_local         VARCHAR2(50)  NOT NULL,
       loc_ds_local         VARCHAR2(500) NOT NULL,
       est_cd_estado        CHAR(2)       NOT NULL) -- (FK)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Palpite
      (pal_cd_palpite      NUMBER(5)    NOT NULL, -- (PK)
       pal_qt_gol_equipe_1 NUMBER(3)    NOT NULL,
       pal_qt_gol_equipe_2 NUMBER(3)    NOT NULL,
       pal_qt_pontos       NUMBER(5)    NOT NULL,
       res_cd_resultado    NUMBER(1)    NOT NULL, -- (FK)
       jog_cd_jogo         NUMBER(5)    NOT NULL, -- (FK)
       apo_cd_aposta       NUMBER(5)    NOT NULL) -- (FK)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Parametro
      (par_cd_parametro   NUMBER(5)    NOT NULL, -- (PK)
       par_vl_jog_derrota NUMBER(5)    NOT NULL,
       par_vl_jog_empate  NUMBER(5)    NOT NULL,
       par_vl_jog_vitoria NUMBER(5)    NOT NULL,
       par_vl_pal_errado  NUMBER(5)    NOT NULL,
       par_vl_pal_parcial NUMBER(5)    NOT NULL,
       par_vl_pal_correto NUMBER(5)    NOT NULL,
       cam_cd_campeonato  NUMBER(5)    NOT NULL, -- (FK)
       fas_cd_fase        NUMBER(5)    NOT NULL) -- (FK)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Pessoa
      (pes_cd_pessoa        NUMBER(5)    NOT NULL, -- (PK)
       pes_nm_pessoa        VARCHAR2(50) NOT NULL,
       pes_cd_identificacao VARCHAR2(50) NOT NULL,
       pes_nu_cpf           NUMBER(15)       NULL,
       pes_nu_rg            NUMBER(15)       NULL,
       pes_nu_telefone      NUMBER(20)       NULL,
       pes_nu_celular       NUMBER(20)       NULL,
       pes_ds_email         VARCHAR2(50)     NULL,
       pes_dt_nascimento    DATE             NULL,
       pes_cd_acesso        VARCHAR2(50) NOT NULL,
       pes_in_nivel         NUMBER(1)    NOT NULL)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Resultado
      (res_cd_resultado NUMBER(5)    NOT NULL, -- (PK)
       res_nm_resultado VARCHAR2(50) NOT NULL)
TABLESPACE ts_campeonato_data;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE sequence sq_cd_aposta        START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_campeonato    START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_cam_equ       START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_classificacao START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_conexao       START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_equipe        START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_erro          START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_estado        START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_fase          START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_grupo         START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_jogo          START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_local         START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_palpite       START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_parametro     START WITH 1 INCREMENT BY 1;
CREATE sequence sq_cd_pessoa        START WITH 1 INCREMENT BY 1;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE UNIQUE INDEX pk_aposta        ON Aposta        (apo_cd_aposta        ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_campeonato    ON Campeonato    (cam_cd_campeonato    ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_camequ        ON CamEqu        (rce_cd_cam_equ       ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_classificacao ON Classificacao (cla_cd_classificacao ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_conexao       ON Conexao       (con_cd_conexao       ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_equipe        ON Equipe        (equ_cd_equipe        ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_erro          ON Erro          (err_cd_erro          ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_estado        ON Estado        (est_cd_estado        ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_fase          ON Fase          (fas_cd_fase          ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_grupo         ON Grupo         (gru_cd_grupo         ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_jogo          ON Jogo          (jog_cd_jogo          ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_local         ON Local         (loc_cd_local         ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_palpite       ON Palpite       (pal_cd_palpite       ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_parametro     ON Parametro     (par_cd_parametro     ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_pessoa        ON Pessoa        (pes_cd_pessoa        ASC) TABLESPACE ts_campeonato_index;
CREATE UNIQUE INDEX pk_resultado     ON Resultado     (res_cd_resultado     ASC) TABLESPACE ts_campeonato_index;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
ALTER TABLE Aposta        ADD (CONSTRAINT pk_aposta        PRIMARY KEY (apo_cd_aposta)        USING INDEX);
ALTER TABLE Campeonato    ADD (CONSTRAINT pk_campeonato    PRIMARY KEY (cam_cd_campeonato)    USING INDEX);
ALTER TABLE CamEqu        ADD (CONSTRAINT pk_camequi       PRIMARY KEY (rce_cd_cam_equ)       USING INDEX);
ALTER TABLE Classificacao ADD (CONSTRAINT pk_classificacao PRIMARY KEY (cla_cd_classificacao) USING INDEX);
ALTER TABLE Conexao       ADD (CONSTRAINT pk_conexao       PRIMARY KEY (con_cd_conexao)       USING INDEX);
ALTER TABLE Equipe        ADD (CONSTRAINT pk_equipe        PRIMARY KEY (equ_cd_equipe)        USING INDEX);
ALTER TABLE Erro          ADD (CONSTRAINT pk_erro          PRIMARY KEY (err_cd_erro)          USING INDEX);
ALTER TABLE Estado        ADD (CONSTRAINT pk_estado        PRIMARY KEY (est_cd_estado)        USING INDEX);
ALTER TABLE Fase          ADD (CONSTRAINT pk_fase          PRIMARY KEY (fas_cd_fase)          USING INDEX);
ALTER TABLE Grupo         ADD (CONSTRAINT pk_grupo         PRIMARY KEY (gru_cd_grupo)         USING INDEX);
ALTER TABLE Jogo          ADD (CONSTRAINT pk_jogo          PRIMARY KEY (jog_cd_jogo)          USING INDEX);
ALTER TABLE Local         ADD (CONSTRAINT pk_local         PRIMARY KEY (loc_cd_local)         USING INDEX);
ALTER TABLE Palpite       ADD (CONSTRAINT pk_palpite       PRIMARY KEY (pal_cd_palpite)       USING INDEX);
ALTER TABLE Parametro     ADD (CONSTRAINT pk_parametro     PRIMARY KEY (par_cd_parametro)     USING INDEX);
ALTER TABLE Pessoa        ADD (CONSTRAINT pk_pessoa        PRIMARY KEY (pes_cd_pessoa)        USING INDEX);
ALTER TABLE Resultado     ADD (CONSTRAINT pk_resultado     PRIMARY KEY (res_cd_resultado)     USING INDEX);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
ALTER TABLE Aposta        ADD (CONSTRAINT fk_aposta_01        FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato);
ALTER TABLE Aposta        ADD (CONSTRAINT fk_aposta_02        FOREIGN KEY (pes_cd_pessoa)     REFERENCES Pessoa);
ALTER TABLE Classificacao ADD (CONSTRAINT fk_classificacao_01 FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato);
ALTER TABLE Classificacao ADD (CONSTRAINT fk_classificacao_02 FOREIGN KEY (equ_cd_equipe)     REFERENCES Equipe);
ALTER TABLE CamEqu        ADD (CONSTRAINT fk_camequ_01        FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato);
ALTER TABLE CamEqu        ADD (CONSTRAINT fk_camequ_02        FOREIGN KEY (equ_cd_equipe)     REFERENCES Equipe);
ALTER TABLE Equipe        ADD (CONSTRAINT fk_equipe_01        FOREIGN KEY (est_cd_estado)     REFERENCES Estado);
ALTER TABLE Fase          ADD (CONSTRAINT fk_fase_01          FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato);
ALTER TABLE Grupo         ADD (CONSTRAINT fk_grupo_01         FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato);
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_01          FOREIGN KEY (equ_cd_equipe_1)   REFERENCES Equipe);
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_02          FOREIGN KEY (equ_cd_equipe_2)   REFERENCES Equipe);
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_03          FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato);
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_04          FOREIGN KEY (fas_cd_fase)       REFERENCES Fase);
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_05          FOREIGN KEY (gru_cd_grupo)      REFERENCES Grupo);
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_06          FOREIGN KEY (loc_cd_local)      REFERENCES Local);
ALTER TABLE Palpite       ADD (CONSTRAINT fk_palpite_01       FOREIGN KEY (res_cd_resultado)  REFERENCES Resultado);
ALTER TABLE Palpite       ADD (CONSTRAINT fk_palpite_02       FOREIGN KEY (jog_cd_jogo)       REFERENCES Jogo);
ALTER TABLE Palpite       ADD (CONSTRAINT fk_palpite_03       FOREIGN KEY (apo_cd_aposta)     REFERENCES Aposta);
ALTER TABLE Parametro     ADD (CONSTRAINT fk_parametro_01     FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato);
ALTER TABLE Parametro     ADD (CONSTRAINT fk_parametro_02     FOREIGN KEY (fas_cd_fase)       REFERENCES Fase);
--------------------------------------------------------------------------------