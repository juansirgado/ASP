<% @Language=VBScript %>
<% Option Explicit %>

<!-- #include file = "Include\ConfigDB.asp" -->
<!-- #include file = "Include\MountCombo.asp" -->
<!-- #include file = "Include\FormatField.asp" -->
<!-- #include file = "Include\VerifyAccess.asp" -->
<% VerifyAccess() %>

<html>

<!--
   -------------------------------------------------------------
   Program      : Classificacao.asp
   Description  : Página de processamento da classificação
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
   <title>Cadastro de Classifica&ccedil;&otilde;es</title>
   <link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
   <script language="JavaScript" src="../Script/ProClassificacao.js"></script>
   <script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmProClassificacao" action="ProClassificacao.asp">
<center>
<br>
<h1>Cadastro de Classifica&ccedil;&otilde;es</h1>

<%
' Função de definição das variáveis do Classificacao ===========================
'===============================================================================
Dim objCn, camRs, errRs, strQr, strCn, strOp, strMSG, strTitle, strKey, strName
Dim str_cd_campeonato, str_nm_campeonato, str_in_classificacao, strAdm
Dim str_in_equipe, str_in_palpite, str_in_aposta
Dim str_dt_equipe, str_dt_palpite, str_dt_aposta
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
   str_cd_campeonato    = Trim(Session.Contents("Campeonato"))
   str_nm_campeonato    = ""
   str_in_classificacao = ""
   str_in_equipe        = " checked"
   str_in_palpite       = " checked"
   str_in_aposta        = " checked"

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp                =                Trim(Request.Form("Opcao"))
   strMSG               = ""
   str_cd_campeonato    =                Trim(Request.Form("cam_cd_campeonato"))
   str_nm_campeonato    =                Trim(Request.Form("cam_nm_campeonato"))
   str_in_classificacao = FormatCheckbox(Trim(Request.Form("cam_in_classificacao")), 0)
   str_in_equipe        = FormatCheckbox(Trim(Request.Form("cam_in_equipe")), 0)
   str_in_palpite       = FormatCheckbox(Trim(Request.Form("cam_in_palpite")), 0)
   str_in_aposta        = FormatCheckbox(Trim(Request.Form("cam_in_aposta")), 0)

' Função de pesquisa de Campeonatos(Pesquisa e Exclusão) =======================
'===============================================================================
   If strOp = "Pesquisar" Then
      strQr = "Select cam_cd_campeonato, cam_nm_campeonato, cam_in_classificacao " & _
              "  From Campeonato " & _
              " Where cam_cd_campeonato=" & str_cd_campeonato
      Set camRs = objCn.Execute(strQr)

' Função que pesquisa os dados do Banco ========================================
'===============================================================================
      If Not camRs.EOF Then
         str_cd_campeonato    =                Trim(camRs("cam_cd_campeonato"))
         str_nm_campeonato    =                Trim(camRs("cam_nm_campeonato"))
         str_in_classificacao = FormatCheckbox(Trim(camRs("cam_in_classificacao")), 0)

         strMSG = "Campeonato pesquisado"
      Else
         strMSG = "Campeonato n&atilde;o cadastrado"
      End If

' Função encerra a conexão com o Banco de Dados ================================
'===============================================================================
      If Not IsNull(camRs) Then
         camRs.Close
      End If

      Set camRs = Nothing
   End If


' Função de pesquisa de Classificacaos(Inclusão e Alteração) ===================
'===============================================================================
   If strOp = "Processar" Then

      strQr = "Select cam_in_classificacao From Campeonato "
      If Not str_cd_campeonato = "" Then
         strQr = strQr & "Where cam_cd_campeonato=" & str_cd_campeonato
      End If
      Set camRs = objCn.Execute(strQr)

' Função de Classificacaos =====================================================
'===============================================================================
      If Not camRs.EOF Then

         If Trim(camRs("cam_in_classificacao")) = 0 Then

            strMSG = "<table cellpadding=""10"" class=""table""><tr><td>" & vbCrLf
            strMSG = strMSG & FormatDate(Trim(Now), "%d/%m/%Y %H:%i:%s", 0) & _
                     " - Início da classificação<br>"

            Call MarcaCampeonato(camRs, objCn, str_cd_campeonato, 1)

            If Trim(str_in_equipe) = "checked" Then
               Call ClassificaEquipe(str_cd_campeonato)
            End If

            If Trim(str_in_palpite) = "checked" Then
               Call ClassificaPalpite(str_cd_campeonato)
            End If

            If Trim(str_in_aposta) = "checked" Then
               Call ClassificaAposta(str_cd_campeonato)
            End If

            Call MarcaCampeonato(camRs, objCn,str_cd_campeonato, 0)

            strMSG = strMSG & FormatDate(Trim(Now), "%d/%m/%Y %H:%i:%s", 0) & _
                     " - Final da classificação<br>"
            strMSG = strMSG & "</td></tr></table>" & vbCrLf

         Else
            strMSG = "Classificacao já está sendo processada"
         End If
      Else
         strMSG = "Campeonato n&atilde;o cadastrado"
      End If

      Set camRs = Nothing
   End If
End If


' Dados da última classificação com sucesso ====================================
'===============================================================================
strQr = "Select err_dt_equipe, err_dt_palpite, err_dt_aposta "         & _
          "From (Select Max(err_dt_erro) As err_dt_equipe From Erro "  & _
                 "Where cam_cd_campeonato=" & str_cd_campeonato & " "  & _
                   "And err_cd_mensagem='0' "                          & _
                   "And err_nm_processo='ClassificaEquipe()') equ, "   & _
               "(Select Max(err_dt_erro) As err_dt_palpite From Erro " & _
                 "Where cam_cd_campeonato=" & str_cd_campeonato & " "  & _
                   "And err_cd_mensagem='0' "                          & _
                   "And err_nm_processo='ClassificaPalpite()') pal, "  & _
               "(Select Max(err_dt_erro) As err_dt_aposta From Erro "  & _
                 "Where cam_cd_campeonato=" & str_cd_campeonato & " "  & _
                   "And err_cd_mensagem='0' "                          & _
                   "And err_nm_processo='ClassificaAposta()') apo"

Set errRs = objCn.Execute(strQr)

If Not errRs.EOF Then
   str_dt_equipe  = FormatDate(Trim(errRs("err_dt_equipe")),  "%d/%m/%Y %H:%i:%s", 0)
   str_dt_palpite = FormatDate(Trim(errRs("err_dt_palpite")), "%d/%m/%Y %H:%i:%s", 0)
   str_dt_aposta  = FormatDate(Trim(errRs("err_dt_aposta")),  "%d/%m/%Y %H:%i:%s", 0)
End If

Set errRs = Nothing

' Função de geração da tela de Classificacao ===================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table""><tr>" & vbCrLf)

' Função que monta combo de Campeonatos ========================================
strTitle = "Campeonato"
strKey   = "cam_cd_campeonato"
strName  = "cam_nm_campeonato"
strQr    = "Select cam_cd_campeonato, cam_nm_campeonato From Campeonato Order by cam_nm_campeonato"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, 0)
'===============================================================================
Response.Write("<tr><td align=""right"">Última Classicação Equipes:<br>Palpites:<br>Apostas:</td>" & _
               "<td>" & str_dt_equipe & "<br>" & str_dt_palpite & _
               "<br>" & str_dt_aposta & "</td></tr>" & vbCrLf)
Response.Write("</tr><tr><td>Classificando Campeonato:</td>" & _
               "<td><input type=""checkbox"" name=""cam_in_classificacao""" & _
               str_in_classificacao & " disabled></td></tr>" & vbCrLf)
Response.Write("<tr><td>Classifica Equipes:</td>" & _
               "<td><input type=""checkbox"" name=""cam_in_equipe""" & _
               str_in_equipe & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Classifica Palpites:</td>" & _
               "<td><input type=""checkbox"" name=""cam_in_palpite""" & _
               str_in_palpite & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Classifica Apostas:</td>" & _
               "<td><input type=""checkbox"" name=""cam_in_aposta""" & _
               str_in_aposta & "></td></tr>" & vbCrLf)
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
<input type="button" class="button" name="Pesquisar" value="Pesquisar"
       onClick="JavaScript:claPesquisar(frmProClassificacao);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Processar" value="Processar"
       onClick="JavaScript:claProcessar(frmProClassificacao);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:claLimpar(frmProClassificacao);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>

<%
' Marca/Desmarca campeonato para processo de classificação =====================
'===============================================================================
Sub MarcaCampeonato(camRs, objCn, str_cd_campeonato, str_in_classificacao)

   Dim strQuery

   If str_in_classificacao = 1 Then
      strMSG = strMSG & FormatDate(Trim(Now), "%d/%m/%Y %H:%i:%s", 0) & _
               " - Indicador em classificação<br>"
   Else
      strMSG = strMSG & FormatDate(Trim(Now), "%d/%m/%Y %H:%i:%s", 0) & _
               " - Indicador de classificado<br>"
   End If

   strQuery = "Update campeonato " & _
              "Set cam_in_classificacao=" & str_in_Classificacao & " " & _
              "Where cam_cd_campeonato=" & Trim(str_cd_campeonato)
   Set camRs = objCn.Execute(strQr)

End Sub
'===============================================================================

' Classifica as Equipes do campeonato conforme os Jogos ========================
'===============================================================================
Sub ClassificaEquipe(str_cd_campeonato)

   Dim equRs, strQuery

   strMSG = strMSG & FormatDate(Trim(Now), "%d/%m/%Y %H:%i:%s", 0) & _
            " - Classificando equipes<br>"

   strQuery = "CALL ClassificaEquipe(" & str_cd_campeonato & ")"
   Set equRs = objCn.Execute(strQuery)
   Set equRs = Nothing

End Sub
'===============================================================================

' Classifica as Palpites do campeonato conforme os Jogos =======================
'===============================================================================
Sub ClassificaPalpite(str_cd_campeonato)


   Dim palRs, strQuery

   strMSG = strMSG & FormatDate(Trim(Now), "%d/%m/%Y %H:%i:%s", 0) & _
            " - Classificando palpites<br>"

   strQuery = "CALL ClassificaPalpite(" & str_cd_campeonato & ")"
   Set palRs = objCn.Execute(strQuery)
   Set palRs = Nothing

End Sub
'===============================================================================

' Classifica as Palpites do campeonato conforme os Jogos =======================
'===============================================================================
Sub ClassificaAposta(str_cd_campeonato)

   Dim apoRs, strQuery

   strMSG = strMSG & FormatDate(Trim(Now), "%d/%m/%Y %H:%i:%s", 0) & _
            " - Classificando apostas<br>"

   strQuery = "CALL ClassificaAposta(" & str_cd_campeonato & ")"
   Set apoRs = objCn.Execute(strQuery)
   Set apoRs = Nothing

End Sub
'===============================================================================
%>