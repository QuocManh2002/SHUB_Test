import 'package:flutter/material.dart';

final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.blue,
    fixedSize: const Size(double.maxFinite, 50), 
    shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.blue, width: 1.5),
        borderRadius: BorderRadius.all(Radius.circular(10))));
