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
   Program      : RelPalpites.asp
   Description  : Relatório de Palpites
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
   <title>Rela&ccedil;&atilde;o de palpites</title>
   <link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
   <script language="JavaScript" src="../Script/RelPalpites.js"></script>
   <script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmRelPalpites" action="RelPalpites.asp">
<center>
<br>
<h1>Rela&ccedil;&atilde;o de palpites</h1>

<%
' Função de definição das variáveis do Classificacao ===========================
'===============================================================================
Dim objCn, jogRs, apoRs, strQr, strCn, strOp, strMSG
Dim str_cd_campeonato, str_cd_jogo, strTitle, strKey, strName, strClas

strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

' Função que inicializa os dados da Tela =======================================
'===============================================================================
   strOp         = ""
   strMSG        = "Entre a op&ccedil;&atilde;o desejada"
   str_cd_campeonato = Trim(Session.Contents("Campeonato"))
   str_cd_jogo       = Trim(Session.Contents("Jogo"))

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp         = Trim(Request.Form("Opcao"))
   strMSG        = ""
   str_cd_campeonato = Trim(Request.Form("cam_cd_campeonato"))
   str_cd_jogo       = Trim(Request.Form("jog_cd_jogo"))

' Função de pesquisa de aposta / palpite =======================================
'===============================================================================
   If strOp = "Listar" Then

      strQr = "Select cam.cam_nm_campeonato, jog.jog_cd_jogo, jog.jog_dt_jogo, " & _
                     "jog.equ_cd_equipe_1, jog.equ_cd_equipe_2, " & _
                     "eq1.equ_nm_equipe As equ_nm_equipe_1, eq2.equ_nm_equipe As equ_nm_equipe_2, " & _
                     "jog.jog_qt_gol_equ_1, jog.jog_qt_gol_equ_2, " & _
                     "jog.jog_qt_gol90_equ_1, jog.jog_qt_gol90_equ_2, " & _
                     "jog.jog_qt_cartao_am_1, jog.jog_qt_cartao_am_2, " & _
                     "jog.jog_qt_cartao_vr_1, jog.jog_qt_cartao_vr_2 " & _
                "From Campeonato cam, Jogo jog, Equipe eq1, Equipe eq2 " & _
               "Where jog_cd_jogo=" & str_cd_jogo & " " & _
                 "And cam.cam_cd_campeonato=jog.cam_cd_campeonato " & _
                 "And eq1.equ_cd_equipe=jog.equ_cd_equipe_1 " & _
                 "And eq2.equ_cd_equipe=jog.equ_cd_equipe_2"

      Set jogRs = objCn.Execute(strQr)
      If Not jogRs.EOF Then

         Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>")

' Função que monta combo de Jogos ==============================================
         strTitle = "Jogo"
         strKey   = "jog_cd_jogo"
         strName  = "jog_nm_jogo"
         strQr = "Select jog.jog_cd_jogo, jog.jog_dt_jogo, " & _
                 "CONCAT(CAST(jog.jog_dt_jogo AS CHAR(20)), "" - "", eq1.equ_nm_equipe, "" x "", eq2.equ_nm_equipe) As jog_nm_jogo " & _
                  "From Jogo jog, Equipe eq1, Equipe eq2  " & _
                 "Where jog.cam_cd_campeonato=" & str_cd_campeonato & " " & _
                   "And eq1.equ_cd_equipe=jog.equ_cd_equipe_1 " & _
                   "And eq2.equ_cd_equipe=jog.equ_cd_equipe_2 Order by jog_dt_jogo"

         Call MountCombo(strTitle, strKey, strName, strQr, str_cd_jogo, "")
'===============================================================================

         Response.Write("<td colspan=""7"">Campeonato: "  & Trim(jogRs("cam_nm_campeonato")) & _
                        "</td></tr></table><br><table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>" & _
                        "<td>Escudo</td><td>Equipe 1</td><td>Placar</td><td>Equipe 2</td><td>Escudo</td>" & _
                        "<td>Data</td><td>Placar 90</td><td>Amarelo</td><td>Vermelho</td></tr>" & vbCrLf & _
                        "<tr><td><img src=""../Image/Equipe/" & Trim(jogRs("equ_cd_equipe_1")) & ".gif"" " & _
                        "width=""64px"" height=""48px"" border=""1px""></td>"       & _
                        "<td align=""center"">" & Trim(jogRs("equ_nm_equipe_1"))    & "</td>" & _
                        "<td align=""center"">" & Trim(jogRs("jog_qt_gol_equ_1"))   & " x "   & _
                                                  Trim(jogRs("jog_qt_gol_equ_2"))   & "</td>" & _
                        "<td align=""center"">" & Trim(jogRs("equ_nm_equipe_2"))    & "</td>" & _
                        "<td><img src=""../Image/Equipe/" & Trim(jogRs("equ_cd_equipe_2")) & ".gif"" " & _
                        "width=""64px"" height=""48px"" border=""1px""></td>"       & _
                        "<td align=""left"">"   & FormatDate(Trim(jogRs("jog_dt_jogo")), "%d/%m/%Y %H:%i:%s", 0) & "</td>" & _
                        "<td align=""center"">" & Trim(jogRs("jog_qt_gol90_equ_1")) & " x "   & _
                                                  Trim(jogRs("jog_qt_gol90_equ_2")) & "</td>" & _
                        "<td align=""center"">" & Trim(jogRs("jog_qt_cartao_am_1")) & " x "   & _
                                                  Trim(jogRs("jog_qt_cartao_am_2")) & "</td>" & _
                        "<td align=""center"">" & Trim(jogRs("jog_qt_cartao_vr_1")) & " x "   & _
                                                  Trim(jogRs("jog_qt_cartao_vr_2")) & "</td>" & _
                        "</tr></table><br>"  & vbCrLf)


' Função de pesquisa de Palpites ===============================================
'===============================================================================
         strQr = "Select pes.pes_cd_pessoa As pes_cd_pessoa, "  & _
                        "pes.pes_nm_pessoa As pes_nm_pessoa, "  & _
                        "apo.apo_nm_aposta As apo_nm_aposta, "  & _
                        "pal.pal_qt_pontos As pal_qt_pontos, "  & _
                        "pal.pal_qt_gol_equipe_1 As pal_qt_gol_equipe_1, " & _
                        "pal.pal_qt_gol_equipe_2 As pal_qt_gol_equipe_2  " & _
                   "From Pessoa pes, " & _
                        "Aposta apo, " & _
                        "Palpite pal " & _
                  "Where apo.cam_cd_campeonato=" & str_cd_campeonato & " " & _
                    "And pal.jog_cd_jogo=" & str_cd_jogo & " " & _
                    "And pes.pes_cd_pessoa=apo.pes_cd_pessoa " & _
                    "And apo.apo_cd_aposta = pal.apo_cd_aposta " & _
                  "Order by apo_qt_pontos Desc, pes_nm_pessoa Asc"

         Set apoRs = objCn.Execute(strQr)

         If Not apoRs.EOF Then
            apoRs.MoveFirst

' Função de geração da tela de Apostas =========================================
'===============================================================================
            Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>"    & _
                           "<td>Classifica&ccedil;&atilde;o</td><td>Pessoa</td><td>Foto</td><td>Aposta</td>" & _
                           "<td>Placar</td><td>Pontos</td></tr>" & vbCrLf)

            strClas = 0
            While Not apoRs.EOF

               strClas = strClas + 1
               Response.Write("<tr><td align=""left"">"   & strClas                       & "</td>" & _
                                  "<td align=""left"">"   & Trim(apoRs("pes_nm_pessoa"))  & "</td>" & _
                                  "<td><img src=""../Image/Pessoa/" & Trim(apoRs("pes_cd_pessoa")) & ".png"" " & _
                                  "width=""64px"" height=""64px"" border=""1px""></td>"  & _
                                  "<td align=""left"">"   & Trim(apoRs("apo_nm_aposta")) & "</td>" & _
                                  "<td align=""center"">" & Trim(apoRs("pal_qt_gol_equipe_1")) & " x " & _
                                                            Trim(apoRs("pal_qt_gol_equipe_2")) & "</td>" & _
                                  "<td align=""center"">" & Trim(apoRs("pal_qt_pontos")) & "</td></tr>" & vbCrLf)
               apoRs.MoveNext

            WEnd

            Response.Write("</table>" & vbCrLf)
         Else
            strMSG = "Palpites n&atilde;o cadastrados"
         End If

         If Not IsNull(apoRs) Then
            apoRs.Close
         End If
         Set apoRs = Nothing

      Else
         strMSG = "Jogo n&atilde;o cadastrado"
         strOp  = ""
      End If

      If Not IsNull(jogRs) Then
         jogRs.Close
      End If
      Set jogRs = Nothing
   End If
End If

If Not strOp = "Listar" Then

   Response.Write("<table cellpadding=""5"" class=""table""><tr>" & vbCrLf)


' Função que monta combo de Jogos ==============================================
         strTitle = "Jogo"
         strKey   = "jog_cd_jogo"
         strName  = "jog_nm_jogo"
         strQr = "Select jog.jog_cd_jogo, jog.jog_dt_jogo, " & _
                 "CONCAT(CAST(jog.jog_dt_jogo AS CHAR(20)), "" - "", eq1.equ_nm_equipe, "" x "", eq2.equ_nm_equipe) As jog_nm_jogo " & _
                  "From Jogo jog, Equipe eq1, Equipe eq2  " & _
                 "Where jog.cam_cd_campeonato=" & str_cd_campeonato & " " & _
                   "And eq1.equ_cd_equipe=jog.equ_cd_equipe_1 " & _
                   "And eq2.equ_cd_equipe=jog.equ_cd_equipe_2 Order by jog_dt_jogo"

         Call MountCombo(strTitle, strKey, strName, strQr, str_cd_jogo, "")
'===============================================================================

   Response.Write("</tr><tr><td align=""center"" colspan=""3"">" & _
                  "<font size=""+1"">" & strMSG & "</font></td></tr>" & vbCrLf & _
                  "</table>" & vbCrLf)

End If
Response.Write("<input type=""hidden"" name=""Opcao"" value=""" & strOp & """>"  & vbCrLf & _
               "<input type=""hidden"" name=""cam_cd_campeonato"" value=""" & str_cd_campeonato & """>")


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
       onClick="JavaScript:palListar(frmRelPalpites);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:palLimpar(frmRelPalpites);"
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