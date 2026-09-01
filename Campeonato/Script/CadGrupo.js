// -------------------------------------------------------------
// Program      : CadGrupo.js
// Description  : Script da página de grupos
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function gruPesquisar(frmGrupo)
{
   if ((frmGrupo.gru_cd_grupo.value == '') && (frmGrupo.gru_nm_grupo.value == ''))
   {
      alert('Informe o número ou o nome do grupo');
      frmGrupo.gru_cd_grupo.focus();
      return;
   }
   if (isNaN(frmGrupo.gru_cd_grupo.value))
   {
      alert('O número do grupo deve ser numérico');
      frmGrupo.gru_cd_grupo.focus();
      return;
   }
   frmGrupo.Opcao.value='Pesquisar';
   frmGrupo.submit();
}
//----------------------------------------------------------------------------
function gruIncluir(frmGrupo)
{
   if (frmGrupo.gru_cd_grupo.value != '')
   {
      alert('O número do grupo é automático não deve ser informado');
      frmGrupo.gru_cd_grupo.focus();
      return;
   }
   if (isNaN(frmGrupo.gru_cd_grupo.value))
   {
      alert('O número do grupo deve ser numérico');
      frmGrupo.gru_cd_grupo.focus();
      return;
   }
   if (frmGrupo.gru_nm_grupo.value == '')
   {
      alert('Informe o nome do grupo');
      frmGrupo.gru_nm_grupo.focus();
      return;
   }
   if (frmGrupo.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmGrupo.cam_cd_campeonato.focus();
      return;
   }
   if (confirm('Confirma a inclusão do Grupo?'))
   {
      frmGrupo.Opcao.value='Incluir';
      frmGrupo.submit();
   }
}
//-----------------------------------------------------------------------------
function gruAlterar(frmGrupo)
{
   if (frmGrupo.gru_cd_grupo.value == '')
   {
      alert('Informe o número do grupo');
      frmGrupo.gru_cd_grupo.focus();
      return;
   }
   if (isNaN(frmGrupo.gru_cd_grupo.value))
   {
      alert('O número do grupo deve ser numérico');
      frmGrupo.gru_cd_grupo.focus();
      return;
   }
   if (frmGrupo.gru_nm_grupo.value == '')
   {
      alert('Informe o nome do grupo');
      frmGrupo.gru_nm_grupo.focus();
      return;
   }
   if (frmGrupo.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmGrupo.cam_cd_campeonato.focus();
      return;
   }
   if (confirm('Confirma a alteração do Grupo?'))
   {
      frmGrupo.Opcao.value='Alterar';
      frmGrupo.submit();
   }
}
//-----------------------------------------------------------------------------
function gruExcluir(frmGrupo)
{
   if (frmGrupo.gru_cd_grupo.value == '')
   {
      alert('Informe o número do grupo');
      frmGrupo.gru_cd_grupo.focus();
      return;
   }
   if (isNaN(frmGrupo.gru_cd_grupo.value))
   {
      alert('O número do grupo deve ser numérico');
      frmGrupo.gru_cd_grupo.focus();
      return;
   }
   if (confirm('Confirma a exclusão do Grupo?'))
   {
      frmGrupo.Opcao.value='Excluir';
      frmGrupo.submit();
   }
}
//-----------------------------------------------------------------------------
function gruLimpar(frmGrupo)
{
   frmGrupo.gru_cd_grupo.value              = '';
   frmGrupo.gru_nm_grupo.value              = '';
   frmGrupo.cam_cd_campeonato.selectedIndex = 0;
   frmGrupo.Opcao.value                     = 'Limpar';
}
//-----------------------------------------------------------------------------
