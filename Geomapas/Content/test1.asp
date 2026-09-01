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

<body class="fundoX">
<center>
<br>
<table>

<%

Dim objFile, filArqu, strBuffer, intLoop, intLoop2

strBuffer = "          "

Const forReading = 1
Const tristateFalse = 0 

Set objFile = Server.CreateObject("Scripting.FileSystemObject")
Set filArqu = objFile.OpenTextFile("c:\geomapas\bairro.adb", forReading, tristateFalse)

Response.Write("<tr><td>")
Do  
   strBuffer = filArqu.Read(300)
   For intLoop2 = 1 to LEN(strBuffer)
       If MID(strBuffer, intLoop2, 1) = "#" Then
          Response.Write("</td></tr>" & VBCrLf & "<tr><td>") 
       End If
       Response.Write(MID(strBuffer, intLoop2, 1))
   Next
Loop Until LEN(strBuffer) <> 300
Response.Write("</td></tr>")

If Not IsNull(filArqu) Then
   filArqu.Close
End If
Set filArqu = Nothing
Set objFile = Nothing
%>

</table>
</center>
</body>
</html>