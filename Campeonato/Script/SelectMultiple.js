// -------------------------------------------------------------
// Program      : RelPalpites.js
// Description  : Script do relatório de palpites
// Version      : 1.0
// Date         : 28/06/2005
// Author       : Juan Sirgado y Antico
// Copyright(c) 2005 by JSyA IT Innovation. All Rights Reserved.
// -------------------------------------------------------------
// Version      :
// Date         :
// Author       :
// -------------------------------------------------------------

//----- Adiciona os elementos selecionados na lista fonte para lista destino ------------
//      Parametros:
//         lstSource = lista de origem dos elementos  (de onde serão excluídos os elementos
//                      selecionados)
//         lstTarget = lista de destino dos elementos (onde serão inseridos os elementos
//                     selecionados)
//         blnEvery  = true  significa que todos os elementos serão movidos e
//                     false significa que somente os elementos selecionados serão movidos
//      Variáveis:
//         intSourceSize = número de elementos da lista fonte
//         intTargetSize = número de elementos da lista de destino
//         intIndice     = índice auxiliar de controle do loop
//         intItemIndex  = índice que controla o elemento a ser tratado dentro da lista.
//                         Este artifício é utilizado pois quando excluído o primeiro item
//                         da lista (0), o segundo passa a automaticamente a ser considerado
//                         como o primeiro elemento (0)

//---- Funcão moveItens --------------------------------------------------------
function moveItens(lstSource, lstTarget, blnEvery) {

//---- Inicialização de variáveis
   var intTargetSize = lstTarget.length;
   var intSourceSize = lstSource.length;
   var intItemIndex  = 0;

//---- Loop principal - para cada item selecionado na lista fonte, adiciona à destino
   for (var intIndice = 0; intIndice < intSourceSize; intIndice++)
   {
       if (lstSource.options[intItemIndex] != null)
       {
          if (blnEvery == true || lstSource.options[intItemIndex].selected == true)
          {
             lstTarget.options[intTargetSize] = new Option(lstSource.options[intItemIndex].text);
             lstTarget.options[intTargetSize].value = lstSource.options[intItemIndex].value;
             lstSource.options[intItemIndex] = null;
             intTargetSize++;
          }
          else
          {
             intItemIndex++;
          }
       }
   }
//---- Fim da funcão moveItens -------------------------------------------------
}

//----- Seleciona todos os elementos da lista ----------------------------------
//      Parametros:
//         objList = lista de elementos para serem selecionados

//---- Funcão setItens ---------------------------------------------------------
function setItens(objList) {

//---- Inicialização de variáveis
   var intSize = objList.options.length;

//---- Loop principal - para cada selecionar os itens da lista
   for (var intIndex = 0 ; intIndex < intSize ; intIndex++)
   {
       objList.options[intIndex].selected = true;
   }
}
//---- Fim da funcão setItens --------------------------------------------------

//---- Funcão reset Inicial dos Lists por causa dos &nbsp; ---------------------
function resetLists(objList1, objList2)
{
   objList1.options[0] = null;
   objList2.options[0] = null;
}
//---- Fim da funcão resetItens ------------------------------------------------
