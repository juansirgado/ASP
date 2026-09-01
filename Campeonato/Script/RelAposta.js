// -------------------------------------------------------------
// Program      : RelAposta.js
// Description  : Script do relatório de Apostas
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
function apoListar(frmRelAposta)
{
   if (frmRelAposta.apo_cd_aposta.selectedIndex == 0)
   {
      alert('Informe o número da aposta');
      frmRelAposta.apo_cd_aposta.focus();
      return;
   }
   frmRelAposta.Opcao.value='Listar';
   frmRelAposta.submit();
}
//-----------------------------------------------------------------------------
function apoLimpar(frmRelAposta)
{
   frmRelAposta.apo_cd_aposta.selectedIndex = 0;
   frmRelAposta.Opcao.value='Limpar';
}
//-----------------------------------------------------------------------------
