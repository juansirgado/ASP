<%
'  -------------------------------------------------------------
'  Program      : VerifyAccess.asp
'  Description  : Verifica o acesso ao Campeonato
'  Version      : 1.0
'  Date         : 24/06/2005
'  Author       : Juan Sirgado y Antico
'  Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
'  -------------------------------------------------------------
'  Version      :
'  Date         :
'  Author       :
'  -------------------------------------------------------------

' Funчуo de validaчуo do usuсrio e senha para o sistema campeonato =============
'===============================================================================
Sub VerifyAccess()

' Funчуo de definiчуo das variсveis do VerifyAccess ============================
'===============================================================================
Dim objCn, pesRs, strQr, strCn
Dim str_cd_pessoa, str_cd_acesso, str_cd_erro

' Funчуo inicia a conexуo com o Banco de Dados =================================
'===============================================================================
strCn = cnfDataBase
Set objCn = Server.CreateObject("ADODB.Connection")
objCn.Open strCn

strQr = "Select pes_cd_acesso From Pessoa " & _
        "Where pes_cd_pessoa='" & Trim(Session.Contents("Usuario")) & "'"
Set pesRs = objCn.Execute(strQr)

If Not pesRs.EOF Then
   If Session.Contents("Acesso") = pesRs("pes_cd_acesso") Then
      'Access Ok
      str_cd_erro = 0
   Else
      'Invalid Password
      str_cd_erro = 1
   End If
Else
   'Invalid User
   str_cd_erro = 2
End If

' Funчуo termina a conexуo com o Banco de Dados ================================
'===============================================================================
Set pesRs = Nothing
If Not IsNull(objCn) Then
   objCn.Close
End If
Set objCn = Nothing

If Not str_cd_erro = 0 Then
   Response.Redirect("Logoff.asp")
End If

End Sub

' Funчуo que verifica o nivel de seguranчa(Usuсrio/Administrador) ==============
'===============================================================================
Function VerifyLevel()

    If Trim(Session.Contents("Nivel")) = "1" Then
       VerifyLevel = ""
    Else
       VerifyLevel = " disabled"
    End If

End Function

' Funчуo de Log das conexo~es ao sistema campeonato ============================
'===============================================================================
Sub LogConnection(strLogin, strConn)

    dim cnnDataBase
    dim strQuery
    dim rstUsuario

    Set cnnDataBase = Server.CreateObject("ADODB.Connection")
    cnnDataBase.Open strConn

    If strLogin = 1 Then
' Cria o registro de log com os dados do login =================================
'===============================================================================
       strQuery = "Insert Into Conexao "              & _
                        "(con_cd_conexao, "           & _
                         "con_dt_inicio_conexao, "    & _
                         "con_dt_fim_conexao, "       & _
                         "con_cd_usuario, "           & _
                         "con_cd_sessao) "            & _
                  "Values "                           & _
                        "(sequence_nextval(""sq_cd_conexao""), " & _
                         "NOW(), "                  & _
                         "NULL, '"                    & _
                          Session.Contents("Usuario") & "', " & _
                          Session.SessionId           & ")"
    Else
' Atualiza o registro de log com os dados do logout ============================
'===============================================================================
       strQuery = "Update Conexao "                                       & _
                     "Set con_dt_fim_conexao=NOW() "                      & _
                   "Where con_cd_sessao="   & Session.SessionId           & " "  & _
                     "And con_cd_usuario='" & Session.Contents("Usuario") & "' " & _
                     "And con_dt_fim_conexao IS NULL"
    End If

    Set rstUsuario = cnnDataBase.Execute(strQuery)

    cnnDataBase.Close
    Set cnnDataBase = Nothing

End Sub
'===============================================================================
%>