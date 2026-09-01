<% @ LANGUAGE="VBScript" %>

   <%
   OPTION EXPLICIT

   '-----------------------------------------------------------------------
   'Instalação : EDS do Brasil - BSC
   'Descrição  : Página de Upload de Arquivo (Sample)
   'Autor      : Juan Sirgado y Antico
   'Data       : 10/06/2001
   'Copyright(c) 2001 by EDS do Brasil, Inc. All Rights Reserved.
   '-----------------------------------------------------------------------
   'Alteração  :
   'Autor      :
   'Data       :
   '-----------------------------------------------------------------------

   Dim mySmartUpload
   Dim intCount
   Set mySmartUpload = Server.CreateObject("aspSmartUpload.SmartUpload")
   mySmartUpload.Upload
   intCount = mySmartUpload.Save("../Teste/Upload")
   %>

   <HTML>
   <HEAD>
     <TITLE>Collection - Teste de Arquivo - Powered by EDS - Electronic Data Systems do Brasil </TITLE>
   </HEAD>

   <BASEFONT face="Tahoma" size="2">

   <BODY bgcolor="#FFFFFF">
   <BR>
   <HR>
   <FORM method="post" name="frmFilePut" action="">
     <TABLE border="1" align="center">
       <TR>
         <TD><FONT face="Tahoma" size="2">Arquivos UpLoads: <%=intCount%></FONT></td>
       </TR>
     <DIV align="center">
        <INPUT type="button" name="Voltar" value="Voltar" onclick="javascript:history.back();">
     </DIV>
   </FORM>

   </BODY>
   </HTML>

   <%
   Set mySmartUpload = Nothing
   %>