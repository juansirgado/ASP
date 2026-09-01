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

'-------------------------------------------------------------------------------
'Stored Procedure Oracle
'-------------------------------------------------------------------------------
'CREATE OR REPLACE
'PROCEDURE TESTE_ORA
'         (PARAM_1 IN     VARCHAR2,
'          PARAM_2 OUT    VARCHAR2,
'          PARAM_3 IN OUT VARCHAR2)
'IS
'BEGIN
'   PARAM_2 := '\* ' || PARAM_1 || ' *\';
'   PARAM_3 := '\* ' || PARAM_3 || ' *\';
'END TESTE_ORA;
'/
'-------------------------------------------------------------------------------

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
cmd.CommandText = "TESTE_ORA"
cmd.CommandType = adCmdStoredProc

'Cria o primeiro parâmetro - apenas de entrada
cmd.Parameters.Append cmd.CreateParameter( "PARAM_1", adVarChar, adParamInput, 80, NULL)

'Seta o valor do primeiro parâmetro. 
'O valor pode ser definido também como o último parâmetro da linha anterior.
cmd.Parameters("PARAM_1") = "Teste 123"

'Cria o segundo parâmetro - apenas de saída
'Os de saída não devem ter valores setados.
cmd.Parameters.Append cmd.CreateParameter( "PARAM_2", adVarChar, adParamOutput, 80)

'Cria o terceiro parâmetro - de entrada e saída
'Parâmetros de entrada e saída devem ter o valor setado para NULL.
cmd.Parameters.Append cmd.CreateParameter( "PARAM_3", adVarChar, adParamInputOutput, 80, NULL)
cmd.Parameters("PARAM_3") = "456 Teste"

'Executa o comando, indicando que não serão retornados uma lista de registros.
cmd.Execute , , adExecuteNoRecords

'Retorna o parâmetro de saída para o usuário
Response.Write("<h4>Valor do parâmetro de entrada: "       & cmd.Parameters("PARAM_1") & "</h4>")
Response.Write("<h4>Valor do parâmetro de saída: "         & cmd.Parameters("PARAM_2") & "</h4>")
Response.Write("<h4>Valor do parâmetro de entrada/saída: " & cmd.Parameters("PARAM_3") & "</h4>")

'Fecha a conexão
cnt.Close
Set cnt = Nothing

'-------------------------------------------------------------------------------
'Retorno Programa ASP
'-------------------------------------------------------------------------------
'Valor do parâmetro de entrada: Teste 123
'Valor do parâmetro de saída: \* Teste 123 *\
'Valor do parâmetro de entrada/saída: \* 456 Teste *\
'-------------------------------------------------------------------------------

%>
