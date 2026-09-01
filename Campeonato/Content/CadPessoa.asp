<% @Language=VBScript %>
<% Option Explicit %>

<!-- #include file = "Include\ConfigDB.asp" -->
<!-- #include file = "Include\FormatField.asp" -->
<!-- #include file = "Include\MountCombo.asp" -->
<!-- #include file = "Include\CryptString.asp" -->
<!-- #include file = "Include\VerifyAccess.asp" -->
<% VerifyAccess() %>

<html>

<!--
   -------------------------------------------------------------
   Program      : CadPessoa.asp
   Description  : Página do cadastro de pessoas
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
<title>Cadastro de Pessoas</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadPessoa.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
<script language="JavaScript" src="../Script/isDate.js"></script>
<script language="JavaScript" src="../Script/isAlfaNumeric.js"></script>
</head>

<body>
<form method="post" name="frmPessoa" action="CadPessoa.asp">
<center>
<br>
<h1>Cadastro de Pessoas</h1>

<%
' Função de definição das variáveis da Pessoa ==================================
'===============================================================================
Dim objCn, pesRs, strQr, strCn, strOp, strMSG, strAdm, strTitle, strKey, strName
Dim str_cd_pessoa, str_nm_pessoa, str_cd_identificacao, str_nu_cpf, str_nu_rg
Dim str_nu_telefone, str_nu_celular, str_ds_email, str_dt_nascimento
Dim str_cd_acesso, str_in_nivel
strAdm = VerifyLevel()

' Função inicia a conexão com o Banco de Dados =================================
'===============================================================================
strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

' Função que inicializa os dados da Tela =======================================
'===============================================================================
   strOp                = ""
   strMSG               = "Entre a op&ccedil;&atilde;o desejada"
   str_cd_pessoa        = Trim(Session.Contents("Pessoa"))
   str_nm_pessoa        = ""
   str_cd_identificacao = ""
   str_nu_cpf           = ""
   str_nu_rg            = ""
   str_nu_telefone      = ""
   str_nu_celular       = ""
   str_ds_email         = ""
   str_dt_nascimento    = ""
   str_cd_acesso        = ""
   str_in_nivel         = ""

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp                =                Trim(Request.Form("Opcao"))
   strMSG               = ""
   str_cd_pessoa        =                Trim(Request.Form("pes_cd_pessoa"))
   str_nm_pessoa        =                Trim(Request.Form("pes_nm_pessoa"))
   str_cd_identificacao =                Trim(Request.Form("pes_cd_identificacao"))
   str_nu_cpf           =                Trim(Request.Form("pes_nu_cpf"))
   str_nu_rg            =                Trim(Request.Form("pes_nu_rg"))
   str_nu_telefone      =                Trim(Request.Form("pes_nu_telefone"))
   str_nu_celular       =                Trim(Request.Form("pes_nu_celular"))
   str_ds_email         =                Trim(Request.Form("pes_ds_email"))
   str_dt_nascimento    =                Trim(Request.Form("pes_dt_nascimento"))
   str_cd_acesso        =                Trim(Request.Form("pes_cd_acesso"))
   str_in_nivel         = FormatCheckbox(Trim(Request.Form("pes_in_nivel")), 0)

' Função de pesquisa de Pessoas(Inclusão e Alteração) ======================
'===============================================================================
   If (strOp = "Incluir") or (strOp = "Alterar") or (strOp = "Excluir") Then

      strQr = "Select pes_cd_pessoa from Pessoa "
      If Not str_cd_pessoa = "" Then
         strQr = strQr & "Where pes_cd_pessoa=" & str_cd_pessoa
      Else
         strQr = strQr & "Where pes_cd_pessoa=0"
      End If
      Set pesRs = objCn.Execute(strQr)

' Função de pesquisa de Pessoas(Pesquisa e Exclusão) =======================
'===============================================================================
   Else If strOp = "Pesquisar" Then
           strQr = "Select pes_cd_pessoa, pes_nm_pessoa, pes_cd_identificacao, " & _
                   "pes_nu_cpf, pes_nu_rg, pes_nu_telefone, pes_nu_celular, "    & _
                   "pes_ds_email, pes_dt_nascimento, pes_cd_acesso, "            & _
                   "pes_in_nivel From Pessoa "
           If Not str_cd_pessoa = "" Then
              strQr = strQr & "Where pes_cd_pessoa=" & str_cd_pessoa
           Else
              strQr = strQr & "Where Upper(pes_nm_pessoa) Like Upper('%" & str_nm_pessoa & "%')"
           End If
           Set pesRs = objCn.Execute(strQr)

' Função que pesquisa os dados do Banco ========================================
'===============================================================================
           If Not pesRs.EOF Then
              str_cd_pessoa =                Trim(pesRs("pes_cd_pessoa"))
              str_nm_pessoa =                Trim(pesRs("pes_nm_pessoa"))
              str_cd_identificacao =         Trim(pesRs("pes_cd_identificacao"))
              str_nu_cpf =                   Trim(pesRs("pes_nu_cpf"))
              str_nu_rg =                    Trim(pesRs("pes_nu_rg"))
              str_nu_telefone =              Trim(pesRs("pes_nu_telefone"))
              str_nu_celular =               Trim(pesRs("pes_nu_celular"))
              str_ds_email =                 Trim(pesRs("pes_ds_email"))
              str_dt_nascimento = FormatDate(Trim(pesRs("pes_dt_nascimento")), "%d/%m/%Y", 0)
              str_cd_acesso =    CryptString(Trim(pesRs("pes_cd_acesso")), "segredo", 1)
              If Trim(strAdm) = "disabled" Then
                 If Not (Trim(str_cd_pessoa) = Trim(Session.Contents("Pessoa"))) Then
                      str_cd_acesso = ""
                 End If
              End If
              str_in_nivel =  FormatCheckbox(Trim(pesRs("pes_in_nivel")), 0)
              strMSG = "Pessoa pesquisada"
           Else
              strMSG = "Pessoa n&atilde;o cadastrada"
           End If
        End If

   End If

' Função de inclusão de Pessoas =================================================
'===============================================================================
   If strOp = "Incluir" Then

      If pesRs.EOF Then
         strQr = "Insert Into Pessoa (pes_cd_pessoa, pes_nm_pessoa, "                & _
                 "pes_cd_identificacao, pes_nu_cpf, pes_nu_rg, pes_nu_telefone, "    & _
                 "pes_nu_celular, pes_ds_email, pes_dt_nascimento, pes_cd_acesso, "  & _
                 "pes_in_nivel) Values (sequence_nextval('sq_cd_pessoa'), "         & _
                 FormatString(Trim(str_nm_pessoa), 2)                   & ", "  & _
                 FormatString(Trim(str_cd_identificacao), 2)            & ", "  & _
                              Trim(str_nu_cpf)                          & ", "  & _
                              Trim(str_nu_rg)                           & ", "  & _
                              Trim(str_nu_telefone)                     & ", "  & _
                              Trim(str_nu_celular)                      & ", "  & _
                 FormatString(Trim(str_ds_email), 2)                    & ", "  & _
                   FormatDate(Trim(str_dt_nascimento), "%d/%m/%Y", 2)   & ", '" & _
                  CryptString(Trim(str_cd_acesso), "segredo", 0)        &"', "  & _
               FormatCheckbox(Trim(str_in_nivel), 2) & ")"
         Set pesRs = objCn.Execute(strQr)
         strMSG = "Pessoa inclu&iacute;da"
      Else
         strMSG = "Pessoa j&aacute; cadastrada"
      End If

   End If

' Função de alteração de Pessoas ===========================================
'===============================================================================
   If strOp = "Alterar" Then

      If Trim(str_cd_pessoa) = Trim(Session.Contents("Pessoa")) Then
         If Not pesRs.EOF Then
            strQr = "Update Pessoa Set "    & _
                    "pes_nm_pessoa="        &   FormatString(Trim(str_nm_pessoa), 2)        & ", " & _
                    "pes_cd_identificacao=" &   FormatString(Trim(str_cd_identificacao), 2) & ", " & _
                    "pes_nu_cpf="           &                Trim(str_nu_cpf)               & ", " & _
                    "pes_nu_rg="            &                Trim(str_nu_rg)                & ", " & _
                    "pes_nu_telefone="      &                Trim(str_nu_telefone)          & ", " & _
                    "pes_nu_celular="       &                Trim(str_nu_celular)           & ", " & _
                    "pes_ds_email="         &   FormatString(Trim(str_ds_email), 2)         & ", " & _
                    "pes_dt_nascimento="    &     FormatDate(Trim(str_dt_nascimento), "%d/%m/%Y", 2) & ", " & _
                    "pes_cd_acesso='"       &    CryptString(Trim(str_cd_acesso), "segredo", 0) & "', " & _
                    "pes_in_nivel="         & FormatCheckbox(Trim(str_in_nivel), 2)         & " "  & _
                    "Where pes_cd_pessoa="  &                Trim(str_cd_pessoa)
            Set pesRs = objCn.Execute(strQr)
            strMSG = "Pessoa alterada"
         Else
            strMSG = "Pessoa n&atilde;o cadastrada"
         End If
      Else
         strMSG = "Pessoa n&atilde;o &eacute; voc&ecirc;, acesso negado"
      End If

   End If

' Função de exclusão de Pessoas ============================================
'===============================================================================
   If strOp = "Excluir" Then

      If Not pesRs.EOF Then
         strQr = "Delete from Pessoa " & _
                 "Where pes_cd_pessoa=" & Trim(str_cd_pessoa)
         Set pesRs = objCn.Execute(strQr)
         strMSG = "Pessoa exclu&iacute;da"
      Else
         strMSG = "Pessoa n&atilde;o cadastrada"
      End If

   End If

' Função encerra a conexão com o Banco de Dados =================================
'===============================================================================
   If (Not IsNull(pesRs)) And strOp = "Pesquisar" Then
      pesRs.Close
   End If
   Set pesRs = Nothing

End If

' Função de geração da tela de Pessoas =====================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)

' Função que monta combo de Pessoas ============================================
strTitle = "Pessoa"
strKey   = "pes_cd_pessoa"
strName  = "pes_nm_pessoa"
strQr    = "Select pes_cd_pessoa, pes_nm_pessoa from Pessoa Order by pes_nm_pessoa"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_pessoa, "")
'===============================================================================

Response.Write("<tr><td>Nome:</td>" & _
               "<td><input type=""text"" name=""pes_nm_pessoa"" size=""50"" maxlength=""50""" & _
               "value=""" & str_nm_pessoa & """></td></tr>" & vbCrLf)
Response.Write("<tr><td>Foto:</td>" & _
               "<td><img src=""../Image/Pessoa/" & str_cd_pessoa & ".png"" " & _
               "width=""160px"" height=""200px"" border=""1px""></td></tr>" & vbCrLf)
Response.Write("<tr><td>Identifica&ccedil;&atilde;o:</td>" & _
               "<td><input type=""text"" name=""pes_cd_identificacao"" size=""16"" maxlength=""16""" & _
               "value=""" & str_cd_identificacao & """" & strAdm & "></td></tr>" & vbCrLf)
If Trim(strAdm) = "disabled" Then
   Response.Write("<input type=""hidden"" name=""pes_cd_identificacao"" " & _
                  "value=""" & str_cd_identificacao & """>"  & vbCrLf)
End If
Response.Write("<tr><td>CPF:</td>" & _
               "<td><input type=""text"" name=""pes_nu_cpf"" size=""20"" maxlength=""20""" & _
               "value=""" & str_nu_cpf & """></td></tr>" & vbCrLf)
Response.Write("<tr><td>RG:</td>" & _
               "<td><input type=""text"" name=""pes_nu_rg"" size=""20"" maxlength=""20""" & _
               "value=""" & str_nu_rg & """></td></tr>" & vbCrLf)
Response.Write("<tr><td>Telefone:</td>" & _
               "<td><input type=""text"" name=""pes_nu_telefone"" size=""15"" maxlength=""15""" & _
               "value=""" & str_nu_telefone & """></td></tr>" & vbCrLf)
Response.Write("<tr><td>Celular:</td>" & _
               "<td><input type=""text"" name=""pes_nu_celular"" size=""15"" maxlength=""15""" & _
               "value=""" & str_nu_celular & """></td></tr>" & vbCrLf)
Response.Write("<tr><td>E-Mail:</td>" & _
               "<td><input type=""text"" name=""pes_ds_email"" size=""50"" maxlength=""50""" & _
               "value=""" & str_ds_email & """></td></tr>" & vbCrLf)
Response.Write("<tr><td>Data de nascimento:</td>" & _
               "<td><input type=""text"" name=""pes_dt_nascimento"" size=""10"" maxlength=""10""" & _
               "value=""" & str_dt_nascimento & """></td></tr>" & vbCrLf)
If Trim(strAdm) = "disabled" Then
   Response.Write("<tr><td>C&oacute;digo de acesso:</td>" & _
                  "<td><input type=""password"" name=""pes_cd_acesso"" size=""20"" maxlength=""20""" & _
                  "value=""" & str_cd_acesso & """ alt=""Somente letras e N&uacute;meros sem acentos.""><i>&nbsp;*Alfan&uacute;merico</i></td></tr>" & vbCrLf)
Else
   Response.Write("<tr><td>C&oacute;digo de acesso:</td>" & _
                  "<td><input type=""text"" name=""pes_cd_acesso"" size=""20"" maxlength=""20""" & _
                  "value=""" & str_cd_acesso & """ alt=""Somente letras e N&uacute;meros sem acentos.""><i>&nbsp;*Alfan&uacute;merico</i></td></tr>" & vbCrLf)
End If
Response.Write("<tr><td>Nivel de administrador:</td>" & _
               "<td><input type=""checkbox"" name=""pes_in_nivel""" & _
               str_in_nivel & "" & strAdm & "></td></tr>" & vbCrLf)
If Trim(strAdm) = "disabled" Then
   Response.Write("<input type=""hidden"" name=""pes_in_nivel"" " & _
                  "value=""" & Trim(str_in_nivel) & """>"  & vbCrLf)
End If
Response.Write("<tr><td align=""center"" colspan=""3"">" & _
               "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf)
Response.Write("</table>" & vbCrLf & "<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
Set pesRs = Nothing
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
       onClick="JavaScript:pesPesquisar(frmPessoa);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Incluir" value="Incluir"
       onClick="JavaScript:pesIncluir(frmPessoa);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Alterar" value="Alterar"
       onClick="JavaScript:pesAlterar(frmPessoa);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Excluir" value="Excluir"
       onClick="JavaScript:pesExcluir(frmPessoa);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:pesLimpar(frmPessoa);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>