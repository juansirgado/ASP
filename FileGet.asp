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
    %>

   <HTML>
   <HEAD>
     <TITLE>Collection - Teste de Arquivo - Powered by EDS - Electronic Data Systems do Brasil </TITLE>
   </HEAD>

   <BASEFONT face="Tahoma" size="2">

   <BODY bgcolor="#FFFFFF">
   <BR>
   <HR>
   <FORM method="post" name="frmFileGet" action="FilePut.asp" enctype="multipart/form-data">
     <TABLE border="0" align="center">
       <TR>
         <TD><FONT face="Tahoma" size="2">Arquivo:</FONT></td>
         <TD><INPUT type="file" name="Arquivo"></td>
       </TR>
     <DIV align="center">
        <INPUT type="submit" name="Enviar" value="Enviar">
        <INPUT type="button" name="Voltar" value="Voltar" onclick="javascript:history.back();">
     </DIV>
   </FORM>

   </BODY>
   </HTML>