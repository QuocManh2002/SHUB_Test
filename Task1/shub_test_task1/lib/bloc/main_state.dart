import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MainState extends Equatable {
  final File? file;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final int? totalTransactions;
  final double? totalLiters;
  final double? totalAmount;

  const MainState(
      {this.file,
      this.startTime,
      this.endTime,
      this.totalTransactions,
      this.totalLiters,
      this.totalAmount});

  MainState copyWith(
      {File? file,
      TimeOfDay? startTime,
      TimeOfDay? endTime,
      int? totalTransactions,
      double? totalLiters,
      double? totalAmount}) {
    return MainState(
        file: file ?? this.file,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        totalTransactions: totalTransactions ?? this.totalTransactions,
        totalLiters: totalLiters ?? this.totalLiters,
        totalAmount: totalAmount ?? this.totalAmount);
  }

  @override
  List<Object?> get props =>
      [file, startTime, endTime, totalTransactions, totalLiters, totalAmount];
}
