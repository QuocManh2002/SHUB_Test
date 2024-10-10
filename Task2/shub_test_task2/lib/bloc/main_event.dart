import 'package:equatable/equatable.dart';

abstract class MainEvent extends Equatable{
  const MainEvent();

  @override
  List<Object> get props => [];
}

class TimeChange extends MainEvent {
  final DateTime time;
  const TimeChange({required this.time});

  @override 
  List<Object> get props => [time];
}
class QuantityChange extends MainEvent {
  final double quantity;
  const QuantityChange({required this.quantity});

  @override 
  List<Object> get props => [quantity];
}
class ColumnNumChange extends MainEvent {
  final String columnNum;
  const ColumnNumChange({required this.columnNum});

  @override 
  List<Object> get props => [columnNum];
}
class UnitPriceChange extends MainEvent {
  final double unitPrice;
  const UnitPriceChange({required this.unitPrice});

  @override 
  List<Object> get props => [unitPrice];
}
class TotalChange extends MainEvent {
  final double total;
  const TotalChange({required this.total});

  @override
  List<Object> get props => [total];
}
class SubmitForm extends MainEvent {
  final bool isFormValid;

  const SubmitForm({required this.isFormValid});

  @override
  List<Object> get props => [isFormValid];
}
