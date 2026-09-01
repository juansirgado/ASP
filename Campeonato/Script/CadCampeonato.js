// -------------------------------------------------------------
// Program      : CadCampeonato.js
// Description  : Script da página de campeonatos
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function camPesquisar(frmCampeonato)
{
   if ((frmCampeonato.cam_cd_campeonato.value == '') && (frmCampeonato.cam_nm_campeonato.value == ''))
   {
      alert('Informe o número ou nome do campeonato');
      frmCampeonato.cam_cd_campeonato.focus();
      return;
   }
   if (isNaN(frmCampeonato.cam_cd_campeonato.value))
   {
      alert('O número do campeonato deve ser numérico');
      frmCampeonato.cam_cd_campeonato.focus();
      return;
   }
   frmCampeonato.Opcao.value='Pesquisar';
   frmCampeonato.submit();
}
//----------------------------------------------------------------------------
function camIncluir(frmCampeonato)
{
   if (frmCampeonato.cam_cd_campeonato.value != '')
   {
      alert('O número do campeonato é automático não deve ser informado');
      frmCampeonato.cam_cd_campeonato.focus();
      return;
   }
   if (isNaN(frmCampeonato.cam_cd_campeonato.value))
   {
      alert('O número campeonato deve ser numérico');
      frmCampeonato.cam_cd_campeonato.focus();
      return;
   }
   if (frmCampeonato.cam_nm_campeonato.value == '')
   {
      alert('Informe o nome do campeonato');
      frmCampeonato.cam_nm_campeonato.focus();
      return;
   }
   if (frmCampeonato.cam_dt_inicio.value == '')
   {
      alert('Informe a data de início do campeonato');
      frmCampeonato.cam_dt_inicio.focus();
      return;
   }
   if (!(isDate(frmCampeonato.cam_dt_inicio)))
   {
      alert('Data de início de campeonato inválida(DD/MM/AAAA)');
      frmCampeonato.cam_dt_inicio.focus();
      return;
   }
   if (frmCampeonato.cam_dt_termino.value == '')
   {
      alert('Informe a data de termino do campeonato');
      frmCampeonato.cam_dt_termino.focus();
      return;
   }
   if (!(isDate(frmCampeonato.cam_dt_termino)))
   {
      alert('Data de termino de campeonato inválida(DD/MM/AAAA)');
      frmCampeonato.cam_dt_termino.focus();
      return;
   }
   if (frmCampeonato.cam_ds_campeonato.value == '')
   {
      alert('Informe a descrição do campeonato');
      frmCampeonato.cam_ds_campeonato.focus();
      return;
   }
   if (frmCampeonato.cam_vl_aposta.value == '')
   {
      alert('Informe o valor da aposta para o campeonato');
      frmCampeonato.cam_vl_aposta.focus();
      return;
   }
   if (confirm('Confirma a inclusão do campeonato?'))
   {
      frmCampeonato.Opcao.value='Incluir';
      frmCampeonato.submit();
   }
}
//-----------------------------------------------------------------------------
function camAlterar(frmCampeonato)
{
   if (frmCampeonato.cam_cd_campeonato.value == '')
   {
      alert('Informe o número do campeonato');
      frmCampeonato.cam_cd_campeonato.focus();
      return;
   }
   if (isNaN(frmCampeonato.cam_cd_campeonato.value))
   {
      alert('O número campeonato deve ser numérico');
      frmCampeonato.cam_cd_campeonato.focus();
      return;
   }
   if (frmCampeonato.cam_nm_campeonato.value == '')
   {
      alert('Informe o nome do campeonato');
      frmCampeonato.cam_nm_campeonato.focus();
      return;
   }
   if (frmCampeonato.cam_dt_inicio.value == '')
   {
      alert('Informe a data de início do campeonato');
      frmCampeonato.cam_dt_inicio.focus();
      return;
   }
   if (!(isDate(frmCampeonato.cam_dt_inicio)))
   {
      alert('Data de início de campeonato inválida(DD/MM/AAAA)');
      frmCampeonato.cam_dt_inicio.focus();
      return;
   }
   if (frmCampeonato.cam_dt_termino.value == '')
   {
      alert('Informe a data de termino do campeonato');
      frmCampeonato.cam_dt_termino.focus();
      return;
   }
   if (!(isDate(frmCampeonato.cam_dt_termino)))
   {
      alert('Data de termino de campeonato inválida(DD/MM/AAAA)');
      frmCampeonato.cam_dt_termino.focus();
      return;
   }
   if (frmCampeonato.cam_ds_campeonato.value == '')
   {
      alert('Informe a descrição do campeonato');
      frmCampeonato.cam_ds_campeonato.focus();
      return;
   }
   if (frmCampeonato.cam_vl_aposta.value == '')
   {
      alert('Informe o valor da aposta para o campeonato');
      frmCampeonato.cam_vl_aposta.focus();
      return;
   }
   if (confirm('Confirma a alteração do campeonato?'))
   {
      frmCampeonato.Opcao.value='Alterar';
      frmCampeonato.submit();
   }
}
//-----------------------------------------------------------------------------
function camExcluir(frmCampeonato)
{
   if (frmCampeonato.cam_cd_campeonato.value == '')
   {
      alert('Informe o número do campeonato');
      frmCampeonato.cam_cd_campeonato.focus();
      return;
   }
   if (isNaN(frmCampeonato.cam_cd_campeonato.value))
   {
      alert('O número campeonato deve ser numérico');
      frmCampeonato.cam_cd_campeonato.focus();
      return;
   }
   if (confirm('Confirma a exclusão do campeonato?'))
   {
      frmCampeonato.Opcao.value='Excluir';
      frmCampeonato.submit();
   }
}
//-----------------------------------------------------------------------------
function camLimpar(frmCampeonato)
{
   frmCampeonato.cam_cd_campeonato.value = '';
   frmCampeonato.cam_nm_campeonato.value = '';
   frmCampeonato.cam_dt_inicio.value     = '';
   frmCampeonato.cam_dt_termino.value    = '';
   frmCampeonato.cam_ds_campeonato.value = '';
   frmCampeonato.cam_vl_aposta.value     = '';
   frmCampeonato.Opcao.value             = 'Limpar';
}
//-----------------------------------------------------------------------------
