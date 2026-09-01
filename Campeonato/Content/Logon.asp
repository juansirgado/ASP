<% @Language=VBScript %>
<% Option Explicit %>

<!-- #include file = "Include\ConfigDB.asp" -->
<!-- #include file = "Include\MountCombo.asp" -->
<!-- #include file = "Include\CryptString.asp" -->
<!-- #include file = "Include\VerifyAccess.asp" -->

<html>

<!--
   -------------------------------------------------------------
   Program      : Logon.asp
   Description  : Página de logon do Campeonato
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
<title>Acesso ao sistema Campeonato</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/Logon.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
<script language="JavaScript" src="../Script/isAlfaNumeric.js"></script>
</head>

<body>
<form method="post" name="frmLogon" action="Logon.asp">
<center>
<br>
<h1>Sistema Campeonato</h1>

<%
' Função de definição das variáveis do Logon ===================================
'===============================================================================
Dim objCn, pesRs, strQr, strCn, strOp, strMSG, strTitle, strKey, strName
Dim str_cd_campeonato, str_cd_pessoa, str_cd_acesso

' Função inicia a conexão com o Banco de Dados =================================
'===============================================================================
strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

' Função que inicializa os dados da Tela =======================================
'===============================================================================
   strOp              = ""
   strMSG             = "Selecione o campeonato"
   str_cd_campeonato  = ""
   str_cd_pessoa      = ""
   str_cd_acesso      = ""

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp              = Trim(Request.Form("Opcao"))
   strMSG             = ""
   str_cd_campeonato  = Trim(Request.Form("cam_cd_campeonato"))
   str_cd_pessoa      = Trim(Request.Form("pes_cd_pessoa"))
   str_cd_acesso      = Trim(Request.Form("pes_cd_acesso"))

' Função de pesquisa de Logon ==================================================
'===============================================================================

   If (strOp = "Entrar") Then
      strQr = "Select pes_cd_pessoa, pes_cd_acesso, pes_in_nivel From Pessoa Where pes_cd_pessoa ='" & str_cd_pessoa & "'"
      Set pesRs = objCn.Execute(strQr)

      If Not pesRs.EOF Then
         If CryptString(str_cd_acesso, "segredo", 0) = pesRs("pes_cd_acesso") Then
' Função de criação da sessão do usuário =======================================
'===============================================================================
            Session("Campeonato") = str_cd_campeonato
            Session("Usuario")    = str_cd_pessoa
            Session("Pessoa")     = pesRs("pes_cd_pessoa")
            Session("Acesso")     = pesRs("pes_cd_acesso")
            Session("Nivel")      = pesRs("pes_in_nivel")
            Call LogConnection(1, strCn)
            Response.Redirect("ConEstatistica.asp")
         Else
           strMSG = "Senha inválida"
         End If
      Else
         strMSG = "Usuário inválido"
      End If

      Set pesRs = Nothing
   End If

End If

' Função de geração da tela de Logons ==========================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table""><tr>" & vbCrLf)

' Função que monta combo de Campeonatos ========================================
strTitle = "Campeonato"
strKey   = "cam_cd_campeonato"
strName  = "cam_nm_campeonato"
strQr    = "Select cam_cd_campeonato, cam_nm_campeonato From Campeonato Order by cam_nm_campeonato"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, "")
'===============================================================================

Response.Write("</tr><tr>")

' Função que monta combo de Pessoas ============================================
strTitle = "Pessoa"
strKey   = "pes_cd_pessoa"
strName  = "pes_nm_pessoa"
strQr    = "Select pes_cd_pessoa, pes_nm_pessoa from Pessoa Order by pes_nm_pessoa"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_pessoa, "")
'===============================================================================

Response.Write("</tr><tr><td>C&oacute;digo de acesso:</td>" & _
               "<td><input type=""password"" name=""pes_cd_acesso"" size=""20"" maxlength=""20""" & _
               "value=""" & str_cd_acesso & """></td></tr>" & vbCrLf)

Response.Write("<tr><td align=""center"" colspan=""3"">" & _
               "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf)
Response.Write("</table>" & vbCrLf & "<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
If Not IsNull(objCn) Then
   objCn.Close
End If
Set objCn = Nothing
'===============================================================================
%>

<br>
<table cellpadding="1" cellspacing="20">
<tr><td>
<input type="button" class="button" name="Entrar" value="Entrar"
       onClick="JavaScript:logEntrar(frmLogon);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:logLimpar(frmLogon);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>