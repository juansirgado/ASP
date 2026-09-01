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
   Program      : RelAposta.asp
   Description  : Relatório de apostas
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
   <title>Rela&ccedil;&atilde;o do aposta</title>
   <link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
   <script language="JavaScript" src="../Script/RelAposta.js"></script>
   <script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmRelAposta" action="RelAposta.asp">
<center>
<br>
<h1>Rela&ccedil;&atilde;o do aposta</h1>

<%
' Função de definição das variáveis do Classificacao ===========================
'===============================================================================
Dim objCn, apoRs, palRs, strQr, strCn, strOp, strMSG
Dim str_cd_aposta, strTitle, strKey, strName
Dim wrk_nm_fase, wrk_nm_grupo

strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

' Função que inicializa os dados da Tela =======================================
'===============================================================================
   strOp         = ""
   strMSG        = "Entre a op&ccedil;&atilde;o desejada"
   str_cd_aposta = Trim(Session.Contents("Aposta"))

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp         = Trim(Request.Form("Opcao"))
   strMSG        = ""
   str_cd_aposta = Trim(Request.Form("apo_cd_aposta"))

' Função de pesquisa de aposta / palpite =======================================
'===============================================================================
   If strOp = "Listar" Then

      strQr = "Select cam.cam_nm_campeonato, apo.apo_qt_pontos, " & _
                     "apo.apo_qt_errado, apo.apo_qt_parcial, apo.apo_qt_correto "& _
                "From Aposta apo, Campeonato cam " & _
               "Where apo.apo_cd_aposta=" & str_cd_aposta & " " & _
                 "And cam.cam_cd_campeonato=apo.cam_cd_campeonato"

      Set apoRs = objCn.Execute(strQr)
      If Not apoRs.EOF Then

         Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>")

' Função que monta combo de Apostas ============================================
         strTitle = "Aposta"
         strKey   = "apo_cd_aposta"
         strName  = "apo_nm_aposta"
         strQr = "Select apo_cd_aposta, apo_nm_aposta From Aposta Order by apo_nm_aposta"

         Call MountCombo(strTitle, strKey, strName, strQr, str_cd_aposta, "")
'===============================================================================

         Response.Write("<td>Campeonato: "    & Trim(apoRs("cam_nm_campeonato")) & "</td>" & _
                        "</tr></table><br><table cellpadding=""5"" cellspacing=""5"" class=""table""><tr><tr>" & _
                        "<td>Correto</td><td>Parcial</td><td>Errado</td><td>Pontos</td></tr><tr>" & _
                        "<td>" & Trim(apoRs("apo_qt_correto")) & "</td>" & _
                        "<td>" & Trim(apoRs("apo_qt_parcial")) & "</td>" & _
                        "<td>" & Trim(apoRs("apo_qt_errado"))  & "</td>" & _
                        "<td>" & Trim(apoRs("apo_qt_pontos"))  & "</td>" & _
                        "</tr></table><br>")

' Função de pesquisa de Palpites ===============================================
'===============================================================================
         strQr = "Select sel.fas_nm_fase     AS fas_nm_fase, "     & _
                        "sel.gru_nm_grupo    AS gru_nm_grupo, "    & _
                        "sel.jog_dt_jogo     As jog_dt_jogo, "     & _
                        "sel.equ_nm_equipe_1 As equ_nm_equipe_1, " & _
                        "sel.equ_nm_equipe_2 As equ_nm_equipe_2, " & _
                        "sel.equ_cd_equipe_1 As equ_cd_equipe_1, " & _
                        "sel.equ_cd_equipe_2 As equ_cd_equipe_2, " & _
                        "sel.jog_qt_gol90_equ_1 As jog_qt_gol90_equ_1, " & _
                        "sel.jog_qt_gol90_equ_2 As jog_qt_gol90_equ_2, " & _
                        "sel.jog_qt_gol_equ_1   As jog_qt_gol_equ_1, "   & _
                        "sel.jog_qt_gol_equ_2   As jog_qt_gol_equ_2, "   & _
                        "sel.pal_qt_gol_equipe_1 As pal_qt_gol_equipe_1, " & _
                        "sel.pal_qt_gol_equipe_2 As pal_qt_gol_equipe_2, " & _
                        "sel.pal_cd_palpite   As pal_cd_palpite, "      & _
                        "res.res_nm_resultado As res_nm_resultado, "    & _
                        "sel.pal_qt_pontos    As pal_qt_pontos "        & _
                   "From " & _
                        "(Select slt.fas_cd_fase  As fas_cd_fase, "   & _
                                "slt.fas_nm_fase  As fas_nm_fase, "   & _
                                "slt.gru_cd_grupo  As gru_cd_grupo, " & _
                                "slt.gru_nm_grupo  As gru_nm_grupo, " & _
                                "slt.jog_dt_jogo   As jog_dt_jogo, "  & _
                                "slt.equ_nm_equipe_1 As equ_nm_equipe_1, " & _
                                "slt.equ_nm_equipe_2 As equ_nm_equipe_2, " & _
                                "slt.equ_cd_equipe_1 As equ_cd_equipe_1, " & _
                                "slt.equ_cd_equipe_2 As equ_cd_equipe_2, " & _
                                "slt.jog_qt_gol90_equ_1 As jog_qt_gol90_equ_1, " & _
                                "slt.jog_qt_gol90_equ_2 As jog_qt_gol90_equ_2, " & _
                                "slt.jog_qt_gol_equ_1   As jog_qt_gol_equ_1, " & _
                                "slt.jog_qt_gol_equ_2   As jog_qt_gol_equ_2, " & _
                                "COALESCE(pal.pal_qt_gol_equipe_1, 0) As pal_qt_gol_equipe_1, " & _
                                "COALESCE(pal.pal_qt_gol_equipe_2, 0) As pal_qt_gol_equipe_2, " & _
                                "COALESCE(pal.pal_cd_palpite, 0)      As pal_cd_palpite, "      & _
                                "COALESCE(pal.res_cd_resultado, 0)    As res_cd_resultado, "    & _
                                "COALESCE(pal.pal_qt_pontos, 0)       As pal_qt_pontos "        & _
                           "From " & _
                                "(Select jog.jog_cd_jogo As jog_cd_jogo, "   & _
                                        "fas.fas_cd_fase As fas_cd_fase, "   & _
                                        "fas.fas_nm_fase As fas_nm_fase, "   & _
                                        "gru.gru_cd_grupo As gru_cd_grupo, " & _
                                        "gru.gru_nm_grupo As gru_nm_grupo, " & _
                                        "jog.jog_dt_jogo As jog_dt_jogo, "   & _
                                        "eq1.equ_nm_equipe As equ_nm_equipe_1, " & _
                                        "eq2.equ_nm_equipe As equ_nm_equipe_2, " & _
                                        "eq1.equ_cd_equipe As equ_cd_equipe_1, " & _
                                        "eq2.equ_cd_equipe As equ_cd_equipe_2, " & _
                                        "jog.jog_qt_gol90_equ_1 As jog_qt_gol90_equ_1, " & _
                                        "jog.jog_qt_gol90_equ_2 As jog_qt_gol90_equ_2, " & _
                                        "jog.jog_qt_gol_equ_1 As jog_qt_gol_equ_1, "     & _
                                        "jog.jog_qt_gol_equ_2 As jog_qt_gol_equ_2 "      & _
                                   "From Jogo      jog, " & _
                                        "Fase      fas, " & _
                                        "Grupo     gru, " & _
                                        "Equipe    eq1, " & _
                                        "Equipe    eq2, " & _
                                        "Aposta    apo "  & _
                                  "Where apo.apo_cd_aposta=" & str_cd_aposta & " "     & _
                                    "And jog.cam_cd_campeonato=apo.cam_cd_campeonato " & _
                                    "And eq1.equ_cd_equipe=jog.equ_cd_equipe_1 "       & _
                                    "And eq2.equ_cd_equipe=jog.equ_cd_equipe_2 "       & _
                                    "And fas.fas_cd_fase=jog.fas_cd_fase "             & _
                                    "And gru.gru_cd_grupo=jog.gru_cd_grupo) slt "      & _
                      "Left Join Palpite pal  " & _
                             "On " & str_cd_aposta & "=pal.apo_cd_aposta " & _
                            "And slt.jog_cd_jogo=pal.jog_cd_jogo) sel, "   & _
                        "Resultado res " & _
                  "Where res.res_cd_resultado=sel.res_cd_resultado "       & _
                  "Order by sel.fas_cd_fase, sel.gru_cd_grupo, sel.jog_dt_jogo, sel.pal_cd_palpite"

         Set palRs = objCn.Execute(strQr)

         If Not palRs.EOF Then
            palRs.MoveFirst

' Função de geração da tela de Apostas =========================================
'===============================================================================
            Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr><td>Escudo</td>"  & _
                           "<td>Equipe 1</td><td>Placar</td><td>Equipe 2</td><td>Escudo</td><td>Data</td>" & _
                           "<td>Placar 90</td><td>Palpite</td><td>Resultado</td><td>Pontos</td></tr>" & vbCrLf)

            wrk_nm_fase  = ""
            wrk_nm_grupo = ""

            While Not palRs.EOF

               If wrk_nm_fase  <> Trim(palRs("fas_nm_fase")) Or wrk_nm_grupo <> Trim(palRs("gru_nm_grupo")) Then
                  Response.Write("<tr><td colspan=""5"">Fase: " & Trim(palRs("fas_nm_fase"))   & "</td>" & _
                                     "<td colspan=""6"">Grupo: " & Trim(palRs("gru_nm_grupo")) & "</td></tr>")
                  wrk_nm_fase  = Trim(palRs("fas_nm_fase"))
                  wrk_nm_grupo = Trim(palRs("gru_nm_grupo"))
               End If

               Response.Write("<tr><td><img src=""../Image/Equipe/" & Trim(palRs("equ_cd_equipe_1")) & ".gif"" " & _
                                  "width=""64px"" height=""48px"" border=""1px""></td>"              & _
                                  "<td align=""center"">" & Trim(palRs("equ_nm_equipe_1"))     & "</td>" & _
                                  "<td align=""center"">" & Trim(palRs("jog_qt_gol_equ_1"))    & " x "   & _
                                                            Trim(palRs("jog_qt_gol_equ_2"))    & "</td>" & _
                                  "<td align=""center"">" & Trim(palRs("equ_nm_equipe_2"))     & "</td>" & _
                                  "<td><img src=""../Image/Equipe/" & Trim(palRs("equ_cd_equipe_2")) & ".gif"" " & _
                                  "width=""64px"" height=""48px"" border=""1px""></td>"              & _
                                  "<td align=""left"">"   & FormatDate(Trim(palRs("jog_dt_jogo")), "%d/%m/%Y %H:%i:%s", 0) & "</td>" & _
                                  "<td align=""center"">" & Trim(palRs("jog_qt_gol90_equ_1"))  & " x "   & _
                                                            Trim(palRs("jog_qt_gol90_equ_2"))  & "</td>" & _
                                  "<td align=""center"">" & Trim(palRs("pal_qt_gol_equipe_1")) & " x "   & _
                                                            Trim(palRs("pal_qt_gol_equipe_2")) & "</td>" & _
                                  "<td align=""center"">" & Trim(palRs("res_nm_resultado"))    & "</td>" & _
                                  "<td align=""center"">" & Trim(palRs("pal_qt_pontos"))       & "</td></tr>" & vbCrLf)
               palRs.MoveNext

            WEnd

            Response.Write("</table>" & vbCrLf)
         Else
            strMSG = "Palpites n&atilde;o cadastrados"
         End If

         If Not IsNull(palRs) Then
            palRs.Close
         End If
         Set palRs = Nothing

      Else
         strMSG = "Aposta n&atilde;o cadastrada"
         strOp  = ""
      End If

      If Not IsNull(apoRs) Then
         apoRs.Close
      End If
      Set apoRs = Nothing
   End If
End If

If Not strOp = "Listar" Then

   Response.Write("<table cellpadding=""5"" class=""table""><tr>" & vbCrLf)

' Função que monta combo de Apostas ============================================
   strTitle = "Aposta"
   strKey   = "apo_cd_aposta"
   strName  = "apo_nm_aposta"
   strQr    = "Select apo_cd_aposta, apo_nm_aposta From Aposta Order by apo_nm_aposta"

   Call MountCombo(strTitle, strKey, strName, strQr, str_cd_aposta, 0)
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
       onClick="JavaScript:apoListar(frmRelAposta);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:apoLimpar(frmRelAposta);"
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