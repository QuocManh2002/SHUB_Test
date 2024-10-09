import 'package:equatable/equatable.dart';

class ResultModel extends Equatable{
  final int totalTransactions;
  final double totalLiters;
  final double totalAmount;

  const ResultModel({
    required this.totalAmount,
    required this.totalLiters,
    required this.totalTransactions
  });

  ResultModel copyWith({int? totalTransactions, double? totalLiters, double? totalAmount}){
    return ResultModel(
      totalAmount: totalAmount ?? this.totalAmount, 
      totalLiters: totalLiters ?? this.totalLiters, 
      totalTransactions: totalTransactions ?? this.totalTransactions);
  }

  @override
  List<Object> get props => [totalTransactions, totalAmount, totalLiters];
}