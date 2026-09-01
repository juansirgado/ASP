// -------------------------------------------------------------
// Program      : isAlfaNumeric.js
// Description  : Script de teste de campo alfa-numérico
// Version      : 1.0
// Date         : 28/06/2010
// Author       : Juan Sirgado y Antico
// Copyright(c) 2010 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------
function isAlfaNumeric(strAlfaNum)               // recebe um argumento string qualquer
{
   sAlfaNum = strAlfaNum;                        // monta o argumento em uma variavel do programa
   for(int c = 0; c < sAlfaNum.length(); c++)    // loop para cada caracter da string
   {
      char cAlfaNum = sAlfaNum.charAt(c);        // monta cada caracter da string em um campo char
// Números
      if ((cAlfaNum == '0') || (cAlfaNum == '1') || (cAlfaNum == '2') || (cAlfaNum == '3') || (cAlfaNum == '4') ||
          (cAlfaNum == '5') || (cAlfaNum == '6') || (cAlfaNum == '7') || (cAlfaNum == '8') || (cAlfaNum == '9') || 
// Letras minusculas
          (cAlfaNum == 'a') || (cAlfaNum == 'b') || (cAlfaNum == 'c') || (cAlfaNum == 'd') || (cAlfaNum == 'e') || 
          (cAlfaNum == 'f') || (cAlfaNum == 'g') || (cAlfaNum == 'h') || (cAlfaNum == 'i') || (cAlfaNum == 'j') || 
          (cAlfaNum == 'k') || (cAlfaNum == 'l') || (cAlfaNum == 'm') || (cAlfaNum == 'n') || (cAlfaNum == 'o') || 
          (cAlfaNum == 'p') || (cAlfaNum == 'q') || (cAlfaNum == 'r') || (cAlfaNum == 's') || (cAlfaNum == 't') || 
          (cAlfaNum == 'u') || (cAlfaNum == 'v') || (cAlfaNum == 'w') || (cAlfaNum == 'x') || (cAlfaNum == 'y') || 
          (cAlfaNum == 'z') ||
// Letras maiusculas
          (cAlfaNum == 'A') || (cAlfaNum == 'B') || (cAlfaNum == 'C') || (cAlfaNum == 'D') || (cAlfaNum == 'E') || 
          (cAlfaNum == 'F') || (cAlfaNum == 'G') || (cAlfaNum == 'H') || (cAlfaNum == 'I') || (cAlfaNum == 'J') || 
          (cAlfaNum == 'K') || (cAlfaNum == 'L') || (cAlfaNum == 'M') || (cAlfaNum == 'N') || (cAlfaNum == 'O') || 
          (cAlfaNum == 'P') || (cAlfaNum == 'Q') || (cAlfaNum == 'R') || (cAlfaNum == 'S') || (cAlfaNum == 'T') || 
          (cAlfaNum == 'U') || (cAlfaNum == 'V') || (cAlfaNum == 'W') || (cAlfaNum == 'X') || (cAlfaNum == 'Y') || 
          (cAlfaNum == 'Z')) // valida se é alfanumerico ou não
      {
         continue;                               // se for alfanumerico vai para o proximo caracter
      }
      else
      {
         return false;                           // se o char não for alfanumerico sai do programa e retorna 'false'
      }
   }
   return true;                                  // se todo o campo for alfanumerico sai do programa e retorna 'true'
//-----------------------------------------------------------------------------
}
