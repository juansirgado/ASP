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
   Program      : RelCampeonato.asp
   Description  : Relatório de campeonato
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
   <title>Rela&ccedil;&atilde;o do campeonato</title>
   <link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
   <script language="JavaScript" src="../Script/RelCampeonato.js"></script>
   <script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmRelCampeonato" action="RelCampeonato.asp">
<center>
<br>
<h1>Rela&ccedil;&atilde;o do campeonato</h1>

<%
' Função de definição das variáveis do Classificacao ===========================
'===============================================================================
Dim objCn, camRs, JogRs, strQr, strCn, strOp, strMSG
Dim str_cd_campeonato, strTitle, strKey, strName
Dim wrk_nm_fase, wrk_nm_grupo

strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

' Função que inicializa os dados da Tela =======================================
'===============================================================================
   strOp             = ""
   strMSG            = "Entre a op&ccedil;&atilde;o desejada"
   str_cd_campeonato = Trim(Session.Contents("Campeonato"))

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp             = Trim(Request.Form("Opcao"))
   strMSG            = ""
   str_cd_campeonato = Trim(Request.Form("cam_cd_campeonato"))

' Função de pesquisa de campeonato / jogos =====================================
'===============================================================================
   If strOp = "Listar" Then

      strQr = "SELECT cam_dt_inicio, cam_dt_termino " & _
              "FROM Campeonato " & _
              "WHERE cam_cd_campeonato=" & str_cd_campeonato

      Set camRs = objCn.Execute(strQr)
      If Not camRs.EOF Then

         Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>")

' Função que monta combo de Campeonatos ========================================
         strTitle = "Campeonato"
         strKey   = "cam_cd_campeonato"
         strName  = "cam_nm_campeonato"
         strQr = "Select cam_cd_campeonato, cam_nm_campeonato From Campeonato Order by cam_nm_campeonato"

         Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, "")
'===============================================================================

         Response.Write("<td><img src=""../Image/Campeonato/" & str_cd_campeonato & ".png"" " & _
                        "width=""40px"" height=""30px"" border=""1px""></td>"                & _
                        "<td>In&iacute;cio: "  & FormatDate(Trim(camRs("cam_dt_inicio")),  "%d/%m/%Y", 0) & "</td>" & _
                        "<td>T&eacute;rmino: " & FormatDate(Trim(camRs("cam_dt_termino")), "%d/%m/%Y", 0) & "</td>" & _
                        "</tr></table><br>")

' Função de pesquisa de Jogos ==================================================
'===============================================================================
         strQr = "Select fas.fas_nm_fase AS fas_nm_fase, "       & _
                        "gru.gru_nm_grupo AS gru_nm_grupo, "     & _
                        "jog.jog_dt_jogo AS jog_dt_jogo, "       & _
                        "eq1.equ_cd_equipe AS equ_cd_equipe_1, " & _
                        "eq2.equ_cd_equipe AS equ_cd_equipe_2, " & _
                        "eq1.equ_nm_equipe AS equ_nm_equipe_1, " & _
                        "eq2.equ_nm_equipe AS equ_nm_equipe_2, " & _
                        "jog.jog_qt_gol90_equ_1 AS jog_qt_gol90_equ_1, " & _
                        "jog.jog_qt_gol90_equ_2 AS jog_qt_gol90_equ_2, " & _
                        "jog.jog_qt_gol_equ_1 AS jog_qt_gol_equ_1, "     & _
                        "jog.jog_qt_gol_equ_2 AS jog_qt_gol_equ_2, "     & _
                        "jog.jog_qt_cartao_am_1 AS jog_qt_cartao_am_1, " & _
                        "jog.jog_qt_cartao_am_2 AS jog_qt_cartao_am_2, " & _
                        "jog.jog_qt_cartao_vr_1 AS jog_qt_cartao_vr_1, " & _
                        "jog.jog_qt_cartao_vr_2 AS jog_qt_cartao_vr_2  " & _
                   "From Jogo   jog, " & _
                        "Fase   fas, " & _
                        "Grupo  gru, " & _
                        "Equipe eq1, " & _
                        "Equipe eq2 "  & _
                  "Where jog.cam_cd_campeonato='" & str_cd_campeonato & "' " & _
                    "And fas.fas_cd_fase=jog.fas_cd_fase "   & _
                    "And gru.gru_cd_grupo=jog.gru_cd_grupo " & _
                    "And eq1.equ_cd_equipe=jog.equ_cd_equipe_1 " & _
                    "And eq2.equ_cd_equipe=jog.equ_cd_equipe_2 " & _
                  "Order by fas.fas_cd_fase Asc, gru.gru_cd_grupo Asc, jog.jog_dt_jogo Asc, jog.jog_cd_jogo Asc"

         Set jogRs = objCn.Execute(strQr)

         If Not jogRs.EOF Then
            jogRs.MoveFirst

' Função de geração da tela de Campeonatos ====================================
'===============================================================================
            Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>"  & _
                           "<td>Escudo</td><td>Equipe 1</td><td>Placar</td><td>Equipe 2</td><td>Escudo</td>" & _
                           "<td>Data</td><td>Placar 90</td><td>Amarelo</td><td>Vermelho</td></tr>" & vbCrLf)

            wrk_nm_fase  = ""
            wrk_nm_grupo = ""

            While Not jogRs.EOF

               If wrk_nm_fase  <> Trim(jogRs("fas_nm_fase")) Or wrk_nm_grupo <> Trim(jogRs("gru_nm_grupo")) Then
                  Response.Write("<tr><td colspan=""5"">Fase: " & Trim(jogRs("fas_nm_fase"))   & "</td>" & _
                                     "<td colspan=""4"">Grupo: " & Trim(jogRs("gru_nm_grupo")) & "</td></tr>")
                  wrk_nm_fase  = Trim(jogRs("fas_nm_fase"))
                  wrk_nm_grupo = Trim(jogRs("gru_nm_grupo"))
               End If

               Response.Write("<tr><td><img src=""../Image/Equipe/" & Trim(jogRs("equ_cd_equipe_1")) & ".gif"" " & _
                                  "width=""64px"" height=""48px"" border=""1px""></td>"              & _
                                  "<td align=""center"">" & Trim(jogRs("equ_nm_equipe_1"))    & "</td>" & _
                                  "<td align=""center"">" & Trim(jogRs("jog_qt_gol_equ_1"))   & " x "   & _
                                                            Trim(jogRs("jog_qt_gol_equ_2"))   & "</td>" & _
                                  "<td align=""center"">" & Trim(jogRs("equ_nm_equipe_2"))    & "</td>" & _
                                  "<td><img src=""../Image/Equipe/" & Trim(jogRs("equ_cd_equipe_2")) & ".gif"" " & _
                                  "width=""64px"" height=""48px"" border=""1px""></td>"              & _
                                  "<td align=""left"">"   & FormatDate(Trim(jogRs("jog_dt_jogo")), "%d/%m/%Y %H:%i:%s", 0) & "</td>" & _
                                  "<td align=""center"">" & Trim(jogRs("jog_qt_gol90_equ_1")) & " x "   & _
                                                            Trim(jogRs("jog_qt_gol90_equ_2")) & "</td>" & _
                                  "<td align=""center"">" & Trim(jogRs("jog_qt_cartao_am_1")) & " x "   & _
                                                            Trim(jogRs("jog_qt_cartao_am_2")) & "</td>" & _
                                  "<td align=""center"">" & Trim(jogRs("jog_qt_cartao_vr_1")) & " x "   & _
                                                            Trim(jogRs("jog_qt_cartao_vr_2")) & "</td>" & _
                                  "</tr>"  & vbCrLf)
               jogRs.MoveNext

            WEnd

            Response.Write("</table>" & vbCrLf)
         Else
            strMSG = "Jogos n&atilde;o cadastrados"
         End If

         If Not IsNull(jogRs) Then
            jogRs.Close
         End If
         Set jogRs = Nothing

      Else
         strMSG = "Campeonato n&atilde;o cadastrado"
         strOp  = ""
      End If

      If Not IsNull(camRs) Then
         camRs.Close
      End If
      Set camRs = Nothing
   End If
End If

If Not strOp = "Listar" Then

   Response.Write("<table cellpadding=""5"" class=""table""><tr>" & vbCrLf)

' Função que monta combo de Campeonatos ========================================
   strTitle = "Campeonato"
   strKey   = "cam_cd_campeonato"
   strName  = "cam_nm_campeonato"
   strQr    = "Select cam_cd_campeonato, cam_nm_campeonato From Campeonato Order by cam_nm_campeonato"

   Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, 0)
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
<input type="button" class="button" name="Listar" value="Listar"
       onClick="JavaScript:camListar(frmRelCampeonato);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:camLimpar(frmRelCampeonato);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Voltar" value="Voltar"
       onClick="JavaScript:history.back();"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);">
</td></tr>
</table>
</center>
</form>
</body>
</html>