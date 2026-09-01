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
   Program      : CadJogo.asp
   Description  : Página do cadastro de jogos
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
<title>Cadastro de Jogos</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadJogo.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmJogo" action="CadJogo.asp">
<center>
<br>
<h1>Cadastro de Jogos</h1>

<%
' Função de definição das variáveis do Jogo ====================================
'===============================================================================
Dim objCn, jogRs, strQr, strCn, strOp, strMSG, strAdm, strTitle, strKey, strName
Dim str_cd_jogo, str_dt_jogo, str_ds_jogo, str_cd_equipe_1, str_cd_equipe_2
Dim str_qt_gol90_equ_1, str_qt_gol90_equ_2, str_qt_gol_equ_1, str_qt_gol_equ_2
Dim str_qt_cartao_am_1, str_qt_cartao_am_2, str_qt_cartao_vr_1, str_qt_cartao_vr_2
Dim str_cd_campeonato, str_cd_grupo, str_cd_fase, str_cd_local
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
   str_cd_jogo        = ""
   str_dt_jogo        = ""
   str_ds_jogo        = ""
   str_cd_equipe_1    = ""
   str_cd_equipe_2    = ""
   str_qt_gol90_equ_1 = ""
   str_qt_gol90_equ_2 = ""
   str_qt_gol_equ_1   = ""
   str_qt_gol_equ_2   = ""
   str_qt_cartao_am_1 = ""
   str_qt_cartao_am_2 = ""
   str_qt_cartao_vr_1 = ""
   str_qt_cartao_vr_2 = ""
   str_cd_campeonato  = Trim(Session.Contents("Campeonato"))
   str_cd_fase        = ""
   str_cd_grupo       = ""
   str_cd_local       = ""

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp              = Trim(Request.Form("Opcao"))
   strMSG             = ""

   str_cd_jogo        = Trim(Request.Form("jog_cd_jogo"))
   str_dt_jogo        = Trim(Request.Form("jog_dt_jogo"))
   str_ds_jogo        = Trim(Request.Form("jog_ds_jogo"))
   str_cd_equipe_1    = Trim(Request.Form("equ_cd_equipe_1"))
   str_cd_equipe_2    = Trim(Request.Form("equ_cd_equipe_2"))
   str_qt_gol90_equ_1 = Trim(Request.Form("jog_qt_gol90_equ_1"))
   str_qt_gol90_equ_2 = Trim(Request.Form("jog_qt_gol90_equ_2"))
   str_qt_gol_equ_1   = Trim(Request.Form("jog_qt_gol_equ_1"))
   str_qt_gol_equ_2   = Trim(Request.Form("jog_qt_gol_equ_2"))
   str_qt_cartao_am_1 = Trim(Request.Form("jog_qt_cartao_am_1"))
   str_qt_cartao_am_2 = Trim(Request.Form("jog_qt_cartao_am_2"))
   str_qt_cartao_vr_1 = Trim(Request.Form("jog_qt_cartao_vr_1"))
   str_qt_cartao_vr_2 = Trim(Request.Form("jog_qt_cartao_vr_2"))
   str_cd_campeonato  = Trim(Request.Form("cam_cd_campeonato"))
   str_cd_fase        = Trim(Request.Form("fas_cd_fase"))
   str_cd_grupo       = Trim(Request.Form("gru_cd_grupo"))
   str_cd_local       = Trim(Request.Form("loc_cd_local"))


' Função de pesquisa de Jogos(Inclusão e Alteração) ============================
'===============================================================================
   If (strOp = "Incluir") or (strOp = "Alterar") or (strOp = "Excluir") Then

      strQr = "Select jog_cd_jogo from Jogo "
      If Not str_cd_jogo = "" Then
         strQr = strQr & "Where jog_cd_jogo=" & str_cd_jogo
      Else
         strQr = strQr & "Where jog_cd_jogo=0"
      End If
      Set jogRs = objCn.Execute(strQr)

' Função de pesquisa de Jogos(Pesquisa e Exclusão) =============================
'===============================================================================
   Else If strOp = "Pesquisar" Then
           strQr = "Select jog_cd_jogo, jog_dt_jogo, jog_ds_jogo, equ_cd_equipe_1, equ_cd_equipe_2, " & _
                   "jog_qt_gol90_equ_1, jog_qt_gol90_equ_2, jog_qt_gol_equ_1, jog_qt_gol_equ_2, "     & _
                   "jog_qt_cartao_am_1, jog_qt_cartao_am_2, jog_qt_cartao_vr_1, jog_qt_cartao_vr_2, " & _
                   "cam_cd_campeonato, fas_cd_fase, gru_cd_grupo, loc_cd_local From Jogo "            & _
                   "Where jog_cd_jogo=" & str_cd_jogo
           'Response.Write(strQr)
           Set jogRs = objCn.Execute(strQr)

' Função que pesquisa os dados do Banco ========================================
'===============================================================================
           If Not jogRs.EOF Then
              str_cd_jogo        =            Trim(jogRs("jog_cd_jogo"))
              str_dt_jogo        = FormatDate(Trim(jogRs("jog_dt_jogo")), "%d/%m/%Y %H:%i:%s", 0)
              str_ds_jogo        =            Trim(jogRs("jog_ds_jogo"))
              str_cd_equipe_1    =            Trim(jogRs("equ_cd_equipe_1"))
              str_cd_equipe_2    =            Trim(jogRs("equ_cd_equipe_2"))
              str_qt_gol90_equ_1 =            Trim(jogRs("jog_qt_gol90_equ_1"))
              str_qt_gol90_equ_2 =            Trim(jogRs("jog_qt_gol90_equ_2"))
              str_qt_gol_equ_1   =            Trim(jogRs("jog_qt_gol_equ_1"))
              str_qt_gol_equ_2   =            Trim(jogRs("jog_qt_gol_equ_2"))
              str_qt_cartao_am_1 =            Trim(jogRs("jog_qt_cartao_am_1"))
              str_qt_cartao_am_2 =            Trim(jogRs("jog_qt_cartao_am_2"))
              str_qt_cartao_vr_1 =            Trim(jogRs("jog_qt_cartao_vr_1"))
              str_qt_cartao_vr_2 =            Trim(jogRs("jog_qt_cartao_vr_2"))
              str_cd_campeonato  =            Trim(jogRs("cam_cd_campeonato"))
              str_cd_fase        =            Trim(jogRs("fas_cd_fase"))
              str_cd_grupo       =            Trim(jogRs("gru_cd_grupo"))
              str_cd_local       =            Trim(jogRs("loc_cd_local"))
              strMSG = "Jogo pesquisado"
           Else
              strMSG = "Jogo n&atilde;o cadastrado"
           End If
        End If

   End If

' Função de inclusão de Jogos ==================================================
'===============================================================================
   If strOp = "Incluir" Then

      If jogRs.EOF Then
         strQr = "Insert into Jogo (jog_cd_jogo, jog_dt_jogo, jog_ds_jogo, equ_cd_equipe_1, "       & _
                 "equ_cd_equipe_2, jog_qt_gol90_equ_1, jog_qt_gol90_equ_2, jog_qt_gol_equ_1, "      & _
                 "jog_qt_gol_equ_2, jog_qt_cartao_am_1, jog_qt_cartao_am_2, jog_qt_cartao_vr_1, "   & _
                 "jog_qt_cartao_vr_2, cam_cd_campeonato, fas_cd_fase, gru_cd_grupo, loc_cd_local) " & _
                 "Values (sequence_nextval('sq_cd_jogo'), "    & _
                   FormatDate(Trim(str_dt_jogo), "%d/%m/%Y %H:%i:%s", 2) & ", " & _
                 FormatString(Trim(str_ds_jogo), 2)    & ", " & _
                              Trim(str_cd_equipe_1)    & ", " & _
                              Trim(str_cd_equipe_2)    & ", " & _
                              Trim(str_qt_gol90_equ_1) & ", " & _
                              Trim(str_qt_gol90_equ_2) & ", " & _
                              Trim(str_qt_gol_equ_1)   & ", " & _
                              Trim(str_qt_gol_equ_2)   & ", " & _
                              Trim(str_qt_cartao_am_1) & ", " & _
                              Trim(str_qt_cartao_am_2) & ", " & _
                              Trim(str_qt_cartao_vr_1) & ", " & _
                              Trim(str_qt_cartao_vr_2) & ", " & _
                              Trim(str_cd_campeonato)  & ", " & _
                              Trim(str_cd_fase)        & ", " & _
                              Trim(str_cd_grupo)       & ", " & _
                              Trim(str_cd_grupo)       & ")"
         Set jogRs = objCn.Execute(strQr)
         strMSG = "Jogo inclu&iacute;do"
      Else
         strMSG = "Jogo j&aacute; cadastrado"
      End If

   End If

' Função de alteração de Jogos =================================================
'===============================================================================
   If strOp = "Alterar" Then

      If Not jogRs.EOF Then
         strQr = "Update Jogo Set "    & _
                 "jog_dt_jogo="        &   FormatDate(Trim(str_dt_jogo), "%d/%m/%Y %H:%i:%s", 2) & ", "  & _
                 "jog_ds_jogo="        & FormatString(Trim(str_ds_jogo), 2)    & ", " & _
                 "equ_cd_equipe_1="    &              Trim(str_cd_equipe_1)    & ", " & _
                 "equ_cd_equipe_2="    &              Trim(str_cd_equipe_2)    & ", " & _
                 "jog_qt_gol90_equ_1=" &              Trim(str_qt_gol90_equ_1) & ", " & _
                 "jog_qt_gol90_equ_2=" &              Trim(str_qt_gol90_equ_2) & ", " & _
                 "jog_qt_gol_equ_1="   &              Trim(str_qt_gol_equ_1)   & ", " & _
                 "jog_qt_gol_equ_2="   &              Trim(str_qt_gol_equ_2)   & ", " & _
                 "jog_qt_cartao_am_1=" &              Trim(str_qt_cartao_am_1) & ", " & _
                 "jog_qt_cartao_am_2=" &              Trim(str_qt_cartao_am_2) & ", " & _
                 "jog_qt_cartao_vr_1=" &              Trim(str_qt_cartao_vr_1) & ", " & _
                 "jog_qt_cartao_vr_2=" &              Trim(str_qt_cartao_vr_2) & ", " & _
                 "cam_cd_campeonato="  &              Trim(str_cd_campeonato)  & ", " & _
                 "fas_cd_fase="        &              Trim(str_cd_fase)        & ", " & _
                 "gru_cd_grupo="       &              Trim(str_cd_grupo)       & ", " & _
                 "loc_cd_local="       &              Trim(str_cd_local)       & " "  & _
                 "Where jog_cd_jogo="  &              Trim(str_cd_jogo)
         'Response.Write("[" & strQr & "]")
         Set jogRs = objCn.Execute(strQr)
         strMSG = "Jogo alterado"
      Else
         strMSG = "Jogo n&atilde;o cadastrado"
      End If

   End If

' Função de exclusão de Jogos ==================================================
'===============================================================================
   If strOp = "Excluir" Then

      If Not jogRs.EOF Then
         strQr = "Delete from Jogo "  & _
                    "Where jog_cd_jogo=" & Trim(str_cd_jogo)
         Set jogRs = objCn.Execute(strQr)
         strMSG = "Jogo exclu&iacute;do"
      Else
         strMSG = "Jogo n&atilde;o cadastrado"
      End If

   End If

' Função encerra a conexão com o Banco de Dados ================================
'===============================================================================
   If (Not IsNull(jogRs)) And strOp = "Pesquisar" Then
      jogRs.Close
   End If
   Set jogRs = Nothing

End If

' Função de geração da tela de Jogos ===========================================
'===============================================================================
Response.Write("<table cellpadding=""5"" class=""table"">" & vbCrLf)

' Função que monta combo de Jogos ==============================================
strTitle = "Jogo"
strKey   = "jog_cd_jogo"
strName  = "jog_nm_jogo"
strQr = "Select jog.jog_cd_jogo, jog.jog_dt_jogo, " & _
        "CONCAT(CAST(jog.jog_dt_jogo AS CHAR(20)), "" - "", eq1.equ_nm_equipe, "" X "", eq2.equ_nm_equipe) As jog_nm_jogo " & _
         "From Jogo jog, Equipe eq1, Equipe eq2  " & _
        "Where jog.cam_cd_campeonato=" & str_cd_campeonato & " " & _
          "And eq1.equ_cd_equipe=jog.equ_cd_equipe_1 " & _
          "And eq2.equ_cd_equipe=jog.equ_cd_equipe_2 Order by jog_dt_jogo"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_jogo, "")
'===============================================================================

Response.Write("<tr><td>Data:</td>" & _
               "<td><input type=""text"" name=""jog_dt_jogo"" size=""20"" maxlength=""20""" & _
               "value=""" & str_dt_jogo & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Descri&ccedil;&atilde;o:</td>" & _
               "<td><textarea cols=""50"" rows=""5"" name=""jog_ds_jogo""" & strAdm & ">" & _
               str_ds_jogo & "</textarea></td></tr><tr>" & vbCrLf)

' Função que monta combo de Equipe 1 ===========================================
strTitle = "Equipe 1"
strKey   = "equ_cd_equipe_1"
strName  = "equ_nm_equipe_1"
strQr = "Select equ.equ_cd_equipe As equ_cd_equipe_1, equ.equ_nm_equipe As equ_nm_equipe_1 " & _
        "From Equipe equ, " & _
             "CamEqu rce "  & _
        "Where rce.cam_cd_campeonato=" & str_cd_campeonato & " " & _
          "And rce.equ_cd_equipe=equ.equ_cd_equipe "             & _
        "Order by equ.equ_nm_equipe"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_equipe_1, strAdm)
'===============================================================================

Response.Write("</tr><tr>")

' Função que monta combo de Equipe 2 ===========================================
strTitle = "Equipe 2"
strKey   = "equ_cd_equipe_2"
strName  = "equ_nm_equipe_2"
strQr = "Select equ.equ_cd_equipe As equ_cd_equipe_2, equ.equ_nm_equipe As equ_nm_equipe_2 " & _
        "From Equipe equ, " & _
             "CamEqu rce "  & _
        "Where rce.cam_cd_campeonato=" & str_cd_campeonato & " " & _
          "And rce.equ_cd_equipe=equ.equ_cd_equipe "             & _
        "Order by equ.equ_nm_equipe"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_equipe_2, strAdm)
'===============================================================================

Response.Write("</tr><tr><td>Gols da equipe 1 nos 90 minutos:</td>" & _
               "<td><input type=""text"" name=""jog_qt_gol90_equ_1"" size=""3"" maxlength=""3""" & _
               "value=""" & str_qt_gol90_equ_1 & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Gols da equipe 2 nos 90 minutos:</td>" & _
               "<td><input type=""text"" name=""jog_qt_gol90_equ_2"" size=""3"" maxlength=""3""" & _
               "value=""" & str_qt_gol90_equ_2 & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Total de gols da equipe 1:</td>" & _
               "<td><input type=""text"" name=""jog_qt_gol_equ_1"" size=""3"" maxlength=""3""" & _
               "value=""" & str_qt_gol_equ_1 & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Total de gols da equipe 2</td>" & _
               "<td><input type=""text"" name=""jog_qt_gol_equ_2"" size=""3"" maxlength=""3""" & _
               "value=""" & str_qt_gol_equ_2 & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Cartões amarelos da equipe 1</td>" & _
               "<td><input type=""text"" name=""jog_qt_cartao_am_1"" size=""2"" maxlength=""2""" & _
               "value=""" & str_qt_cartao_am_1 & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Cartões amarelos da equipe 2</td>" & _
               "<td><input type=""text"" name=""jog_qt_cartao_am_2"" size=""2"" maxlength=""2""" & _
               "value=""" & str_qt_cartao_am_2 & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Cartões vermelhos da equipe 1</td>" & _
               "<td><input type=""text"" name=""jog_qt_cartao_vr_1"" size=""2"" maxlength=""2""" & _
               "value=""" & str_qt_cartao_vr_1 & """" & strAdm & "></td></tr>" & vbCrLf)
Response.Write("<tr><td>Cartões vermelhos da equipe 2</td>" & _
               "<td><input type=""text"" name=""jog_qt_cartao_vr_2"" size=""2"" maxlength=""2""" & _
               "value=""" & str_qt_cartao_vr_2 & """" & strAdm & "></td></tr><tr>" & vbCrLf)

' Função que monta combo de Campeonatos ========================================
strTitle = "Campeonato"
strKey   = "cam_cd_campeonato"
strName  = "cam_nm_campeonato"
strQr = "Select cam_cd_campeonato, cam_nm_campeonato From Campeonato Order by cam_nm_campeonato"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, strAdm)
'===============================================================================

Response.Write("</tr><tr>")

' Função que monta combo de Grupos =============================================
strTitle = "Grupo"
strKey   = "gru_cd_grupo"
strName  = "gru_nm_grupo"
strQr = "Select gru_cd_grupo, gru_nm_grupo From Grupo " & _
        "Where cam_cd_campeonato=" & str_cd_campeonato &  " Order by gru_nm_grupo"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_grupo, strAdm)
'===============================================================================

Response.Write("</tr><tr>")

' Função que monta combo de Fases ==============================================
strTitle = "Fase"
strKey   = "fas_cd_fase"
strName  = "fas_nm_fase"
strQr = "Select fas_cd_fase, fas_nm_fase From Fase " & _
        "Where cam_cd_campeonato=" & str_cd_campeonato & " Order by fas_nm_fase"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_fase, strAdm)
'===============================================================================

Response.Write("</tr><tr>")

' Função que monta combo de Locais =============================================
strTitle = "Local"
strKey   = "loc_cd_local"
strName  = "loc_nm_local"
strQr = "Select loc_cd_local, loc_nm_local From Local Order by loc_nm_local"

Call MountCombo(strTitle, strKey, strName, strQr, str_cd_local, strAdm)
'===============================================================================

Response.Write("</tr><tr><td align=""center"" colspan=""3"">" & _
               "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf)
Response.Write("</table>" & vbCrLf & "<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
Set jogRs = Nothing
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
       onClick="JavaScript:jogPesquisar(frmJogo);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Incluir" value="Incluir"
       onClick="JavaScript:jogIncluir(frmJogo);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Alterar" value="Alterar"
       onClick="JavaScript:jogAlterar(frmJogo);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Excluir" value="Excluir"
       onClick="JavaScript:jogExcluir(frmJogo);"<%=strAdm%>
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:jogLimpar(frmJogo);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>