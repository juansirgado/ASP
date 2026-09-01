// -------------------------------------------------------------
// Program      : ClaEquipes.js
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
function equListar(frmClaEquipes)
{
   if (frmClaEquipes.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Informe o número do campeonato');
      frmClaEquipes.cam_cd_campeonato.focus();
      return;
   }
   frmClaEquipes.Opcao.value='Listar';
   frmClaEquipes.submit();
}
//-----------------------------------------------------------------------------
function equLimpar(frmClaEquipes)
{
   frmClaEquipes.cam_cd_campeonato.selectedIndex = 0;
   frmClaEquipes.Opcao.value='Limpar';
}
//-----------------------------------------------------------------------------
