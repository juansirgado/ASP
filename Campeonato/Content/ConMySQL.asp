<% @Language=VBScript %>
<% Option Explicit %>

<!-- #include file = "Include\FormatField.asp" -->

<html>

<!--
   -------------------------------------------------------------
   Program      : ConMySql.ASP
   Description  : Página de teste do MySQL com ASP
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
' Função de definição das variáveis do campeonato ==============================
'===============================================================================
Dim cnfDataBase
Dim objCn, conRs, strQr, strCn, strOp, strMSG
Dim str_cd_conexao, str_qt_conexao, str_dt_conexao

' Função que monta o String de Conexão com o Banco de Dados ====================
'===============================================================================
'cnfDataBase = "Provider=msdaora;Data Source=orahome;User Id=campeonato;Password=nato;"
'cnfDataBase = "Provider=MySqlProv;Location=localhost;Data Source=db_campeonato;User ID=root;Password=antico09;"
cnfDataBase = "Driver={MySQL ODBC 3.51 Driver};Server=localhost;Database=db_campeonato;UID=root;PWD=antico09;Option=3"
'===============================================================================

' Função inicia a conexão com o Banco de Dados =================================
'===============================================================================
strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

strQr = "Select COUNT(*) As con_qt_conexao, "&_
        "DATE_FORMAT(MIN(con_dt_inicio_conexao), '%d/%m/%Y') As con_dt_conexao " & _
        "From Conexao"
'Response.Write(strQr)
Set conRs = objCn.Execute(strQr)

If Not conRs.EOF Then
   str_qt_conexao = Trim(conRs("con_qt_conexao"))
   str_dt_conexao = Trim(conRs("con_dt_conexao"))
End If

Set conRs = Nothing

strMSG = "Bem vindo"

' Função de geração da tela de Logins ==========================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)

Response.Write("<tr><td>Servidor iniciado:</td>" & _
               "<td>" & FormatDate(Application("app_dt_start"), "%d/%m/%Y", 0) & "</td></tr>" & vbCrLf)
Response.Write("<tr><td>Conex&otilde;es ao servidor:</td>" & _
               "<td>" & Application("app_qt_users") & "</td></tr>" & vbCrLf)
Response.Write("<tr><td>Usu&aacute;rios conectados:</td>" & _
               "<td>" & Application("app_qt_online") & "</td></tr>" & vbCrLf)
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
<img src="../Image/Fifa1.jpg">
</center>
</form>
</body>
</html>