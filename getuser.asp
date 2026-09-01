<html>
<head>
<title>Get User</title>
</head>

<%
Set Reg = Server.CreateObject("IISSample.RegistryAccess")

strUser = Reg.Get("\\" & Request.ServerVariables("REMOTE_ADDR") & _
                  "\HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\DefaultUserName")
'strUser = Reg.Get("\\" & Request.ServerVariables("REMOTE_ADDR") & _
'                  "\HKLM\System\CurrentControlSet\Control")
%>

<body>
<form>

<p>User: <%=strUser%></p>
<br>

</form>
</body>
</html>