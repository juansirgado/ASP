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
   Program      : CadFase.asp
   Description  : Página do cadastro de fases
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
<title>Cadastro de Fases</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadFase.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmFase" action="CadFase.asp">
<center>
<br>
<h1>Cadastro de Fases</h1>

<%
' Função de definição das variáveis do Fase ====================================
'===============================================================================
Dim objCn, fasRs, strQr, strCn, strOp, strMSG, strAdm
Dim str_cd_fase, str_nm_fase, str_cd_campeonato, strTitle, strKey, strName
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
   str_cd_fase =       ""
   str_nm_fase =       ""
   str_cd_campeonato  = Trim(Session.Contents("Campeonato"))

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp =             Trim(Request.Form("Opcao"))
   strMSG =            ""
   str_cd_fase =       Trim(Request.Form("fas_cd_fase"))
   str_nm_fase =       Trim(Request.Form("fas_nm_fase"))
   str_cd_campeonato = Trim(Request.Form("cam_cd_campeonato"))

' Função de pesquisa de Fases(Inclusão e Alteração) ============================
'===============================================================================
   If (strOp = "Incluir") or (strOp = "Alterar") or (strOp = "Excluir") Then

      strQr = "Select fas_cd_fase from Fase "
      If Not str_cd_fase = "" Then
         strQr = strQr & "Where fas_cd_fase=" & str_cd_fase
      Else
         strQr = strQr & "Where fas_cd_fase=0"
      End If
      Set fasRs = objCn.Execute(strQr)

' Função de pesquisa de Fases(Pesquisa e Exclusão) =============================
'===============================================================================
   Else If strOp = "Pesquisar" Then
           strQr = "Select fas_cd_fase, fas_nm_fase, cam_cd_campeonato from Fase "
           If Not str_cd_fase = "" Then
              strQr = strQr & "Where fas_cd_fase=" & str_cd_fase
           Else
              strQr = strQr & "Where Upper(fas_nm_fase) Like Upper('%" & str_nm_fase & "%')"
           End If
           Set fasRs = objCn.Execute(strQr)

' Função que pesquisa os dados do Banco ========================================
'===============================================================================
           If Not fasRs.EOF Then
              str_cd_fase =       Trim(fasRs("fas_cd_fase"))
              str_nm_fase =       Trim(fasRs("fas_nm_fase"))
              str_cd_campeonato = Trim(fasRs("cam_cd_campeonato"))
              strMSG = "Fase pesquisada"
           Else
              strMSG = "Fase n&atilde;o cadastrada"
           End If
        End If

   End If

' Função de inclusão de Fases =================================================
'===============================================================================
   If strOp = "Incluir" Then

      If fasRs.EOF Then
         strQr = "Insert into Fase (fas_cd_fase, fas_nm_fase, cam_cd_campeonato) " & _
                 "Values (sequence_nextval('sq_cd_fase'), "              & _
                 FormatString(Trim(str_nm_fase), 2)   & ", " & _
                              Trim(str_cd_campeonato) & ")"
         Set fasRs = objCn.Execute(strQr)
         strMSG = "Fase inclu&iacute;da"
      Else
         strMSG = "Fase j&aacute; cadastrada"
      End If

   End If

' Função de alteração de Fases =================================================
'===============================================================================
   If strOp = "Alterar" Then

      If Not fasRs.EOF Then
         strQr = "Update Fase Set "   & _
                 "fas_nm_fase="       & FormatString(Trim(str_nm_fase), 2)   & ", " & _
                 "cam_cd_campeonato=" &              Trim(str_cd_campeonato) & " "  & _
                 "Where fas_cd_fase=" &              Trim(str_cd_fase)
         Set fasRs = objCn.Execute(strQr)
         strMSG = "Fase alterada"
      Else
         strMSG = "Fase n&atilde;o cadastrada"
      End If

   End If

' Função de exclusão de Fases ==================================================
'===============================================================================
   If strOp = "Excluir" Then

      If Not fasRs.EOF Then
         strQr = "Delete from Fase "  & _
                 "Where fas_cd_fase=" & Trim(str_cd_fase)
         Set fasRs = objCn.Execute(strQr)
         strMSG = "Fase exclu&iacute;da"
      Else
         strMSG = "Fase n&atilde;o cadastrada"
      End If

   End If

' Função encerra a conexão com o Banco de Dados ================================
'===============================================================================
   If (Not IsNull(fasRs)) And strOp = "Pesquisar" Then
      fasRs.Close
   End If
   Set fasRs = Nothing

End If

' Função de geração da tela de Fases ===========================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)

' Função que monta combo de Fases ==============================================
strTitle = "Fase"
strKey   = "fas_cd_fase"
strName  = "fas_nm_fase"
strQr = "Select fas_cd_fase, fas_nm_fase From Fase " & _
        "Where cam_cd_campeonato=" & str_cd_campeonato & " Order by fas_nm_fase"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_fase, "")
'===============================================================================

Response.Write("<tr><td>Nome:</td>" & _
               "<td><input type=""text"" name=""fas_nm_fase"" size=""50"" maxlength=""50""" & _
               "value=""" & str_nm_fase & """" & strAdm & "></td></tr><tr>" & vbCrLf)

' Função que monta combo de Campeonatos ========================================
strTitle = "Campeonato"
strKey   = "cam_cd_campeonato"
strName  = "cam_nm_campeonato"
strQr = "Select cam_cd_campeonato, cam_nm_campeonato From Campeonato Order by cam_nm_campeonato"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, strAdm)
'===============================================================================

Response.Write("</tr><tr><td align=""center"" colspan=""3"">" & _
               "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf)
Response.Write("</table>" & vbCrLf & "<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
Set fasRs = Nothing
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
       onClick="JavaScript:fasPesquisar(frmFase);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Incluir" value="Incluir"
       onClick="JavaScript:fasIncluir(frmFase);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Alterar" value="Alterar"
       onClick="JavaScript:fasAlterar(frmFase);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Excluir" value="Excluir"
       onClick="JavaScript:fasExcluir(frmFase);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:fasLimpar(frmFase);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>