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
   Program      : CadCamEqu.asp
   Description  : Página do cadastro de campeonatos/equipes
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
<title>Cadastro de Equipes</title>
<link rel="stylesheet" href="../Style/Aplicacao.css" type="text/css">
<script language="JavaScript" src="../Script/CadCamEqu.js"></script>
<script language="JavaScript" src="../Script/Button.js"></script>
<script language="JavaScript" src="../Script/SelectMultiple.js"></script>
</head>

<body onload="JavaScript:if (document.frmCamEqu.Opcao.value == 'Pesquisar')
                         {
                            resetLists(document.frmCamEqu.equ_cd_equipe_1,
                                       document.frmCamEqu.equ_cd_equipe_2);
                         }">
<form method="post" name="frmCamEqu" action="CadCamEqu.asp">
<center>
<br>
<h1>Cadastro de Campeonato x Equipes</h1>

<%
' Função de definição das variáveis do Equipe ==================================
'===============================================================================
Dim objCn, camRs, equRs, rceRs, strQr, strCn, strOp, strMSG, strAdm
Dim str_cd_equipe, str_cd_campeonato, strTitle, strKey, strName
Dim str_cd_equipes, arr_cd_equipes, int_qt_equipes, int_nu_contador
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
   str_cd_campeonato   = Trim(Session.Contents("Campeonato"))

Else

' Função que pesquisa os dados da Tela =========================================
'===============================================================================
   strOp              = Trim(Request.Form("Opcao"))
   strMSG             = ""
   str_cd_campeonato  = Trim(Request.Form("cam_cd_campeonato"))

' Função de pesquisa de campeonatos / equipes ==================================
'===============================================================================


   If strOp = "Pesquisar" Then

      strQr = "Select cam_dt_inicio, cam_dt_termino " & _
                "From Campeonato " & _
               "Where cam_cd_campeonato=" & str_cd_campeonato

      Set camRs = objCn.Execute(strQr)
      If Not camRs.EOF Then

         Response.Write("<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>")

' Função que monta combo de Campeonato =========================================
         strTitle = "Campeonato"
         strKey   = "cam_cd_campeonato"
         strName  = "cam_nm_campeonato"
         strQr = "Select cam_cd_campeonato, cam_nm_campeonato From Campeonato Order by cam_nm_campeonato"

         Call MountCombo(strTitle, strKey, strName, strQr, str_cd_campeonato, "")
'===============================================================================

         Response.Write("<td>In&iacute;cio: "  & FormatDate(Trim(camRs("cam_dt_inicio")),  "%d/%m/%Y", 0) & "</td>" & _
                        "<td>T&eacute;rmino: " & FormatDate(Trim(camRs("cam_dt_termino")), "%d/%m/%Y", 0) & "</td>" & _
                        "</tr></table><br>" & _
                        "<table cellpadding=""5"" cellspacing=""5"" class=""table""><tr>" & _
                        "<td align=""center"">Equipes Cadastradas</td><td align=""center"">Mover</td>" & _
                        "<td align=""center"">Equipes no Campeonato</td></tr><tr>"  & vbCrLf)

' Função de pesquisa de Equipes Cadastradas que não estão no Campeonato ========
'===============================================================================
         Response.Write("<td><select name=""equ_cd_equipe_1"" size=""15"" multiple>" & vbCrLf & _
                        "<option value=""0"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; " & _
                                            "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "& _
                                            "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </option>" & vbCrLf)

         strQr = "Select equ.equ_cd_equipe, equ.equ_nm_equipe " & _
                   "From Equipe             equ "              & _
                  "Where equ.equ_cd_equipe Not In (Select distinct equ_cd_equipe " & _
                                                    "From CamEqu rce "  & _
                                                   "Where cam_cd_campeonato=" & str_cd_campeonato & ") " & _
                  "Order by equ.equ_nm_equipe"

         Set equRs = objCn.Execute(strQr)
         If Not equRs.EOF Then
            equRs.MoveFirst
' Função de geração da tela de Equipes =========================================
'===============================================================================
            While Not equRs.EOF
               Response.Write("<option value=""" & Trim(equRs("equ_cd_equipe")) & """>" & Trim(equRs("equ_nm_equipe")) & "</option>" & vbCrLf)
               equRs.MoveNext
            WEnd
         End If
         Response.Write("</select></td>" & vbCrLf)
         Response.Write("<td align=""center"">" & _
                        "<input type=""button"" class=""button"" name=""IncluiSel"" value=""&nbsp;&nbsp;&gt;&nbsp;&nbsp;"" " & _
	                       "onClick='JavaScript:moveItens(frmCamEqu.equ_cd_equipe_1,"                   & _
                                                             "frmCamEqu.equ_cd_equipe_2, false);'><br><br>" & _
                        "<input type=""button"" class=""button"" name=""IncluiTudo"" value=""&nbsp;&gt;&nbsp;&gt;&nbsp;"" "  & _
	                       "onClick='JavaScript:moveItens(frmCamEqu.equ_cd_equipe_1,"                   & _
                                                             "frmCamEqu.equ_cd_equipe_2, true);'><br><br>"  & _
                        "<input type=""button"" class=""button"" name=""ExcluiTudo"" value=""&nbsp;&lt;&nbsp;&lt;&nbsp;"" "  & _
	                       "onClick='JavaScript:moveItens(frmCamEqu.equ_cd_equipe_2,"                   & _
                                                             "frmCamEqu.equ_cd_equipe_1, true);'><br><br>"  & _
                        "<input type=""button"" class=""button"" name=""ExcluiSel"" value=""&nbsp;&nbsp;&lt;&nbsp;&nbsp;"" " & _
	                       "onClick='Javascript:moveItens(frmCamEqu.equ_cd_equipe_2,"                   & _
                                                             "frmCamEqu.equ_cd_equipe_1, false);'></td>" & vbCrLf)

' Função de pesquisa de Equipes Cadastradas que estão no Campeonato ============
'===============================================================================
         Response.Write("<td><select name=""equ_cd_equipe_2"" size=""15"" multiple>" & vbCrLf & _
                        "<option value=""0"">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; " & _
                                            "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "& _
                                            "&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </option>" & vbCrLf)

         strQr = "Select equ.equ_cd_equipe, equ.equ_nm_equipe " & _
                   "From Equipe equ, "                          & _
                        "CamEqu rce  "                          & _
                  "Where rce.cam_cd_campeonato=" & str_cd_campeonato & " " & _
                    "And equ.equ_cd_equipe=rce.equ_cd_equipe "  & _
                  "Order by equ.equ_nm_equipe"

         Set equRs = objCn.Execute(strQr)
         If Not equRs.EOF Then
            equRs.MoveFirst
' Função de geração da tela de Equipes =========================================
'===============================================================================
            While Not equRs.EOF
               Response.Write("<option value=""" & Trim(equRs("equ_cd_equipe")) & """>" & Trim(equRs("equ_nm_equipe")) & "</option>" & vbCrLf)
               equRs.MoveNext
            WEnd
         End If
         Response.Write("</select></td>" & vbCrLf)

         strMSG = "Campeonato x equipes pesquisado"
' Função encerra a conexão com o Banco de Dados Equipe =========================
'===============================================================================
         If (Not IsNull(equRs)) Then
            equRs.Close
         End If
         Set equRs = Nothing

      End If
      strMSG = "Campeonato n&atilde;o cadastrado"
' Função encerra a conexão com o Banco de Dados Campeonato =====================
'===============================================================================
      If (Not IsNull(camRs)) Then
         camRs.Close
      End If
      Set camRs = Nothing

   End If

End If

' Função de altualização de Equipes ============================================
'===============================================================================
If strOp = "Atualizar" Then


  str_cd_campeonato = Request.Form("cam_cd_campeonato")
  str_cd_equipes    = Request.Form("equ_cd_equipe_2")
  arr_cd_equipes    = Split(str_cd_equipes, ",", -1, 1)

  strQr = "Delete From CamEqu Where cam_cd_campeonato=" & str_cd_campeonato
  Set rceRs = objCn.Execute(strQr)
  int_qt_equipes = ubound(arr_cd_equipes)

  For int_nu_contador = 0 to int_qt_equipes

      strQr = "Insert into CamEqu (rce_cd_cam_equ, cam_cd_campeonato, equ_cd_equipe) " & _
              "Values (sequence_nextval('sq_cd_cam_equ'), " & _
               str_cd_campeonato & ", " & _
               Trim(arr_cd_equipes(int_nu_contador))  & ")"
      Set rceRs = objCn.Execute(strQr)

   Next

   Set rceRs = Nothing
   strMSG = "Campeonato x equipes atualizado"

End If

' Função de geração da tela de Classificacao ===================================
'===============================================================================
If Not strOp = "Pesquisar" Then

   Response.Write("<table cellpadding=""5"" class=""table""><tr>" & vbCrLf)

' Função que monta combo de Campeonato =========================================
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
<input type="button" class="button" name="Pesquisar" value="Pesquisar"
       onClick="JavaScript:rcePesquisar(frmCamEqu);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td><td>
<%If strOp = "Pesquisar" Then%>
     <input type="button" class="button" name="Atualizar" value="Atualizar"
            onClick="JavaScript:rceAtualizar(frmCamEqu);"<%=strAdm%>
            onMouseOut="javascript:styleButton(this,0);"
            onMouseOver="javascript:styleButton(this,1);"></td><td>
<%End If%>
<input type="button" class="button" name="Limpar" value="Limpar"
       onClick="JavaScript:rceLimpar(frmCamEqu);"
       onMouseOut="javascript:styleButton(this,0);"
       onMouseOver="javascript:styleButton(this,1);"></td></tr>
</table>
</center>
</form>
</body>
</html>