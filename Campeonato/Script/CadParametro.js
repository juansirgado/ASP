// -------------------------------------------------------------
// Program      : CadParametro.js
// Description  : Script da página de paramentros
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function parPesquisar(frmParametro)
{
   if (frmParametro.par_cd_parametro.value == '')
   {
      alert('Informe o número ou nome do parametro');
      frmParametro.par_cd_parametro.focus();
      return;
   }
   if (isNaN(frmParametro.par_cd_parametro.value))
   {
      alert('O número do parametro deve ser numérico');
      frmParametro.par_cd_parametro.focus();
      return;
   }
   frmParametro.Opcao.value='Pesquisar';
   frmParametro.submit();
}
//----------------------------------------------------------------------------
function parIncluir(frmParametro)
{
   if (frmParametro.par_cd_parametro.value != '')
   {
      alert('O número do paramentro é automático não deve ser informado');
      frmParametro.par_cd_parametro.focus();
      return;
   }
   if (isNaN(frmParametro.par_cd_parametro.value))
   {
      alert('O número parametro deve ser numérico');
      frmParametro.par_cd_parametro.focus();
      return;
   }
   if (frmParametro.par_vl_jog_derrota.value == '')
   {
      alert('Informe os pontos do jogo para derrota');
      frmParametro.par_vl_jog_derrota.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_jog_derrota.value))
   {
      alert('Os pontos do jogo para derrota deve ser numérico');
      frmParametro.par_vl_jog_derrota.focus();
      return;
   }
   if (frmParametro.par_vl_jog_empate.value == '')
   {
      alert('Informe os pontos do jogo para empate');
      frmParametro.par_vl_jog_empate.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_jog_empate.value))
   {
      alert('Os pontos do jogo para empate deve ser numérico');
      frmParametro.par_vl_jog_empate.focus();
      return;
   }
   if (frmParametro.par_vl_jog_vitoria.value == '')
   {
      alert('Informe os pontos do jogo para vitória');
      frmParametro.par_vl_jog_vitoria.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_jog_vitoria.value))
   {
      alert('O pontos do jogo para vitória deve ser numérico');
      frmParametro.par_vl_jog_vitoria.focus();
      return;
   }
   if (frmParametro.par_vl_pal_errado.value == '')
   {
      alert('Informe os pontos do palpite errado');
      frmParametro.par_vl_pal_errado.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_pal_errado.value))
   {
      alert('O pontos para palpite errado deve ser numérico');
      frmParametro.par_vl_pal_errado.focus();
      return;
   }
   if (frmParametro.par_vl_pal_parcial.value == '')
   {
      alert('Informe os pontos do palpite parcial');
      frmParametro.par_vl_pal_parcial.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_pal_parcial.value))
   {
      alert('Os pontos para palpite parcial deve ser numérico');
      frmParametro.par_vl_pal_parcial.focus();
      return;
   }
   if (frmParametro.par_vl_pal_correto.value == '')
   {
      alert('Informe os pontos do palpite correto');
      frmParametro.par_vl_pal_correto.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_pal_correto.value))
   {
      alert('Os pontos para palpite correto deve ser numérico');
      frmParametro.par_vl_pal_correto.focus();
      return;
   }
   if (frmParametro.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmParametro.cam_cd_campeonato.focus();
      return;
   }
   if (frmParametro.fas_cd_fase.selectedIndex == 0)
   {
      alert('Selecione a fase');
      frmParametro.fas_cd_fase.focus();
      return;
   }
   if (confirm('Confirma a inclusão do parametro?'))
   {
      frmParametro.Opcao.value='Incluir';
      frmParametro.submit();
   }
}
//-----------------------------------------------------------------------------
function parAlterar(frmParametro)
{
   if (frmParametro.par_cd_parametro.value == '')
   {
      alert('Informe o número do parametro');
      frmParametro.par_cd_parametro.focus();
      return;
   }
   if (isNaN(frmParametro.par_cd_parametro.value))
   {
      alert('O número parametro deve ser numérico');
      frmParametro.par_cd_parametro.focus();
      return;
   }
   if (frmParametro.par_vl_jog_derrota.value == '')
   {
      alert('Informe os pontos do jogo para derrota');
      frmParametro.par_vl_jog_derrota.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_jog_derrota.value))
   {
      alert('Os pontos do jogo para derrota deve ser numérico');
      frmParametro.par_vl_jog_derrota.focus();
      return;
   }
   if (frmParametro.par_vl_jog_empate.value == '')
   {
      alert('Informe os pontos do jogo para empate');
      frmParametro.par_vl_jog_empate.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_jog_empate.value))
   {
      alert('Os pontos do jogo para empate deve ser numérico');
      frmParametro.par_vl_jog_empate.focus();
      return;
   }
   if (frmParametro.par_vl_jog_vitoria.value == '')
   {
      alert('Informe os pontos do jogo para vitória');
      frmParametro.par_vl_jog_vitoria.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_jog_vitoria.value))
   {
      alert('O pontos do jogo para vitória deve ser numérico');
      frmParametro.par_vl_jog_vitoria.focus();
      return;
   }
   if (frmParametro.par_vl_pal_errado.value == '')
   {
      alert('Informe os pontos do palpite errado');
      frmParametro.par_vl_pal_errado.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_pal_errado.value))
   {
      alert('O pontos para palpite errado deve ser numérico');
      frmParametro.par_vl_pal_errado.focus();
      return;
   }
   if (frmParametro.par_vl_pal_parcial.value == '')
   {
      alert('Informe os pontos do palpite parcial');
      frmParametro.par_vl_pal_parcial.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_pal_parcial.value))
   {
      alert('Os pontos para palpite parcial deve ser numérico');
      frmParametro.par_vl_pal_parcial.focus();
      return;
   }
   if (frmParametro.par_vl_pal_correto.value == '')
   {
      alert('Informe os pontos do palpite correto');
      frmParametro.par_vl_pal_correto.focus();
      return;
   }
   if (isNaN(frmParametro.par_vl_pal_correto.value))
   {
      alert('Os pontos para palpite correto deve ser numérico');
      frmParametro.par_vl_pal_correto.focus();
      return;
   }
   if (frmParametro.cam_cd_campeonato.selectedIndex == 0)
   {
      alert('Selecione o campeonato');
      frmParametro.cam_cd_campeonato.focus();
      return;
   }
   if (frmParametro.fas_cd_fase.selectedIndex == 0)
   {
      alert('Selecione a fase');
      frmParametro.fas_cd_fase.focus();
      return;
   }
   if (confirm('Confirma a alteração do parametro?'))
   {
      frmParametro.Opcao.value='Alterar';
      frmParametro.submit();
   }
}
//-----------------------------------------------------------------------------
function parExcluir(frmParametro)
{
   if (frmParametro.par_cd_parametro.value == '')
   {
      alert('Informe o número do parametro');
      frmParametro.par_cd_parametro.focus();
      return;
   }
   if (isNaN(frmParametro.par_cd_parametro.value))
   {
      alert('O número parametro deve ser numérico');
      frmParametro.par_cd_parametro.focus();
      return;
   }
   if (confirm('Confirma a exclusão do parametro?'))
   {
      frmParametro.Opcao.value='Excluir';
      frmParametro.submit();
   }
}
//-----------------------------------------------------------------------------
function parLimpar(frmParametro)
{
   frmParametro.par_cd_parametro.value   = '';
   frmParametro.par_vl_jog_derrota.value = '';
   frmParametro.par_vl_jog_empate.value  = '';
   frmParametro.par_vl_jog_vitoria.value = '';
   frmParametro.par_vl_pal_errado.value  = '';
   frmParametro.par_vl_pal_parcial.value = '';
   frmParametro.par_vl_pal_correto.value = '';
   frmParametro.cam_cd_campeonato.selectedIndex = 0;
   frmParametro.fas_cd_fase.selectedIndex       = 0;
   frmParametro.Opcao.value = 'Limpar';
}
//-----------------------------------------------------------------------------
