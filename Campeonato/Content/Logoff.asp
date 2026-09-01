<% @Language=VBScript %>
<% Option Explicit %>

<!-- #include file = "Include\ConfigDB.asp" -->
<!-- #include file = "Include\VerifyAccess.asp" -->

<html>>

<!--
   -------------------------------------------------------------
   Program      : CadAposta.asp
   Description  : Página do cadastro de apostas
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

<%
' Função de definição das variáveis do Logoff ==================================
'===============================================================================
   Dim strCn
   strCn = cnfDataBase
   Call LogConnection(0, strCn)

' Função de remoção da sessão do usuário =======================================
'===============================================================================
   Session.Contents.Remove("Campeonato")
   Session.Contents.Remove("Usuario")
   Session.Contents.Remove("Acesso")
   Session.Contents.Remove("Nivel")
   Session.Abandon
   Response.Redirect("Logon.asp")
'===============================================================================
%>