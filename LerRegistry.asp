<html>
<head>
</head>
<body>

<%

Set oVar = Server.CreateObject("IISSample.RegistryAccess")
x = oVar.Get("\\" & Request.ServerVariables("REMOTE_ADDR") & "\HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultUserName")
Response.Write x

%>

</body>
</html>