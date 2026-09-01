// -------------------------------------------------------------
// Program      : isDate.js
// Description  : Script de teste de campo data
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------
function isDate(strDate)                       // recebe um argumento string qualquer
{
   sDate = strDate.value;                      // monta o argumento em uma variavel do programa
   if (sDate.length != 10)
   {
      return false;                            // encerra o programa e retorna false
   }
   sDay   = sDate.substring(0,2);              // separa a data em dia, mês e ano
   sMonth = sDate.substring(3,5);
   sYear  = sDate.substring(6,10);
   if ((isNaN(sDay)) || (isNaN(sMonth)) || (isNaN(sYear)))
   {
      return false;                            // encerra o programa e retorna false
   }
   iDay   = parseInt(sDay,10);                 // converte dia, mês e ano em numéricos para calculos
   iMonth = parseInt(sMonth,10);
   iYear  = parseInt(sYear,10);
   if ((iDay < 1) || (iDay > 31))              // dia invalido
   {
      return false;                            // encerra o programa e retorna false
   }
   if ((iMonth < 1) || (iMonth > 12))          // mês invalido
   {
      return false;                            // encerra o programa e retorna false
   }
   if ((iYear < 1900) || (iYear > 2100))       // ano invalido
   {
       return false;                           // encerra o programa e retorna false
   }
   if (((iMonth == 4) || (iMonth == 6) ||
        (iMonth == 9) || (iMonth == 11)) && 
        (iDay == 31))                          // dia invalido
   {
      return false;                            // encerra o programa e retorna false
   }
   if ((iMonth == 2) &&
      ((iDay == 30) || (iDay == 31)))          // dia invalido
   {
      return false;                            // encerra o programa e retorna false
   }
   bLeapYear = false;                          // verifica se o ano é bissexto(divisivel por 4, !100 e 400)
   if ((iYear % 4) == 0)
      bLeapYear = true;
   if ((iYear % 100) == 0)
      bLeapYear = false;
   if ((iYear % 400) == 0)
      bLeapYear = true;
   if ((!(bLeapYear)) && (iMonth == 2) && (iDay > 28)) // dia invalido
   {
      return false;                            // encerra o programa e retorna false
   }
   return true;                                // se for uma data valida sai do programa e retorna 'true'
//-----------------------------------------------------------------------------
}
// ----------------------------------------------------------------------------
function isTime(strTime)                       // recebe um argumento string qualquer
{
   sTime = strTime.value;                      // monta o argumento em uma variavel do programa
   if (sTime.length != 8)
   {
      return false;                            // encerra o programa e retorna false
   }
   sHour   = sTime.substring(0,2);             // separa o horário em hora, minuto e segundo
   sMinute = sTime.substring(3,5);
   sSecond = sTime.substring(6,8);
   if ((isNaN(sHour)) || (isNaN(sMinute)) || (isNaN(sSecond)))
   {
      return false;                            // encerra o programa e retorna false
   }
   iHour   = parseInt(sHour,10);               // converte hora, minuto e segundo em numéricos para calculos
   iMinute = parseInt(sMinute,10);
   iSecond = parseInt(sSecond,10);
   if ((iHour < 0) || (iHour > 23))            // hora invalida
   {
      return false;                            // encerra o programa e retorna false
   }
   if ((iMinute < 0) || (iMinute > 59))        // minuto invalido
   {
      return false;                            // encerra o programa e retorna false
   }
   if ((iSecond < 0) || (iSecond > 59))        // segundo invalido
   {
       return false;                           // encerra o programa e retorna false
   }
   return true;                                // se for um horário valido sai do programa e retorna 'true'
//-----------------------------------------------------------------------------
}
// ----------------------------------------------------------------------------
function isDateTime(strDateTime)               // recebe um argumento string qualquer
{
   sDateTime = strDateTime.value;              // monta o argumento em uma variavel do programa
   if (sTime.length != 19)
   {
      return false;                            // encerra o programa e retorna false
   }
   sDate = strDateTime.substring(0,10);
   sTime = strDateTime.substring(11,19);

   if (!((isDate(sDate)) && (isTime(sTime))))
   {
      return false;                            // encerra o programa e retorna false
   }
   return true;                                // se for uma data e horário validos sai do programa e retorna 'true'
//-----------------------------------------------------------------------------
}
