// -------------------------------------------------------------
// Program      : Button.js
// Description  : Script da página de palpites
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

function styleButton(objButton,numStyle)
{
   if (numStyle == 0)
   {
      objButton.style.color             = '#FFFFDD';     
      objButton.style.borderTopColor    = '#228822';
      objButton.style.borderRightColor  = '#228822';
      objButton.style.borderLeftColor   = '#228822';
      objButton.style.borderBottomColor = '#228822';
      objButton.style.backgroundColor   = '#228822';     
   }
   else
   {
      objButton.style.color             = '#228822';     
      objButton.style.borderTopColor    = '#FFFFDD';
      objButton.style.borderRightColor  = '#FFFFDD';
      objButton.style.borderLeftColor   = '#FFFFDD';
      objButton.style.borderBottomColor = '#FFFFDD';
      objButton.style.backgroundColor   = '#FFFFDD';     
   }
}
//-----------------------------------------------------------------------------
