import 'package:flutter/material.dart';

class Utils{

  bool isValidStartEndTime(TimeOfDay startTime, TimeOfDay endTime) {
    final startDateTime =
        DateTime(0, 0, 0, startTime.hour, startTime.minute, 0);
    final endDateTime = DateTime(0, 0, 0, endTime.hour, endTime.minute, 0);
    return endDateTime.isAfter(startDateTime) || endDateTime.isAtSameMomentAs(startDateTime);
  }
  
}