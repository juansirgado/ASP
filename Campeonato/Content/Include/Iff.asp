<%
'  -------------------------------------------------------------
'  Program      : FuncaoAsp.asp
'  Description  : Funcoes do sistema de Campeonato
'  Version      : 1.0
'  Date         : 24/06/2005
'  Author       : Juan Sirgado y Antico
'  Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
'  -------------------------------------------------------------
'  Version      :
'  Date         :
'  Author       :
'  -------------------------------------------------------------

' Funчуo Iff simula o comando de decisуo IF mas como funчуo ====================
'===============================================================================
Function Iff(arg1, arg2, arg3)

    If arg1 Then
' Se arg1 for "True" retorna arg2
       Iff = arg2
    Else
' Se arg1 for "False" retorna arg3
       Iff = arg3
    End If

End Function
'===============================================================================
%>