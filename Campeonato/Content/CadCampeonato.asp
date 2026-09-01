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
   Program      : CadCampeonato.asp
   Description  : Página do cadastro de campeonatos
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
<title>Cadastro de Campeonatos</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadCampeonato.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
<script language="JavaScript" src="../Script/isDate.js"></script>
</head>

<body>
<form method="post" name="frmCampeonato" action="CadCampeonato.asp">
<center>
<br>
<h1>Cadastro de Campeonatos</h1>

<%
' Função de definição das variáveis do campeonato ==============================
'===============================================================================
Dim objCn, camRs, strQr, strCn, strOp, strMSG, strAdm
Dim str_cd_campeonato, str_nm_campeonato, str_dt_inicio
Dim str_dt_termino, str_ds_campeonato, str_vl_aposta, strTitle, strKey, strName
strAdm = VerifyLevel()

' Função inicia a conexão com o Banco de Dados =================================
'===============================================================================
strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

' Função que inicializa os dados da Tela =======================================
'===============================================================================
   strOp             = ""
   strMSG            = "Entre a op&ccedil;&atilde;o desejada"
   str_cd_campeonato = Trim(Session.Contents("Campeonato"))
   str_nm_campeonato = ""
   str_dt_inicio     = ""
   str_dt_termino    = ""
   str_ds_campeonato = ""
   str_vl_aposta     = ""

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp             = Trim(Request.Form("Opcao"))
   strMSG            = ""
   str_cd_campeonato = Trim(Request.Form("cam_cd_campeonato"))
   str_nm_campeonato = Trim(Request.Form("cam_nm_campeonato"))
   str_dt_inicio     = Trim(Request.Form("cam_dt_inicio"))
   str_dt_termino    = Trim(Request.Form("cam_dt_termino"))
   str_ds_campeonato = Trim(Request.Form("cam_ds_campeonato"))
   str_vl_aposta     = Trim(Request.Form("cam_vl_aposta"))

' Função de pesquisa de Campeonatos(Inclusão e Alteração) ======================
'===============================================================================
   If (strOp = "Incluir") or (strOp = "Alterar") or (strOp = "Excluir") Then

      strQr = "Select cam_cd_campeonato from Campeonato "
      If Not str_cd_campeonato = "" Then
         strQr = strQr & "Where cam_cd_campeonato=" & str_cd_campeonato
      Else
         strQr = strQr & "Where cam_cd_campeonato=0"
      End If
      Set camRs = objCn.Execute(strQr)

' Função de pesquisa de Campeonatos(Pesquisa e Exclusão) =======================
'===============================================================================
   Else If strOp = "Pesquisar" Then
           strQr = "Select cam_cd_campeonato, cam_nm_campeonato, cam_dt_inicio, cam_dt_termino, "
           strQr = strQr & "cam_ds_campeonato, cam_vl_aposta from Campeonato "
           If Not str_cd_campeonato = "" Then
              strQr = strQr & "Where cam_cd_campeonato=" & str_cd_campeonato
           Else
              strQr = strQr & "Where Upper(cam_nm_campeonato) Like Upper('%" & str_nm_campeonato & "%')"
           End If
           Set camRs = objCn.Execute(strQr)

' Função que pesquisa os dados do Banco ========================================
'===============================================================================
           If Not camRs.EOF Then
              str_cd_campeonato =             Trim(camRs("cam_cd_campeonato"))
              str_nm_campeonato =             Trim(camRs("cam_nm_campeonato"))
              str_dt_inicio =      FormatDate(Trim(camRs("cam_dt_inicio")),  "%d/%m/%Y", 0)
              str_dt_termino =     FormatDate(Trim(camRs("cam_dt_termino")), "%d/%m/%Y", 0)
              str_ds_campeonato =             Trim(camRs("cam_ds_campeonato"))
              str_vl_aposta =     FormatValue(Trim(camRs("cam_vl_aposta")), 2, 0)
              strMSG = "Campeonato pesquisado"
           Else
              strMSG = "Campeonato n&atilde;o cadastrado"
           End If
        End If

   End If

' Função de inclusão de Campeonatos ============================================
'===============================================================================
   If strOp = "Incluir" Then

      If camRs.EOF Then
         strQr = "Insert into Campeonato (cam_cd_campeonato, cam_nm_campeonato, cam_dt_inicio, "
         strQr = strQr & "cam_dt_termino, cam_ds_campeonato, cam_vl_aposta, cam_in_classificacao) "
         strQr = strQr & "Values (sequence_nextval('sq_cd_campeonato'), "
         strQr = strQr & FormatString(Trim(str_nm_campeonato), 2)            & ", "
         strQr = strQr &   FormatDate(Trim(str_dt_inicio), "%d/%m/%Y", 2)    & ", "
         strQr = strQr &   FormatDate(Trim(str_dt_termino), "%d/%m/%Y", 2)   & ", "
         strQr = strQr & FormatString(Trim(str_ds_campeonato), 2)            & ", "
         strQr = strQr &  FormatValue(Trim(str_vl_aposta), 2, 2)             & ", 0)"
         Set camRs = objCn.Execute(strQr)
         strMSG = "Campeonato inclu&iacute;do"
      Else
         strMSG = "Campeonato j&aacute; cadastrado"
      End If

   End If

' Função de alteração de Campeonatos ===========================================
'===============================================================================
   If strOp = "Alterar" Then

      If Not camRs.EOF Then
         strQr = "Update Campeonato Set "
         strQr = strQr & "cam_nm_campeonato="       & FormatString(Trim(str_nm_campeonato), 2)            & ", "
         strQr = strQr & "cam_dt_inicio="           &   FormatDate(Trim(str_dt_inicio), "%d/%m/%Y", 2)    & ", "
         strQr = strQr & "cam_dt_termino="          &   FormatDate(Trim(str_dt_termino), "%d/%m/%Y", 2)   & ", "
         strQr = strQr & "cam_ds_campeonato="       & FormatString(Trim(str_ds_campeonato), 2)            & ", "
         strQr = strQr & "cam_vl_aposta="           &  FormatValue(Trim(str_vl_aposta), 2, 2)             & " "
         strQr = strQr & "Where cam_cd_campeonato=" &              Trim(str_cd_campeonato)
         Set camRs = objCn.Execute(strQr)
         strMSG = "Campeonato alterado"
      Else
         strMSG = "Campeonato n&atilde;o cadastrado"
      End If

   End If

' Função de exclusão de Campeonatos ============================================
'===============================================================================
   If strOp = "Excluir" Then

      If Not camRs.EOF Then
         strQr = "Delete from Campeonato " & _
                 "Where cam_cd_campeonato=" & Trim(str_cd_campeonato)
         Set camRs = objCn.Execute(strQr)
         strMSG = "Campeonato exclu&iacute;do"
      Else
         strMSG = "Campeonato n&atilde;o cadastrado"
      End If

   End If

' Função encerra a conexão com o Banco de Dados =================================
'===============================================================================
   If (Not IsNull(camRs)) And strOp = "Pesquisar" Then
     camRs.Close
   End If
   Set camRs = Nothing

End If

' Função de geração da tela de Campeonatos =====================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)

' Função que monta combo de Campeonatos ========================================
strTitle = "Campeonato"
strKey   = "cam_cd_campeonato"
strName  = "cam_nm_campeonato"
strQr = "Select cam_cd_campeonato, cam_nm_campeonato From Campeonato Order by cam_nm_campeonato"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, "")
'===============================================================================

Response.Write("<tr><td>Nome:</td>" & _
               "<td><input type=""text"" name=""cam_nm_campeonato"" size=""50"" maxlength=""50""" & _
               "value=""" & str_nm_campeonato & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Bandeira:</td>" & _
               "<td><img src=""../Image/Campeonato/" & str_cd_campeonato & ".png"" " & _
               "width=""200px"" height=""160px"" border=""1px""></td></tr>" & vbCrLf)
Response.Write("<tr><td>Data de in&iacute;cio:</td>" & _
               "<td><input type=""text"" name=""cam_dt_inicio"" size=""10"" maxlength=""10""" & _
               "value=""" & str_dt_inicio & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Data de term&iacute;no:</td>" & _
               "<td><input type=""text"" name=""cam_dt_termino"" size=""10"" maxlength=""10""" & _
               "value=""" & str_dt_termino & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Descri&ccedil;&atilde;o:</td>" & _
               "<td><textarea cols=""50"" rows=""5"" name=""cam_ds_campeonato""" & strAdm & ">" & _
               str_ds_campeonato & "</textarea></td></tr>" & vbCrLf)
Response.Write("<tr><td>Valor da aposta:</td>" & _
               "<td><input type=""text"" name=""cam_vl_aposta"" size=""12"" maxlength=""12""" & _
               "value=""" & str_vl_aposta & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td align=""center"" colspan=""3"">" & _
               "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf)
Response.Write("</table>" & vbCrLf & "<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
Set camRs = Nothing
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
       onClick="JavaScript:camPesquisar(frmCampeonato);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Incluir" value="Incluir"
       onClick="JavaScript:camIncluir(frmCampeonato);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Alterar" value="Alterar"
       onClick="JavaScript:camAlterar(frmCampeonato);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Excluir" value="Excluir"
       onClick="JavaScript:camExcluir(frmCampeonato);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:camLimpar(frmCampeonato);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>