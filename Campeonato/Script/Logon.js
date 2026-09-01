// -------------------------------------------------------------
// Program      : Logon.js
// Description  : Script da página de logon
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function logEntrar(frmLog0n)
{
   if (frmLogon.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmLogon.cam_cd_campeonato.focus();
      return;
   }
   if (frmLogon.pes_cd_pessoa.selectedIndex == 0)
   {
      alert('Usuário não cadastrado');
      frmLogon.cam_cd_campeonato.focus();
      return;
   }
   if (frmLogon.pes_cd_acesso.value == '')
   {
      alert('Informe a senha de Login');
      frmLogon.pes_cd_acesso.focus();
      return;
   }
   frmLogon.Opcao.value='Entrar';
   frmLogon.submit();
}
//----------------------------------------------------------------------------
function logLimpar(frmLogon)
{
   frmLogon.cam_cd_campeonato.selectedIndex = 0;
   frmLogon.pes_cd_acesso.value             = '';
   frmLogon.Opcao.value                     = 'Limpar';
}
//-----------------------------------------------------------------------------
