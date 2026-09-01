// -------------------------------------------------------------
// Program      : ProClassificacao.js
// Description  : Script da página do processo de classificação(Time/Aposta)
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function claPesquisar(frmProClassificacao)
{
   if (frmProClassificacao.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Informe o número do campeonato');
      frmProClassificacao.cam_cd_campeonato.focus();
      return;
   }
   frmProClassificacao.Opcao.value='Pesquisar';
   frmProClassificacao.submit();
}
//----------------------------------------------------------------------------
function claProcessar(frmProClassificacao)
{
   if (frmProClassificacao.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Informe o número do campeonato');
      frmProClassificacao.cam_cd_campeonato.focus();
      return;
   }
   if (confirm('Confirma o processamento?'))
   {
      frmProClassificacao.Opcao.value='Processar';
      frmProClassificacao.submit();
   }
}
//-----------------------------------------------------------------------------
function claLimpar(frmProClassificacao)
{
   frmProClassificacao.cam_cd_campeonato.selectedIndex = 0;
   frmProClassificacao.cam_in_classificacao.checked    = false;
   frmProClassificacao.cam_in_equipe.checked           = false;
   frmProClassificacao.cam_in_palpite.checked          = false;
   frmProClassificacao.cam_in_aposta.checked           = false;
   frmProClassificacao.Opcao.value='Limpar';
}
//-----------------------------------------------------------------------------
