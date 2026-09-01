<% @Language=VBScript %>
<% Option Explicit %>

<!-- #include file = "Include\ConfigDB.asp" -->
<!-- #include file = "Include\FormatField.asp" -->

<html>

<!--
   -------------------------------------------------------------
   Program      : Inicio.html
   Description  : Página de inicio do campeonato
   Version      : 1.0
   Date         : 28/06/2005
   Author       : Juan Sirgado y Antico
   Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
   -------------------------------------------------------------
   Version      :
   Date         :
   Author       :
   -------------------------------------------------------------
-->

<head>
   <title>Campeonato</title>
   <link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
</head>

<body>
<form method="post" name="frmEstatistica" action="Estatistica.asp">
<center>
<br>
<h1>Sistema Campeonato</h1>

<%
' Função de definição das variáveis do Login ===================================
'===============================================================================
Dim objCn, conRs, strQr, strCn, strOp, strMSG
Dim str_cd_conexao, str_qt_conexao, str_dt_conexao, str_qt_users, str_qt_online, str_dt_start

' Função inicia a conexão com o Banco de Dados =================================
'===============================================================================
strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

strQr = "Select COUNT(*) As con_qt_conexao, " & _
        "DATE_FORMAT(MIN(con_dt_inicio_conexao), '%d/%m/%Y') As con_dt_conexao " & _
        "From Conexao"
Set conRs = objCn.Execute(strQr)

If Not conRs.EOF Then
   str_qt_conexao = Trim(conRs("con_qt_conexao"))
   str_dt_conexao = Trim(conRs("con_dt_conexao"))
End If

str_dt_start = Trim(Application("app_dt_start"))
If (Len(str_dt_start) = 0) Then
   str_dt_start = "n/a"
Else
   'str_dt_start = FormatDate(str_dt_start, "%d/%m/%Y", 0)
End If

str_qt_users = Trim(Application("app_qt_users"))
If (Len(str_qt_users) = 0) Then
   str_qt_users = "n/a"
End If

str_qt_online = Trim(Application("app_qt_online"))
If (Len(str_qt_online) = 0) Then
   str_qt_online = "n/a"
End If

Set conRs = Nothing

strMSG = "Bem vindo"

' Função de geração da tela de Logins ==========================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)

Response.Write("<tr><td>Servidor iniciado:</td>" & _
               "<td>" & str_dt_start & "</td></tr>" & vbCrLf)
Response.Write("<tr><td>Conex&otilde;es ao servidor:</td>" & _
               "<td>" & str_qt_users & "</td></tr>" & vbCrLf)
Response.Write("<tr><td>Usu&aacute;rios conectados:</td>" & _
               "<td>" & str_qt_online & "</td></tr>" & vbCrLf)
Response.Write("<tr><td>Acessos ao sistema:</td>" & _
               "<td>" & str_qt_conexao & "</td></tr>" & vbCrLf)
Response.Write("<tr><td>Hospedado em:</td>" & _
               "<td>" & str_dt_conexao & "</td></tr>" & vbCrLf)
Response.Write("<tr><td align=""center"" colspan=""3"">" & _
               "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf)

Response.Write("</table>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
If Not IsNull(objCn) Then
   objCn.Close
End If
Set objCn = Nothing
'===============================================================================
%>
<br><br>
<img src="../Image/Fifa.jpg">
</center>
</form>
</body>
</html>