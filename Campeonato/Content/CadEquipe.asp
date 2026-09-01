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
   Program      : CadEquipe.asp
   Description  : Página do cadastro de equipes
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
<title>Cadastro de Equipes</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadEquipe.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmEquipe" action="CadEquipe.asp">
<center>
<br>
<h1>Cadastro de Equipes</h1>

<%
' Função de definição das variáveis do Equipe ==================================
'===============================================================================
Dim objCn, equRs, strQr, strCn, strOp, strMSG, strAdm, strTitle, strKey, strName
Dim str_cd_equipe, str_nm_equipe, str_ds_equipe, str_cd_estado
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
   str_cd_equipe =     ""
   str_nm_equipe =     ""
   str_ds_equipe =     ""
   str_cd_estado =     ""

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp =             Trim(Request.Form("Opcao"))
   strMSG =            ""
   str_cd_equipe =     Trim(Request.Form("equ_cd_equipe"))
   str_nm_equipe =     Trim(Request.Form("equ_nm_equipe"))
   str_ds_equipe =     Trim(Request.Form("equ_ds_equipe"))
   str_cd_estado =     Trim(Request.Form("est_cd_estado"))

' Função de pesquisa de Equipes(Inclusão e Alteração) ==========================
'===============================================================================
   If (strOp = "Incluir") or (strOp = "Alterar") or (strOp = "Excluir") Then

      strQr = "Select equ_cd_equipe from Equipe "
      If Not str_cd_equipe = "" Then
         strQr = strQr & "Where equ_cd_equipe=" & str_cd_equipe
      Else
         strQr = strQr & "Where equ_cd_equipe=0"
      End If
      Set equRs = objCn.Execute(strQr)

' Função de pesquisa de Equipes(Pesquisa e Exclusão) ===========================
'===============================================================================
   Else If strOp = "Pesquisar" Then
           strQr = "Select equ_cd_equipe, equ_nm_equipe, equ_ds_equipe, est_cd_estado from Equipe "
           If Not str_cd_equipe = "" Then
              strQr = strQr & "Where equ_cd_equipe=" & str_cd_equipe
           Else
              strQr = strQr & "Where Upper(equ_nm_equipe) Like Upper('%" & str_nm_equipe & "%')"
           End If
           Set equRs = objCn.Execute(strQr)

' Função que pesquisa os dados do Banco ========================================
'===============================================================================
           If Not equRs.EOF Then
              str_cd_equipe =     Trim(equRs("equ_cd_equipe"))
              str_nm_equipe =     Trim(equRs("equ_nm_equipe"))
              str_ds_equipe =     Trim(equRs("equ_ds_equipe"))
              str_cd_estado =     Trim(equRs("est_cd_estado"))
              strMSG = "Equipe pesquisada"
           Else
              strMSG = "Equipe n&atilde;o cadastrada"
           End If
        End If

   End If

' Função de inclusão de Equipes ================================================
'===============================================================================
   If strOp = "Incluir" Then

      If equRs.EOF Then
         strQr = "Insert into Equipe (equ_cd_equipe, equ_nm_equipe, equ_ds_equipe, " & _
                 "est_cd_estado) Values (sequence_nextval('sq_cd_equipe'), "            & _
                 FormatString(Trim(str_nm_equipe), 2) & ", " & _
                 FormatString(Trim(str_ds_equipe), 2) & ", " & _
                 FormatString(Trim(str_cd_estado), 2) & ")"
         Set equRs = objCn.Execute(strQr)
         strMSG = "Equipe inclu&iacute;da"
      Else
         strMSG = "Equipe j&aacute; cadastrada"
      End If

   End If

' Função de alteração de Equipes ===============================================
'===============================================================================
   If strOp = "Alterar" Then

      If Not equRs.EOF Then
         strQr = "Update Equipe Set "   & _
                 "equ_nm_equipe="       & FormatString(Trim(str_nm_equipe), 2) & ", " & _
                 "equ_ds_equipe="       & FormatString(Trim(str_ds_equipe), 2) & ", "  & _
                 "est_cd_estado="       & FormatString(Trim(str_cd_estado), 2) & " "  & _
                 "Where equ_cd_equipe=" & Trim(str_cd_equipe)
         Set equRs = objCn.Execute(strQr)
         strMSG = "Equipe alterada"
      Else
         strMSG = "Equipe n&atilde;o cadastrada"
      End If

   End If

' Função de exclusão de Equipes ================================================
'===============================================================================
   If strOp = "Excluir" Then

      If Not equRs.EOF Then
         strQr = "Delete from Equipe "  & _
                 "Where equ_cd_equipe=" & Trim(str_cd_equipe)
         Set equRs = objCn.Execute(strQr)
         strMSG = "Equipe exclu&iacute;da"
      Else
         strMSG = "Equipe n&atilde;o cadastrada"
      End If

   End If

' Função encerra a conexão com o Banco de Dados ================================
'===============================================================================
   If (Not IsNull(equRs)) And strOp = "Pesquisar" Then
      equRs.Close
   End If
   Set equRs = Nothing

End If

' Função de geração da tela de Equipes =========================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)

' Função que monta combo de Equipe =============================================
strTitle = "Equipe"
strKey   = "equ_cd_equipe"
strName  = "equ_nm_equipe"
strQr = "Select equ.equ_cd_equipe As equ_cd_equipe, equ.equ_nm_equipe As equ_nm_equipe " & _
        "From Equipe equ " & _
        "Order by equ.equ_nm_equipe"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_equipe, "")
'===============================================================================

Response.Write("<tr><td>Nome:</td>" & _
               "<td><input type=""text"" name=""equ_nm_equipe"" size=""50"" maxlength=""50""" & _
               "value=""" & str_nm_equipe & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Escudo:</td>" & _
               "<td><img src=""../Image/Equipe/" & str_cd_equipe & ".gif"" " & _
               "width=""200px"" height=""160px"" border=""1px""> " & _
                   "<img src=""../Image/Equipe/" & str_cd_equipe & "b.gif"" " & _
               "width=""100px"" height=""160px"" border=""1px""></td></tr>" & vbCrLf)
Response.Write("<tr><td>Descri&ccedil;&atilde;o:</td>" & _
               "<td><textarea cols=""50"" rows=""5"" name=""equ_ds_equipe""" & strAdm & ">" & _
               str_ds_equipe & "</textarea></td></tr><tr>" & vbCrLf)

' Função que monta combo de Estados ============================================
strTitle = "Estado"
strKey   = "est_cd_estado"
strName  = "est_nm_estado"
strQr = "Select est_cd_estado, est_nm_estado From Estado Order by est_nm_estado"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_estado, strAdm)
'===============================================================================

Response.Write("</tr><tr><td align=""center"" colspan=""3"">" & _
               "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf)
Response.Write("</table>" & vbCrLf & "<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
Set equRs = Nothing
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
       onClick="JavaScript:equPesquisar(frmEquipe);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Incluir" value="Incluir"
       onClick="JavaScript:equIncluir(frmEquipe);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Alterar" value="Alterar"
       onClick="JavaScript:equAlterar(frmEquipe);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Excluir" value="Excluir"
       onClick="JavaScript:equExcluir(frmEquipe);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:equLimpar(frmEquipe);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>