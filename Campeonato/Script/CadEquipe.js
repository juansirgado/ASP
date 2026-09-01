// -------------------------------------------------------------
// Program      : CadEquipe.js
// Description  : Script da página de equipes
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function equPesquisar(frmEquipe)
{
   if ((frmEquipe.equ_cd_equipe.value == '') && (frmEquipe.equ_nm_equipe.value == ''))
   {
      alert('Informe o número ou o nome da equipe');
      frmEquipe.equ_cd_equipe.focus();
      return;
   }
   if (isNaN(frmEquipe.equ_cd_equipe.value))
   {
      alert('O número da equipe deve ser numérico');
      frmEquipe.equ_cd_equipe.focus();
      return;
   }
   frmEquipe.Opcao.value='Pesquisar';
   frmEquipe.submit();
}
//----------------------------------------------------------------------------
function equIncluir(frmEquipe)
{
   if (frmEquipe.equ_cd_equipe.value != '')
   {
      alert('O número da equipe é automático não deve ser informado');
      frmEquipe.equ_cd_equipe.focus();
      return;
   }
   if (isNaN(frmEquipe.equ_cd_equipe.value))
   {
      alert('O número da equipe deve ser numérico');
      frmEquipe.equ_cd_equipe.focus();
      return;
   }
   if (frmEquipe.equ_nm_equipe.value == '')
   {
      alert('Informe o nome da equipe');
      frmEquipe.equ_nm_equipe.focus();
      return;
   }
   if (frmEquipe.equ_ds_equipe.value == '')
   {
      alert('Informe a descrição da equipe');
      frmEquipe.equ_ds_equipe.focus();
      return;
   }
   if (frmEquipe.est_cd_estado.selectedIndex == 0)
   {
      alert('Selecione o estado');
      frmEquipe.est_cd_estado.focus();
      return;
   }
   if (confirm('Confirma a inclusão da equipe?'))
   {
      frmEquipe.Opcao.value='Incluir';
      frmEquipe.submit();
   }
}
//-----------------------------------------------------------------------------
function equAlterar(frmEquipe)
{
   if (frmEquipe.equ_cd_equipe.value == '')
   {
      alert('Informe o número da equipe');
      frmEquipe.equ_cd_equipe.focus();
      return;
   }
   if (isNaN(frmEquipe.equ_cd_equipe.value))
   {
      alert('O número da equipe deve ser numérico');
      frmEquipe.equ_cd_equipe.focus();
      return;
   }
   if (frmEquipe.equ_nm_equipe.value == '')
   {
      alert('Informe o nome da equipe');
      frmEquipe.equ_nm_equipe.focus();
      return;
   }
   if (frmEquipe.equ_ds_equipe.value == '')
   {
      alert('Informe a descrição da equipe');
      frmEquipe.equ_ds_equipe.focus();
      return;
   }
   if (frmEquipe.est_cd_estado.selectedIndex == 0)
   {
      alert('Selecione o estado');
      frmEquipe.est_cd_estado.focus();
      return;
   }
   if (confirm('Confirma a alteração da equipe?'))
   {
      frmEquipe.Opcao.value='Alterar';
      frmEquipe.submit();
   }
}
//-----------------------------------------------------------------------------
function equExcluir(frmEquipe)
{
   if (frmEquipe.equ_cd_equipe.value == '')
   {
      alert('Informe o número da equipe');
      frmEquipe.equ_cd_equipe.focus();
      return;
   }
   if (isNaN(frmEquipe.equ_cd_equipe.value))
   {
      alert('O número da equipe deve ser numérico');
      frmEquipe.equ_cd_equipe.focus();
      return;
   }
   if (confirm('Confirma a exclusão da equipe?'))
   {
      frmEquipe.Opcao.value='Excluir';
      frmEquipe.submit();
   }
}
//-----------------------------------------------------------------------------
function equLimpar(frmEquipe)
{
   frmEquipe.equ_cd_equipe.value             = '';
   frmEquipe.equ_nm_equipe.value             = '';
   frmEquipe.equ_ds_equipe.value             = '';
   frmEquipe.est_cd_estado.selectedIndex     = 0;
   frmEquipe.Opcao.value                     = 'Limpar';
}
//-----------------------------------------------------------------------------
