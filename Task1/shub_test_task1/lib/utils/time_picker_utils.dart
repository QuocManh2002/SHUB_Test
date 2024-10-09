import 'package:flutter/material.dart';

class TimePickerUtils {
  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final result = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      cancelText: "Huỷ",
      confirmText: "Xác nhận",
    );
    return result;
  }
}