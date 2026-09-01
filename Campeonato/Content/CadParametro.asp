<% @Language=VBScript %>
<% Option Explicit %>

<!-- #include file = "Include\ConfigDB.asp" -->
<!-- #include file = "Include\MountCombo.asp" -->
<!-- #include file = "Include\VerifyAccess.asp" -->
<% VerifyAccess() %>

<html>

<!--
   -------------------------------------------------------------
   Program      : CadParametro.asp
   Description  : Página do cadastro de parametros
   Version      : 1.0
   Date         : 24/06/2005
   Author       : Juan Sirgado y Antico
   Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
   -------------------------------------------------------------
   Version      :
   Date         :
   Author       :
   -------------------------------------------------------------
-->

<head>
<title>Cadastro de Parametros</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadParametro.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmParametro" action="CadParametro.asp">
<center>
<br>
<h1>Cadastro de Parametros</h1>

<%
' Função de definição das variáveis do Parametro ===============================
'===============================================================================
Dim objCn, parRs, strQr, strCn, strOp, strMSG, strAdm
Dim str_cd_parametro, str_vl_jog_derrota, str_vl_jog_empate, str_vl_jog_vitoria
Dim str_vl_pal_errado, str_vl_pal_parcial, str_vl_pal_correto
Dim str_cd_campeonato, str_cd_fase, strTitle, strKey, strName
strAdm = VerifyLevel()

' Função inicia a conexão com o Banco de Dados =================================
'===============================================================================
strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

' Função que inicializa os dados da Tela =======================================
'===============================================================================
   strOp              = ""
   strMSG             = "Entre a op&ccedil;&atilde;o desejada"
   str_cd_parametro   = ""
   str_vl_jog_derrota = ""
   str_vl_jog_empate  = ""
   str_vl_jog_vitoria = ""
   str_vl_pal_errado  = ""
   str_vl_pal_parcial = ""
   str_vl_pal_correto = ""
   str_cd_campeonato  = Trim(Session.Contents("Campeonato"))
   str_cd_fase        = ""

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp              = Trim(Request.Form("Opcao"))
   strMSG             = ""
   str_cd_parametro   = Trim(Request.Form("par_cd_parametro"))
   str_vl_jog_derrota = Trim(Request.Form("par_vl_jog_derrota"))
   str_vl_jog_empate  = Trim(Request.Form("par_vl_jog_empate"))
   str_vl_jog_vitoria = Trim(Request.Form("par_vl_jog_vitoria"))
   str_vl_pal_errado  = Trim(Request.Form("par_vl_pal_errado"))
   str_vl_pal_parcial = Trim(Request.Form("par_vl_pal_parcial"))
   str_vl_pal_correto = Trim(Request.Form("par_vl_pal_correto"))
   str_cd_campeonato  = Trim(Request.Form("cam_cd_campeonato"))
   str_cd_fase        = Trim(Request.Form("fas_cd_fase"))

' Função de pesquisa de Parametros(Inclusão e Alteração) =======================
'===============================================================================
   If (strOp = "Incluir") or (strOp = "Alterar") or (strOp = "Excluir") Then

      strQr = "Select par_cd_parametro from Parametro "
      If Not str_cd_parametro = "" Then
         strQr = strQr & "Where par_cd_parametro=" & str_cd_parametro
      Else
         strQr = strQr & "Where par_cd_parametro=0"
      End If
      Set parRs = objCn.Execute(strQr)

' Função de pesquisa de Parametros(Pesquisa e Exclusão) ========================
'===============================================================================
   Else If strOp = "Pesquisar" Then
           strQr = "Select par_cd_parametro, par_vl_jog_derrota, par_vl_jog_empate, "   & _
                   "par_vl_jog_vitoria, par_vl_pal_errado, par_vl_pal_parcial, "        & _
                   "par_vl_pal_correto, cam_cd_campeonato, fas_cd_fase from Parametro " & _
                   "Where par_cd_parametro=" & str_cd_parametro
           Set parRs = objCn.Execute(strQr)

' Função que pesquisa os dados do Banco ========================================
'===============================================================================
           If Not parRs.EOF Then
              str_cd_parametro   = Trim(parRs("par_cd_parametro"))
              str_vl_jog_derrota = Trim(parRs("par_vl_jog_derrota"))
              str_vl_jog_empate  = Trim(parRs("par_vl_jog_empate"))
              str_vl_jog_vitoria = Trim(parRs("par_vl_jog_vitoria"))
              str_vl_pal_errado  = Trim(parRs("par_vl_pal_errado"))
              str_vl_pal_parcial = Trim(parRs("par_vl_pal_parcial"))
              str_vl_pal_correto = Trim(parRs("par_vl_pal_correto"))
              str_cd_campeonato  = Trim(parRs("cam_cd_campeonato"))
              str_cd_fase        = Trim(parRs("fas_cd_fase"))
              strMSG = "Parametro pesquisado"
           Else
              strMSG = "Parametro n&atilde;o cadastrado"
           End If
        End If

   End If

' Função de inclusão de Parametros =============================================
'===============================================================================
   If strOp = "Incluir" Then

      If parRs.EOF Then
         strQr = "Insert into Parametro (par_cd_parametro, par_vl_jog_derrota, par_vl_jog_empate, " & _
                 "par_vl_jog_vitoria, par_vl_pal_errado, par_vl_pal_parcial, par_vl_pal_correto, "  & _
                 "cam_cd_campeonato, fas_cd_fase) Values (sequence_nextval('sq_cd_parametro'), "                & _
                 Trim(str_vl_jog_derrota) & ", " & _
                 Trim(str_vl_jog_empate)  & ", " & _
                 Trim(str_vl_jog_vitoria) & ", " & _
                 Trim(str_vl_pal_errado)  & ", " & _
                 Trim(str_vl_pal_parcial) & ", " & _
                 Trim(str_vl_pal_correto) & ", " & _
                 Trim(str_cd_campeonato)  & ", " & _
                 Trim(str_cd_fase)        & ")"
         'Response.Write("[" & strQr & "]")
         Set parRs = objCn.Execute(strQr)
         strMSG = "Parametro inclu&iacute;do"
      Else
         strMSG = "Parametro j&aacute; cadastrado"
      End If

   End If

' Função de alteração de Parametros ============================================
'===============================================================================
   If strOp = "Alterar" Then

      If Not parRs.EOF Then
         strQr = "Update Parametro Set "   & _
                 "par_vl_jog_derrota="     & Trim(str_vl_jog_derrota) & ", " & _
                 "par_vl_jog_empate="      & Trim(str_vl_jog_empate)  & ", " & _
                 "par_vl_jog_vitoria="     & Trim(str_vl_jog_vitoria) & ", " & _
                 "par_vl_pal_errado="      & Trim(str_vl_pal_errado)  & ", " & _
                 "par_vl_pal_parcial="     & Trim(str_vl_pal_parcial) & ", " & _
                 "par_vl_pal_correto="     & Trim(str_vl_pal_correto) & ", " & _
                 "cam_cd_campeonato="      & Trim(str_cd_campeonato)  & ", " & _
                 "fas_cd_fase="            & Trim(str_cd_fase)        & " "  & _
                 "Where par_cd_parametro=" & Trim(str_cd_parametro)
         Set parRs = objCn.Execute(strQr)
         strMSG = "Parametro alterado"
      Else
         strMSG = "Parametro n&atilde;o cadastrado"
      End If

   End If

' Função de exclusão de Parametros =============================================
'===============================================================================
   If strOp = "Excluir" Then

      If Not parRs.EOF Then
         strQr = "Delete from Parametro "  & _
                 "Where par_cd_parametro=" & Trim(str_cd_parametro)
         Set parRs = objCn.Execute(strQr)
         strMSG = "Parametro exclu&iacute;do"
      Else
         strMSG = "Parametro n&atilde;o cadastrado"
      End If

   End If

' Função encerra a conexão com o Banco de Dados ================================
'===============================================================================
   If (Not IsNull(parRs)) And strOp = "Pesquisar" Then
      parRs.Close
   End If
   Set parRs = Nothing

End If

' Função de geração da tela de Parametros ======================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)

' Função que monta combo de Grupos =============================================
strTitle = "Parametro"
strKey   = "par_cd_parametro"
strName  = "par_nm_parametro"
strQr = "Select par.par_cd_parametro, CONCAT(CAST(par.par_cd_parametro AS CHAR(3)), "" - "", fas.fas_nm_fase) as par_nm_parametro " & _
          "From Parametro par, Fase fas " & _
         "Where par.cam_cd_campeonato=" & str_cd_campeonato & " " & _
           "And fas.fas_cd_fase=par.fas_cd_fase " & _
         "Order by par_cd_parametro"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_parametro, "")
'===============================================================================

Response.Write("<tr><td>Pontos do jogo para derrota:</td>" & _
               "<td><input type=""text"" name=""par_vl_jog_derrota"" size=""2"" maxlength=""2""" & _
               "value=""" & str_vl_jog_derrota & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Pontos do jogo para empate:</td>" & _
               "<td><input type=""text"" name=""par_vl_jog_empate"" size=""2"" maxlength=""2""" & _
               "value=""" & str_vl_jog_empate & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Pontos do jogo para vi&oacute;ria:</td>" & _
               "<td><input type=""text"" name=""par_vl_jog_vitoria"" size=""2"" maxlength=""2""" & _
               "value=""" & str_vl_jog_vitoria & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Pontos para palpite errado:</td>" & _
               "<td><input type=""text"" name=""par_vl_pal_errado"" size=""2"" maxlength=""2""" & _
               "value=""" & str_vl_pal_errado & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Pontos para palpite parcial:</td>" & _
               "<td><input type=""text"" name=""par_vl_pal_parcial"" size=""2"" maxlength=""2""" & _
               "value=""" & str_vl_pal_parcial & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Pontos para palpite correto:</td>" & _
               "<td><input type=""text"" name=""par_vl_pal_correto"" size=""2"" maxlength=""2""" & _
               "value=""" & str_vl_pal_correto & """" & strAdm & "></td></tr><tr>" & vbCrLf)

' Função que monta combo de Campeonatos ========================================
strTitle = "Campeonato"
strKey   = "cam_cd_campeonato"
strName  = "cam_nm_campeonato"
strQr = "Select cam_cd_campeonato, cam_nm_campeonato From Campeonato Order by cam_nm_campeonato"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, strAdm)
'===============================================================================

Response.Write("</tr><tr>")

' Função que monta combo de Fases ==============================================
strTitle = "Fase"
strKey   = "fas_cd_fase"
strName  = "fas_nm_fase"
strQr = "Select fas_cd_fase, fas_nm_fase From Fase " & _
        "Where cam_cd_campeonato=" & str_cd_campeonato & " Order by fas_nm_fase"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_fase, strAdm)
'===============================================================================

Response.Write("</tr><tr><td align=""center"" colspan=""3"">" & _
               "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf)
Response.Write("</table>" & vbCrLf & "<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
Set parRs = Nothing
If Not IsNull(objCn) Then
   objCn.Close
End If
Set objCn = Nothing
'===============================================================================
%>

<br>
<table cellpadding="1" cellspacing="20">
<tr><td>
<input type="button" class="button" name="Pesquisar" value="Pesquisar"
       onClick="JavaScript:parPesquisar(frmParametro);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Incluir" value="Incluir"
       onClick="JavaScript:parIncluir(frmParametro);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Alterar" value="Alterar"
       onClick="JavaScript:parAlterar(frmParametro);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Excluir" value="Excluir"
       onClick="JavaScript:parExcluir(frmParametro);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:parLimpar(frmParametro);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>