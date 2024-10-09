import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class InputModel extends Equatable{
  final File file;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const InputModel({
    required this.file,
    required this.startTime,
    required this.endTime
  });

  InputModel copyWith({File? file, TimeOfDay? startTime, TimeOfDay? endTime}){
    return InputModel(
      file: file ?? this.file,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime
      );
  }

  @override
  List<Object> get props => [file, startTime, endTime];
}