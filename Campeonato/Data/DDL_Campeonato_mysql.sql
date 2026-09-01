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

--------------------------------------------------------------------------------
-- CREATE USER 'campeonato' IDENTIFIED BY 'nato'; -- (On User Root)
--------------------------------------------------------------------------------
GRANT ALL PRIVILEGES       ON *.* TO 'campeonato'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES       ON *.* TO 'campeonato'@'%'         WITH GRANT OPTION;
GRANT RELOAD,PROCESS,USAGE ON *.* TO 'campeonato'@'localhost';
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE DATABASE db_campeonato;
USE db_campeonato;
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Aposta
      (apo_cd_aposta      DECIMAL(5)  NOT NULL,
       apo_nm_aposta      VARCHAR(50) NOT NULL,
       apo_qt_errado      DECIMAL(3)  NOT NULL,
       apo_qt_parcial     DECIMAL(3)  NOT NULL,
       apo_qt_correto     DECIMAL(3)  NOT NULL,
       apo_qt_pontos      DECIMAL(5)  NOT NULL,
       apo_dt_ultima_alt  DATETIME    NOT NULL,
       apo_cd_usuario_alt VARCHAR(50) NOT NULL,
       apo_nu_ip_alt      VARCHAR(50) NOT NULL,
       cam_cd_campeonato  DECIMAL(5)  NOT NULL,
       pes_cd_pessoa      DECIMAL(5)  NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Campeonato
      (cam_cd_campeonato    DECIMAL(5)    NOT NULL,
       cam_nm_campeonato    VARCHAR(50)   NOT NULL,
       cam_ds_campeonato    VARCHAR(500)  NOT NULL,
       cam_dt_inicio        DATETIME      NOT NULL,
       cam_dt_termino       DATETIME      NOT NULL,
       cam_vl_aposta        DECIMAL(11,2) NOT NULL,
       cam_in_classificacao DECIMAL(1)    NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE CamEqu
      (rce_cd_cam_equ       DECIMAL(9) NOT NULL,
       cam_cd_campeonato    DECIMAL(5) NOT NULL,
       equ_cd_equipe        DECIMAL(5) NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Classificacao
      (cla_cd_classificacao DECIMAL(5) NOT NULL,
       cla_qt_vitoria       DECIMAL(3) NOT NULL,
       cla_qt_empate        DECIMAL(3) NOT NULL,
       cla_qt_derrota       DECIMAL(3) NOT NULL,
       cla_qt_gol_pro       DECIMAL(5) NOT NULL,
       cla_qt_gol_contra    DECIMAL(5) NOT NULL,
       cla_qt_cartao_am     DECIMAL(5) NOT NULL,
       cla_qt_cartao_vr     DECIMAL(5) NOT NULL,
       cla_qt_pontos        DECIMAL(9) NOT NULL,
       cam_cd_campeonato    DECIMAL(5) NOT NULL,
       equ_cd_equipe        DECIMAL(5) NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Conexao
      (con_cd_conexao        DECIMAL(9)  NOT NULL,
       con_dt_inicio_conexao DATETIME    NOT NULL,
       con_dt_fim_conexao    DATETIME        NULL,
       con_cd_usuario        VARCHAR(50) NOT NULL,
       con_cd_sessao         DECIMAL(15) NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Equipe
      (equ_cd_equipe     DECIMAL(5)   NOT NULL,
       equ_nm_equipe     VARCHAR(50)  NOT NULL,
       equ_ds_equipe     VARCHAR(500) NOT NULL,
       est_cd_estado     CHAR(2)      NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Erro
      (err_cd_erro       DECIMAL(5)   NOT NULL,
       err_dt_erro       DATETIME     NOT NULL,
       err_nm_processo   VARCHAR(50)  NOT NULL,
       err_cd_mensagem   VARCHAR(25)  NOT NULL,
       err_ds_mensagem   VARCHAR(500) NOT NULL,
       cam_cd_campeonato DECIMAL(5)   NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Estado
      (est_cd_estado     CHAR(2)     NOT NULL,
       est_nm_estado     VARCHAR(50) NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Fase
      (fas_cd_fase       DECIMAL(5)  NOT NULL,
       fas_nm_fase       VARCHAR(50) NOT NULL,
       cam_cd_campeonato DECIMAL(5)  NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Grupo
      (gru_cd_grupo      DECIMAL(5)  NOT NULL,
       gru_nm_grupo      VARCHAR(50) NOT NULL,
       cam_cd_campeonato DECIMAL(5)  NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Jogo
      (jog_cd_jogo        DECIMAL(5)   NOT NULL,
       jog_dt_jogo        DATETIME     NOT NULL,
       jog_ds_jogo        VARCHAR(500) NOT NULL,
       equ_cd_equipe_1    DECIMAL(5)   NOT NULL,
       equ_cd_equipe_2    DECIMAL(5)   NOT NULL,
       jog_qt_gol90_equ_1 DECIMAL(3)       NULL,
       jog_qt_gol90_equ_2 DECIMAL(3)       NULL,
       jog_qt_gol_equ_1   DECIMAL(3)       NULL,
       jog_qt_gol_equ_2   DECIMAL(3)       NULL,
       jog_qt_cartao_am_1 DECIMAL(2)       NULL,
       jog_qt_cartao_am_2 DECIMAL(2)       NULL,
       jog_qt_cartao_vr_1 DECIMAL(2)       NULL,
       jog_qt_cartao_vr_2 DECIMAL(2)       NULL,
       cam_cd_campeonato  DECIMAL(5)   NOT NULL,
       fas_cd_fase        DECIMAL(5)   NOT NULL,
       gru_cd_grupo       DECIMAL(5)   NOT NULL,
       loc_cd_local       DECIMAL(5)   NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Local
      (loc_cd_local         DECIMAL(5)   NOT NULL,
       loc_nm_local         VARCHAR(50)  NOT NULL,
       loc_ds_local         VARCHAR(500) NOT NULL,
       est_cd_estado        CHAR(2)      NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Palpite
      (pal_cd_palpite      DECIMAL(5) NOT NULL,
       pal_qt_gol_equipe_1 DECIMAL(3) NOT NULL,
       pal_qt_gol_equipe_2 DECIMAL(3) NOT NULL,
       pal_qt_pontos       DECIMAL(5) NOT NULL,
       res_cd_resultado    DECIMAL(1) NOT NULL,
       jog_cd_jogo         DECIMAL(5) NOT NULL,
       apo_cd_aposta       DECIMAL(5) NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Parametro
      (par_cd_parametro   DECIMAL(5) NOT NULL,
       par_vl_jog_derrota DECIMAL(5) NOT NULL,
       par_vl_jog_empate  DECIMAL(5) NOT NULL,
       par_vl_jog_vitoria DECIMAL(5) NOT NULL,
       par_vl_pal_errado  DECIMAL(5) NOT NULL,
       par_vl_pal_parcial DECIMAL(5) NOT NULL,
       par_vl_pal_correto DECIMAL(5) NOT NULL,
       cam_cd_campeonato  DECIMAL(5) NOT NULL,
       fas_cd_fase        DECIMAL(5) NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Pessoa
      (pes_cd_pessoa        DECIMAL(5)  NOT NULL,
       pes_nm_pessoa        VARCHAR(50) NOT NULL,
       pes_cd_identificacao VARCHAR(50) NOT NULL,
       pes_nu_cpf           DECIMAL(15)     NULL,
       pes_nu_rg            DECIMAL(15)     NULL,
       pes_nu_telefone      DECIMAL(20)     NULL,
       pes_nu_celular       DECIMAL(20)     NULL,
       pes_ds_email         VARCHAR(50)     NULL,
       pes_dt_nascimento    DATETIME        NULL,
       pes_cd_acesso        VARCHAR(50) NOT NULL,
       pes_in_nivel         DECIMAL(1)  NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE TABLE Resultado
      (res_cd_resultado DECIMAL(1)  NOT NULL,
       res_nm_resultado VARCHAR(50) NOT NULL);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
CREATE UNIQUE INDEX pk_aposta        ON Aposta        (apo_cd_aposta        ASC);
CREATE UNIQUE INDEX pk_campeonato    ON Campeonato    (cam_cd_campeonato    ASC);
CREATE UNIQUE INDEX pk_camequ        ON CamEqu        (rce_cd_cam_equ       ASC);
CREATE UNIQUE INDEX pk_classificacao ON Classificacao (cla_cd_classificacao ASC);
CREATE UNIQUE INDEX pk_conexao       ON Conexao       (con_cd_conexao       ASC);
CREATE UNIQUE INDEX pk_equipe        ON Equipe        (equ_cd_equipe        ASC);
CREATE UNIQUE INDEX pk_erro          ON Erro          (err_cd_erro          ASC);
CREATE UNIQUE INDEX pk_estado        ON Estado        (est_cd_estado        ASC);
CREATE UNIQUE INDEX pk_fase          ON Fase          (fas_cd_fase          ASC);
CREATE UNIQUE INDEX pk_grupo         ON Grupo         (gru_cd_grupo         ASC);
CREATE UNIQUE INDEX pk_jogo          ON Jogo          (jog_cd_jogo          ASC);
CREATE UNIQUE INDEX pk_local         ON Local         (loc_cd_local         ASC);
CREATE UNIQUE INDEX pk_palpite       ON Palpite       (pal_cd_palpite       ASC);
CREATE UNIQUE INDEX pk_parametro     ON Parametro     (par_cd_parametro     ASC);
CREATE UNIQUE INDEX pk_pessoa        ON Pessoa        (pes_cd_pessoa        ASC);
CREATE UNIQUE INDEX pk_resultado     ON Resultado     (res_cd_resultado     ASC);
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
ALTER TABLE Aposta        ADD (CONSTRAINT pk_aposta        PRIMARY KEY (apo_cd_aposta));
ALTER TABLE Campeonato    ADD (CONSTRAINT pk_campeonato    PRIMARY KEY (cam_cd_campeonato));
ALTER TABLE CamEqu        ADD (CONSTRAINT pk_camequi       PRIMARY KEY (rce_cd_cam_equ));
ALTER TABLE Classificacao ADD (CONSTRAINT pk_classificacao PRIMARY KEY (cla_cd_classificacao));
ALTER TABLE Conexao       ADD (CONSTRAINT pk_conexao       PRIMARY KEY (con_cd_conexao));
ALTER TABLE Equipe        ADD (CONSTRAINT pk_equipe        PRIMARY KEY (equ_cd_equipe));
ALTER TABLE Erro          ADD (CONSTRAINT pk_erro          PRIMARY KEY (err_cd_erro));
ALTER TABLE Estado        ADD (CONSTRAINT pk_estado        PRIMARY KEY (est_cd_estado));
ALTER TABLE Fase          ADD (CONSTRAINT pk_fase          PRIMARY KEY (fas_cd_fase));
ALTER TABLE Grupo         ADD (CONSTRAINT pk_grupo         PRIMARY KEY (gru_cd_grupo));
ALTER TABLE Jogo          ADD (CONSTRAINT pk_jogo          PRIMARY KEY (jog_cd_jogo));
ALTER TABLE Local         ADD (CONSTRAINT pk_local         PRIMARY KEY (loc_cd_local));
ALTER TABLE Palpite       ADD (CONSTRAINT pk_palpite       PRIMARY KEY (pal_cd_palpite));
ALTER TABLE Parametro     ADD (CONSTRAINT pk_parametro     PRIMARY KEY (par_cd_parametro));
ALTER TABLE Pessoa        ADD (CONSTRAINT pk_pessoa        PRIMARY KEY (pes_cd_pessoa));
ALTER TABLE Resultado     ADD (CONSTRAINT pk_resultado     PRIMARY KEY (res_cd_resultado));
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
ALTER TABLE Aposta        ADD (CONSTRAINT fk_aposta_01        FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato (cam_cd_campeonato));
ALTER TABLE Aposta        ADD (CONSTRAINT fk_aposta_02        FOREIGN KEY (pes_cd_pessoa)     REFERENCES Pessoa     (pes_cd_pessoa));
ALTER TABLE Classificacao ADD (CONSTRAINT fk_classificacao_01 FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato (cam_cd_campeonato));
ALTER TABLE Classificacao ADD (CONSTRAINT fk_classificacao_02 FOREIGN KEY (equ_cd_equipe)     REFERENCES Equipe     (equ_cd_equipe));
ALTER TABLE CamEqu        ADD (CONSTRAINT fk_camequ_01        FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato (cam_cd_campeonato));
ALTER TABLE CamEqu        ADD (CONSTRAINT fk_camequ_02        FOREIGN KEY (equ_cd_equipe)     REFERENCES Equipe     (equ_cd_equipe));
ALTER TABLE Equipe        ADD (CONSTRAINT fk_equipe_01        FOREIGN KEY (est_cd_estado)     REFERENCES Estado     (est_cd_estado));
ALTER TABLE Fase          ADD (CONSTRAINT fk_fase_01          FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato (cam_cd_campeonato));
ALTER TABLE Grupo         ADD (CONSTRAINT fk_grupo_01         FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato (cam_cd_campeonato));
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_01          FOREIGN KEY (equ_cd_equipe_1)   REFERENCES Equipe     (equ_cd_equipe));
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_02          FOREIGN KEY (equ_cd_equipe_2)   REFERENCES Equipe     (equ_cd_equipe));
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_03          FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato (cam_cd_campeonato));
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_04          FOREIGN KEY (fas_cd_fase)       REFERENCES Fase       (fas_cd_fase));
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_05          FOREIGN KEY (gru_cd_grupo)      REFERENCES Grupo      (gru_cd_grupo));
ALTER TABLE Jogo          ADD (CONSTRAINT fk_jogo_06          FOREIGN KEY (loc_cd_local)      REFERENCES Local      (loc_cd_local));
ALTER TABLE Palpite       ADD (CONSTRAINT fk_palpite_01       FOREIGN KEY (res_cd_resultado)  REFERENCES Resultado  (res_cd_resultado));
ALTER TABLE Palpite       ADD (CONSTRAINT fk_palpite_02       FOREIGN KEY (jog_cd_jogo)       REFERENCES Jogo       (jog_cd_jogo));
ALTER TABLE Palpite       ADD (CONSTRAINT fk_palpite_03       FOREIGN KEY (apo_cd_aposta)     REFERENCES Aposta     (apo_cd_aposta));
ALTER TABLE Parametro     ADD (CONSTRAINT fk_parametro_01     FOREIGN KEY (cam_cd_campeonato) REFERENCES Campeonato (cam_cd_campeonato));
ALTER TABLE Parametro     ADD (CONSTRAINT fk_parametro_02     FOREIGN KEY (fas_cd_fase)       REFERENCES Fase       (fas_cd_fase));
--------------------------------------------------------------------------------