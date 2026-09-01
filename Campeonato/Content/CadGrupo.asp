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
   Program      : CadGrupo.asp
   Description  : Página do cadastro de grupos
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
<title>Cadastro de Grupos</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadGrupo.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmGrupo" action="CadGrupo.asp">
<center>
<br>
<h1>Cadastro de Grupos</h1>

<%
' Função de definição das variáveis do Grupo ===================================
'===============================================================================
Dim objCn, gruRs, strQr, strCn, strOp, strMSG, strAdm
Dim str_cd_grupo, str_nm_grupo, str_cd_campeonato, strTitle, strKey, strName
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
   str_cd_grupo =      ""
   str_nm_grupo =      ""
   str_cd_campeonato  = Trim(Session.Contents("Campeonato"))

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp =             Trim(Request.Form("Opcao"))
   strMSG =            ""
   str_cd_grupo =      Trim(Request.Form("gru_cd_grupo"))
   str_nm_grupo =      Trim(Request.Form("gru_nm_grupo"))
   str_cd_campeonato = Trim(Request.Form("cam_cd_campeonato"))

' Função de pesquisa de Grupos(Inclusão e Alteração) ======================
'===============================================================================
   If (strOp = "Incluir") or (strOp = "Alterar") or (strOp = "Excluir") Then

      strQr = "Select gru_cd_grupo from Grupo "
      If Not str_cd_grupo = "" Then
         strQr = strQr & "Where gru_cd_grupo=" & str_cd_grupo
      Else
         strQr = strQr & "Where gru_cd_grupo=0"
      End If
      Set gruRs = objCn.Execute(strQr)

' Função de pesquisa de Grupos(Pesquisa e Exclusão) =======================
'===============================================================================
   Else If strOp = "Pesquisar" Then
           strQr = "Select gru_cd_grupo, gru_nm_grupo, cam_cd_campeonato from Grupo "
           If Not str_cd_grupo = "" Then
              strQr = strQr & "Where gru_cd_grupo=" & str_cd_grupo
           Else
              strQr = strQr & "Where Upper(gru_nm_grupo) Like Upper('%" & str_nm_grupo & "%')"
           End If
           Set gruRs = objCn.Execute(strQr)

' Função que pesquisa os dados do Banco ========================================
'===============================================================================
           If Not gruRs.EOF Then
              str_cd_grupo =      Trim(gruRs("gru_cd_grupo"))
              str_nm_grupo =      Trim(gruRs("gru_nm_grupo"))
              str_cd_campeonato = Trim(gruRs("cam_cd_campeonato"))
              strMSG = "Grupo pesquisado"
           Else
              strMSG = "Grupo n&atilde;o cadastrado"
           End If
        End If

   End If

' Função de inclusão de Grupos =================================================
'===============================================================================
   If strOp = "Incluir" Then

      If gruRs.EOF Then
         strQr = "Insert into Grupo (gru_cd_grupo, gru_nm_grupo, cam_cd_campeonato) " & _
                 "Values (sequence_nextval('sq_cd_grupo'), "             & _
                 FormatString(Trim(str_nm_grupo), 2)  & ", " & _
                              Trim(str_cd_campeonato) & ")"
         Set gruRs = objCn.Execute(strQr)
         strMSG = "Grupo inclu&iacute;do"
      Else
         strMSG = "Grupo j&aacute; cadastrado"
      End If

   End If

' Função de alteração de Grupos ===========================================
'===============================================================================
   If strOp = "Alterar" Then

      If Not gruRs.EOF Then
         strQr = "Update Grupo Set "    & _
                  "gru_nm_grupo="       & FormatString(Trim(str_nm_grupo), 2)  & ", " & _
                  "cam_cd_campeonato="  &              Trim(str_cd_campeonato) & " "  & _
                  "Where gru_cd_grupo=" &              Trim(str_cd_grupo)
         Set gruRs = objCn.Execute(strQr)
         strMSG = "Grupo alterado"
      Else
         strMSG = "Grupo n&atilde;o cadastrado"
      End If

   End If

' Função de exclusão de Grupos ============================================
'===============================================================================
   If strOp = "Excluir" Then

      If Not gruRs.EOF Then
         strQr = "Delete from Grupo " & _
                 "Where gru_cd_grupo=" & Trim(str_cd_grupo)
         Set gruRs = objCn.Execute(strQr)
         strMSG = "Grupo exclu&iacute;do"
      Else
         strMSG = "Grupo n&atilde;o cadastrado"
      End If

   End If

' Função encerra a conexão com o Banco de Dados =================================
'===============================================================================
   If (Not IsNull(gruRs)) And strOp = "Pesquisar" Then
      gruRs.Close
   End If
   Set gruRs = Nothing

End If

' Função de geração da tela de Grupos =====================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)

' Função que monta combo de Grupos =============================================
strTitle = "Grupo"
strKey   = "gru_cd_grupo"
strName  = "gru_nm_grupo"
strQr = "Select gru_cd_grupo, gru_nm_grupo From Grupo " & _
        "Where cam_cd_campeonato=" & str_cd_campeonato &  " Order by gru_nm_grupo"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_grupo, "")
'===============================================================================

Response.Write("<tr><td>Nome:</td>" & _
               "<td><input type=""text"" name=""gru_nm_grupo"" size=""50"" maxlength=""50""" & _
               "value=""" & str_nm_grupo & """" & strAdm & "></td></tr><tr>" & vbCrLf)

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
Set gruRs = Nothing
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
       onClick="JavaScript:gruPesquisar(frmGrupo);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Incluir" value="Incluir"
       onClick="JavaScript:gruIncluir(frmGrupo);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Alterar" value="Alterar"
       onClick="JavaScript:gruAlterar(frmGrupo);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Excluir" value="Excluir"
       onClick="JavaScript:gruExcluir(frmGrupo);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:gruLimpar(frmGrupo);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>