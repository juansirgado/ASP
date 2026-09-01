// -------------------------------------------------------------
// Program      : CadLocal.js
// Description  : Script da página de locals
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function locPesquisar(frmLocal)
{
   if ((frmLocal.loc_cd_local.value == '') && (frmLocal.loc_nm_local.value == ''))
   {
      alert('Informe o número ou o nome do local');
      frmLocal.loc_cd_local.focus();
      return;
   }
   if (isNaN(frmLocal.loc_cd_local.value))
   {
      alert('O número do local deve ser numérico');
      frmLocal.loc_cd_local.focus();
      return;
   }
   frmLocal.Opcao.value='Pesquisar';
   frmLocal.submit();
}
//----------------------------------------------------------------------------
function locIncluir(frmLocal)
{
   if (frmLocal.loc_cd_local.value != '')
   {
      alert('O número do local é automático não deve ser informado');
      frmLocal.loc_cd_local.focus();
      return;
   }
   if (frmLocal.loc_nm_local.value == '')
   {
      alert('Informe o nome do local');
      frmLocal.loc_nm_local.focus();
      return;
   }
   if (frmLocal.loc_ds_local.value == '')
   {
      alert('Informe a descrição do local');
      frmLocal.loc_ds_local.focus();
      return;
   }
   if (frmLocal.est_cd_estado.selectedIndex == 0)
   {
      alert('Selecione o estado');
      frmLocal.est_cd_estado.focus();
      return;
   }
   if (confirm('Confirma a inclusão do local?'))
   {
      frmLocal.Opcao.value='Incluir';
      frmLocal.submit();
   }
}
//-----------------------------------------------------------------------------
function locAlterar(frmLocal)
{
   if (frmLocal.loc_cd_local.value == '')
   {
      alert('Informe o número do local');
      frmLocal.loc_cd_local.focus();
      return;
   }
   if (isNaN(frmLocal.loc_cd_local.value))
   {
      alert('O número do local deve ser numérico');
      frmLocal.loc_cd_local.focus();
      return;
   }
   if (frmLocal.loc_nm_local.value == '')
   {
      alert('Informe o nome do local');
      frmLocal.loc_nm_local.focus();
      return;
   }
   if (frmLocal.loc_ds_local.value == '')
   {
      alert('Informe a descrição do local');
      frmLocal.loc_ds_local.focus();
      return;
   }
   if (frmLocal.est_cd_estado.selectedIndex == 0)
   {
      alert('Selecione o estado');
      frmLocal.est_cd_estado.focus();
      return;
   }
   if (confirm('Confirma a alteração do local?'))
   {
      frmLocal.Opcao.value='Alterar';
      frmLocal.submit();
   }
}
//-----------------------------------------------------------------------------
function locExcluir(frmLocal)
{
   if (frmLocal.loc_cd_local.value == '')
   {
      alert('Informe o número do local');
      frmLocal.loc_cd_local.focus();
      return;
   }
   if (isNaN(frmLocal.loc_cd_local.value))
   {
      alert('O número do local deve ser numérico');
      frmLocal.loc_cd_local.focus();
      return;
   }
   if (confirm('Confirma a exclusão do local?'))
   {
      frmLocal.Opcao.value='Excluir';
      frmLocal.submit();
   }
}
//-----------------------------------------------------------------------------
function locLimpar(frmLocal)
{
   frmLocal.loc_cd_local.value             = '';
   frmLocal.loc_nm_local.value             = '';
   frmLocal.loc_ds_local.value             = '';
   frmLocal.est_cd_estado.selectedIndex     = 0;
   frmLocal.Opcao.value                     = 'Limpar';
}
//-----------------------------------------------------------------------------
