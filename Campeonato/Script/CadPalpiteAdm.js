// -------------------------------------------------------------
// Program      : CadPalpiteAdm.js
// Description  : Script da página de palpites
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function palPesquisar(frmPalpite)
{
   if (frmPalpite.pal_cd_palpite.value == '')
   {
      alert('Informe o número ou nome do palpite');
      frmPalpite.pal_cd_palpite.focus();
      return;
   }
   if (isNaN(frmPalpite.pal_cd_palpite.value))
   {
      alert('O número do palpite deve ser numérico');
      frmPalpite.pal_cd_palpite.focus();
      return;
   }
   frmPalpite.Opcao.value='Pesquisar';
   frmPalpite.submit();
}
//----------------------------------------------------------------------------
function palIncluir(frmPalpite)
{
   if (frmPalpite.pal_cd_palpite.value != '')
   {
      alert('O número do palpite é automático não deve ser informado');
      frmPalpite.pal_cd_palpite.focus();
      return;
   }
   if (isNaN(frmPalpite.pal_cd_palpite.value))
   {
      alert('O número do palpite deve ser numérico');
      frmPalpite.pal_cd_palpite.focus();
      return;
   }
   if (frmPalpite.pal_qt_gol_equipe_1.value == '')
   {
      alert('Informe o número de gols da equipe 1');
      frmPalpite.pal_qt_gol_equipe_1.focus();
      return;
   }
   if (isNaN(frmPalpite.pal_qt_gol_equipe_1.value))
   {
      alert('O número de gols da equipe 1 deve ser numérico');
      frmPalpite.pal_qt_gol_equipe_1.focus();
      return;
   }
   if (frmPalpite.pal_qt_gol_equipe_2.value == '')
   {
      alert('Informe o número de gols da equipe 2');
      frmPalpite.pal_qt_gol_equipe_2.focus();
      return;
   }
   if (isNaN(frmPalpite.pal_qt_gol_equipe_2.value))
   {
      alert('O número de gols da equipe 2 deve ser numérico');
      frmPalpite.pal_qt_gol_equipe_2.focus();
      return;
   }
   if (frmPalpite.pal_qt_pontos.value == '')
   {
      alert('Informe o número de pontos');
      frmPalpite.pal_qt_pontos.focus();
      return;
   }
   if (isNaN(frmPalpite.pal_qt_pontos.value))
   {
      alert('O número de pontos deve ser numérico');
      frmPalpite.pal_qt_pontos.focus();
      return;
   }
   if (frmPalpite.res_cd_resultado.selectedIndex == 0)
   {
      alert('Selecione o resultado');
      frmPalpite.res_cd_resultado.focus();
      return;
   }
   if (frmPalpite.jog_cd_jogo.selectedIndex == 0)
   {
      alert('Selecione o jogo');
      frmPalpite.jog_cd_jogo.focus();
      return;
   }
   if (frmPalpite.apo_cd_aposta.selectedIndex == 0)
   {
      alert('Selecione a aposta');
      frmPalpite.apo_cd_aposta.focus();
      return;
   }
   if (confirm('Confirma a inclusão do palpite?'))
   {
      frmPalpite.Opcao.value='Incluir';
      frmPalpite.submit();
   }
}
//-----------------------------------------------------------------------------
function palAlterar(frmPalpite)
{
   if (frmPalpite.pal_cd_palpite.value == '')
   {
      alert('Informe o número do palpite');
      frmPalpite.pal_cd_palpite.focus();
      return;
   }
   if (isNaN(frmPalpite.pal_cd_palpite.value))
   {
      alert('O número do palpite deve ser numérico');
      frmPalpite.pal_cd_palpite.focus();
      return;
   }
   if (frmPalpite.pal_qt_gol_equipe_1.value == '')
   {
      alert('Informe o número de gols da equipe 1');
      frmPalpite.pal_qt_gol_equipe_1.focus();
      return;
   }
   if (isNaN(frmPalpite.pal_qt_gol_equipe_1.value))
   {
      alert('O número de gols da equipe 1 deve ser numérico');
      frmPalpite.pal_qt_gol_equipe_1.focus();
      return;
   }
   if (frmPalpite.pal_qt_gol_equipe_2.value == '')
   {
      alert('Informe o número de gols da equipe 2');
      frmPalpite.pal_qt_gol_equipe_2.focus();
      return;
   }
   if (isNaN(frmPalpite.pal_qt_gol_equipe_2.value))
   {
      alert('O número de gols da equipe 2 deve ser numérico');
      frmPalpite.pal_qt_gol_equipe_2.focus();
      return;
   }
   if (frmPalpite.pal_qt_pontos.value == '')
   {
      alert('Informe o número de pontos');
      frmPalpite.pal_qt_pontos.focus();
      return;
   }
//   if (isNaN(frmPalpite.pal_qt_pontos.value))
//   {
//      alert('O número de pontos deve ser numérico');
//      frmPalpite.pal_qt_pontos.focus();
//      return;
//   }
   if (frmPalpite.res_cd_resultado.selectedIndex == 0)
   {
      alert('Selecione o resultado');
      frmPalpite.res_cd_resultado.focus();
      return;
   }
   if (frmPalpite.jog_cd_jogo.selectedIndex == 0)
   {
      alert('Selecione o jogo');
      frmPalpite.jog_cd_jogo.focus();
      return;
   }
   if (frmPalpite.apo_cd_aposta.selectedIndex == 0)
   {
      alert('Selecione a aposta');
      frmPalpite.apo_cd_aposta.focus();
      return;
   }
   if (confirm('Confirma a alteração do palpite?'))
   {
      frmPalpite.Opcao.value='Alterar';
      frmPalpite.submit();
   }
}
//-----------------------------------------------------------------------------
function palExcluir(frmPalpite)
{
   if (frmPalpite.pal_cd_palpite.value == '')
   {
      alert('Informe o número do palpite');
      frmPalpite.pal_cd_palpite.focus();
      return;
   }
   if (isNaN(frmPalpite.pal_cd_palpite.value))
   {
      alert('O número do palpite deve ser numérico');
      frmPalpite.pal_cd_palpite.focus();
      return;
   }
   if (confirm('Confirma a exclusão do palpite?'))
   {
      frmPalpite.Opcao.value='Excluir';
      frmPalpite.submit();
   }
}
//-----------------------------------------------------------------------------
function palLimpar(frmPalpite)
{
   frmPalpite.pal_cd_palpite.value           = '';
   frmPalpite.pal_qt_gol_equipe_1.value      = '';
   frmPalpite.pal_qt_gol_equipe_2.value      = '';
   frmPalpite.pal_qt_pontos.value            = '';
   frmPalpite.res_cd_resultado.selectedIndex = 0;
   frmPalpite.jog_cd_jogo.selectedIndex      = 0;
   frmPalpite.apo_cd_aposta.selectedIndex    = 0;
   frmPalpite.Opcao.value = 'Limpar';
}
//-----------------------------------------------------------------------------
