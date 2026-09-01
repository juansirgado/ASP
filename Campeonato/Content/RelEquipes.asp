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
   Program      : RelEquipes.asp
   Description  : Relatório de equipes
   Version      : 1.0
   Date         : 24/06/2005
   Author       : Juan Sirgado y Antico
   Copyright(c) 2005 by JSyA Informática. All Rights Reserved.
   -------------------------------------------------------------
   Version      :
   Date         :
   Author       :
   -------------------------------------------------------------
-->

<head>
   <title>Rela&ccedil;&atilde;o de equipes</title>
   <link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
   <script language="JavaScript" src="../Script/RelEquipes.js"></script>
   <script language="JavaScript" src="../Script/Common.js"></script>
</head>

<body>
<form method="post" name="frmRelEquipes" action="RelEquipes.asp">
<center>
<br>
<h1>Rela&ccedil;&atilde;o de equipes</h1>

<%
' Função de definição das variáveis do Classificacao ===========================
'===============================================================================
Dim objCn, camRs, equRs, strQr, strCn, strOp, strMSG
Dim str_cd_campeonato, strTitle, strKey, strName, strClas

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

         Response.Write("<td>In&iacute;cio: "  & FormatDate(Trim(camRs("cam_dt_inicio")),  "%d/%m/%Y", 0) & "</td>" & _
                        "<td>T&eacute;rmino: " & FormatDate(Trim(camRs("cam_dt_termino")), "%d/%m/%Y", 0) & "</td>" & _
                        "</tr></table><br>")

' Função de pesquisa de Equipes ================================================
'===============================================================================
         strQr = "Select equ.equ_cd_equipe     As equ_cd_equipe, "     & _
                        "equ.equ_nm_equipe     As equ_nm_equipe, "     & _
                        "cla.cla_qt_vitoria    As cla_qt_vitoria, "    & _
       			"cla.cla_qt_empate     As cla_qt_empate, "     & _
       			"cla.cla_qt_derrota    As cla_qt_derrota, "    & _
       			"cla.cla_qt_gol_pro    As cla_qt_gol_pro, "    & _
       			"cla.cla_qt_gol_contra As cla_qt_gol_contra, " & _
       			"(cla.cla_qt_gol_pro - cla.cla_qt_gol_contra) As cla_qt_gol_saldo, " & _
       			"cla.cla_qt_cartao_am  As cla_qt_cartao_am, "  & _
       			"cla.cla_qt_cartao_vr  As cla_qt_cartao_vr, "  & _
       			"cla.cla_qt_pontos     As cla_qt_pontos "      & _
                   "From equipe        equ, " & _
                        "classificacao cla "  & _
                  "Where cla.cam_cd_campeonato=" & str_cd_campeonato & " " & _
                    "And equ.equ_cd_equipe=cla.equ_cd_equipe " & _
                  "Order by cla_qt_pontos Desc, cla_qt_vitoria Desc, cla_qt_gol_saldo Desc, equ_nm_equipe Asc"

         Set equRs = objCn.Execute(strQr)

         If Not equRs.EOF Then
            equRs.MoveFirst

' Função de geração da tela de Campeonatos ====================================
'===============================================================================
            Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table"">" & _
                           "<tr><td>Classifica&ccedil;&atilde;o</td><td>Equipe</td><td>Escudo</td><td>Vit&oacute;rias</td>" & _
                           "<td>Empates</td><td>Derrota</td><td>Gols Pro</td><td>Gols Contra</td>" & _
                           "<td>Gols Saldo</td><td>Amarelos</td><td>Vermelhos</td><td>Pontos</td></tr>" & vbCrLf)
            strClas = 0
            While Not equRs.EOF
               strClas = strClas + 1
               Response.Write("<tr><td align=""center"">" & strClas                          & "</td>" & _
                                  "<td align=""center"">" & Trim(equRs("equ_nm_equipe"))     & "</td>" & _
                                  "<td><img src=""../Image/Equipe/" & Trim(equRs("equ_cd_equipe")) & ".gif"" " & _
                                  "width=""44px"" height=""33px"" border=""1px""></td>"      & _
                                  "<td align=""center"">" & Trim(equRs("cla_qt_vitoria"))    & "</td>" & _
                                  "<td align=""center"">" & Trim(equRs("cla_qt_empate"))     & "</td>" & _
                                  "<td align=""center"">" & Trim(equRs("cla_qt_derrota"))    & "</td>" & _
                                  "<td align=""center"">" & Trim(equRs("cla_qt_gol_pro"))    & "</td>" & _
                                  "<td align=""center"">" & Trim(equRs("cla_qt_gol_contra")) & "</td>" & _
                                  "<td align=""center"">" & Trim(equRs("cla_qt_gol_saldo"))  & "</td>" & _
                                  "<td align=""center"">" & Trim(equRs("cla_qt_cartao_am"))  & "</td>" & _
                                  "<td align=""center"">" & Trim(equRs("cla_qt_cartao_vr"))  & "</td>" & _
                                  "<td align=""center"">" & Trim(equRs("cla_qt_pontos"))     & "</td></tr>"  & vbCrLf)
               equRs.MoveNext
            WEnd

            Response.Write("</table>" & vbCrLf)
         Else
            strMSG = "Equipes/Classifica&ccedil;&otilde;es n&atilde;o cadastrados"
         End If

         If Not IsNull(equRs) Then
            equRs.Close
         End If
         Set equRs = Nothing

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
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"
       onClick="JavaScript:equListar(frmRelEquipes);"></td><td>
<input type="button" class="button" name="Limpar" value="Limpar"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"
       onClick="JavaScript:equLimpar(frmRelEquipes);"></td><td>
<input type="button" class="button" name="Voltar" value="Voltar"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"
       onClick="JavaScript:history.back();">
</td></tr>
</table>
</center>
</form>
</body>
</html>