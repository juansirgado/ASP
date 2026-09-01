// -------------------------------------------------------------
// Instalação : JSA do Brasil - E-Solution
// Descrição  : Página Inicial do Guia GeoMapas
// Autor      : Juan Sirgado y Antico
// Data       : 29/06/2001
// Copyright(c) 2000 by JSA do Brasil, Inc. All Rights Reserved.
// -------------------------------------------------------------
// Alteração  :
// Autor      :
// Data       :
// -------------------------------------------------------------
function changeGif(imgChange, index)
{
   imgChange.src = '..\\Media\\' & imgChange.name & index & '.gif';
}
// -------------------------------------------------------------
function MapReload(frmMenu, intPage, strLetter)
{
   frmMenu.hidPage.value = intPage;
   frmMenu.hidLetter.value = strLetter;
   frmMenu.submit();
}
// -------------------------------------------------------------
