// -------------------------------------------------------------
// Program      : isCPF.js
// Description  : Script de teste de campo CPF
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------
function isCPF(strCPF) // recebe um argumento string qualquer
{
   sNumber = strCPF;   // monta o argumento em uma variavel do programa
   iDgControl1 = 0;    // campo contendo do Primeiro Digito de Controle Calculado
   iDgControl2 = 0;    // campo contendo do Segundo Digito de Controle Calculado
   iDgControle = 0;    // campo contendo do Digito de Controle Calculado
   iDgContrStr = 0;    // campo contendo do Digito de Controle Passado

   if (NaN(sNumber))
   {
      return false;
   }
   if (sNumber.length != 14)
   {
      return false;
   }
   iDgContrStr = parseInt(sNumber.substring(12, 14));
// calcula os 2 digitos de controle o Digito de Controle
// loop para percorrer cada caracter da string e calcular o Digito de Controle
   for(int i = 0; i < sNumber.length - 2; i++)
   {
// monta cada caracter da string em um campo inteiro e aplica o calculo do CPF
       iDgControl1 += parseInt(sNumber.substring(11 - i, 12 - i )) * ((i % 8) + 2);
       iDgControl2 += parseInt(sNumber.substring(11 - i, 12 - i )) * (((i + 1) % 8) + 2);
// calcula o digito de controle para cada caracter
   }
   iDgControl1 = 11 - (iDgControl1 % 11);                       // calcula o Primeiro digito de controle
   iDgControl1 = (iDgControl1 < 10) ? iDgControl1 : 0;
   iDgControl2 = 11 - ((iDgControl2 + (iDgControl1 * 2)) % 11); // calcula o Segundo digito de controle
   iDgControl2 = (iDgControl2 < 10) ? iDgControl2 : 0;
   iDgControle = (iDgControl1 * 10) + iDgControl2;              // calcula o Digito de controle composto
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
