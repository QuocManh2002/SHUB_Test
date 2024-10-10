import 'package:flutter/material.dart';

class TimePickerUtils {
  Future<TimeOfDay?> pickTime(BuildContext context, TimeOfDay initTime) async {
    final result = await showTimePicker(
      context: context, 
      initialTime: initTime,
      cancelText: "Huỷ",
      confirmText: "Xác nhận",
    );
    return result;
  }
}