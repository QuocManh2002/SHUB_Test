import 'package:equatable/equatable.dart';

class MainState extends Equatable {
  final DateTime? time;
  final double? quantity;
  final String? columnNum;
  final double? unitPrice;
  final double? total;
  final bool? isFormValid;

  const MainState(
      {this.time,
      this.quantity,
      this.columnNum,
      this.unitPrice,
      this.total,
      this.isFormValid});

  MainState copyWith(
      {DateTime? time,
      double? quantity,
      String? columnNum,
      double? unitPrice,
      double? total,
      bool? isFormValid}) {
    return MainState(
        time: time ?? this.time,
        quantity: quantity ?? this.quantity,
        columnNum: columnNum ?? this.columnNum,
        unitPrice: unitPrice ?? this.unitPrice,
        total: total ?? this.total,
        isFormValid: isFormValid ?? this.isFormValid
        );
  }

  @override
  List<Object?> get props =>
      [time, quantity, columnNum, unitPrice, total, isFormValid];
}
