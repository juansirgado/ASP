// -------------------------------------------------------------
// Program      : isNumeric.js
// Description  : Script de teste de campo numérico
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------
function isNumeric(strNumber)                  // recebe um argumento string qualquer
{
   sNumber = strNumber.value;                  // monta o argumento em uma variavel do programa
   for(int c = 0; c < sNumber.length(); c++)   // loop para cada caracter da string
   {
      char cNumber = sNumber.charAt(c);        // monta cada caracter da string em um campo char
      if ((cNumber == '0') || (cNumber == '1') || (cNumber == '2') ||
          (cNumber == '3') || (cNumber == '4') || (cNumber == '5') ||
          (cNumber == '6') || (cNumber == '7') || (cNumber == '8') ||
          (cNumber == '9') || (cNumber == '.') || (cNumber == ',')) // valida se é numerico ou não
      {
         continue;                             // se for numero vai para o proximo caracter
      }
      else
      {
         return false;                         // se o char não for numero sai do programa e retorna 'false'
      }
   }
   return true;                                // se todo o campo for numérico sai do programa e retorna 'true'
//-----------------------------------------------------------------------------
}
