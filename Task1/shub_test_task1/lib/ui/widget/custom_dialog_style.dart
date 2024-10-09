import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class CustomDialogStyle {
  void warningDialog({
    required BuildContext context,
    required String title,
  }){
    AwesomeDialog(
      context: context,
      animType: AnimType.leftSlide,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      title: title,
      titleTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      dialogType: DialogType.warning,
      btnOkOnPress: () {
        
      },
      btnOkColor: Colors.amber 
      ).show();
  }
}