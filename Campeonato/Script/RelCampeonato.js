// -------------------------------------------------------------
// Program      : RelCampeonato.js
// Description  : Script do relatório de campeonatos
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

//----------------------------------------------------------------------------
function camListar(frmRelCampeonato)
{
   if (frmRelCampeonato.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Informe o número do campeonato');
      frmRelCampeonato.cam_cd_campeonato.focus();
      return;
   }
   frmRelCampeonato.Opcao.value='Listar';
   frmRelCampeonato.submit();
}
//-----------------------------------------------------------------------------
function camLimpar(frmRelCampeonato)
{
   frmRelCampeonato.cam_cd_campeonato.selectedIndex = 0;
   frmRelCampeonato.Opcao.value='Limpar';
}
//-----------------------------------------------------------------------------
