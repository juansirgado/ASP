// -------------------------------------------------------------
// Program      : isRG.js
// Description  : Script de teste de campo RG
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------
function isRG(strRG) // recebe um argumento string qualquer
{
   sNumber = strRG;  // monta o argumento em uma variavel do programa
   iDgControle = 0;  // campo contendo do Digito de Controle Calculado
   iDgContrStr = 0;  // campo contendo do Digito de Controle Passado

   if (NaN(sNumber))
   {
      return false;
   }
   if (sNumber.length != 9)
   {
      return false;
   }
   iDgContrStr = parseInt(sNumber.substring(8, 9));
// calcula os 2 digitos de controle o Digito de Controle
// loop para percorrer cada caracter da string e calcular o Digito de Controle
   for(int i = 0; i < sNumber.length - 1; i++)
   {
// monta cada caracter da string em um campo inteiro e aplica o calculo do RG
       iDgControle += parseInt(sNumber.substring(7 - i, 8 - i )) * ((i % 8) + 2);
// calcula o digito de controle para cada caracter
   }
   iDgControle = 11 - (iDgControle % 11); // calcula o Primeiro digito de controle
   iDgControle = (iDgControle < 10) ? iDgControle : 'X';
   if (iDgControle == iDgContrStr)
   {
      return true;  // se digito de controle estiver correto retorna 'true'
   }
   else
   {
      return false; // se digito de controle estiver errado retorna 'false'
   }
//-----------------------------------------------------------------------------
}
