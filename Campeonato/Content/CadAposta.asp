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

<head>
<title>Cadastro de Apostas</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadAposta.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmAposta" action="CadAposta.asp">
<center>
<br>
<h1>Cadastro de Apostas</h1>

<%
' Função de definição das variáveis do Aposta ==================================
'===============================================================================
Dim objCn, apoRs, strQr, strCn, strOp, strMSG, strAdm
Dim str_cd_aposta, str_nm_aposta, str_dt_ultima_alt, str_cd_usuario_alt
Dim str_nu_ip_alt, str_qt_errado, str_qt_parcial, str_qt_correto, str_qt_pontos
Dim str_cd_campeonato, str_cd_pessoa, strTitle, strKey, strName
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
   str_cd_aposta      = ""
   str_nm_aposta      = ""
   str_qt_errado      = ""
   str_qt_parcial     = ""
   str_qt_correto     = ""
   str_qt_pontos      = ""
   str_dt_ultima_alt  = ""
   str_cd_usuario_alt = ""
   str_nu_ip_alt      = ""
   str_cd_campeonato  = Trim(Session.Contents("Campeonato"))
   str_cd_pessoa      = Trim(Session.Contents("Pessoa"))

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp              = Trim(Request.Form("Opcao"))
   strMSG             = ""

   str_cd_aposta      = Trim(Request.Form("apo_cd_aposta"))
   str_nm_aposta      = Trim(Request.Form("apo_nm_aposta"))
   str_qt_errado      = 0
   str_qt_parcial     = 0
   str_qt_correto     = 0
   str_qt_pontos      = 0
   str_dt_ultima_alt  = FormatDate(Now, "%d/%m/%Y %H:%i:%s", 0)
   str_cd_usuario_alt = Session.Contents("Usuario")
   str_nu_ip_alt      = Session.SessionId
   str_cd_campeonato  = Trim(Request.Form("cam_cd_campeonato"))
   str_cd_pessoa      = Trim(Request.Form("pes_cd_pessoa"))


' Função de pesquisa de Apostas(Inclusão e Alteração) ==========================
'===============================================================================
   If (strOp = "Incluir") or (strOp = "Alterar") or (strOp = "Excluir") Then

      strQr = "Select apo_cd_aposta from Aposta "
      If Not str_cd_aposta = "" Then
         strQr = strQr & "Where apo_cd_aposta=" & str_cd_aposta
      Else
         strQr = strQr & "Where apo_cd_aposta=0"
      End If
      Set apoRs = objCn.Execute(strQr)

' Função de pesquisa de Apostas(Pesquisa e Exclusão) ===========================
'===============================================================================
   Else If strOp = "Pesquisar" Then
           strQr = "Select apo_cd_aposta, apo_nm_aposta, apo_qt_errado, apo_qt_parcial, "   & _
                   "apo_qt_correto, apo_qt_pontos, apo_dt_ultima_alt, apo_cd_usuario_alt, " & _
                   "apo_nu_ip_alt, cam_cd_campeonato, pes_cd_pessoa from Aposta "
           If Not str_cd_aposta = "" Then
              strQr = strQr & "Where apo_cd_aposta=" & str_cd_aposta
           Else
              strQr = strQr & "Where Upper(apo_nm_aposta) Like Upper('%" & str_nm_aposta & "%')"
           End If

           Set apoRs = objCn.Execute(strQr)

' Função que pesquisa os dados do Banco ========================================
'===============================================================================
           If Not apoRs.EOF Then
              str_cd_aposta      =            Trim(apoRs("apo_cd_aposta"))
              str_nm_aposta      =            Trim(apoRs("apo_nm_aposta"))
              str_qt_errado      =            Trim(apoRs("apo_qt_errado"))
              str_qt_parcial     =            Trim(apoRs("apo_qt_parcial"))
              str_qt_correto     =            Trim(apoRs("apo_qt_correto"))
              str_qt_pontos      =            Trim(apoRs("apo_qt_pontos"))
              str_dt_ultima_alt  = FormatDate(Trim(apoRs("apo_dt_ultima_alt")), "%d/%m/%Y %H:%i:%s", 0)
              str_cd_usuario_alt =            Trim(apoRs("apo_cd_usuario_alt"))
              str_nu_ip_alt      =            Trim(apoRs("apo_nu_ip_alt"))
              str_cd_campeonato  =            Trim(apoRs("cam_cd_campeonato"))
              str_cd_pessoa      =            Trim(apoRs("pes_cd_pessoa"))
              strMSG = "Aposta pesquisada"
           Else
              strMSG = "Aposta n&atilde;o cadastrada"
           End If
        End If

   End If

' Função de inclusão de Apostas ================================================
'===============================================================================
   If strOp = "Incluir" Then

      If apoRs.EOF Then
         strQr = "Insert into Aposta (apo_cd_aposta, apo_nm_aposta, apo_qt_errado, "     & _
                 "apo_qt_parcial, apo_qt_correto, apo_qt_pontos, apo_dt_ultima_alt, "    & _
                 "apo_cd_usuario_alt, apo_nu_ip_alt, cam_cd_campeonato, pes_cd_pessoa) " & _
                 "Values (sequence_nextval('sq_cd_aposta'),"      & _
                 FormatString(Trim(str_nm_aposta), 2) & ", " & _
                              Trim(str_qt_errado)     & ", " & _
                              Trim(str_qt_parcial)    & ", " & _
                              Trim(str_qt_correto)    & ", " & _
                              Trim(str_qt_pontos)     & ", " & _
                   FormatDate(Now, "%d/%m/%Y %H:%i:%s", 2) & ", " & _
                 FormatString(Session.Contents("Usuario"), 2)  & ", " & _
                 FormatString(Session.SessionId, 2)   & ", " & _
                              Trim(str_cd_campeonato) & ", " & _
                              Trim(str_cd_pessoa)     & ")"
         Set apoRs = objCn.Execute(strQr)
         strMSG = "Aposta inclu&iacute;da"
      Else
         strMSG = "Aposta j&aacute; cadastrada"
      End If

   End If

' Função de alteração de Apostas ===============================================
'===============================================================================
   If strOp = "Alterar" Then

      If Trim(str_cd_pessoa) = Trim(Session.Contents("Pessoa")) Then
         If Not apoRs.EOF Then
            strQr = "Update Aposta Set "   & _
                    "apo_nm_aposta="       & FormatString(Trim(str_nm_aposta), 2) & ", " & _
                    "apo_qt_errado="       &              Trim(str_qt_errado)     & ", " & _
                    "apo_qt_parcial="      &              Trim(str_qt_parcial)    & ", " & _
                    "apo_qt_correto="      &              Trim(str_qt_correto)    & ", " & _
                    "apo_qt_pontos="       &              Trim(str_qt_pontos)     & ", " & _
                    "apo_dt_ultima_alt="   &   FormatDate(Now, "%d/%m/%Y %H:%i:%s", 2) & ", " & _
                    "apo_cd_usuario_alt="  & FormatString(Session.Contents("Usuario"), 2)  & ", " & _
                    "apo_nu_ip_alt="       & FormatString(Session.SessionId, 2)   & ", " & _
                    "cam_cd_campeonato="   &              Trim(str_cd_campeonato) & ", " & _
                    "pes_cd_pessoa="       &              Trim(str_cd_pessoa)     & "  " & _
                    "Where apo_cd_aposta=" &              Trim(str_cd_aposta)
            Set apoRs = objCn.Execute(strQr)
            strMSG = "Aposta alterada"
         Else
            strMSG = "Aposta n&atilde;o cadastrada"
         End If
      Else
         strMSG = "Aposta n&atilde;o &eacute; sua, acesso negado"
      End If

   End If

' Função de exclusão de Apostas ================================================
'===============================================================================
   If strOp = "Excluir" Then

      If Not apoRs.EOF Then
         strQr = "Delete from Aposta "  & _
                 "Where apo_cd_aposta=" & Trim(str_cd_aposta)
         Set apoRs = objCn.Execute(strQr)
         strMSG = "Aposta exclu&iacute;da"
      Else
         strMSG = "Aposta n&atilde;o cadastrada"
      End If

   End If

' Função encerra a conexão com o Banco de Dados ================================
'===============================================================================
   If (Not IsNull(apoRs)) And strOp = "Pesquisar" Then
      apoRs.Close
   End If
   Set apoRs = Nothing

End If

' Função de geração da tela de Apostas =========================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)

' Função que monta combo de Aposta =============================================
   strTitle = "Aposta"
   strKey   = "apo_cd_aposta"
   strName  = "apo_nm_aposta"
   strQr = "Select apo_cd_aposta, apo_nm_aposta " & _
           "From Aposta "  & _
           "Where pes_cd_pessoa=" & Trim(Session.Contents("Pessoa")) & " " & _
           "Order by apo_nm_aposta"

   Call MountCombo(strTitle, strKey, strName, strQr, str_cd_aposta, "")
'===============================================================================

Response.Write("<tr><td>Nome:</td>" & _
               "<td><input type=""text"" name=""apo_nm_aposta"" size=""50"" maxlength=""50""" & _
               "value=""" & str_nm_aposta & """></td></tr>" & vbCrLf)
Response.Write("<tr><td>Palpite errado:</td>" & _
               "<td><input type=""text"" name=""apo_qt_errado"" size=""3"" maxlength=""3""" & _
               "value=""" & str_qt_errado & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Palpite parcial:</td>" & _
               "<td><input type=""text"" name=""apo_qt_parcial"" size=""3"" maxlength=""3""" & _
               "value=""" & str_qt_parcial & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Palpite correto:</td>" & _
               "<td><input type=""text"" name=""apo_qt_correto"" size=""3"" maxlength=""3""" & _
               "value=""" & str_qt_correto & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Quantidade de pontos:</td>" & _
               "<td><input type=""text"" name=""apo_qt_pontos"" size=""5"" maxlength=""5""" & _
               "value=""" & str_qt_pontos & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Data da &uacute;ltima altera&ccedil;&atilde;o:</td>" & _
               "<td><input type=""text"" name=""apo_dt_ultima_alt"" size=""25"" maxlength=""25""" & _
               "value=""" & str_dt_ultima_alt & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Usu&aacute;rio da altera&ccedil;&atilde;o:</td>" & _
               "<td><input type=""text"" name=""apo_cd_usuario_alt"" size=""40"" maxlength=""40""" & _
               "value=""" & str_cd_usuario_alt & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>N&uacute;mero do IP da altera&ccedil;&atilde;o:</td>" & _
               "<td><input type=""text"" name=""apo_nu_ip_alt"" size=""15"" maxlength=""15""" & _
               "value=""" & str_nu_ip_alt & """" & strAdm & "></td></tr><tr>" & vbCrLf)
If Trim(strAdm) = "disabled" Then
   Response.Write("<input type=""hidden"" name=""apo_qt_errado"" " & _
                  "value=""" & str_qt_errado & """>"  & vbCrLf)
   Response.Write("<input type=""hidden"" name=""apo_qt_parcial"" " & _
                  "value=""" & str_qt_parcial & """>"  & vbCrLf)
   Response.Write("<input type=""hidden"" name=""apo_qt_correto"" " & _
                  "value=""" & str_qt_correto & """>"  & vbCrLf)
   Response.Write("<input type=""hidden"" name=""apo_qt_pontos"" " & _
                  "value=""" & str_qt_pontos & """>"  & vbCrLf)
   Response.Write("<input type=""hidden"" name=""apo_dt_ultima_alt"" " & _
                  "value=""" & str_dt_ultima_alt & """>"  & vbCrLf)
   Response.Write("<input type=""hidden"" name=""apo_cd_usuario_alt"" " & _
                  "value=""" & str_cd_usuario_alt & """>"  & vbCrLf)
   Response.Write("<input type=""hidden"" name=""apo_nu_ip_alt"" " & _
                  "value=""" & str_nu_ip_alt & """>"  & vbCrLf)
End If

' Função que monta combo de Campeonatos ========================================
If Trim(strAdm) = "disabled" Then
   Response.Write("<input type=""hidden"" name=""cam_cd_campeonato"" " & _
                  "value=""" & str_cd_campeonato & """>"  & vbCrLf)
End If
strTitle = "Campeonato"
strKey   = "cam_cd_campeonato"
strName  = "cam_nm_campeonato"
strQr = "Select cam_cd_campeonato, cam_nm_campeonato from Campeonato Order by cam_nm_campeonato"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, strAdm)
'===============================================================================

Response.Write("</tr><tr>")

' Função que monta combo de Pessoas ============================================
If Trim(strAdm) = "disabled" Then
   Response.Write("<input type=""hidden"" name=""pes_cd_pessoa"" " & _
                  "value=""" & str_cd_pessoa & """>"  & vbCrLf)
End If
strTitle = "Pessoa"
strKey   = "pes_cd_pessoa"
strName  = "pes_nm_pessoa"
strQr = "Select pes_cd_pessoa, pes_nm_pessoa from Pessoa Order by pes_nm_pessoa"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_pessoa, strAdm)
'===============================================================================

Response.Write("</tr><tr><td align=""center"" colspan=""3"">" & _
               "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf)
Response.Write("</table>" & vbCrLf & "<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
Set apoRs = Nothing
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
       onClick="JavaScript:apoPesquisar(frmAposta);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Incluir" value="Incluir"
       onClick="JavaScript:apoIncluir(frmAposta);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Alterar" value="Alterar"
       onClick="JavaScript:apoAlterar(frmAposta);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Excluir" value="Excluir"
       onClick="JavaScript:apoExcluir(frmAposta);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:apoLimpar(frmAposta);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>