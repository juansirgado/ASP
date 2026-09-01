// -------------------------------------------------------------
// Program      : CadPalpite.js
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
   if (frmPalpite.apo_cd_aposta.selectedIndex == 0)
   {
      alert('Selecione a aposta');
      frmPalpite.apo_cd_aposta.focus();
      return;
   }
   frmPalpite.Opcao.value='Pesquisar';
   frmPalpite.submit();
}
//----------------------------------------------------------------------------
function palAtualizar(frmPalpite)
{
   if (frmPalpite.apo_cd_aposta.selectedIndex == 0)
   {
      alert('Selecione a aposta');
      frmPalpite.apo_cd_aposta.focus();
      return;
   }
//   for (int i = 1; i < frmPalpite.cam_qt_jogos.value; i++)
//   {
      if (frmPalpite.pal_qt_gol_equipe_1_1.value == '')
      {
         alert('Informe o número de gols');
         frmPalpite.pal_qt_gol_equipe_1_1.focus();
         return;
      }
      if (isNaN(frmPalpite.pal_qt_gol_equipe_1_1.value))
      {
         alert('O número de gols deve ser numérico');
         frmPalpite.pal_qt_gol_equipe_1_1.focus();
         return;
      }
      if (frmPalpite.pal_qt_gol_equipe_2_1.value == '')
      {
         alert('Informe o número de gols');
         frmPalpite.pal_qt_gol_equipe_2_1.focus();
         return;
      }
      if (isNaN(frmPalpite.pal_qt_gol_equipe_2_1.value))
      {
         alert('O número de gols deve ser numérico');
         frmPalpite.pal_qt_gol_equipe_2_1.focus();
         return;
      }
//   }
   if (confirm('Confirma a atualização dos palpites?'))
   {
      frmPalpite.Opcao.value='Atualizar';
      frmPalpite.submit();
   }
}
//-----------------------------------------------------------------------------
function palLimpar(frmPalpite)
{
   frmPalpite.apo_cd_aposta.selectedIndex = 0;
   frmPalpite.Opcao.value = 'Limpar';
}
//-----------------------------------------------------------------------------
