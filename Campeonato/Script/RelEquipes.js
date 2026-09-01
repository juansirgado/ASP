// -------------------------------------------------------------
// Program      : RelEquipes.js
// Description  : Script do relatório de campeonatos
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA Informática. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

//----------------------------------------------------------------------------
function equListar(frmRelEquipes)
{
   if (frmRelEquipes.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Informe o número do campeonato');
      frmRelEquipes.cam_cd_campeonato.focus();
      return;
   }
   frmRelEquipes.Opcao.value='Listar';
   frmRelEquipes.submit();
}
//-----------------------------------------------------------------------------
function equLimpar(frmRelEquipes)
{
   frmRelEquipes.cam_cd_campeonato.selectedIndex = 0;
   frmRelEquipes.Opcao.value='Limpar';
}
//-----------------------------------------------------------------------------
