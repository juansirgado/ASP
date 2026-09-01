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
   Program      : ClaApostas.asp
   Description  : Relatório de Apostas
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
   <title>Classifica&ccedil;&atilde;o de apostas</title>
   <link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
   <script language="JavaScript" src="../Script/ClaApostas.js"></script>
   <script language="JavaScript" src="../Script/Button.js"></script>
</head>

<body>
<form method="post" name="frmClaApostas" action="ClaApostas.asp">
<center>
<br>
<h1>Classifica&ccedil;&atilde;o de apostas</h1>

<%
' Função de definição das variáveis do Classificacao ===========================
'===============================================================================
Dim objCn, camRs, apoRs, strQr, strCn, strOp, strMSG
Dim str_cd_campeonato, strTitle, strKey, strName, strClas

strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

' Função que inicializa os dados da Tela =======================================
'===============================================================================
   strOp         = ""
   strMSG        = "Entre a op&ccedil;&atilde;o desejada"
   str_cd_campeonato = Trim(Session.Contents("Campeonato"))

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp         = Trim(Request.Form("Opcao"))
   strMSG        = ""
   str_cd_campeonato = Trim(Request.Form("cam_cd_campeonato"))

' Função de pesquisa de aposta / palpite =======================================
'===============================================================================
   If strOp = "Listar" Then

      strQr = "Select cam_nm_campeonato, cam_dt_inicio, cam_dt_termino " & _
                "From Campeonato " & _
               "Where cam_cd_campeonato=" & str_cd_campeonato

      Set camRs = objCn.Execute(strQr)
      If Not camRs.EOF Then

         Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>")

' Função que monta combo de Apostas ============================================
         strTitle = "Campeonato"
         strKey   = "cam_cd_campeonato"
         strName  = "cam_nm_campeonato"
         strQr = "Select cam_cd_campeonato, cam_nm_campeonato From Campeonato Order by cam_nm_campeonato"

         Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, "")
'===============================================================================

         Response.Write("<td>In&iacute;cio: "  & FormatDate(Trim(camRs("cam_dt_inicio")),  "%d/%m/%Y", 0) & "</td>" & _
                        "<td>T&eacute;rmino: " & FormatDate(Trim(camRs("cam_dt_termino")), "%d/%m/%Y", 0) & "</td>" & _
                        "</tr></table><br>")

' Função de pesquisa de Palpites ===============================================
'===============================================================================
         strQr = "Select pes.pes_cd_pessoa  As pes_cd_pessoa, "  & _
                        "pes.pes_nm_pessoa  As pes_nm_pessoa, "  & _
                        "apo.apo_nm_aposta  As apo_nm_aposta, "  & _
                        "apo.apo_qt_correto As apo_qt_correto, " & _
                        "apo.apo_qt_parcial As apo_qt_parcial, " & _
                        "apo.apo_qt_errado  As apo_qt_errado, "  & _
                        "apo.apo_qt_pontos  As apo_qt_pontos "   & _
                   "From Pessoa pes, " & _
                        "Aposta apo "  & _
                  "Where apo.cam_cd_campeonato=" & str_cd_campeonato & " " & _
                    "And pes.pes_cd_pessoa=apo.pes_cd_pessoa " & _
                  "Order by apo_qt_pontos Desc, apo_qt_correto Desc, apo_qt_parcial Desc, apo_qt_errado Asc, pes_nm_pessoa Asc"

         'Response.Write(strQr)
         'strQr = "Select dummy From dual Where dummy = 'y'"
         Set apoRs = objCn.Execute(strQr)

         If Not apoRs.EOF Then
            apoRs.MoveFirst

' Função de geração da tela de Apostas =========================================
'===============================================================================
            Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>"    & _
                           "<td>Classifica&ccedil;&atilde;o</td><td>Pessoa</td><td>Foto</td><td>Aposta</td>" & _
                           "<td>Correto</td><td>Parcial</td><td>Errado</td>" & _
                           "<td>Pontos</td></tr>" & vbCrLf)

            strClas = 0
            While Not apoRs.EOF

               strClas = strClas + 1
               Response.Write("<tr><td align=""left"">"   & strClas                       & "</td>" & _
                                  "<td align=""left"">"   & Trim(apoRs("pes_nm_pessoa"))  & "</td>" & _
                                  "<td><img src=""../Image/Pessoa/" & Trim(apoRs("pes_cd_pessoa")) & ".png"" " & _
                                  "width=""64px"" height=""64px"" border=""1px""></td>"  & _
                                  "<td align=""left"">"   & Trim(apoRs("apo_nm_aposta"))  & "</td>" & _
                                  "<td align=""center"">" & Trim(apoRs("apo_qt_correto")) & "</td>" & _
                                  "<td align=""center"">" & Trim(apoRs("apo_qt_parcial")) & "</td>" & _
                                  "<td align=""center"">" & Trim(apoRs("apo_qt_errado"))  & "</td>" & _
                                  "<td align=""center"">" & Trim(apoRs("apo_qt_pontos"))  & "</td></tr>" & vbCrLf)
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
         strMSG = "Aposta n&atilde;o cadastrada"
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

' Função que monta combo de Apostas ============================================
   strTitle = "Campeonato"
   strKey   = "cam_cd_campeonato"
   strName  = "cam_nm_campeonato"
   strQr = "Select cam_cd_campeonato, cam_nm_campeonato From Campeonato Order by cam_nm_campeonato"

   Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, "")
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
       onClick="JavaScript:palListar(frmClaApostas);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:palLimpar(frmClaApostas);"
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