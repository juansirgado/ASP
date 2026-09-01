-- Campeonato
--------------------------------------------------------------------------------
Insert into Campeonato (cam_cd_campeonato, cam_nm_campeonato, cam_ds_campeonato, cam_dt_inicio, cam_dt_termino, cam_vl_aposta, cam_in_classificacao)
Values (100, 'Fifa 2005 Interclubles', 'Fifa Interclubles 2005(Japão - Toyota Cup)', '2005-12-11', '2005-12-18', 10.00, 0);
--------------------------------------------------------------------------------

-- Equipe
--------------------------------------------------------------------------------
Insert Into Equipe (equ_cd_equipe, equ_nm_equipe, equ_ds_equipe, est_cd_estado) Values (101, 'Al Ittihad', 'AFC - Asia - Arábia Saudita',        '00');
Insert Into Equipe (equ_cd_equipe, equ_nm_equipe, equ_ds_equipe, est_cd_estado) Values (102, 'Al Ahly',    'CAF - Africa - Egito',               '00');
Insert Into Equipe (equ_cd_equipe, equ_nm_equipe, equ_ds_equipe, est_cd_estado) Values (103, 'Sydney',     'OFC - Oceania - Australia',          '00');
Insert Into Equipe (equ_cd_equipe, equ_nm_equipe, equ_ds_equipe, est_cd_estado) Values (104, 'Saprissa',   'CONCACAF - Americas - Costa Rica',   '00');
Insert Into Equipe (equ_cd_equipe, equ_nm_equipe, equ_ds_equipe, est_cd_estado) Values (105, 'São Paulo',  'CONMEBOL - America do Sul - Brasil', '00');
Insert Into Equipe (equ_cd_equipe, equ_nm_equipe, equ_ds_equipe, est_cd_estado) Values (106, 'Liverpool',  'UEFA - Europa - Inglatera',          '00');
--------------------------------------------------------------------------------

-- Grupo
--------------------------------------------------------------------------------
Insert Into Grupo (gru_cd_grupo, gru_nm_grupo, cam_cd_campeonato) Values (100, 'Não se aplica', 100);
--------------------------------------------------------------------------------

-- Fase
--------------------------------------------------------------------------------
Insert Into Fase (fas_cd_fase, fas_nm_fase, cam_cd_campeonato) Values (101,  'Quartas de Final',   100);
Insert Into Fase (fas_cd_fase, fas_nm_fase, cam_cd_campeonato) Values (102,  'Semifinais',         100);
Insert Into Fase (fas_cd_fase, fas_nm_fase, cam_cd_campeonato) Values (103,  'Decisão do 5 lugar', 100);
Insert Into Fase (fas_cd_fase, fas_nm_fase, cam_cd_campeonato) Values (104,  'Decisão do 3 lugar', 100);
Insert Into Fase (fas_cd_fase, fas_nm_fase, cam_cd_campeonato) Values (105,  'Finais',             100);
--------------------------------------------------------------------------------

--Parametro
--------------------------------------------------------------------------------
Insert Into Parametro (par_cd_parametro, par_vl_jog_derrota, par_vl_jog_empate, par_vl_jog_vitoria, par_vl_pal_errado, par_vl_pal_parcial, par_vl_pal_correto, cam_cd_campeonato, fas_cd_fase) Values (101,  0, 1, 3, 0, 1, 3, 100, 101);
Insert Into Parametro (par_cd_parametro, par_vl_jog_derrota, par_vl_jog_empate, par_vl_jog_vitoria, par_vl_pal_errado, par_vl_pal_parcial, par_vl_pal_correto, cam_cd_campeonato, fas_cd_fase) Values (102,  0, 1, 3, 0, 1, 3, 100, 102);
Insert Into Parametro (par_cd_parametro, par_vl_jog_derrota, par_vl_jog_empate, par_vl_jog_vitoria, par_vl_pal_errado, par_vl_pal_parcial, par_vl_pal_correto, cam_cd_campeonato, fas_cd_fase) Values (103,  0, 1, 3, 0, 1, 3, 100, 103);
Insert Into Parametro (par_cd_parametro, par_vl_jog_derrota, par_vl_jog_empate, par_vl_jog_vitoria, par_vl_pal_errado, par_vl_pal_parcial, par_vl_pal_correto, cam_cd_campeonato, fas_cd_fase) Values (104,  0, 1, 3, 0, 1, 3, 100, 104);
Insert Into Parametro (par_cd_parametro, par_vl_jog_derrota, par_vl_jog_empate, par_vl_jog_vitoria, par_vl_pal_errado, par_vl_pal_parcial, par_vl_pal_correto, cam_cd_campeonato, fas_cd_fase) Values (105,  0, 1, 3, 0, 2, 5, 100, 105);
--------------------------------------------------------------------------------

-- Local
--------------------------------------------------------------------------------
Insert Into Local (loc_cd_local, loc_nm_local, loc_ds_local, est_cd_estado) Values (101, 'Tokyo',    ' ', '00');
Insert Into Local (loc_cd_local, loc_nm_local, loc_ds_local, est_cd_estado) Values (102, 'Toyota',   ' ', '00');
Insert Into Local (loc_cd_local, loc_nm_local, loc_ds_local, est_cd_estado) Values (103, 'Yokohama', ' ', '00');
--------------------------------------------------------------------------------

-- Campeonato / Equipe
--------------------------------------------------------------------------------
Insert Into CamEqu (rce_cd_cam_equ, cam_cd_campeonato, equ_cd_equipe) Values (101, 100, 101);
Insert Into CamEqu (rce_cd_cam_equ, cam_cd_campeonato, equ_cd_equipe) Values (102, 100, 102);
Insert Into CamEqu (rce_cd_cam_equ, cam_cd_campeonato, equ_cd_equipe) Values (103, 100, 103);
Insert Into CamEqu (rce_cd_cam_equ, cam_cd_campeonato, equ_cd_equipe) Values (104, 100, 104);
Insert Into CamEqu (rce_cd_cam_equ, cam_cd_campeonato, equ_cd_equipe) Values (105, 100, 105);
Insert Into CamEqu (rce_cd_cam_equ, cam_cd_campeonato, equ_cd_equipe) Values (106, 100, 106);
--------------------------------------------------------------------------------

-- Jogo
--------------------------------------------------------------------------------
Insert Into Jogo (jog_cd_jogo, jog_dt_jogo, jog_ds_jogo, equ_cd_equipe_1, equ_cd_equipe_2, jog_qt_gol90_equ_1, jog_qt_gol90_equ_2, jog_qt_gol_equ_1, jog_qt_gol_equ_2, jog_qt_cartao_am_1, jog_qt_cartao_am_2, jog_qt_cartao_vr_1, jog_qt_cartao_vr_2, cam_cd_campeonato, fas_cd_fase, gru_cd_grupo, loc_cd_local) Values (501, '2005/12/11 19:20:00', ' ', 101, 102, 0, 0, 0, 0, 0, 0, 0, 0, 100, 101, 100, 101);
Insert Into Jogo (jog_cd_jogo, jog_dt_jogo, jog_ds_jogo, equ_cd_equipe_1, equ_cd_equipe_2, jog_qt_gol90_equ_1, jog_qt_gol90_equ_2, jog_qt_gol_equ_1, jog_qt_gol_equ_2, jog_qt_cartao_am_1, jog_qt_cartao_am_2, jog_qt_cartao_vr_1, jog_qt_cartao_vr_2, cam_cd_campeonato, fas_cd_fase, gru_cd_grupo, loc_cd_local) Values (502, '2005/12/12 19:20:00', ' ', 103, 104, 0, 0, 0, 0, 0, 0, 0, 0, 100, 101, 100, 102);
Insert Into Jogo (jog_cd_jogo, jog_dt_jogo, jog_ds_jogo, equ_cd_equipe_1, equ_cd_equipe_2, jog_qt_gol90_equ_1, jog_qt_gol90_equ_2, jog_qt_gol_equ_1, jog_qt_gol_equ_2, jog_qt_cartao_am_1, jog_qt_cartao_am_2, jog_qt_cartao_vr_1, jog_qt_cartao_vr_2, cam_cd_campeonato, fas_cd_fase, gru_cd_grupo, loc_cd_local) Values (503, '2005/12/14 19:20:00', ' ', 000, 105, 0, 0, 0, 0, 0, 0, 0, 0, 100, 102, 100, 101);
Insert Into Jogo (jog_cd_jogo, jog_dt_jogo, jog_ds_jogo, equ_cd_equipe_1, equ_cd_equipe_2, jog_qt_gol90_equ_1, jog_qt_gol90_equ_2, jog_qt_gol_equ_1, jog_qt_gol_equ_2, jog_qt_cartao_am_1, jog_qt_cartao_am_2, jog_qt_cartao_vr_1, jog_qt_cartao_vr_2, cam_cd_campeonato, fas_cd_fase, gru_cd_grupo, loc_cd_local) Values (504, '2005/12/15 19:20:00', ' ', 000, 106, 0, 0, 0, 0, 0, 0, 0, 0, 100, 102, 100, 103);
Insert Into Jogo (jog_cd_jogo, jog_dt_jogo, jog_ds_jogo, equ_cd_equipe_1, equ_cd_equipe_2, jog_qt_gol90_equ_1, jog_qt_gol90_equ_2, jog_qt_gol_equ_1, jog_qt_gol_equ_2, jog_qt_cartao_am_1, jog_qt_cartao_am_2, jog_qt_cartao_vr_1, jog_qt_cartao_vr_2, cam_cd_campeonato, fas_cd_fase, gru_cd_grupo, loc_cd_local) Values (505, '2005/12/16 19:20:00', ' ', 000, 000, 0, 0, 0, 0, 0, 0, 0, 0, 100, 103, 100, 101);
Insert Into Jogo (jog_cd_jogo, jog_dt_jogo, jog_ds_jogo, equ_cd_equipe_1, equ_cd_equipe_2, jog_qt_gol90_equ_1, jog_qt_gol90_equ_2, jog_qt_gol_equ_1, jog_qt_gol_equ_2, jog_qt_cartao_am_1, jog_qt_cartao_am_2, jog_qt_cartao_vr_1, jog_qt_cartao_vr_2, cam_cd_campeonato, fas_cd_fase, gru_cd_grupo, loc_cd_local) Values (506, '2005/12/18 16:20:00', ' ', 000, 000, 0, 0, 0, 0, 0, 0, 0, 0, 100, 104, 100, 103);
Insert Into Jogo (jog_cd_jogo, jog_dt_jogo, jog_ds_jogo, equ_cd_equipe_1, equ_cd_equipe_2, jog_qt_gol90_equ_1, jog_qt_gol90_equ_2, jog_qt_gol_equ_1, jog_qt_gol_equ_2, jog_qt_cartao_am_1, jog_qt_cartao_am_2, jog_qt_cartao_vr_1, jog_qt_cartao_vr_2, cam_cd_campeonato, fas_cd_fase, gru_cd_grupo, loc_cd_local) Values (507, '2005/12/18 19:20:00', ' ', 000, 000, 0, 0, 0, 0, 0, 0, 0, 0, 100, 105, 100, 103);
--------------------------------------------------------------------------------

-- Classificacao
--------------------------------------------------------------------------------
Insert Into Classificacao (cla_cd_classificacao, cla_qt_vitoria, cla_qt_empate, cla_qt_derrota, cla_qt_gol_pro, cla_qt_gol_contra, cla_qt_cartao_am, cla_qt_cartao_vr, cla_qt_pontos, cam_cd_campeonato, equ_cd_equipe) Values (101, 0, 0, 0, 0, 0, 0, 0, 0, 100, 101);
Insert Into Classificacao (cla_cd_classificacao, cla_qt_vitoria, cla_qt_empate, cla_qt_derrota, cla_qt_gol_pro, cla_qt_gol_contra, cla_qt_cartao_am, cla_qt_cartao_vr, cla_qt_pontos, cam_cd_campeonato, equ_cd_equipe) Values (102, 0, 0, 0, 0, 0, 0, 0, 0, 100, 102);
Insert Into Classificacao (cla_cd_classificacao, cla_qt_vitoria, cla_qt_empate, cla_qt_derrota, cla_qt_gol_pro, cla_qt_gol_contra, cla_qt_cartao_am, cla_qt_cartao_vr, cla_qt_pontos, cam_cd_campeonato, equ_cd_equipe) Values (103, 0, 0, 0, 0, 0, 0, 0, 0, 100, 103);
Insert Into Classificacao (cla_cd_classificacao, cla_qt_vitoria, cla_qt_empate, cla_qt_derrota, cla_qt_gol_pro, cla_qt_gol_contra, cla_qt_cartao_am, cla_qt_cartao_vr, cla_qt_pontos, cam_cd_campeonato, equ_cd_equipe) Values (104, 0, 0, 0, 0, 0, 0, 0, 0, 100, 104);
Insert Into Classificacao (cla_cd_classificacao, cla_qt_vitoria, cla_qt_empate, cla_qt_derrota, cla_qt_gol_pro, cla_qt_gol_contra, cla_qt_cartao_am, cla_qt_cartao_vr, cla_qt_pontos, cam_cd_campeonato, equ_cd_equipe) Values (105, 0, 0, 0, 0, 0, 0, 0, 0, 100, 105);
Insert Into Classificacao (cla_cd_classificacao, cla_qt_vitoria, cla_qt_empate, cla_qt_derrota, cla_qt_gol_pro, cla_qt_gol_contra, cla_qt_cartao_am, cla_qt_cartao_vr, cla_qt_pontos, cam_cd_campeonato, equ_cd_equipe) Values (106, 0, 0, 0, 0, 0, 0, 0, 0, 100, 106);
--------------------------------------------------------------------------------

-- Pessoa
--------------------------------------------------------------------------------
Insert Into Pessoa (pes_cd_pessoa, pes_nm_pessoa, pes_cd_identificacao, pes_nu_cpf, pes_nu_rg,pes_nu_telefone, pes_nu_celular, pes_ds_email, pes_dt_nascimento,pes_cd_acesso,pes_in_nivel) Values (1, 'Juan Antico',      'JSYA\\Juan',   0, 0, 0, 0, 'juan.antico@eds.com',       '1967/09/24', '*X/gqg', 1);
Insert Into Pessoa (pes_cd_pessoa, pes_nm_pessoa, pes_cd_identificacao, pes_nu_cpf, pes_nu_rg,pes_nu_telefone, pes_nu_celular, pes_ds_email, pes_dt_nascimento,pes_cd_acesso,pes_in_nivel) Values (2, 'Adriano Alves',    'AMER\\kzn2d6', 0, 0, 0, 0, 'adriano.alves-eds@eds.com', '1900/01/01', '*X/gqg', 0);
Insert Into Pessoa (pes_cd_pessoa, pes_nm_pessoa, pes_cd_identificacao, pes_nu_cpf, pes_nu_rg,pes_nu_telefone, pes_nu_celular, pes_ds_email, pes_dt_nascimento,pes_cd_acesso,pes_in_nivel) Values (3, 'Carlos Gimenez',   'AMER\\sz1b56', 0, 0, 0, 0, 'carlos.gimenez@eds.com',    '1900/01/01', '*X/gqg', 0);
Insert Into Pessoa (pes_cd_pessoa, pes_nm_pessoa, pes_cd_identificacao, pes_nu_cpf, pes_nu_rg,pes_nu_telefone, pes_nu_celular, pes_ds_email, pes_dt_nascimento,pes_cd_acesso,pes_in_nivel) Values (4, 'Flavio Gama',      'AMER\\zzylj6', 0, 0, 0, 0, 'flavio.gama@eds.com',       '1900/01/01', '*X/gqg', 0);
Insert Into Pessoa (pes_cd_pessoa, pes_nm_pessoa, pes_cd_identificacao, pes_nu_cpf, pes_nu_rg,pes_nu_telefone, pes_nu_celular, pes_ds_email, pes_dt_nascimento,pes_cd_acesso,pes_in_nivel) Values (5, 'Henrique Silva',   'AMER\\pz2zgs', 0, 0, 0, 0, 'henrique.silva@eds.com',    '1900/01/01', '*X/gqg', 0);
Insert Into Pessoa (pes_cd_pessoa, pes_nm_pessoa, pes_cd_identificacao, pes_nu_cpf, pes_nu_rg,pes_nu_telefone, pes_nu_celular, pes_ds_email, pes_dt_nascimento,pes_cd_acesso,pes_in_nivel) Values (6, 'Luciano Silva',    'AMER\\pz2zgs', 0, 0, 0, 0, 'luciano.silva@eds.com',     '1900/01/01', '*X/gqg', 0);
Insert Into Pessoa (pes_cd_pessoa, pes_nm_pessoa, pes_cd_identificacao, pes_nu_cpf, pes_nu_rg,pes_nu_telefone, pes_nu_celular, pes_ds_email, pes_dt_nascimento,pes_cd_acesso,pes_in_nivel) Values (7, 'Marcelo Guedes',   'AMER\\vzk2hm', 0, 0, 0, 0, 'marcelo.guedes@eds.com',    '1900/01/01', '*X/gqg', 0);
Insert Into Pessoa (pes_cd_pessoa, pes_nm_pessoa, pes_cd_identificacao, pes_nu_cpf, pes_nu_rg,pes_nu_telefone, pes_nu_celular, pes_ds_email, pes_dt_nascimento,pes_cd_acesso,pes_in_nivel) Values (8, 'Marcelo Katayama', 'AMER\\lzv1c3', 0, 0, 0, 0, 'marcelo.katayama@eds.com',  '1900/01/01', '*X/gqg', 0);
--------------------------------------------------------------------------------
