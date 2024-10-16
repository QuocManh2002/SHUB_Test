import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shub_test_task1/model/input_model.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class ImportFile extends MainEvent {}

class SelectStartTime extends MainEvent {
  final TimeOfDay time;

  const SelectStartTime({required this.time});

  @override
  List<Object> get props => [time];
}

class SelectEndTime extends MainEvent {
  final TimeOfDay time;

  const SelectEndTime({required this.time});

  @override
  List<Object> get props => [time];
}

class GetResult extends MainEvent {
  final InputModel input;
  final BuildContext context;

  const GetResult({required this.input, required this.context});

  @override
  List<Object> get props => [input, context];
}
