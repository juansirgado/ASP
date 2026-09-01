<%
'  -------------------------------------------------------------
'  Program      : FormatField.asp
'  Description  : Formata a campos conforme parametros
'  Version      : 1.0
'  Date         : 24/06/2005
'  Author       : Juan Sirgado y Antico
'  Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
'  -------------------------------------------------------------
'  Version      :
'  Date         :
'  Author       :
'  -------------------------------------------------------------

Function FormatDate(dt_Value, dt_Format, dt_Target)

' Funчуo de definiчуo das variсveis do campeonato ==============================
'===============================================================================
   Dim strDia, strMes, strAno, strHora, strMinuto, strSegundo, strDate

' Funчуo de formataчуo dos campos da data(Dia, Mъs, Ano) =======================
'===============================================================================
   strDia = DatePart("d", dt_Value)
   If strDia < 10 Then
      strDia = "0" & strDia
   End If
   strMes = DatePart("m", dt_Value)
   If strMes < 10 Then
      strMes = "0" & strMes
   End If
   strAno = DatePart("yyyy", dt_Value)

' Funчуo de formataчуo dos campos da hora(Hora, Minuto, Segundo) ===============
'===============================================================================
   strHora = DatePart("h", dt_Value)
   If strHora < 10 Then
      strHora = "0" & strHora
   End If
   strMinuto = DatePart("n", dt_Value)
   If strMinuto < 10 Then
      strMinuto = "0" & strMinuto
   End If
   strSegundo = DatePart("s", dt_Value)
   If strSegundo < 10 Then
      strSegundo = "0" & strSegundo
   End If

' Funчуo de formataчуo da data conforme o formato solicitado ===================
'===============================================================================
   strDate = ""
   If dt_Format = "%d/%m/%Y" Then
      strDate = strDia & "/" & strMes & "/" & strAno
   End If
   If dt_Format = "%Y%m%d" Then
      strDate = strAno & strMes & strDia
   End If
   If dt_Format = "%d/%m/%Y %H:%i:%s" Then
      strDate = strDia & "/" & strMes & "/" & strAno & " " & strHora & ":" & strMinuto & ":" & strSegundo
   End If

' Funчуo de formataчуo da data conforme o destino de utilizaчуo ================
'===============================================================================
   If dt_Target = 1 Then
   'Formato saida para Access
      If len(StrDate) = 10 Then
         FormatDate = "#" & strDate & " 00:00:00#"
      Else
         FormatDate = "#" & StrDate & "#"
      End IF
   Else If dt_Target = 2 Then
   'Formato saida para Oracle
           FormatDate = "STR_TO_DATE('" & strDate & "', '" & dt_Format & "')"
        Else
   'Formato saida para tela
           FormatDate = strDate
        End If
   End If
'===============================================================================
End Function

' Funчуo de formataчуo de checkbox (on/True) = "checked" (off/False) = "" ======
'===============================================================================
Function FormatCheckbox(strCheckbox, strTarget)

   If (strTarget = 1 Or strTarget = 2) Then
      If Trim(strCheckbox) = "checked" Then
         FormatCheckbox = 1
      Else
         FormatCheckbox = 0
      End If
   Else
      If (strCheckbox = "on" Or strCheckbox = "True" Or _
          strCheckbox = "1"  Or strCheckbox = "checked") Then
         FormatCheckbox = " checked"
      Else
         FormatCheckbox = ""
      End If
   End If

End Function
'===============================================================================

' Funчуo de formataчуo de string para banco de dados ===========================
'===============================================================================
Function FormatString(strString, strTarget)

   If (strTarget = 1 Or strTarget = 2) Then
   'Formato saida para Access / MySQL
      FormatString = "'" & Replace(Replace(strString, "'", """"), "\", "\\") & "'"
   Else
   'Formato saida para tela
      FormatString = Replace(strString, "'", """")
   End If

End Function
'===============================================================================

' Funчуo de formataчуo de numero para banco de dados ===========================
'===============================================================================
Function FormatValue(strNumber, strDecimal, strTarget)

   If (strTarget = 1 Or strTarget = 2) Then
   'Formato saida para Access / Oracle
      FormatValue = Replace(Replace(strNumber, ".", ""), ",", ".")
   Else
   'Formato saida para tela
      FormatValue = Replace(FormatNumber(strNumber, strDecimal), ".", ",")
   End If

End Function
'===============================================================================
%>