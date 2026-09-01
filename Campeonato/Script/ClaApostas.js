// -------------------------------------------------------------
// Program      : ClaApostas.js
// Description  : Script do relatório de palpites
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
function palListar(frmClaApostas)
{
   if (frmClaApostas.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Informe o número do campeonato');
      frmClaApostas.cam_cd_campeonato.focus();
      return;
   }
   frmClaApostas.Opcao.value='Listar';
   frmClaApostas.submit();
}
//-----------------------------------------------------------------------------
function palLimpar(frmClaApostas)
{
   frmClaApostas.cam_cd_campeonato.selectedIndex = 0;
   frmClaApostas.Opcao.value='Limpar';
}
//-----------------------------------------------------------------------------
