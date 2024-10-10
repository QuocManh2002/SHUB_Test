import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class DateTimePickerUtils {
  Future<DateTime?> pickDateTime(BuildContext context, DateTime initTime) async {
    final result = await showOmniDateTimePicker(
        firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
        lastDate: DateTime.now().add(
          const Duration(days: 3652),
        ),
        initialDate: initTime,
        is24HourMode: true,
        isShowSeconds: true,
        minutesInterval: 1,
        secondsInterval: 1,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        constraints: const BoxConstraints(maxWidth: 350, maxHeight: 650),
        transitionBuilder: (context, anim1, anim2, child) {
          return FadeTransition(
            opacity: anim1.drive(
              Tween(
                begin: 0,
                end: 1,
              ),
            ),
            child: child,
          );
        },
        isForce2Digits: true,
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        context: context);
    return result;
  }
}
