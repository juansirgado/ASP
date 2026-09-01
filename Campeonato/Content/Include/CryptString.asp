<%
'  -------------------------------------------------------------
'  Program      : CryptString.asp
'  Description  : Criptografa e Descriptografa uma string
'  Version      : 1.0
'  Date         : 24/06/2005
'  Author       : Juan Sirgado y Antico
'  Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
'  -------------------------------------------------------------
'  Version      :
'  Date         :
'  Author       :
'  -------------------------------------------------------------

Function CryptString(recebesenha, chavedeacesso, descriptografa)

' Função de Criptografia da Senha ==============================================
'===============================================================================

  Const MIN_ASC = 40  'Espaço
  Const MAX_ASC = 126 '~
  Const NUM_ASC = 87  'MAX_ASC - MIN_ASC + 1

  Dim intContador
  Dim intContraBalanco
  Dim intTamanhoSenha
  Dim strCaracter
  Dim guardasenha

  guardasenha = ""

' Geração de um número randômico ===============================================
'===============================================================================
  intContraBalanco = AccessKey(chavedeacesso)
  Rnd -1
  Randomize intContraBalanco

' Criptografa ou Descriptografa a senha ========================================
'===============================================================================
  intTamanhoSenha = Len(recebesenha)
  For intContador = 1 to intTamanhoSenha
      strCaracter = Asc(Mid(recebesenha, intContador, 1))
      If strCaracter >= MIN_ASC And strCaracter <= MAX_ASC Then
         strCaracter = strCaracter - MIN_ASC
         intContraBalanco = Int((NUM_ASC + 1) * Rnd)

         If descriptografa <> 1 Then
' Criptografia da senha ========================================================
'===============================================================================
            strCaracter = ((strCaracter + intContraBalanco) Mod NUM_ASC)
         Else
' Descriptografia da senha =====================================================
'===============================================================================
            strCaracter = ((strCaracter - intContraBalanco) Mod NUM_ASC)
            If strCaracter < 0 Then
               strCaracter = strCaracter + NUM_ASC
            End If
         End If

         strCaracter = strCaracter + MIN_ASC
         guardasenha = guardasenha & Chr(strCaracter)
      End If
  Next

' Retorna a senha Criptografada ================================================
'===============================================================================
  CryptString = guardasenha

End Function

Function AccessKey(chavedeacesso)

' Função para geração do número randômico da senha =============================
'===============================================================================

  Dim intNovoValor1
  Dim intNovoValor2
  Dim intContador
  Dim intTamanhoChaveAcesso
  Dim intValorChaveAcesso
  Dim strCaracter

' Geração do número randômico para criptografia ================================
'===============================================================================
  intTamanhoChaveAcesso = Len(chavedeacesso)
  For intContador = 1 to intTamanhoChaveAcesso
      strCaracter = ASC(Mid(chavedeacesso, intContador, 1))
      intValorChaveAcesso = intValorChaveAcesso Xor (strCaracter * 2 ^ intNovoValor1)
      intValorChaveAcesso = intValorChaveAcesso Xor (strCaracter * 2 ^ intNovoValor2)
      intNovoValor1 = (intNovoValor1 + 7) Mod 19
      intNovoValor2 = (intNovoValor2 + 13) Mod 23
  Next

' Retorna a chave randomica para a criptografia ================================
'===============================================================================
  AccessKey = intValorChaveAcesso

End Function
%>