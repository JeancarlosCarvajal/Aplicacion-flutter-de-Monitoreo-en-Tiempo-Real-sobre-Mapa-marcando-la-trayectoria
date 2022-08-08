import 'package:flutter/material.dart';


// el CustomSnackBar se creo en UI es un mensaje modal
class CustomSnackBar extends SnackBar {
   
  CustomSnackBar({
    Key? key,
    required String message,
    String btnLabel = 'Ok',
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onOK // es una funcion callback
  }) : super(
    key: key,
    content: Text(message),
    duration: duration,
    action: SnackBarAction(
      label: btnLabel, 
      onPressed: (){
        if(onOK != null){
          onOK();
        }
      }
    )
  ); 

}