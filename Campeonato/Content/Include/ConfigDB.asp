<%
'  -------------------------------------------------------------
'  Program      : Configuracao.asp
'  Description  : Controle do sistema de Campeonato
'  Version      : 1.0
'  Date         : 24/06/2005
'  Author       : Juan Sirgado y Antico
'  Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
'  -------------------------------------------------------------
'  Version      :
'  Date         :
'  Author       :
'  -------------------------------------------------------------

' Funчуo de definiчуo das variсveis do campeonato ==============================
'===============================================================================
Dim cnfDataBase
' Funчуo que monta o String de Conexуo com o Banco de Dados ====================
'===============================================================================
cnfDataBase = "Driver={MySQL ODBC 3.51 Driver};Server=dbmy0027.whservidor.com;Database=jsya;UID=jsya;PWD=sirgadoa;"
'===============================================================================
'cnfDataBase = "Provider=msdaora;Data Source=orahome;User Id=campeonato;Password=nato;"
'cnfDataBase = "Provider=MySqlProv;Location=localhost;Data Source=db_campeonato;User ID=campeoanto;Password=nato;"
'cnfDataBase = "Driver={Microsoft Access Driver (*.mdb)};DBQ=Server.MapPath("./..") & "/Data/Campeonato.mdb;"
'cnfDataBase = "Driver={Microsoft ODBC for Oracle};Server=orahome;Uid=campeonato;Pwd=nato;"
'===============================================================================
'Session.LCID         = 1046 'Sessуo para manter a data no formato DDMMYYYY
'Server.ScriptTimeout = 9000 'Mantem a sessуo por atщ 15 minutos
'===============================================================================
%>