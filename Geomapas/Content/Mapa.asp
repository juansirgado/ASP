<% @Language=VBScript %>
<% Option Explicit %>

<html>

<!--
   -------------------------------------------------------------
   Instalação : JSA do Brasil - E-Solutions
   Descrição  : Página Mapa do Guia GeoMapas
   Autor      : Juan Sirgado y Antico
   Data       : 29/06/2001
   Copyright(c) 2000 by JSA do Brasil, Inc. All Rights Reserved.
   -------------------------------------------------------------
   Alteração  :
   Autor      :
   Data       :
   -------------------------------------------------------------
-->

<head>
   <title>Geomapas - Guia São Paulo 2001</title>
   <link rel="stylesheet" href="../Style/Mapa.css" type="text/css">
   <script language="JavaScript" src="../Script/Mapa.js"></script>
</head>

<body class="fundo">
<center>
<br>

<%
Dim cnnObj, rstMap, strQuery, strConnect, strType, strKey
Dim strPage, strLetter, strFrameX, strframeY, strLines, strColumns, intLoopLine, intLoopColumn
Dim intLine, intColumn, intLineBegin, intLineEnd, intColumnBegin, intColumnEnd

strConnect = "Driver={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(".\..") & "\Data\Mapa.mdb;"
Set cnnObj = Server.CreateObject("ADODB.Connection")
cnnObj.Open strConnect

If Request.ServerVariables("CONTENT_LENGTH") = 0 Then

   strPage = Trim(Request.QueryString("Page"))
   strLetter = Trim(Request.QueryString("Letter"))
   strLines = "5"
   strColumns = "11"
   strFrameX = "050083"
   strFrameY = "050083"
   strType = ""
   strKey = ""

Else

   strPage = Trim(Request.Form("hidPage"))
   strLetter = Trim(Request.Form("hidLetter"))
   strLines = Trim(Request.Form("selLines"))
   strColumns = Trim(Request.Form("selColumns"))
   strFrameX = Trim(Request.Form("selFrameX"))
   strFrameY = Trim(Request.Form("selFrameY"))
   strType = Trim(Request.Form("radType"))
   strKey = Trim(Request.Form("texKey"))

End If

strQuery = "SELECT line, column " & _
           "FROM map " & _
           "WHERE page = " & strPage & " AND " & _
                 "letter = '" & strLetter & "' "
Set rstMap = cnnObj.Execute(strQuery)

If Not rstMap.EOF Then
   intLine = CInt(Trim(rstMap("line")))
   intColumn = CInt(Trim(rstMap("column")))
Else
   intLine = CInt("1")
   intColumn = CInt("1")
End If

intLineBegin = intLine - Int(CInt(strLines) / 2)
If intLineBegin < 1 Then
   intLineBegin = 1
End If
intLineEnd = intLineBegin + CInt(strLines) - 1
If intLineEnd > 45 Then
   intLineEnd = 45
   intLineBegin = intLineEnd - CInt(strLines) + 1
End If

intColumnBegin = intColumn - Int(CInt(strColumns) / 2)
If intColumnBegin < 1 Then
   intColumnBegin = 1
End If
intColumnEnd = intColumnBegin + CInt(strColumns) - 1
If intColumnEnd > 80 Then
   intColumnEnd = 80
   intColumnBegin = intColumnEnd - CInt(strColumns) + 1
End If

strQuery = "SELECT page, letter " & _
           "FROM map " & _
           "WHERE line >= " & intLineBegin & "AND " & _
                 "line <= " & intLineEnd & " AND " & _
                 "column >= " & intColumnBegin & " AND " & _
                 "column <= " & intColumnEnd & " " & _
           "ORDER BY line, column "
Set rstMap = cnnObj.Execute(strQuery)

'-------------------------------------------------------------------------------
'Response.Write("<h3>Página " & strPage & " Letra " & strLetter & "</h3>" & VBCrLf)
'Response.Write("<h3>Linha " & intLine & " Coluna " & intColumn & "</h3>" & VBCrLf)
'Response.Write("<h3>Linha I-" & intLineBegin & " F-" & intLineEnd & "</h3>" & VBCrLf)
'Response.Write("<h3>Coluna I-" & intColumnBegin & " F-" & intColumnEnd & "</h3>" & VBCrLf)
'-------------------------------------------------------------------------------
'Do While Not rstMap.EOF
'   Response.write(rstMap("page") & "-" & rstMap("letter") & VBCrLf)
'   rstMap.MoveNext
'Loop
'-------------------------------------------------------------------------------
Response.write("<table cellpadding='0' cellspacing='0' border='2'" & VBCrLf)
If Not rstMap.EOF Then
   rstMap.MoveFirst
   For intLoopLine = intLineBegin to intLineEnd
       Response.write("<tr>" & VBCrLf )
       For intLoopColumn = intColumnBegin to intColumnEnd
           Response.write("<td>" & _
 "<a href=""JavaScript:MapReload(parent.menu.frmMenu," & Trim(rstMap("Page")) & ",'" & _
                                                         Trim(rstMap("Letter")) & "');"">" & _
 "<img src='../Media/" & Trim(rstMap("Page")) & Trim(rstMap("Letter")) & _
       ".jpg' width='" & CInt(MID(strFrameX,1,3)) & "' height='" & _
                         CInt(MID(strFrameY,4,3)) & "' border='0'>" & "</a></td>" & VBCrLf)
           rstMap.MoveNext
       Next
       Response.write("</tr>" & VBCrLf)
   Next
End If
Response.write(VBCrLf & "</table>")

If Not IsNull(rstMap) Then
   rstMap.Close
End If
Set rstMap = Nothing

If Not IsNull(cnnObj) Then
      cnnObj.Close
End If
Set cnnObj = Nothing
%>

</center>
</body>
</html>