// -------------------------------------------------------------
// Program      : RelPalpites.js
// Description  : Script do relatório de palpites
// Version      : 1.0
// Date         : 12/06/2010
// Author       : Juan Sirgado y Antico
// Copyright(c) 2010 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

//----------------------------------------------------------------------------
function palListar(frmRelPalpites)
{
   if (frmRelPalpites.jog_cd_jogo.selectedIndex == 0)
   {
      alert('Informe o número do jogo');
      frmRelPalpites.jog_cd_jogo.focus();
      return;
   }
   frmRelPalpites.Opcao.value='Listar';
   frmRelPalpites.submit();
}
//-----------------------------------------------------------------------------
function palLimpar(frmRelPalpites)
{
   frmRelPalpites.jog_cd_jogo.selectedIndex = 0;
   frmRelPalpites.Opcao.value='Limpar';
}
//-----------------------------------------------------------------------------
