// -------------------------------------------------------------
// Program      : CadAposta.js
// Description  : Script da página de apostas
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function apoPesquisar(frmAposta)
{
   if ((frmAposta.apo_cd_aposta.value == '') && (frmAposta.apo_nm_aposta.value == ''))
   {
      alert('Informe o número ou nome da aposta');
      frmAposta.apo_cd_aposta.focus();
      return;
   }
   if (isNaN(frmAposta.apo_cd_aposta.value))
   {
      alert('O número da aposta deve ser numérico');
      frmAposta.apo_cd_aposta.focus();
      return;
   }
   frmAposta.Opcao.value='Pesquisar';
   frmAposta.submit();
}
//----------------------------------------------------------------------------
function apoIncluir(frmAposta)
{
   if (frmAposta.apo_cd_aposta.value != '')
   {
      alert('O número da aposta é automático não deve ser informado');
      frmAposta.apo_cd_aposta.focus();
      return;
   }
   if (isNaN(frmAposta.apo_cd_aposta.value))
   {
      alert('O número da aposta deve ser numérico');
      frmAposta.apo_cd_aposta.focus();
      return;
   }
   if (frmAposta.apo_nm_aposta.value == '')
   {
      alert('Informe o nome da aposta');
      frmAposta.apo_nm_aposta.focus();
      return;
   }
   if (frmAposta.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmAposta.cam_cd_campeonato.focus();
      return;
   }
   if (frmAposta.pes_cd_pessoa.selectedIndex == 0)
   {
      alert('Selecione a pessoa');
      frmAposta.pes_cd_pessoa.focus();
      return;
   }
   if (confirm('Confirma a inclusão da aposta?'))
   {
      frmAposta.Opcao.value='Incluir';
      frmAposta.submit();
   }
}
//-----------------------------------------------------------------------------
function apoAlterar(frmAposta)
{
   if (frmAposta.apo_cd_aposta.value == '')
   {
      alert('Informe o número da aposta');
      frmAposta.apo_cd_aposta.focus();
      return;
   }
   if (isNaN(frmAposta.apo_cd_aposta.value))
   {
      alert('O número da aposta deve ser numérico');
      frmAposta.apo_cd_aposta.focus();
      return;
   }
   if (frmAposta.apo_nm_aposta.value == '')
   {
      alert('Informe o nome da aposta');
      frmAposta.apo_nm_aposta.focus();
      return;
   }
   if (frmAposta.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmAposta.cam_cd_campeonato.focus();
      return;
   }
   if (frmAposta.pes_cd_pessoa.selectedIndex == 0)
   {
      alert('Selecione a pessoa');
      frmAposta.pes_cd_pessoa.focus();
      return;
   }
   if (confirm('Confirma a alteração da aposta?'))
   {
      frmAposta.Opcao.value='Alterar';
      frmAposta.submit();
   }
}
//-----------------------------------------------------------------------------
function apoExcluir(frmAposta)
{
   if (frmAposta.apo_cd_aposta.value == '')
   {
      alert('Informe o número da aposta');
      frmAposta.apo_cd_aposta.focus();
      return;
   }
   if (isNaN(frmAposta.apo_cd_aposta.value))
   {
      alert('O número da aposta deve ser numérico');
      frmAposta.apo_cd_aposta.focus();
      return;
   }
   if (confirm('Confirma a exclusão da aposta?'))
   {
      frmAposta.Opcao.value='Excluir';
      frmAposta.submit();
   }
}
//-----------------------------------------------------------------------------
function apoLimpar(frmAposta)
{
   frmAposta.apo_cd_aposta.value             = '';
   frmAposta.apo_qt_errado.value             = '';
   frmAposta.apo_qt_parcial.value            = '';
   frmAposta.apo_qt_correto.value            = '';
   frmAposta.apo_qt_pontos.value             = '';
   frmAposta.apo_dt_ultima_alt.value         = '';
   frmAposta.apo_cd_usuario_alt.value        = '';
   frmAposta.apo_nu_ip_alt.value             = '';
   frmAposta.cam_cd_campeonato.selectedIndex = 0;
   frmAposta.pes_cd_pessoa.selectedIndex     = 0;
   frmAposta.Opcao.value = 'Limpar';
}
//-----------------------------------------------------------------------------
