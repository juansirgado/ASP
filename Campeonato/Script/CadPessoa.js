// -------------------------------------------------------------
// Program      : CadPessoa.js
// Description  : Script da página de pessoas
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function pesPesquisar(frmPessoa)
{
   if ((frmPessoa.pes_cd_pessoa.value == '') && (frmPessoa.pes_nm_pessoa.value == ''))
   {
      alert('Informe o número ou o nome da pessoa');
      frmPessoa.pes_cd_pessoa.focus();
      return;
   }
   if (isNaN(frmPessoa.pes_cd_pessoa.value))
   {
      alert('O número da pessoa deve ser numérico');
      frmPessoa.pes_cd_pessoa.focus();
      return;
   }
   frmPessoa.Opcao.value='Pesquisar';
   frmPessoa.submit();
}
//----------------------------------------------------------------------------
function pesIncluir(frmPessoa)
{
   if (frmPessoa.pes_cd_pessoa.value != '')
   {
      alert('O número da pessoa é automático não deve ser informado');
      frmPessoa.pes_cd_pessoa.focus();
      return;
   }
   if (isNaN(frmPessoa.pes_cd_pessoa.value))
   {
      alert('O número da pessoa deve ser numérico');
      frmPessoa.pes_cd_pessoa.focus();
      return;
   }
   if (frmPessoa.pes_nm_pessoa.value == '')
   {
      alert('Informe o nome da pessoa');
      frmPessoa.pes_nm_pessoa.focus();
      return;
   }
   if (frmPessoa.pes_cd_identificacao.value == '')
   {
      alert('Informe a identificação da pessoa');
      frmPessoa.pes_cd_identificacao.focus();
      return;
   }
   if (frmPessoa.pes_nu_cpf.value == '')
   {
      alert('Informe o número do CPF da pessoa');
      frmPessoa.pes_nu_cpf.focus();
      return;
   }
   if (frmPessoa.pes_nu_rg.value == '')
   {
      alert('Informe o número do RG da pessoa');
      frmPessoa.pes_nu_rg.focus();
      return;
   }
   if (frmPessoa.pes_nu_telefone.value == '')
   {
      alert('Informe o telefone da pessoa');
      frmPessoa.pes_nu_telefone.focus();
      return;
   }
   if (isNaN(frmPessoa.pes_nu_telefone.value))
   {
      alert('O telefone da pessoa deve ser numérico');
      frmPessoa.pes_nu_telefone.focus();
      return;
   }
   if (frmPessoa.pes_nu_celular.value == '')
   {
      alert('Informe o número do celular da pessoa');
      frmPessoa.pes_nu_celular.focus();
      return;
   }
   if (isNaN(frmPessoa.pes_nu_celular.value))
   {
      alert('O celular da pessoa deve ser numérico');
      frmPessoa.pes_nu_celular.focus();
      return;
   }
   if (frmPessoa.pes_ds_email.value == '')
   {
      alert('Informe o e-mail da pessoa');
      frmPessoa.pes_ds_email.focus();
      return;
   }
   if (frmPessoa.pes_dt_nascimento.value == '')
   {
      alert('Informe a data de nascimento da pessoa');
      frmPessoa.pes_dt_nascimento.focus();
      return;
   }
   if (!(isDate(frmPessoa.pes_dt_nascimento)))
   {
      alert('Data de nascimento da pessoa inválida(DD/MM/AAAA)');
      frmPessoa.pes_dt_nascimento.focus();
      return;
   }
   if (frmPessoa.pes_cd_acesso.value == '')
   {
      alert('Informe a senha de acesso da pessoa');
      frmPessoa.pes_cd_acesso.focus();
      return;
   }
//   if (!(isAlfaNumeric(frmPessoa.pes_cd_acesso.value)))
//   {
//      alert('A senha de acesso da pessoa deve ser Alfa-Numérica');
//      frmPessoa.pes_cd_acesso.focus();
//      return;
//   }
   if (confirm('Confirma a inclusão da pessoa?'))
   {
      frmPessoa.Opcao.value='Incluir';
      frmPessoa.submit();
   }
}
//-----------------------------------------------------------------------------
function pesAlterar(frmPessoa)
{
   if (frmPessoa.pes_cd_pessoa.value == '')
   {
      alert('Informe o número da pessoa');
      frmPessoa.pes_cd_pessoa.focus();
      return;
   }
   if (isNaN(frmPessoa.pes_cd_pessoa.value))
   {
      alert('O número da pessoa deve ser numérico');
      frmPessoa.pes_cd_pessoa.focus();
      return;
   }
   if (frmPessoa.pes_nm_pessoa.value == '')
   {
      alert('Informe o nome da pessoa');
      frmPessoa.pes_nm_pessoa.focus();
      return;
   }
   if (frmPessoa.pes_cd_identificacao.value == '')
   {
      alert('Informe a identificação da pessoa');
      frmPessoa.pes_cd_identificacao.focus();
      return;
   }
   if (frmPessoa.pes_nu_cpf.value == '')
   {
      alert('Informe o número do CPF da pessoa');
      frmPessoa.pes_nu_cpf.focus();
      return;
   }
   if (frmPessoa.pes_nu_rg.value == '')
   {
      alert('Informe o número do RG da pessoa');
      frmPessoa.pes_nu_rg.focus();
      return;
   }
   if (frmPessoa.pes_nu_telefone.value == '')
   {
      alert('Informe o telefone da pessoa');
      frmPessoa.pes_nu_telefone.focus();
      return;
   }
   if (isNaN(frmPessoa.pes_nu_telefone.value))
   {
      alert('O telefone da pessoa deve ser numérico');
      frmPessoa.pes_nu_telefone.focus();
      return;
   }
   if (frmPessoa.pes_nu_celular.value == '')
   {
      alert('Informe o número do celular da pessoa');
      frmPessoa.pes_nu_celular.focus();
      return;
   }
   if (isNaN(frmPessoa.pes_nu_celular.value))
   {
      alert('O celular da pessoa deve ser numérico');
      frmPessoa.pes_nu_celular.focus();
      return;
   }
   if (frmPessoa.pes_ds_email.value == '')
   {
      alert('Informe o e-mail da pessoa');
      frmPessoa.pes_ds_email.focus();
      return;
   }
   if (frmPessoa.pes_dt_nascimento.value == '')
   {
      alert('Informe a data de nascimento da pessoa');
      frmPessoa.pes_dt_nascimento.focus();
      return;
   }
   if (!(isDate(frmPessoa.pes_dt_nascimento)))
   {
      alert('Data de nascimento da pessoa inválida(DD/MM/AAAA)');
      frmPessoa.pes_dt_nascimento.focus();
      return;
   }
   if (frmPessoa.pes_cd_acesso.value == '')
   {
      alert('Informe a senha de acesso da pessoa');
      frmPessoa.pes_cd_acesso.focus();
      return;
   }
//   if (!(isAlfaNumeric(frmPessoa.pes_cd_acesso.value)))
//   {
//      alert('A senha de acesso da pessoa deve ser Alfa-Numérica');
//      frmPessoa.pes_cd_acesso.focus();
//      return;
//   }
   if (confirm('Confirma a alteração da pessoa?'))
   {
      frmPessoa.Opcao.value='Alterar';
      frmPessoa.submit();
   }
}
//-----------------------------------------------------------------------------
function pesExcluir(frmPessoa)
{
   if (frmPessoa.pes_cd_pessoa.value == '')
   {
      alert('Informe o número da pessoa');
      frmPessoa.pes_cd_pessoa.focus();
      return;
   }
   if (isNaN(frmPessoa.pes_cd_pessoa.value))
   {
      alert('O número da pessoa deve ser numérico');
      frmPessoa.pes_cd_pessoa.focus();
      return;
   }
   if (confirm('Confirma a exclusão da pessoa?'))
   {
      frmPessoa.Opcao.value='Excluir';
      frmPessoa.submit();
   }
}
//-----------------------------------------------------------------------------
function pesLimpar(frmPessoa)
{
   frmPessoa.pes_cd_pessoa.value        = '';
   frmPessoa.pes_nm_pessoa.value        = '';
   frmPessoa.pes_cd_identificacao.value = '';
   frmPessoa.pes_nu_cpf.value           = '';
   frmPessoa.pes_nu_rg.value            = '';
   frmPessoa.pes_nu_telefone.value      = '';
   frmPessoa.pes_nu_celular.value       = '';
   frmPessoa.pes_ds_email.value         = '';
   frmPessoa.pes_dt_nascimento.value    = '';
   frmPessoa.pes_cd_acesso.value        = '';
   frmPessoa.Opcao.value                = 'Limpar';
}
//-----------------------------------------------------------------------------
