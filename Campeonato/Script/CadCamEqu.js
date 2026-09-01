// -------------------------------------------------------------
// Program      : CadCamEqu.js
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

function rcePesquisar(frmCamEqu)
{
   if (frmCamEqu.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmCamEqu.cam_cd_campeonato.focus();
      return;
   }
   frmCamEqu.Opcao.value='Pesquisar';
   frmCamEqu.submit();
}
//----------------------------------------------------------------------------
function rceAtualizar(frmCamEqu)
{
   if (frmCamEqu.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione a campeonato');
      frmCamEqu.cam_cd_campeonato.focus();
      return;
   }
   if (confirm('Confirma a atualização do campeonato x equipes?'))
   {
	  setItens(frmCamEqu.equ_cd_equipe_2);
      frmCamEqu.Opcao.value='Atualizar';
      frmCamEqu.submit();
   }
}
//-----------------------------------------------------------------------------
function rceLimpar(frmCamEqu)
{
   frmCamEqu.cam_cd_campeonato.selectedIndex = 0;
   frmCamEqu.Opcao.value = 'Limpar';
}
//-----------------------------------------------------------------------------
