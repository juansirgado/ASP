// -------------------------------------------------------------
// Program      : CadFase.js
// Description  : Script da página de fases
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function fasPesquisar(frmFase)
{
   if ((frmFase.fas_cd_fase.value == '') && (frmFase.fas_nm_fase.value == ''))
   {
      alert('Informe o número ou o nome da fase');
      frmFase.fas_cd_fase.focus();
      return;
   }
   if (isNaN(frmFase.fas_cd_fase.value))
   {
      alert('O número da fase deve ser numérico');
      frmFase.fas_cd_fase.focus();
      return;
   }
   frmFase.Opcao.value='Pesquisar';
   frmFase.submit();
}
//----------------------------------------------------------------------------
function fasIncluir(frmFase)
{
   if (frmFase.fas_cd_fase.value != '')
   {
      alert('O número da fase é automático não deve ser informado');
      frmFase.fas_cd_fase.focus();
      return;
   }
   if (isNaN(frmFase.fas_cd_fase.value))
   {
      alert('O número da fase deve ser numérico');
      frmFase.fas_cd_fase.focus();
      return;
   }
   if (frmFase.fas_nm_fase.value == '')
   {
      alert('Informe o nome da fase');
      frmFase.fas_nm_fase.focus();
      return;
   }
   if (frmFase.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmFase.cam_cd_campeonato.focus();
      return;
   }
   if (confirm('Confirma a inclusão da Fase?'))
   {
      frmFase.Opcao.value='Incluir';
      frmFase.submit();
   }
}
//-----------------------------------------------------------------------------
function fasAlterar(frmFase)
{
   if (frmFase.fas_cd_fase.value == '')
   {
      alert('Informe o número da fase');
      frmFase.fas_cd_fase.focus();
      return;
   }
   if (isNaN(frmFase.fas_cd_fase.value))
   {
      alert('O número da fase deve ser numérico');
      frmFase.fas_cd_fase.focus();
      return;
   }
   if (frmFase.fas_nm_fase.value == '')
   {
      alert('Informe o nome da fase');
      frmFase.fas_nm_fase.focus();
      return;
   }
   if (frmFase.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmFase.cam_cd_campeonato.focus();
      return;
   }
   if (confirm('Confirma a alteração do Fase?'))
   {
      frmFase.Opcao.value='Alterar';
      frmFase.submit();
   }
}
//-----------------------------------------------------------------------------
function fasExcluir(frmFase)
{
   if (frmFase.fas_cd_fase.value == '')
   {
      alert('Informe o número da fase');
      frmFase.fas_cd_fase.focus();
      return;
   }
   if (isNaN(frmFase.fas_cd_fase.value))
   {
      alert('O número da fase deve ser numérico');
      frmFase.fas_cd_fase.focus();
      return;
   }
   if (confirm('Confirma a exclusão da Fase?'))
   {
      frmFase.Opcao.value='Excluir';
      frmFase.submit();
   }
}
//-----------------------------------------------------------------------------
function fasLimpar(frmFase)
{
   frmFase.fas_cd_fase.value               = '';
   frmFase.fas_nm_fase.value               = '';
   frmFase.cam_cd_campeonato.selectedIndex = 0;
   frmFase.Opcao.value                     = 'Limpar';
}
//-----------------------------------------------------------------------------
