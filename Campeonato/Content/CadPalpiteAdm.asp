<% @Language=VBScript %>
<% Option Explicit %>

<!-- #include file = "Include\ConfigDB.asp" -->
<!-- #include file = "Include\MountCombo.asp" -->
<!-- #include file = "Include\VerifyAccess.asp" -->
<% VerifyAccess() %>

<html>

<!--
   -------------------------------------------------------------
   Program      : CadPalpite.asp
   Description  : Página do cadastro de palpites
   Version      : 1.0
   Date         : 24/06/2005
   Author       : Juan Sirgado y Antico
   Copyright(c) 2005 by JSyA Informática. All Rights Reserved.
   -------------------------------------------------------------
   Version      :
   Date         :
   Author       :
   -------------------------------------------------------------
-->

<head>
<title>Cadastro de Palpites</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadPalpiteAdm.js"></script>
<script language="JavaScript" src="../Script/Common.js"></script>
</head>

<body>
<form method="post" name="frmPalpite" action="CadPalpiteAdm.asp">
<center>
<br>
<h1>Cadastro de Palpites</h1>

<%
' Função de definição das variáveis do Palpite =================================
'===============================================================================
Dim objCn, palRs, strQr, strCn, strOp, strMSG, strAdm
Dim str_cd_palpite, str_qt_gol_equipe_1, str_qt_gol_equipe_2, str_qt_pontos
Dim str_cd_resultado, str_cd_jogo, str_cd_aposta, strTitle, strKey, strName
strAdm = VerifyLevel()

' Função inicia a conexão com o Banco de Dados =================================
'===============================================================================
strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

' Função que inicializa os dados da Tela =======================================
'===============================================================================
   strOp               = ""
   strMSG              = "Entre a op&ccedil;&atilde;o desejada"
   str_cd_palpite      = ""
   str_qt_gol_equipe_1 = ""
   str_qt_gol_equipe_2 = ""
   str_qt_pontos       = ""
   str_cd_resultado    = ""
   str_cd_jogo         = ""
   str_cd_aposta       = ""

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp              = Trim(Request.Form("Opcao"))
   strMSG             = ""

   str_cd_palpite      = Trim(Request.Form("pal_cd_palpite"))
   str_qt_gol_equipe_1 = Trim(Request.Form("pal_qt_gol_equipe_1"))
   str_qt_gol_equipe_2 = Trim(Request.Form("pal_qt_gol_equipe_2"))
   str_qt_pontos       = Trim(Request.Form("pal_qt_pontos"))
   str_cd_resultado    = Trim(Request.Form("res_cd_resultado"))
   str_cd_jogo         = Trim(Request.Form("jog_cd_jogo"))
   str_cd_aposta       = Trim(Request.Form("apo_cd_aposta"))

' Função de pesquisa de Palpites(Inclusão e Alteração) =========================
'===============================================================================
   If (strOp = "Incluir") or (strOp = "Alterar") or (strOp = "Excluir") Then

      strQr = "Select pal_cd_palpite from palpite "
      If Not str_cd_palpite = "" Then
         strQr = strQr & "Where pal_cd_palpite=" & str_cd_palpite
      Else
         strQr = strQr & "Where pal_cd_palpite=0"
      End If
      Set palRs = objCn.Execute(strQr)

' Função de pesquisa de Palpites(Pesquisa e Exclusão) ==========================
'===============================================================================
   Else If strOp = "Pesquisar" Then
           strQr = "Select pal_cd_palpite, pal_qt_gol_equipe_1, pal_qt_gol_equipe_2, " & _
                   "pal_qt_pontos, res_cd_resultado, jog_cd_jogo, apo_cd_aposta  "    & _
                   "From Palpite Where pal_cd_palpite=" & str_cd_palpite
           Set palRs = objCn.Execute(strQr)

' Função que pesquisa os dados do Banco ========================================
'===============================================================================
           If Not palRs.EOF Then
              str_cd_palpite      = Trim(palRs("pal_cd_palpite"))
              str_qt_gol_equipe_1 = Trim(palRs("pal_qt_gol_equipe_1"))
              str_qt_gol_equipe_2 = Trim(palRs("pal_qt_gol_equipe_2"))
              str_qt_pontos       = Trim(palRs("pal_qt_pontos"))
              str_cd_resultado    = Trim(palRs("res_cd_resultado"))
              str_cd_jogo         = Trim(palRs("jog_cd_jogo"))
              str_cd_aposta       = Trim(palRs("apo_cd_aposta"))
              strMSG = "Palpite pesquisado"
           Else
              strMSG = "Palpite n&atilde;o cadastrado"
           End If
        End If

   End If

' Função de inclusão de Palpites ===============================================
'===============================================================================
   If strOp = "Incluir" Then

      If palRs.EOF Then
         strQr = "Insert into Palpite (pal_cd_palpite, pal_qt_gol_equipe_1, pal_qt_gol_equipe_2, " & _
                 "pal_qt_pontos, res_cd_resultado, jog_cd_jogo, apo_cd_aposta) "                   & _
                 "Values (sequence_nextval('sq_cd_palpite'), " & _
                 Trim(str_qt_gol_equipe_1) & ", " & _
                 Trim(str_qt_gol_equipe_2) & ", " & _
                 Trim(str_qt_pontos)       & ", " & _
                 Trim(str_cd_resultado)    & ", " & _
                 Trim(str_cd_jogo)         & ", " & _
                 Trim(str_cd_aposta)       & ")"
         Set palRs = objCn.Execute(strQr)
         strMSG = "Palpite inclu&iacute;do"
      Else
         strMSG = "Palpite j&aacute; cadastrado"
      End If

   End If

' Função de alteração de Palpites ==============================================
'===============================================================================
   If strOp = "Alterar" Then

      If Not palRs.EOF Then
         strQr = "Update Palpite Set "   & _
                 "pal_qt_gol_equipe_1="  & Trim(str_qt_gol_equipe_1) & ", " & _
                 "pal_qt_gol_equipe_2="  & Trim(str_qt_gol_equipe_2) & ", " & _
                 "pal_qt_pontos="        & Trim(str_qt_pontos)       & ", " & _
                 "res_cd_resultado="     & Trim(str_cd_resultado)    & ", " & _
                 "jog_cd_jogo="          & Trim(str_cd_jogo)         & ", " & _
                 "apo_cd_aposta="        & Trim(str_cd_aposta)       & " " & _
                 "Where pal_cd_palpite=" & Trim(str_cd_palpite)
         Set palRs = objCn.Execute(strQr)
         strMSG = "Palpite alterado"
      Else
         strMSG = "Palpite n&atilde;o cadastrado"
      End If

   End If

' Função de exclusão de Palpites ===============================================
'===============================================================================
   If strOp = "Excluir" Then

      If Not palRs.EOF Then
         strQr = "Delete from Palpite "  & _
                 "Where pal_cd_palpite=" & Trim(str_cd_palpite)
         Set palRs = objCn.Execute(strQr)
         strMSG = "Palpite exclu&iacute;do"
      Else
         strMSG = "Palpite n&atilde;o cadastrado"
      End If

   End If

' Função encerra a conexão com o Banco de Dados ================================
'===============================================================================
   If (Not IsNull(palRs)) And strOp = "Pesquisar" Then
      palRs.Close
   End If
   Set palRs = Nothing

End If

' Função de geração da tela de Palpites ========================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)
Response.Write("<tr><td>Palpite:</td>" & _
               "<td><input type=""text"" name=""pal_cd_palpite"" size=""5"" maxlength=""5""" & _
               "value=""" & str_cd_palpite & """> *</td></tr>" & vbCrLf)
Response.Write("<tr><td>Gols da equipe 1:</td>" & _
               "<td><input type=""text"" name=""pal_qt_gol_equipe_1"" size=""3"" maxlength=""3""" & _
               "value=""" & str_qt_gol_equipe_1 & """></td></tr>" & vbCrLf)
Response.Write("<tr><td>Gols da equipe 2:</td>" & _
               "<td><input type=""text"" name=""pal_qt_gol_equipe_2"" size=""3"" maxlength=""3""" & _
               "value=""" & str_qt_gol_equipe_2 & """></td></tr><tr>" & vbCrLf)

' Função que monta combo de Resultado ==========================================
strTitle = "Resultado"
strKey   = "res_cd_resultado"
strName  = "res_nm_resultado"
strQr = "Select res_cd_resultado, res_nm_resultado From Resultado Order by res_cd_resultado"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_resultado, strAdm)
'===============================================================================

Response.Write("</tr><tr><td>Quantidade de pontos:</td>" & _
               "<td><input type=""text"" name=""pal_qt_pontos"" size=""3"" maxlength=""3""" & _
               "value=""" & str_qt_pontos & """" & strAdm & "></td></tr><tr>" & vbCrLf)

' Função que monta combo de Jogo ==============================================
strTitle = "Jogo"
strKey   = "jog_cd_jogo"
strName  = "jog_nm_jogo"

strQr = "Select jog_cd_jogo, TO_CHAR(jog_dt_jogo, '%d/%m/%Y %H:%i:%s') || ' ' || " & _
        "equ_1.equ_nm_equipe || ' X ' || equ_2.equ_nm_equipe AS jog_nm_jogo "          & _
        "From Jogo jog, Equipe equ_1, Equipe equ_2 Where equ_1.equ_cd_equipe="         & _
        "equ_cd_equipe_1 And equ_2.equ_cd_equipe=equ_cd_equipe_2 Order BY jog_dt_jogo"
Call MountCombo(strTitle, strKey, strName, strQr, str_cd_jogo, strAdm)
'===============================================================================

Response.Write("</tr><tr>")

' Função que monta combo de Aposta =============================================
strTitle = "Aposta"
strKey   = "apo_cd_aposta"
strName  = "apo_nm_aposta"
strQr    = "Select apo_cd_aposta, TO_CHAR(apo_dt_ultima_alt, '%d/%m/%Y %H:%i:%s') "    & _
           "|| ' ' || 'Aposta ' || apo_cd_aposta || ' de ' || apo_cd_usuario_alt As apo_nm_aposta From " & _
           "Aposta Order by apo_cd_aposta"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_aposta, strAdm)
'===============================================================================

If Trim(strAdm) = "disabled" Then
   Response.Write("<input type=""hidden"" name=""res_cd_resultado"" " & _
                  "value=""" & str_cd_resultado & """>"  & vbCrLf)
   Response.Write("<input type=""hidden"" name=""pal_qt_pontos"" " & _
                  "value=""" & str_qt_pontos & """>"  & vbCrLf)
   Response.Write("<input type=""hidden"" name=""jog_cd_jogo"" " & _
                  "value=""" & str_cd_jogo & """>"  & vbCrLf)
   Response.Write("<input type=""hidden"" name=""apo_cd_aposta"" " & _
                  "value=""" & str_cd_aposta & """>"  & vbCrLf)
End If

Response.Write("</tr><tr><td align=""center"" colspan=""3"">" & _
               "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf)
Response.Write("</table>" & vbCrLf & "<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
Set palRs = Nothing
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
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"
       onClick="JavaScript:palPesquisar(frmPalpite);"></td><td>
<input type="button" class="button" name="Incluir" value="Incluir"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"
       onClick="JavaScript:palIncluir(frmPalpite);"<%=strAdm%>></td><td>
<input type="button" class="button" name="Alterar" value="Alterar"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"
       onClick="JavaScript:palAlterar(frmPalpite);"<%=strAdm%>></td><td>
<input type="button" class="button" name="Excluir" value="Excluir"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"
       onClick="JavaScript:palExcluir(frmPalpite);"<%=strAdm%>></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"
       onClick="JavaScript:palLimpar(frmPalpite);"></td></tr>
</table>
</center>
</form>
</body>
</html>