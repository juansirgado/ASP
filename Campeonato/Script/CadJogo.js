// -------------------------------------------------------------
// Program      : CadJogo.js
// Description  : Script da página de jogos
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function jogPesquisar(frmJogo)
{
   if (frmJogo.jog_cd_jogo.value == '')
   {
      alert('Informe o número ou nome do jogo');
      frmJogo.jog_cd_jogo.focus();
      return;
   }
   if (isNaN(frmJogo.jog_cd_jogo.value))
   {
      alert('O número do jogo deve ser numérico');
      frmJogo.jog_cd_jogo.focus();
      return;
   }
   frmJogo.Opcao.value='Pesquisar';
   frmJogo.submit();
}
//----------------------------------------------------------------------------
function jogIncluir(frmJogo)
{
   if (frmJogo.jog_cd_jogo.value != '')
   {
      alert('O número do jogo é automático não deve ser informado');
      frmJogo.jog_cd_jogo.focus();
      return;
   }
   if (isNaN(frmJogo.jog_cd_jogo.value))
   {
      alert('O número jogo deve ser numérico');
      frmJogo.jog_cd_jogo.focus();
      return;
   }
   if (frmJogo.jog_dt_jogo.value == '')
   {
      alert('Informe a data do jogo');
      frmJogo.jog_dt_jogo.focus();
      return;
   }
   if (!(isDateTime(frmJogo.jog_dt_jogo)))
   {
      alert('Data do jogo inválida(DD/MM/AAAA HH:MM:SS)');
      frmJogo.jog_dt_jogo.focus();
      return;
   }
   if (frmJogo.jog_ds_jogo.value == '')
   {
      alert('Informe a descrição do jogo');
      frmJogo.jog_ds_jogo.focus();
      return;
   }
   if (frmJogo.equ_cd_equipe_1.selectedIndex == 0)
   {
      alert('Selecione a equipe 1');
      frmJogo.equ_cd_equipe_1.focus();
      return;
   }
   if (frmJogo.equ_cd_equipe_2.selectedIndex == 0)
   {
      alert('Selecione a equipe 1');
      frmJogo.equ_cd_equipe_2.focus();
      return;
   }
   if (frmJogo.jog_qt_gol90_equ_1.value == '')
   {
      alert('Informe o número de gols da equipe 1 nos 90 minutos');
      frmJogo.jog_qt_gol90_equ_1.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_gol90_equ_1.value))
   {
      alert('O número de gols da equipe 1 nos 90 minutos deve ser numérico');
      frmJogo.jog_qt_gol90_equ_1.focus();
      return;
   }
   if (frmJogo.jog_qt_gol90_equ_2.value == '')
   {
      alert('Informe o número de gols da equipe 2 nos 90 minutos');
      frmJogo.jog_qt_gol90_equ_2.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_gol90_equ_2.value))
   {
      alert('O número de gols da equipe 2 nos 90 minutos deve ser numérico');
      frmJogo.jog_qt_gol90_equ_2.focus();
      return;
   }
   if (frmJogo.jog_qt_gol_equ_1.value == '')
   {
      alert('Informe o número total de gols da equipe 1');
      frmJogo.jog_qt_gol_equ_1.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_gol_equ_1.value))
   {
      alert('O número total de gols da equipe 1 deve ser numérico');
      frmJogo.jog_qt_gol_equ_1.focus();
      return;
   }
   if (frmJogo.jog_qt_gol_equ_2.value == '')
   {
      alert('Informe o número total de gols da equipe 2');
      frmJogo.jog_qt_gol_equ_2.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_gol_equ_2.value))
   {
      alert('O número total de gols da equipe 2 deve ser numérico');
      frmJogo.jog_qt_gol_equ_2.focus();
      return;
   }
   if (frmJogo.jog_qt_cartao_am_1.value == '')
   {
      alert('Informe o número de cartões amarelos da equipe 1');
      frmJogo.jog_qt_cartao_am_1.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_cartao_am_1.value))
   {
      alert('O número de cartões amarelos da equipe 1 deve ser numérico');
      frmJogo.jog_qt_cartao_am_1.focus();
      return;
   }
   if (frmJogo.jog_qt_cartao_am_2.value == '')
   {
      alert('Informe o número de cartões amarelos da equipe 2');
      frmJogo.jog_qt_cartao_am_2.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_cartao_am_2.value))
   {
      alert('O número de cartões amarelos da equipe 2 deve ser numérico');
      frmJogo.jog_qt_cartao_am_2.focus();
      return;
   }
   if (frmJogo.jog_qt_cartao_vr_1.value == '')
   {
      alert('Informe o número de cartões vermelhos da equipe 1');
      frmJogo.jog_qt_cartao_vr_1.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_cartao_vr_1.value))
   {
      alert('O número de cartões vermelhos da equipe 1 deve ser numérico');
      frmJogo.jog_qt_cartao_vr_1.focus();
      return;
   }
   if (frmJogo.jog_qt_cartao_vr_2.value == '')
   {
      alert('Informe o número de cartões vermelhos da equipe 2');
      frmJogo.jog_qt_cartao_vr_2.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_cartao_vr_2.value))
   {
      alert('O número de cartões vermelhos da equipe 2 deve ser numérico');
      frmJogo.jog_qt_cartao_vr_2.focus();
      return;
   }
   if (frmJogo.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmJogo.cam_cd_campeonato.focus();
      return;
   }
   if (frmJogo.fas_cd_fase.selectedIndex == 0)
   {
      alert('Selecione a fase');
      frmJogo.fas_cd_fase.focus();
      return;
   }
   if (frmJogo.gru_cd_grupo.selectedIndex == 0)
   {
      alert('Selecione o grupo');
      frmJogo.gru_cd_grupo.focus();
      return;
   }
   if (frmJogo.loc_cd_local.selectedIndex == 0)
   {
      alert('Selecione o local');
      frmJogo.loc_cd_local.focus();
      return;
   }
   if (confirm('Confirma a inclusão do jogo?'))
   {
      frmJogo.Opcao.value='Incluir';
      frmJogo.submit();
   }
}
//-----------------------------------------------------------------------------
function jogAlterar(frmJogo)
{
   if (frmJogo.jog_cd_jogo.value == '')
   {
      alert('Informe o número do jogo');
      frmJogo.jog_cd_jogo.focus();
      return;
   }
   if (isNaN(frmJogo.jog_cd_jogo.value))
   {
      alert('O número jogo deve ser numérico');
      frmJogo.jog_cd_jogo.focus();
      return;
   }
   if (frmJogo.jog_dt_jogo.value == '')
   {
      alert('Informe a data do jogo');
      frmJogo.jog_dt_jogo.focus();
      return;
   }
//   if (!(isDate(frmJogo.jog_dt_jogo)))
//   {
//      alert('Data do jogo inválida(DD/MM/AAAA HH:MM:SS)');
//      frmJogo.jog_dt_jogo.focus();
//      return;
//   }
   if (frmJogo.jog_ds_jogo.value == '')
   {
      alert('Informe a descrição do jogo');
      frmJogo.jog_ds_jogo.focus();
      return;
   }
   if (frmJogo.equ_cd_equipe_1.selectedIndex == 0)
   {
      alert('Selecione a equipe 1');
      frmJogo.equ_cd_equipe_1.focus();
      return;
   }
   if (frmJogo.equ_cd_equipe_2.selectedIndex == 0)
   {
      alert('Selecione a equipe 1');
      frmJogo.equ_cd_equipe_2.focus();
      return;
   }
   if (frmJogo.jog_qt_gol90_equ_1.value == '')
   {
      alert('Informe o número de gols da equipe 1 nos 90 minutos');
      frmJogo.jog_qt_gol90_equ_1.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_gol90_equ_1.value))
   {
      alert('O número de gols da equipe 1 nos 90 minutos deve ser numérico');
      frmJogo.jog_qt_gol90_equ_1.focus();
      return;
   }
   if (frmJogo.jog_qt_gol90_equ_2.value == '')
   {
      alert('Informe o número de gols da equipe 2 nos 90 minutos');
      frmJogo.jog_qt_gol90_equ_2.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_gol90_equ_2.value))
   {
      alert('O número de gols da equipe 2 nos 90 minutos deve ser numérico');
      frmJogo.jog_qt_gol90_equ_2.focus();
      return;
   }
   if (frmJogo.jog_qt_gol_equ_1.value == '')
   {
      alert('Informe o número total de gols da equipe 1');
      frmJogo.jog_qt_gol_equ_1.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_gol_equ_1.value))
   {
      alert('O número total de gols da equipe 1 deve ser numérico');
      frmJogo.jog_qt_gol_equ_1.focus();
      return;
   }
   if (frmJogo.jog_qt_gol_equ_2.value == '')
   {
      alert('Informe o número total de gols da equipe 2');
      frmJogo.jog_qt_gol_equ_2.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_gol_equ_2.value))
   {
      alert('O número total de gols da equipe 2 deve ser numérico');
      frmJogo.jog_qt_gol_equ_2.focus();
      return;
   }
   if (frmJogo.jog_qt_cartao_am_1.value == '')
   {
      alert('Informe o número de cartões amarelos da equipe 1');
      frmJogo.jog_qt_cartao_am_1.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_cartao_am_1.value))
   {
      alert('O número de cartões amarelos da equipe 1 deve ser numérico');
      frmJogo.jog_qt_cartao_am_1.focus();
      return;
   }
   if (frmJogo.jog_qt_cartao_am_2.value == '')
   {
      alert('Informe o número de cartões amarelos da equipe 2');
      frmJogo.jog_qt_cartao_am_2.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_cartao_am_2.value))
   {
      alert('O número de cartões amarelos da equipe 2 deve ser numérico');
      frmJogo.jog_qt_cartao_am_2.focus();
      return;
   }
   if (frmJogo.jog_qt_cartao_vr_1.value == '')
   {
      alert('Informe o número de cartões vermelhos da equipe 1');
      frmJogo.jog_qt_cartao_vr_1.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_cartao_vr_1.value))
   {
      alert('O número de cartões vermelhos da equipe 1 deve ser numérico');
      frmJogo.jog_qt_cartao_vr_1.focus();
      return;
   }
   if (frmJogo.jog_qt_cartao_vr_2.value == '')
   {
      alert('Informe o número de cartões vermelhos da equipe 2');
      frmJogo.jog_qt_cartao_vr_2.focus();
      return;
   }
   if (isNaN(frmJogo.jog_qt_cartao_vr_2.value))
   {
      alert('O número de cartões vermelhos da equipe 2 deve ser numérico');
      frmJogo.jog_qt_cartao_vr_2.focus();
      return;
   }
   if (frmJogo.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmJogo.cam_cd_campeonato.focus();
      return;
   }
   if (frmJogo.fas_cd_fase.selectedIndex == 0)
   {
      alert('Selecione a fase');
      frmJogo.fas_cd_fase.focus();
      return;
   }
   if (frmJogo.gru_cd_grupo.selectedIndex == 0)
   {
      alert('Selecione o grupo');
      frmJogo.gru_cd_grupo.focus();
      return;
   }
   if (frmJogo.loc_cd_local.selectedIndex == 0)
   {
      alert('Selecione o local');
      frmJogo.loc_cd_local.focus();
      return;
   }
   if (confirm('Confirma a alteração do jogo?'))
   {
      frmJogo.Opcao.value='Alterar';
      frmJogo.submit();
   }
}
//-----------------------------------------------------------------------------
function jogExcluir(frmJogo)
{
   if (frmJogo.jog_cd_jogo.value == '')
   {
      alert('Informe o número do jogo');
      frmJogo.jog_cd_jogo.focus();
      return;
   }
   if (isNaN(frmJogo.jog_cd_jogo.value))
   {
      alert('O número jogo deve ser numérico');
      frmJogo.jog_cd_jogo.focus();
      return;
   }
   if (confirm('Confirma a exclusão do jogo?'))
   {
      frmJogo.Opcao.value='Excluir';
      frmJogo.submit();
   }
}
//-----------------------------------------------------------------------------
function jogLimpar(frmJogo)
{
   frmJogo.jog_cd_jogo.value        = '';
   frmJogo.jog_dt_jogo.value        = '';
   frmJogo.jog_ds_jogo.value        = '';
   frmJogo.jog_qt_gol90_equ_1.value = '';
   frmJogo.jog_qt_gol90_equ_2.value = '';
   frmJogo.jog_qt_gol_equ_1.value   = '';
   frmJogo.jog_qt_gol_equ_2.value   = '';
   frmJogo.jog_qt_cartao_am_1.value = '';
   frmJogo.jog_qt_cartao_am_2.value = '';
   frmJogo.jog_qt_cartao_vr_1.value = '';
   frmJogo.jog_qt_cartao_vr_2.value = '';
   frmJogo.equ_cd_equipe_1.selectedIndex   = 0;
   frmJogo.equ_cd_equipe_2.selectedIndex   = 0;
   frmJogo.cam_cd_campeonato.selectedIndex = 0;
   frmJogo.fas_cd_fase.selectedIndex       = 0;
   frmJogo.gru_cd_grupo.selectedIndex      = 0;
   frmJogo.est_cd_estado.selectedIndex     = 0;
   frmJogo.Opcao.value = 'Limpar';
}
//-----------------------------------------------------------------------------
