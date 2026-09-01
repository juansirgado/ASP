CREATE OR REPLACE PACKAGE PkgClassificacao IS
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

-- Declaracao de Variaveis
-- ==============================================================================
   v_count_cla NUMBER;
   v_error_prc VARCHAR2(50)  := '';
   v_error_cod VARCHAR2(25)  := '';
   v_error_msg VARCHAR2(500) := '';

-- Declaracao de Procedimentos
-- ==============================================================================
   PROCEDURE ClassificaEquipe  (p_cam_cd_campeonato IN Campeonato.cam_cd_campeonato%TYPE);
   PROCEDURE ClassificaPalpite (p_cam_cd_campeonato IN Campeonato.cam_cd_campeonato%TYPE);
   PROCEDURE ClassificaAposta  (p_cam_cd_campeonato IN Campeonato.cam_cd_campeonato%TYPE);
   PROCEDURE GravaLog          (p_cam_cd_campeonato IN NUMBER,
                                p_err_nm_processo   IN VARCHAR2,
                                p_err_cd_mensagem   IN VARCHAR2,
                                p_err_ds_mensagem   IN VARCHAR2);

-- Declaracao de Funções
-- ==============================================================================

   FUNCTION  IFF               (p_expr              IN VARCHAR2) RETURN NUMBER;
-- ==============================================================================
END PkgClassificacao;
/

CREATE OR REPLACE PACKAGE BODY PkgClassificacao IS
-- Classifica as Equipes do campeonato conforme os Jogos ========================
-- ==============================================================================
PROCEDURE ClassificaEquipe (p_cam_cd_campeonato IN Campeonato.cam_cd_campeonato%TYPE)

IS

   CURSOR cur_equipe IS
          --
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
                        DECODE(IFF(TO_CHAR(jog_qt_gol90_equ_1) || '>' || TO_CHAR(jog_qt_gol90_equ_2)),1, 1, 0) As cla_qt_vitoria,
                        DECODE(jog_qt_gol90_equ_1, jog_qt_gol90_equ_2, 1, 0)                                   As cla_qt_empate,
                        DECODE(IFF(TO_CHAR(jog_qt_gol90_equ_1) || '<' || TO_CHAR(jog_qt_gol90_equ_2)),1, 1, 0) As cla_qt_derrota,
                        jog_qt_gol_equ_1   As cla_qt_gol_pro,
                        jog_qt_gol_equ_2   As cla_qt_gol_contra,
                        jog_qt_cartao_am_1 As cla_qt_cartao_am,
                        jog_qt_cartao_vr_1 As cla_qt_cartao_vr,
                        DECODE(IFF(jog_qt_gol90_equ_1 || '>' || jog_qt_gol90_equ_2), 1, par_vl_jog_vitoria,
                               DECODE(jog_qt_gol90_equ_1, jog_qt_gol90_equ_2, par_vl_jog_empate, par_vl_jog_derrota)) As cla_qt_pontos
                   From Jogo          jog,
                        Parametro     par
                  Where jog.cam_cd_campeonato = p_cam_cd_campeonato
                    and par.cam_cd_campeonato = p_cam_cd_campeonato
                    and jog.jog_dt_jogo       < SYSDATE
                    and jog.fas_cd_fase       = par.fas_cd_fase
                  Union
                 Select jog.cam_cd_campeonato    As cam_cd_campeonato,
                        jog.equ_cd_equipe_2      As equ_cd_equipe,
                        jog.jog_cd_jogo          As jog_cd_jogo,
                        DECODE(IFF(TO_CHAR(jog_qt_gol90_equ_2) || '>' || TO_CHAR(jog_qt_gol90_equ_1)),1, 1, 0) As cla_qt_vitoria,
                        DECODE(jog_qt_gol90_equ_2, jog_qt_gol90_equ_1, 1, 0)                                   As cla_qt_empate,
                        DECODE(IFF(TO_CHAR(jog_qt_gol90_equ_2) || '<' || TO_CHAR(jog_qt_gol90_equ_1)),1, 1, 0) As cla_qt_derrota,
                        jog_qt_gol_equ_2   As cla_qt_gol_pro,
                        jog_qt_gol_equ_1   As cla_qt_gol_contra,
                        jog_qt_cartao_am_2 As cla_qt_cartao_am,
                        jog_qt_cartao_vr_2 As cla_qt_cartao_vr,
                        DECODE(IFF(jog_qt_gol90_equ_2 || '>' || jog_qt_gol90_equ_1), 1, par_vl_jog_vitoria,
                               DECODE(jog_qt_gol90_equ_2, jog_qt_gol90_equ_1, par_vl_jog_empate, par_vl_jog_derrota)) As cla_qt_pontos
                   From Jogo          jog,
                        Parametro     par
                  Where jog.cam_cd_campeonato = p_cam_cd_campeonato
                    and par.cam_cd_campeonato = p_cam_cd_campeonato
                    and jog.jog_dt_jogo       < SYSDATE
                    and jog.fas_cd_fase       = par.fas_cd_fase
                 )
           Group by cam_cd_campeonato,
                    equ_cd_equipe;
--
BEGIN
--
   FOR rec_Equipe IN cur_Equipe
       LOOP

          Select COUNT(*) Into v_count_cla
            From classificacao
           Where cam_cd_campeonato = rec_Equipe.cam_cd_campeonato
             And equ_cd_equipe     = rec_Equipe.equ_cd_equipe;

          IF v_count_cla = 0 Then
             Insert Into Classificacao
                   (cla_cd_classificacao,
                    cla_qt_vitoria,
                    cla_qt_empate,
                    cla_qt_derrota,
                    cla_qt_gol_pro,
                    cla_qt_gol_contra,
                    cla_qt_cartao_am,
                    cla_qt_cartao_vr,
                    cla_qt_pontos,
                    cam_cd_campeonato,
                    equ_cd_equipe)
             Values(sq_cd_classificacao.NEXTVAL,
                    rec_Equipe.cla_qt_vitoria,
                    rec_Equipe.cla_qt_empate,
                    rec_Equipe.cla_qt_derrota,
                    rec_Equipe.cla_qt_gol_pro,
                    rec_Equipe.cla_qt_gol_contra,
                    rec_Equipe.cla_qt_cartao_am,
                    rec_Equipe.cla_qt_cartao_vr,
                    rec_Equipe.cla_qt_pontos,
                    rec_Equipe.cam_cd_campeonato,
                    rec_Equipe.equ_cd_equipe);
          ELSE
             Update Classificacao
                Set cla_qt_vitoria       = rec_Equipe.cla_qt_vitoria,
                    cla_qt_empate        = rec_Equipe.cla_qt_empate,
                    cla_qt_derrota       = rec_Equipe.cla_qt_derrota,
                    cla_qt_gol_pro       = rec_Equipe.cla_qt_gol_pro,
                    cla_qt_gol_contra    = rec_Equipe.cla_qt_gol_contra,
                    cla_qt_cartao_am     = rec_Equipe.cla_qt_cartao_am,
                    cla_qt_cartao_vr     = rec_Equipe.cla_qt_cartao_vr,
                    cla_qt_pontos        = rec_Equipe.cla_qt_pontos
              Where cam_cd_campeonato    = rec_Equipe.cam_cd_campeonato
                And equ_cd_equipe        = rec_Equipe.equ_cd_equipe;
          END IF;
   END LOOP;
   --
   v_error_prc := 'ClassificaEquipe()';
   v_error_cod := 0;
   v_error_msg := 'Equipes classificadas com sucesso.';
   --
   GravaLog (p_cam_cd_campeonato, v_error_prc, v_error_cod, v_error_msg);
   --
   COMMIT;
   --
EXCEPTION
   WHEN OTHERS THEN
        --
        v_error_prc := 'ClassificaEquipe()';
        v_error_cod := SQLCODE;
        v_error_msg := SQLERRM;
        --
        GravaLog (p_cam_cd_campeonato, v_error_prc, v_error_cod, v_error_msg);
        --
        COMMIT;
        --
END ClassificaEquipe;
-- ==============================================================================

-- Classifica as Palpites do campeonato conforme os Jogos =======================
-- ==============================================================================
PROCEDURE ClassificaPalpite (p_cam_cd_campeonato IN Campeonato.cam_cd_campeonato%TYPE)

IS

   CURSOR cur_Palpite IS
   ---
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
                    and jog_dt_jogo             < SYSDATE
                    and par.fas_cd_fase         = jog.fas_cd_fase
                    and pal.jog_cd_jogo         = jog.jog_cd_jogo
                    and pal.pal_qt_gol_equipe_1 = jog.jog_qt_gol_equ_1
                    and pal.pal_qt_gol_equipe_2 = jog.jog_qt_gol_equ_2
                 Union
                 Select pal_cd_palpite        As pal_cd_palpite,
                        par_vl_pal_parcial    As pal_qt_pontos,
                        2                     As res_cd_resultado
                   From Jogo       jog,
                        Palpite    pal,
                        Parametro  par
                  Where jog.cam_cd_campeonato     = p_cam_cd_campeonato
                    and par.cam_cd_campeonato     = p_cam_cd_campeonato
                    and jog_dt_jogo               < SYSDATE
                    and par.fas_cd_fase           = jog.fas_cd_fase
                    and pal.jog_cd_jogo           = jog.jog_cd_jogo
                    and ((jog.jog_qt_gol_equ_1    > jog.jog_qt_gol_equ_2
                    and   pal.pal_qt_gol_equipe_1 > pal.pal_qt_gol_equipe_2)
                    or   (jog.jog_qt_gol_equ_1    < jog.jog_qt_gol_equ_2
                    and   pal.pal_qt_gol_equipe_1 < pal.pal_qt_gol_equipe_2)
                    or   (jog.jog_qt_gol_equ_1    = jog.jog_qt_gol_equ_2
                    and   pal.pal_qt_gol_equipe_1 = pal.pal_qt_gol_equipe_2))
                    and (pal.pal_qt_gol_equipe_1 <> jog.jog_qt_gol_equ_1
                    or   pal.pal_qt_gol_equipe_2 <> jog.jog_qt_gol_equ_2)
                 Union
                 Select pal_cd_palpite        As pal_cd_palpite,
                        par_vl_pal_errado     As pal_qt_pontos,
                        1                     As res_cd_resultado
                   From Jogo       jog,
                        Palpite    pal,
                        Parametro  par
                  Where jog.cam_cd_campeonato     = p_cam_cd_campeonato
                    and par.cam_cd_campeonato     = p_cam_cd_campeonato
                    and jog_dt_jogo               < SYSDATE
                    and par.fas_cd_fase           = jog.fas_cd_fase
                    and pal.jog_cd_jogo           = jog.jog_cd_jogo
                    and ((jog.jog_qt_gol_equ_1    > jog.jog_qt_gol_equ_2
                    and  (pal.pal_qt_gol_equipe_1 < pal.pal_qt_gol_equipe_2
                     or   pal.pal_qt_gol_equipe_1 = pal.pal_qt_gol_equipe_2))
                     or  (jog.jog_qt_gol_equ_1    < jog.jog_qt_gol_equ_2
                    and  (pal.pal_qt_gol_equipe_1 > pal.pal_qt_gol_equipe_2
                     or   pal.pal_qt_gol_equipe_1 = pal.pal_qt_gol_equipe_2))
                     or  (jog.jog_qt_gol_equ_1    = jog.jog_qt_gol_equ_2
                    and  (pal.pal_qt_gol_equipe_1 > pal.pal_qt_gol_equipe_2
                     or   pal.pal_qt_gol_equipe_1 < pal.pal_qt_gol_equipe_2)))
                 );
--
BEGIN
--
   FOR rec_Palpite IN cur_Palpite
       LOOP
       --
          Update Palpite
             Set pal_qt_pontos    = rec_Palpite.pal_qt_pontos,
                 res_cd_resultado = rec_Palpite.res_cd_resultado
           Where pal_cd_palpite   = rec_Palpite.pal_cd_palpite;
       --
       END LOOP;
   --
   v_error_prc := 'ClassificaPalpite()';
   v_error_cod := 0;
   v_error_msg := 'Palpites classificados com sucesso.';
   --
   GravaLog (p_cam_cd_campeonato, v_error_prc, v_error_cod, v_error_msg);
   --
   COMMIT;
   --
EXCEPTION
   WHEN OTHERS THEN
        --
        v_error_prc := 'ClassificaPalpite()';
        v_error_cod := SQLCODE;
        v_error_msg := SQLERRM;
        --
        GravaLog (p_cam_cd_campeonato, v_error_prc, v_error_cod, v_error_msg);
        --
        COMMIT;
        --
END ClassificaPalpite;
-- ==============================================================================

-- Classifica as Palpites do campeonato conforme os Jogos =======================
-- ==============================================================================
PROCEDURE ClassificaAposta (p_cam_cd_campeonato IN Campeonato.cam_cd_campeonato%TYPE)

IS

CURSOR cur_Classificacao IS
       ---
       Select apo_cd_aposta As apo_cd_aposta,
              SUM(DECODE(res_cd_resultado, 1, 1, 0)) As apo_qt_errado,
              SUM(DECODE(res_cd_resultado, 2, 1, 0)) As apo_qt_parcial,
              SUM(DECODE(res_cd_resultado, 3, 1, 0)) As apo_qt_correto,
              SUM(pal_qt_pontos) As apo_qt_pontos
         From Jogo      jog,
              Palpite   pal
        Where jog.cam_cd_campeonato = p_cam_cd_campeonato
          and jog_dt_jogo           < SYSDATE
          and pal.jog_cd_jogo       = jog.jog_cd_jogo
        Group by apo_cd_aposta;
---
BEGIN
---
   FOR rec_Classificacao IN cur_Classificacao
       LOOP
          Update Aposta
             Set apo_qt_errado  = rec_Classificacao.apo_qt_errado,
                 apo_qt_parcial = rec_Classificacao.apo_qt_parcial,
                 apo_qt_correto = rec_Classificacao.apo_qt_correto,
                 apo_qt_pontos  = rec_Classificacao.apo_qt_pontos
           Where apo_cd_aposta  = rec_Classificacao.apo_cd_aposta;
      END LOOP;
   --
   v_error_prc := 'ClassificaAposta()';
   v_error_cod := 0;
   v_error_msg := 'Apostas classificadas com sucesso.';
   --
   GravaLog (p_cam_cd_campeonato, v_error_prc, v_error_cod, v_error_msg);
   --
   COMMIT;
   --
EXCEPTION
   WHEN OTHERS THEN
        --
        v_error_prc := 'ClassificaAposta()';
        v_error_cod := SQLCODE;
        v_error_msg := SQLERRM;
        --
        GravaLog (p_cam_cd_campeonato, v_error_prc, v_error_cod, v_error_msg);
        --
        COMMIT;
        --
END ClassificaAposta;
-- ==============================================================================

-- Função GravarLog grava log de eventos do sistema de Campeonatos ==============
-- ==============================================================================
PROCEDURE GravaLog (p_cam_cd_campeonato IN NUMBER,
                    p_err_nm_processo   IN VARCHAR2,
                    p_err_cd_mensagem   IN VARCHAR2,
                    p_err_ds_mensagem   IN VARCHAR2)
IS
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
       Values (sq_cd_erro.NEXTVAL,
               SYSDATE,
               p_err_nm_processo,
               p_err_cd_mensagem,
               p_err_ds_mensagem,
               p_cam_cd_campeonato);
   --
EXCEPTION
   WHEN OTHERS THEN
        --
        v_error_cod := SQLCODE;
        v_error_msg := SQLERRM;
        --
        Insert Into Erro
                   (err_cd_erro,
                    err_dt_erro,
                    err_nm_processo,
                    err_cd_mensagem,
                    err_ds_mensagem,
                    cam_cd_campeonato)
            Values (sq_cd_erro.NEXTVAL,
                    SYSDATE,
                    'GravaLog()',
                    v_error_cod,
                    v_error_msg,
                    p_cam_cd_campeonato);
        --
END GravaLog;
-- ==============================================================================

-- Função IFF retorna valida uma expressão e retorna 1(True) ou 0(False) ========
-- ==============================================================================
FUNCTION IFF (p_expr IN VARCHAR2) RETURN NUMBER

IS

-- Declaracao de variáveis
l_sqlstr VARCHAR2(1000);
l_result PLS_INTEGER;

BEGIN
   --
   l_sqlstr := 'SELECT 1 FROM dual WHERE '|| REPLACE(p_expr,'"','''');
   --
   BEGIN
   --
      EXECUTE IMMEDIATE l_sqlstr INTO l_result;
      RETURN 1;
   --
   EXCEPTION WHEN NO_DATA_FOUND THEN
      RETURN 0;
   --
   END;
END IFF;
-- ==============================================================================

-- ==============================================================================
END PkgClassificacao;
/