

import 'package:flutter/material.dart';


void ShowLoadingMessage(BuildContext context) {

  showDialog(
    context: context, 
    barrierDismissible: false, // para que la persona no lo cierre al darle click afuera
    builder: (context) => const AlertDialog(
      title: Text( 'Espere por favor...' ),
      content: Text( 'Calculando ruta...' ),
    )
  );
  return;
}