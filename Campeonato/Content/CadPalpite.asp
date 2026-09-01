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
   Program      : CadPalpite.asp
   Description  : Página do cadastro de palpites
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
<title>Cadastro de Palpites</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadPalpite.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmPalpite" action="CadPalpite.asp">
<center>
<br>
<h1>Cadastro de Palpites</h1>

<%
' Função de definição das variáveis do Palpite =================================
'===============================================================================
Dim objCn, apoRs, palRs, strQr, strCn, strOp, strMSG, strAdm, strJogo
Dim str_cd_palpite, str_qt_gol_equipe_1, str_qt_gol_equipe_2, str_qt_pontos
Dim str_cd_resultado, str_cd_jogo, str_cd_aposta, strTitle, strKey, strName
strAdm = VerifyLevel()

' Função inicia a conexão com o Banco de Dados =================================
'===============================================================================
strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

' Função que inicializa os dados da Tela =======================================
'===============================================================================
   strOp               = ""
   strMSG              = "Entre a op&ccedil;&atilde;o desejada"
   str_cd_aposta       = ""

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp              = Trim(Request.Form("Opcao"))
   strMSG             = ""
   str_cd_aposta      = Trim(Request.Form("apo_cd_aposta"))

' Função de pesquisa de apostas / palpites =====================================
'===============================================================================


   If strOp = "Pesquisar" Then

      strQr = "Select apo.apo_nm_aposta, cam.cam_nm_campeonato, cam.cam_dt_inicio, cam.cam_dt_termino " & _
                "From Aposta apo, Campeonato cam " & _
               "Where apo.apo_cd_aposta=" & str_cd_aposta & " " & _
                 "And cam.cam_cd_campeonato=apo.cam_cd_campeonato"

      Set apoRs = objCn.Execute(strQr)
      If Not apoRs.EOF Then

         Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>")

' Função que monta combo de Aposta =============================================
         strTitle = "Aposta"
         strKey   = "apo_cd_aposta"
         strName  = "apo_nm_aposta"
         strQr = "Select apo_cd_aposta, apo_nm_aposta From Aposta Order by apo_nm_aposta"

         Call MountCombo(strTitle, strKey, strName, strQr, str_cd_aposta, "")
'===============================================================================

         Response.Write("<td>Campeonato: "     & Trim(apoRs("cam_nm_campeonato"))                           & "</td>" & _
                        "<td>In&iacute;cio: "  & FormatDate(Trim(apoRs("cam_dt_inicio")),  "%d/%m/%Y", 0) & "</td>" & _
                        "<td>T&eacute;rmino: " & FormatDate(Trim(apoRs("cam_dt_termino")), "%d/%m/%Y", 0) & "</td>" & _
                        "</tr></table><br>")

' Função de pesquisa de Palpites ===============================================
'===============================================================================
        strQr = "Select sel.jog_cd_jogo     As jog_cd_jogo, " & _
                       "sel.fas_nm_fase     As fas_nm_fase, "  & _
                       "sel.gru_nm_grupo    As gru_nm_grupo, " & _
                       "sel.jog_dt_jogo     As jog_dt_jogo, "  & _
                       "sel.equ_cd_equipe_1 As equ_cd_equipe_1, " & _
                       "sel.equ_cd_equipe_2 As equ_cd_equipe_2, " & _
                       "sel.equ_nm_equipe_1 As equ_nm_equipe_1, " & _
                       "sel.equ_nm_equipe_2 As equ_nm_equipe_2, " & _
                       "COALESCE(pal.pal_qt_gol_equipe_1, 0) As pal_qt_gol_equipe_1, " & _
                       "COALESCE(pal.pal_qt_gol_equipe_2, 0) As pal_qt_gol_equipe_2, " & _
                       "COALESCE(pal.pal_cd_palpite, 0)      As pal_cd_palpite "       & _
                  "From (Select jog.jog_cd_jogo   As jog_cd_jogo, " & _
                               "fas.fas_cd_fase   As fas_cd_fase, "  & _
                               "fas.fas_nm_fase   As fas_nm_fase, " & _
                               "gru.gru_cd_grupo  As gru_cd_grupo, "  & _
                               "gru.gru_nm_grupo  As gru_nm_grupo, " & _
                               "jog.jog_dt_jogo   As jog_dt_jogo, "  & _
                               "eq1.equ_cd_equipe As equ_cd_equipe_1, " & _
                               "eq2.equ_cd_equipe As equ_cd_equipe_2, "  & _
                               "eq1.equ_nm_equipe As equ_nm_equipe_1, " & _
                               "eq2.equ_nm_equipe As equ_nm_equipe_2 "  & _
                          "From Jogo    jog, " & _
                               "Fase    fas, " & _
                               "Grupo   gru, " & _
                               "Equipe  eq1, " & _
                               "Equipe  eq2, " & _
                               "Aposta  apo  " & _
                         "Where apo.apo_cd_aposta=" & str_cd_aposta & " " & _
                           "And jog.cam_cd_campeonato=apo.cam_cd_campeonato    " & _
                           "And eq1.equ_cd_equipe=jog.equ_cd_equipe_1  " & _
                           "And eq2.equ_cd_equipe=jog.equ_cd_equipe_2 " & _
                           "And fas.fas_cd_fase=jog.fas_cd_fase  " & _
                           "And gru.gru_cd_grupo=jog.gru_cd_grupo) sel " & _
                "Left Join Palpite pal  " & _
                       "On " & str_cd_aposta & "=pal.apo_cd_aposta  " & _
                      "And sel.jog_cd_jogo=pal.jog_cd_jogo " & _
                 "Order By sel.fas_cd_fase, sel.gru_cd_grupo, sel.jog_dt_jogo "

         Set palRs = objCn.Execute(strQr)
         strJogo = 0
         If Not palRs.EOF Then
            palRs.MoveFirst
' Função de geração da tela de Palpites ========================================
'===============================================================================
            Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>"  & _
                           "<td>Escudo</td><td>Equipe 1</td><td colspan=""3"">Placar</td><td>Equipe 2</td><td>Escudo</td>" & _
                           "<td>Data</td><td>Fase</td><td>Grupo</td></tr>" & vbCrLf)

            While Not palRs.EOF
               strJogo = strJogo + 1

               Response.Write("<input type=""hidden"" name=""jog_cd_jogo_" & strJogo & """ value=""" & _
                              Trim(palRs("jog_cd_jogo")) & """>" & VbCrLf)
               Response.Write("<input type=""hidden"" name=""pal_cd_palpite_" & strJogo & """ value=""" & _
                              Trim(palRs("pal_cd_palpite")) & """>" & VbCrLf)
               Response.Write("<tr><td><img src=""../Image/Equipe/" & Trim(palRs("equ_cd_equipe_1")) & ".gif"" " & _
                                  "width=""32px"" height=""24px"" border=""1px""></td>" & _
                                  "<td align=""center"">" & Trim(palRs("equ_nm_equipe_1")) & "</td>")
               If Now() > (palRs("jog_dt_jogo")) Then
                  Response.Write("<input type=""hidden"" name=""pal_qt_gol_equipe_1_" & strJogo & """ size=""3"" maxlength=""3"" " & _
                                      "value=""" & Trim(palRs("pal_qt_gol_equipe_1")) & """><td>" & _
                                      Trim(palRs("pal_qt_gol_equipe_1")) & "</td><td> x </td>" & _
                                 "<input type=""hidden"" name=""pal_qt_gol_equipe_2_" & strJogo & """ size=""3"" maxlength=""3"" " & _
                                      "value=""" & Trim(palRs("pal_qt_gol_equipe_2")) & """><td>" & _
                                      Trim(palRs("pal_qt_gol_equipe_2")) & "</td>")
               Else
                  Response.Write("<td><input type=""text"" name=""pal_qt_gol_equipe_1_" & strJogo & """ size=""3"" maxlength=""3"" " & _
                                      "value=""" & Trim(palRs("pal_qt_gol_equipe_1")) & """></td><td> x </td>" & _
                                 "<td><input type=""text"" name=""pal_qt_gol_equipe_2_" & strJogo & """ size=""3"" maxlength=""3"" " & _
                                      "value=""" & Trim(palRs("pal_qt_gol_equipe_2")) & """></td>")
               End If
               Response.Write("<td align=""center"">" & Trim(palRs("equ_nm_equipe_2")) & "</td>" & _
                                  "<td><img src=""../Image/Equipe/" & Trim(palRs("equ_cd_equipe_2")) & ".gif"" " & _
                                  "width=""32px"" height=""24px"" border=""1px""></td>" & _
                                  "<td align=""left"">"   & FormatDate(Trim(palRs("jog_dt_jogo")), "%d/%m/%Y %H:%i:%s", 0) & "</td>" & _
                                  "<td align=""left"">"   & Trim(palRs("fas_nm_fase"))  & "</td>" & _
                                  "<td align=""left"">"   & Trim(palRs("gru_nm_grupo")) & "</td></tr>" & vbCrLf)

               palRs.MoveNext
            WEnd
         End If
         Response.Write("</table>" & vbCrLf)
         Response.Write("<input type=""hidden"" name=""cam_qt_jogos"" value=""" & strJogo & """>")

         strMSG = "Palpite pesquisado"
' Função encerra a conexão com o Banco de Dados Palpite ========================
'===============================================================================
         If (Not IsNull(palRs)) Then
            palRs.Close
         End If
         Set palRs = Nothing

      End If
      strMSG = "Campeonato n&atilde;o cadastrado"
' Função encerra a conexão com o Banco de Dados Aposta =========================
'===============================================================================
      If (Not IsNull(apoRs)) Then
         apoRs.Close
      End If
      Set apoRs = Nothing

   End If

End If

' Função de altualização de Palpites ===========================================
'===============================================================================
If strOp = "Atualizar" Then

   For strJogo = 1 To Trim(Request.Form("cam_qt_jogos"))
       str_cd_palpite = Trim(Request.Form("pal_cd_palpite_" & strJogo))
       If str_cd_palpite = "0" Then
          strQr = "Insert into Palpite (pal_cd_palpite, pal_qt_gol_equipe_1, pal_qt_gol_equipe_2, " & _
                  "pal_qt_pontos, res_cd_resultado, jog_cd_jogo, apo_cd_aposta) "                   & _
                  "Values (sequence_nextval('sq_cd_palpite'), " & _
                   Trim(Request.Form("pal_qt_gol_equipe_1_" & strJogo)) & ", " & _
                   Trim(Request.Form("pal_qt_gol_equipe_2_" & strJogo)) & ", " & _
                  "0"                               & ", " & _
                  "0"                               & ", " & _
                   Trim(Request.Form("jog_cd_jogo_" & strJogo)) & ", " & _
                   Trim(Request.Form("apo_cd_aposta")) & ")"
           Set palRs = objCn.Execute(strQr)
       Else If Not str_cd_palpite = "0" Then
               strQr = "Update Palpite Set "   & _
                       "pal_qt_gol_equipe_1="  & Trim(Request.Form("pal_qt_gol_equipe_1_" & strJogo)) & ", " & _
                       "pal_qt_gol_equipe_2="  & Trim(Request.Form("pal_qt_gol_equipe_2_" & strJogo)) & ", " & _
                       "res_cd_resultado="     & "0 "                      & _
                       "Where pal_cd_palpite=" & str_cd_palpite
               Set palRs = objCn.Execute(strQr)
            End If
       End If
   Next
   strMSG = "Palpite atualizado"

End If

' Função de geração da tela de Classificacao ===================================
'===============================================================================
If Not strOp = "Pesquisar" Then

   Response.Write("<table cellpadding=""5"" class=""table""><tr>" & vbCrLf)

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
   Response.Write("</tr><tr><td align=""center"" colspan=""3"">" & _
                  "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf & _
                  "</table>" & vbCrLf)
End If
Response.Write("<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>")

' Função termina a conexão com o Banco de Dados ================================
'===============================================================================
If Not IsNull(objCn) Then
   objCn.Close
End If
Set objCn = Nothing
%>

<br>
<table cellpadding="1" cellspacing="20">
<tr><td>
<input type="button" class="button" name="Pesquisar" value="Pesquisar"
       onClick="JavaScript:palPesquisar(frmPalpite);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<%If strOp = "Pesquisar" Then%>
     <input type="button" class="button" name="Atualizar" value="Atualizar"
            onClick="JavaScript:palAtualizar(frmPalpite);"
            onMouseOut="javascript:styleButton(this,0);"
            onMouseOver="javascript:styleButton(this,1);"></td><td>
<%End If%>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:palLimpar(frmPalpite);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>