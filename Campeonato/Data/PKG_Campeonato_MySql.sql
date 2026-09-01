/*
   -------------------------------------------------------------
   Program      : PkgClassificacao.sql
   Description  : SQL de processamento da classificação
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
CREATE TABLE mysql_sequence
      (sequence_name     VARCHAR(50) NOT NULL,
       sequence_value    DECIMAL(5)  NOT NULL);
CREATE UNIQUE INDEX pk_mysql_sequence ON mysql_sequence (sequence_name ASC);
--------------------------------------------------------------------------------

-- ==============================================================================
DELIMITER //
-- ==============================================================================

-- ==============================================================================
-- Classifica as Equipes do campeonato conforme os Jogos ========================
-- ==============================================================================
CREATE PROCEDURE ClassificaEquipe (IN p_cam_cd_campeonato DECIMAL(5))
--
BEGIN
--
   DECLARE v_error_ctr DECIMAL(1) DEFAULT 0;
   DECLARE v_error_prc VARCHAR(50);
   DECLARE v_error_cod VARCHAR(25);
   DECLARE v_error_msg VARCHAR(500);
   DECLARE v_count_cla DECIMAL(1);
--
   DECLARE v_cam_cd_campeonato DECIMAL(5);
   DECLARE v_equ_cd_equipe     DECIMAL(5);
   DECLARE v_cla_qt_vitoria    DECIMAL(3);
   DECLARE v_cla_qt_empate     DECIMAL(3);
   DECLARE v_cla_qt_derrota    DECIMAL(3);
   DECLARE v_cla_qt_gol_pro    DECIMAL(5);
   DECLARE v_cla_qt_gol_contra DECIMAL(5);
   DECLARE v_cla_qt_cartao_am  DECIMAL(5);
   DECLARE v_cla_qt_cartao_vr  DECIMAL(5);
   DECLARE v_cla_qt_pontos     DECIMAL(9);
--
   DECLARE cur_equipe CURSOR FOR
   Select cam_cd_campeonato      As cam_cd_campeonato,
          equ_cd_equipe          As equ_cd_equipe,
          SUM(cla_qt_vitoria)    As cla_qt_vitoria,
          SUM(cla_qt_empate)     As cla_qt_empate,
          SUM(cla_qt_derrota)    As cla_qt_derrota,
          SUM(cla_qt_gol_pro)    As cla_qt_gol_pro,
          SUM(cla_qt_gol_contra) As cla_qt_gol_contra,
          SUM(cla_qt_cartao_am)  As cla_qt_cartao_am,
          SUM(cla_qt_cartao_vr)  As cla_qt_cartao_vr,
          SUM(cla_qt_pontos)     As cla_qt_pontos
   From (
         Select jog.cam_cd_campeonato    As cam_cd_campeonato,
                jog.equ_cd_equipe_1      As equ_cd_equipe,
                jog.jog_cd_jogo          As jog_cd_jogo,
                CASE WHEN jog_qt_gol_equ_1 > jog_qt_gol_equ_2 THEN 1 ELSE 0 END As cla_qt_vitoria,
                CASE WHEN jog_qt_gol_equ_1 = jog_qt_gol_equ_2 THEN 1 ELSE 0 END As cla_qt_empate,
                CASE WHEN jog_qt_gol_equ_1 < jog_qt_gol_equ_2 THEN 1 ELSE 0 END As cla_qt_derrota,
                jog_qt_gol_equ_1   As cla_qt_gol_pro,
                jog_qt_gol_equ_2   As cla_qt_gol_contra,
                jog_qt_cartao_am_1 As cla_qt_cartao_am,
                jog_qt_cartao_vr_1 As cla_qt_cartao_vr,
                CASE WHEN jog_qt_gol_equ_1 > jog_qt_gol_equ_2 THEN par_vl_jog_vitoria
                     WHEN jog_qt_gol_equ_1 = jog_qt_gol_equ_2 THEN par_vl_jog_empate
                     ELSE par_vl_jog_derrota END As cla_qt_pontos
           From Jogo          jog,
                Parametro     par
          Where jog.cam_cd_campeonato = p_cam_cd_campeonato
            and par.cam_cd_campeonato = p_cam_cd_campeonato
            and jog.jog_dt_jogo       < NOW()
            and jog.fas_cd_fase       = par.fas_cd_fase
          Union
         Select jog.cam_cd_campeonato    As cam_cd_campeonato,
                jog.equ_cd_equipe_2      As equ_cd_equipe,
                jog.jog_cd_jogo          As jog_cd_jogo,
                CASE WHEN jog_qt_gol_equ_2 > jog_qt_gol_equ_1 THEN 1 ELSE 0 END As cla_qt_vitoria,
                CASE WHEN jog_qt_gol_equ_2 = jog_qt_gol_equ_1 THEN 1 ELSE 0 END As cla_qt_empate,
                CASE WHEN jog_qt_gol_equ_2 < jog_qt_gol_equ_1 THEN 1 ELSE 0 END As cla_qt_derrota,
                jog_qt_gol_equ_2   As cla_qt_gol_pro,
                jog_qt_gol_equ_1   As cla_qt_gol_contra,
                jog_qt_cartao_am_2 As cla_qt_cartao_am,
                jog_qt_cartao_vr_2 As cla_qt_cartao_vr,
                CASE WHEN jog_qt_gol_equ_2 > jog_qt_gol_equ_1 THEN par_vl_jog_vitoria
                     WHEN jog_qt_gol_equ_2 = jog_qt_gol_equ_1 THEN par_vl_jog_empate
                     ELSE par_vl_jog_derrota END As cla_qt_pontos
           From Jogo          jog,
                Parametro     par
          Where jog.cam_cd_campeonato = p_cam_cd_campeonato
            and par.cam_cd_campeonato = p_cam_cd_campeonato
            and jog.jog_dt_jogo       < NOW()
            and jog.fas_cd_fase       = par.fas_cd_fase
        ) As sel_equipe
   Where equ_cd_equipe <> 0
   Group by cam_cd_campeonato,
            equ_cd_equipe;
--
   DECLARE CONTINUE HANDLER FOR NOT FOUND    SET v_error_ctr = 1;
   DECLARE CONTINUE HANDLER FOR SQLWARNING   SET v_error_ctr = 2;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET v_error_ctr = 9;
--
   OPEN cur_Equipe;
   WHILE v_error_ctr = 0 DO 
      FETCH cur_Equipe
       INTO v_cam_cd_campeonato,
            v_equ_cd_equipe,
            v_cla_qt_vitoria,
            v_cla_qt_empate,
            v_cla_qt_derrota,
            v_cla_qt_gol_pro,
            v_cla_qt_gol_contra,
            v_cla_qt_cartao_am,
            v_cla_qt_cartao_vr,
            v_cla_qt_pontos;
--
      Update Classificacao
         Set cla_qt_vitoria    = v_cla_qt_vitoria,
             cla_qt_empate     = v_cla_qt_empate,
             cla_qt_derrota    = v_cla_qt_derrota,
             cla_qt_gol_pro    = v_cla_qt_gol_pro,
             cla_qt_gol_contra = v_cla_qt_gol_contra,
             cla_qt_cartao_am  = v_cla_qt_cartao_am,
             cla_qt_cartao_vr  = v_cla_qt_cartao_vr,
             cla_qt_pontos     = v_cla_qt_pontos
       Where cam_cd_campeonato = v_cam_cd_campeonato
         And equ_cd_equipe     = v_equ_cd_equipe;
--
   END WHILE;
   CLOSE cur_Equipe;
--
   SET v_error_prc = 'ClassificaEquipe()';
--
   IF v_error_ctr = 1 THEN
      SET v_error_cod = 0;
      SET v_error_msg = 'Equipes classificadas com sucesso.';
   ELSE
      SET v_error_cod := 9999;
      SET v_error_msg := 'Erro classificando as equipes.';
   END IF;
--
   CALL GravaLog (p_cam_cd_campeonato, v_error_prc, v_error_cod, v_error_msg);
--
END;
//
-- ==============================================================================

-- Classifica as Palpites do campeonato conforme os Jogos =======================
-- ==============================================================================
CREATE PROCEDURE ClassificaPalpite (IN p_cam_cd_campeonato DECIMAL(5))
--
BEGIN
--
   DECLARE v_error_ctr DECIMAL(1) DEFAULT 0;
   DECLARE v_error_prc VARCHAR(50);
   DECLARE v_error_cod VARCHAR(25);
   DECLARE v_error_msg VARCHAR(500);
--
   DECLARE v_pal_cd_palpite   DECIMAL(5);
   DECLARE v_pal_qt_pontos    DECIMAL(5);
   DECLARE v_res_cd_resultado DECIMAL(1);
--
   DECLARE cur_Palpite CURSOR FOR
      Select pal_cd_palpite   As pal_cd_palpite,
             pal_qt_pontos    As pal_qt_pontos,
             res_cd_resultado As res_cd_resultado
        From (
             Select pal_cd_palpite     As pal_cd_palpite,
                    par_vl_pal_correto As pal_qt_pontos,
                    3                  As res_cd_resultado
               From Jogo       jog,
                    Palpite    pal,
                    Parametro  par
              Where jog.cam_cd_campeonato   = p_cam_cd_campeonato
                and par.cam_cd_campeonato   = p_cam_cd_campeonato
                and jog_dt_jogo             < NOW()
                and par.fas_cd_fase         = jog.fas_cd_fase
                and pal.jog_cd_jogo         = jog.jog_cd_jogo
                and pal.pal_qt_gol_equipe_1 = jog.jog_qt_gol90_equ_1
                and pal.pal_qt_gol_equipe_2 = jog.jog_qt_gol90_equ_2
             Union
             Select pal_cd_palpite        As pal_cd_palpite,
                    par_vl_pal_parcial    As pal_qt_pontos,
                    2                     As res_cd_resultado
               From Jogo       jog,
                    Palpite    pal,
                    Parametro  par
              Where jog.cam_cd_campeonato     = p_cam_cd_campeonato
                and par.cam_cd_campeonato     = p_cam_cd_campeonato
                and jog_dt_jogo               < NOW()
                and par.fas_cd_fase           = jog.fas_cd_fase
                and pal.jog_cd_jogo           = jog.jog_cd_jogo
                and ((jog.jog_qt_gol90_equ_1  > jog.jog_qt_gol90_equ_2
                and   pal.pal_qt_gol_equipe_1 > pal.pal_qt_gol_equipe_2)
                 or  (jog.jog_qt_gol90_equ_1  < jog.jog_qt_gol90_equ_2
                and   pal.pal_qt_gol_equipe_1 < pal.pal_qt_gol_equipe_2)
                 or  (jog.jog_qt_gol90_equ_1  = jog.jog_qt_gol90_equ_2
                and   pal.pal_qt_gol_equipe_1 = pal.pal_qt_gol_equipe_2))
                and (pal.pal_qt_gol_equipe_1 <> jog.jog_qt_gol90_equ_1
                 or  pal.pal_qt_gol_equipe_2 <> jog.jog_qt_gol90_equ_2)
             Union
             Select pal_cd_palpite        As pal_cd_palpite,
                    par_vl_pal_errado     As pal_qt_pontos,
                    1                     As res_cd_resultado
               From Jogo       jog,
                    Palpite    pal,
                    Parametro  par
              Where jog.cam_cd_campeonato     = p_cam_cd_campeonato
                and par.cam_cd_campeonato     = p_cam_cd_campeonato
                and jog_dt_jogo               < NOW()
                and par.fas_cd_fase           = jog.fas_cd_fase
                and pal.jog_cd_jogo           = jog.jog_cd_jogo
                and ((jog.jog_qt_gol90_equ_1  > jog.jog_qt_gol90_equ_2
                and  (pal.pal_qt_gol_equipe_1 < pal.pal_qt_gol_equipe_2
                 or   pal.pal_qt_gol_equipe_1 = pal.pal_qt_gol_equipe_2))
                 or  (jog.jog_qt_gol90_equ_1  < jog.jog_qt_gol90_equ_2
                and  (pal.pal_qt_gol_equipe_1 > pal.pal_qt_gol_equipe_2
                 or   pal.pal_qt_gol_equipe_1 = pal.pal_qt_gol_equipe_2))
                 or  (jog.jog_qt_gol90_equ_1  = jog.jog_qt_gol90_equ_2
                and  (pal.pal_qt_gol_equipe_1 > pal.pal_qt_gol_equipe_2
                 or   pal.pal_qt_gol_equipe_1 < pal.pal_qt_gol_equipe_2)))
             ) As sel_palpite;
--
   DECLARE CONTINUE HANDLER FOR NOT FOUND    SET v_error_ctr = 1;
   DECLARE CONTINUE HANDLER FOR SQLWARNING   SET v_error_ctr = 2;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET v_error_ctr = 9;
--
   OPEN cur_Palpite;
   WHILE v_error_ctr = 0 DO
      FETCH cur_Palpite
       INTO v_pal_cd_palpite,
            v_pal_qt_pontos,
            v_res_cd_resultado;
--
      Update Palpite
         Set pal_qt_pontos    = v_pal_qt_pontos,
             res_cd_resultado = v_res_cd_resultado
       Where pal_cd_palpite   = v_pal_cd_palpite;
--
   END WHILE;
   CLOSE cur_Palpite;
--
   SET v_error_prc = 'ClassificaPalpite()';
--
   IF v_error_ctr = 1 THEN
      SET v_error_cod = 0;
      SET v_error_msg = 'Palpites classificados com sucesso.';
   ELSE
      SET v_error_cod := 9999;
      SET v_error_msg := 'Erro classificando os palpites.';
   END IF;
--
   CALL GravaLog (p_cam_cd_campeonato, v_error_prc, v_error_cod, v_error_msg);
--
END;
//
-- ==============================================================================

-- Classifica as Palpites do campeonato conforme os Jogos =======================
-- ==============================================================================
CREATE PROCEDURE ClassificaAposta (IN p_cam_cd_campeonato DECIMAL(5))
--
BEGIN
--
   DECLARE v_error_ctr DECIMAL(1) DEFAULT 0;
   DECLARE v_error_prc VARCHAR(50);
   DECLARE v_error_cod VARCHAR(25);
   DECLARE v_error_msg VARCHAR(500);
--
   DECLARE v_apo_cd_aposta  DECIMAL(5);
   DECLARE v_apo_qt_errado  DECIMAL(3);
   DECLARE v_apo_qt_parcial DECIMAL(3);
   DECLARE v_apo_qt_correto DECIMAL(3);
   DECLARE v_apo_qt_pontos  DECIMAL(5);
--
   DECLARE cur_Classificacao CURSOR FOR
      Select apo_cd_aposta As apo_cd_aposta,
             SUM(CASE WHEN res_cd_resultado = 1 THEN 1 ELSE 0 END) As apo_qt_errado,
             SUM(CASE WHEN res_cd_resultado = 2 THEN 1 ELSE 0 END) As apo_qt_parcial,
             SUM(CASE WHEN res_cd_resultado = 3 THEN 1 ELSE 0 END) As apo_qt_correto,
             SUM(pal_qt_pontos) As apo_qt_pontos
        From Jogo      jog,
             Palpite   pal
       Where jog.cam_cd_campeonato = p_cam_cd_campeonato
         and jog_dt_jogo           < NOW()
         and pal.jog_cd_jogo       = jog.jog_cd_jogo
       Group by apo_cd_aposta;
--
   DECLARE CONTINUE HANDLER FOR NOT FOUND    SET v_error_ctr = 1;
   DECLARE CONTINUE HANDLER FOR SQLWARNING   SET v_error_ctr = 2;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET v_error_ctr = 9;
--
   OPEN cur_Classificacao;
   WHILE v_error_ctr = 0 DO
      FETCH cur_Classificacao
       INTO v_apo_cd_aposta,
            v_apo_qt_errado,
            v_apo_qt_parcial,
            v_apo_qt_correto,
            v_apo_qt_pontos;
            
--
      Update Aposta
         Set apo_qt_errado  = v_apo_qt_errado,
             apo_qt_parcial = v_apo_qt_parcial,
             apo_qt_correto = v_apo_qt_correto,
             apo_qt_pontos  = v_apo_qt_pontos
       Where apo_cd_aposta  = v_apo_cd_aposta;
--
   END WHILE;
   CLOSE cur_Classificacao;
--
   SET v_error_prc = 'ClassificaAposta()';
--
   IF v_error_ctr = 1 THEN
      SET v_error_cod = 0;
      SET v_error_msg = 'Apostas classificadas com sucesso.';
   ELSE
      SET v_error_cod := 9999;
      SET v_error_msg := 'Erro classificando as apostas.';
   END IF;
--
   CALL GravaLog (p_cam_cd_campeonato, v_error_prc, v_error_cod, v_error_msg);
--
END;
//
-- ==============================================================================

-- Função GravarLog grava log de eventos do sistema de Campeonatos ==============
-- ==============================================================================
CREATE PROCEDURE GravaLog (IN p_cam_cd_campeonato DECIMAL(5),
                           IN p_err_nm_processo   VARCHAR(50),
                           IN p_err_cd_mensagem   VARCHAR(25),
                           IN p_err_ds_mensagem   VARCHAR(500))
--
BEGIN
--
   Insert Into Erro
              (err_cd_erro,
               err_dt_erro,
               err_nm_processo,
               err_cd_mensagem,
               err_ds_mensagem,
               cam_cd_campeonato)
       Values (SEQUENCE_NEXTVAL('sq_cd_erro'),
               NOW(),
               p_err_nm_processo,
               p_err_cd_mensagem,
               p_err_ds_mensagem,
               p_cam_cd_campeonato);
--
END;
//
-- ==============================================================================

-- ==============================================================================
CREATE PROCEDURE sequence_create (p_sequence_name VARCHAR(80))
BEGIN
   INSERT INTO mysql_sequence (sequence_name, sequence_value) VALUES (UPPER(p_sequence_name), 0);
END;
//
-- ==============================================================================

-- ==============================================================================
CREATE FUNCTION sequence_nextval (p_sequence_name VARCHAR(80)) RETURNS DECIMAL(15)
BEGIN
   DECLARE v_value DECIMAL(15);
-- START TRANSACTION;
   SELECT (sequence_value + 1) INTO v_value FROM mysql_sequence WHERE sequence_name = UPPER(p_sequence_name) FOR UPDATE;
   UPDATE mysql_sequence SET sequence_value = v_value WHERE sequence_name = UPPER(p_sequence_name);
   RETURN v_value;
-- COMMIT;
END;
//
-- ==============================================================================

-- ==============================================================================
CREATE FUNCTION sequence_curval (p_sequence_name VARCHAR(80)) RETURNS DECIMAL(15)
BEGIN
   DECLARE v_value DECIMAL(15);
   SELECT sequence_value INTO v_value FROM mysql_sequence WHERE sequence_name = UPPER(p_sequence_name);
   RETURN v_value;
END;
//
-- ==============================================================================
CREATE PROCEDURE sequence_drop (p_sequence_name VARCHAR(80))
BEGIN
   DELETE FROM mysql_sequence WHERE sequence_name = UPPER(p_sequence_name);
END;
//

-- ==============================================================================
DELIMITER ;
-- ==============================================================================

--------------------------------------------------------------------------------
CALL SEQUENCE_CREATE('sq_cd_aposta');
CALL SEQUENCE_CREATE('sq_cd_campeonato');
CALL SEQUENCE_CREATE('sq_cd_cam_equ');
CALL SEQUENCE_CREATE('sq_cd_classificacao');
CALL SEQUENCE_CREATE('sq_cd_conexao');
CALL SEQUENCE_CREATE('sq_cd_equipe');
CALL SEQUENCE_CREATE('sq_cd_erro');
CALL SEQUENCE_CREATE('sq_cd_estado');
CALL SEQUENCE_CREATE('sq_cd_fase');
CALL SEQUENCE_CREATE('sq_cd_grupo');
CALL SEQUENCE_CREATE('sq_cd_jogo');
CALL SEQUENCE_CREATE('sq_cd_local');
CALL SEQUENCE_CREATE('sq_cd_palpite');
CALL SEQUENCE_CREATE('sq_cd_parametro');
CALL SEQUENCE_CREATE('sq_cd_pessoa');

--------------------------------------------------------------------------------

-- ==============================================================================
DROP PROCEDURE sequence_create;
-- DROP FUNCTION  sequence_curval;
-- DROP FUNCTION  sequence_nextval;
DROP PROCEDURE sequence_drop;
-- ==============================================================================
