// -------------------------------------------------------------
// Program      : isBlank.js
// Description  : Script de teste de campo branco
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------
function isBlank(InString)
{
  if (InString.length == 0)
  {
    return true;
  }

  if (InString.length == '')
  {
    return true;
  }

  for (Count=0; Count < InString.length; Count++)
  {
    if (InString.charAt(Count) != ' ')
    {
      return false
    }
  }
  return true;
//-----------------------------------------------------------------------------
}
