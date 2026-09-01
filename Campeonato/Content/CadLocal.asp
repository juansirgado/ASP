<% @Language=VBScript %>
<% Option Explicit %>

<!-- #include file = "Include\ConfigDB.asp" -->
<!-- #include file = "Include\FormatField.asp" -->
<!-- #include file = "Include\MountCombo.asp" -->
<!-- #include file = "Include\VerifyAccess.asp" -->
<% VerifyAccess() %>

<html>

<!--
   -------------------------------------------------------------
   Program      : CadLocal.asp
   Description  : Página do cadastro de locais
   Version      : 1.0
   Date         : 29/06/2005
   Author       : Juan Sirgado y Antico
   Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
   -------------------------------------------------------------
   Version      :
   Date         :
   Author       :
   -------------------------------------------------------------
-->

<head>
<title>Cadastro de Locais</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadLocal.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmLocal" action="CadLocal.asp">
<center>
<br>
<h1>Cadastro de Locais</h1>

<%
' Função de definição das variáveis do Local ===================================
'===============================================================================
Dim objCn, locRs, strQr, strCn, strOp, strMSG, strAdm, strTitle, strKey, strName
Dim str_cd_local, str_nm_local, str_ds_local, str_cd_estado
strAdm = VerifyLevel()

' Função inicia a conexão com o Banco de Dados =================================
'===============================================================================
strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

' Função que inicializa os dados da Tela =======================================
'===============================================================================
   strOp =             ""
   strMSG =            "Entre a op&ccedil;&atilde;o desejada"
   str_cd_local =     ""
   str_nm_local =     ""
   str_ds_local =     ""
   str_cd_estado =     ""

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp =             Trim(Request.Form("Opcao"))
   strMSG =            ""
   str_cd_local =     Trim(Request.Form("loc_cd_local"))
   str_nm_local =     Trim(Request.Form("loc_nm_local"))
   str_ds_local =     Trim(Request.Form("loc_ds_local"))
   str_cd_estado =     Trim(Request.Form("est_cd_estado"))

' Função de pesquisa de Locais(Inclusão e Alteração) ===========================
'===============================================================================
   If (strOp = "Incluir") or (strOp = "Alterar") or (strOp = "Excluir") Then

      strQr = "Select loc_cd_local from Local "
      If Not str_cd_local = "" Then
         strQr = strQr & "Where loc_cd_local=" & str_cd_local
      Else
         strQr = strQr & "Where loc_cd_local=0"
      End If
      Set locRs = objCn.Execute(strQr)

' Função de pesquisa de Locais(Pesquisa e Exclusão) ===========================
'===============================================================================
   Else If strOp = "Pesquisar" Then
           strQr = "Select loc_cd_local, loc_nm_local, loc_ds_local, est_cd_estado from Local "
           If Not str_cd_local = "" Then
              strQr = strQr & "Where loc_cd_local=" & str_cd_local
           Else
              strQr = strQr & "Where Upper(loc_nm_local) Like Upper('%" & str_nm_local & "%')"
           End If
           Set locRs = objCn.Execute(strQr)

' Função que pesquisa os dados do Banco ========================================
'===============================================================================
           If Not locRs.EOF Then
              str_cd_local  =     Trim(locRs("loc_cd_local"))
              str_nm_local  =     Trim(locRs("loc_nm_local"))
              str_ds_local =     Trim(locRs("loc_ds_local"))
              str_cd_estado =     Trim(locRs("est_cd_estado"))
              strMSG = "Local pesquisado"
           Else
              strMSG = "Local n&atilde;o cadastrado"
           End If
        End If

   End If

' Função de inclusão de Locais ================================================
'===============================================================================
   If strOp = "Incluir" Then

      If locRs.EOF Then
         strQr = "Insert into Local (loc_cd_local, loc_nm_local, loc_ds_local, " & _
                 "est_cd_estado) Values (sequence_nextval('sq_cd_local'), "                   & _
                 FormatString(Trim(str_nm_local), 2)  & ", " & _
                 FormatString(Trim(str_ds_local), 2) & ", " & _
                 FormatString(Trim(str_cd_estado), 2) & ")"
         Set locRs = objCn.Execute(strQr)
         strMSG = "Local inclu&iacute;do"
      Else
         strMSG = "Local j&aacute; cadastrado"
      End If

   End If

' Função de alteração de Locais ===============================================
'===============================================================================
   If strOp = "Alterar" Then

      If Not locRs.EOF Then
         strQr = "Update Local Set "   & _
                 "loc_nm_local="       & FormatString(Trim(str_nm_local), 2)  & ", " & _
                 "loc_ds_local="      & FormatString(Trim(str_ds_local), 2) & ", " & _
                 "est_cd_estado="      & FormatString(Trim(str_cd_estado), 2) & " "  & _
                 "Where loc_cd_local=" & Trim(str_cd_local)
         Set locRs = objCn.Execute(strQr)
         strMSG = "Local alterado"
      Else
         strMSG = "Local n&atilde;o cadastrado"
      End If

   End If

' Função de exclusão de Locais ================================================
'===============================================================================
   If strOp = "Excluir" Then

      If Not locRs.EOF Then
         strQr = "Delete from Local "  & _
                 "Where loc_cd_local=" & Trim(str_cd_local)
         Set locRs = objCn.Execute(strQr)
         strMSG = "Local exclu&iacute;do"
      Else
         strMSG = "Local n&atilde;o cadastrado"
      End If

   End If

' Função encerra a conexão com o Banco de Dados ================================
'===============================================================================
   If (Not IsNull(locRs)) And strOp = "Pesquisar" Then
      locRs.Close
   End If
   Set locRs = Nothing

End If

' Função de geração da tela de Locais =========================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)

' Função que monta combo de Locais =============================================
strTitle = "Local"
strKey   = "loc_cd_local"
strName  = "loc_nm_local"
strQr = "Select loc_cd_local, loc_nm_local From Local Order by loc_nm_local"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_local, "")
'===============================================================================

Response.Write("<tr><td>Nome:</td>" & _
               "<td><input type=""text"" name=""loc_nm_local"" size=""50"" maxlength=""50""" & _
               "value=""" & str_nm_local & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Imagem:</td>" & _
               "<td><img src=""../Image/Local/" & str_cd_local & ".gif"" " & _
               "width=""200px"" height=""160px"" border=""1px""></td></tr>" & vbCrLf)
Response.Write("<tr><td>Descri&ccedil;&atilde;o:</td>" & _
               "<td><textarea cols=""50"" rows=""5"" name=""loc_ds_local""" & strAdm & ">" & _
               str_ds_local & "</textarea></td></tr><tr>" & vbCrLf)

' Função que monta combo de Estados ============================================
strTitle = "Estado"
strKey   = "est_cd_estado"
strName  = "est_nm_estado"
strQr    = "Select est_cd_estado, est_nm_estado From Estado Order by est_nm_estado"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_estado, strAdm)
'===============================================================================

Response.Write("</tr><tr><td align=""center"" colspan=""3"">" & _
               "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf)
Response.Write("</table>" & vbCrLf & "<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
Set locRs = Nothing
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
       onClick="JavaScript:locPesquisar(frmLocal);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Incluir" value="Incluir"
       onClick="JavaScript:locIncluir(frmLocal);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Alterar" value="Alterar"
       onClick="JavaScript:locAlterar(frmLocal);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Excluir" value="Excluir"
       onClick="JavaScript:locExcluir(frmLocal);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:locLimpar(frmLocal);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>