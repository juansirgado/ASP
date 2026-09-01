<!-----------------------------------------------------------
Instalação : EDS do Brasil - BSC
Descrição  : Página com ADO acessando Procedure Oracle
Autor      : Juan Sirgado y Antico
Data       : 04/10/2001
Copyright(c) 2001 by EDS do Brasil, Inc. All Rights Reserved.
-------------------------------------------------------------
Alteração  :
Autor      :
Data       :
------------------------------------------------------------>

<!-- #include file = "adovbs.inc" -->

<%

'Cria as variaveis
Dim cnt, cmd

'Cria a conexão com o banco
Set cnt = Server.CreateObject("ADODB.Connection")
cnt.Open "Driver={Oracle ODBC Driver};SERVER=g-j;DATABASE=orcl;UID=system;PWD=manager"

'Cria o comando
Set cmd = Server.CreateObject("ADODB.Command")

'Seta as propriedades do comando
cmd.ActiveConnection = cnt
'Nome da procedure, sem os parâmetros
cmd.CommandText = "cob_pk_teste.cob_sp_teste"
cmd.CommandType = adCmdStoredProc

'Cria os parâmetros para a stored procedure.
cmd.Parameters.Append cmd.CreateParameter( "PARAM_1", adNumber, adParamInput, 2, NULL)
cmd.Parameters("PARAM_1") = 1
cmd.Parameters.Append cmd.CreateParameter( "PARAM_2", adNumber, adParamInput, 2, NULL)
cmd.Parameters("PARAM_2") = 1
cmd.Parameters.Append cmd.CreateParameter( "PARAM_3", adChar, adParamInput, 1, NULL)
cmd.Parameters("PARAM_3") = "A"
cmd.Parameters.Append cmd.CreateParameter( "PARAM_3", adRecordSet, adParamInputOutput, 256, NULL)
'cmd.Parameters("PARAM_3") = "456 Teste"

'Executa o comando, indicando que não serão retornados uma lista de registros.
cmd.Execute, , adExecuteNoRecords

'Retorna o parâmetro de saída para o usuário
Response.Write("<h4>Valor do parâmetro de entrada: "       & cmd.Parameters("PARAM_1") & "</h4>" & vbCrLf & _
               "<h4>Valor do parâmetro de saída: "         & cmd.Parameters("PARAM_2") & "</h4>" & vbCrLf & _
               "<h4>Valor do parâmetro de entrada/saída: " & cmd.Parameters("PARAM_3") & "</h4>")

'Fecha a conexão
cnt.Close
Set cnt = Nothing

%>