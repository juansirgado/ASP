<%
'  -------------------------------------------------------------
'  Program      : MountCombo.asp
'  Description  : Monta combos do sistema de Campeonato
'  Version      : 1.0
'  Date         : 24/06/2005
'  Author       : Juan Sirgado y Antico
'  Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
'  -------------------------------------------------------------
'  Version      :
'  Date         :
'  Author       :
'  -------------------------------------------------------------

' Função que monta combo =======================================================
'===============================================================================
Sub MountCombo(strTitle, strKey, StrName, strQuery, strSelect, strDisable)

   Dim cmbRs

   Response.Write("<td>" & strTitle & ":</td>" & _
                  "<td><select name=""" & strKey & """ size=""1""" & strDisable & ">" & vbCrLf &_
                  "<option value="""">*Selecione " & strTitle & "</option>" & vbCrLf)

   Set cmbRs = objCn.Execute(strQuery)
   If Not cmbRs.EOF Then
      cmbRs.MoveFirst

      While Not cmbRs.EOF
         Response.Write("<option value=""" & Trim(cmbRs(strKey)) & """")
         If strSelect = Trim(cmbRs(strKey)) Then
            Response.Write(" selected")
         End If
         Response.Write(">" & Trim(cmbRs(strName)) & "</option>" & vbCrLf)
         cmbRs.MoveNext
      WEnd
   End If

   If Not IsNull(cmbRs) Then
      cmbRs.Close
   End If
   Set cmbRs = Nothing

   Response.Write("</select></td>" & vbCrLf)

End Sub
'===============================================================================
%>