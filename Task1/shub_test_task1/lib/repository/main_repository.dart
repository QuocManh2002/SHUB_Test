import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:shub_test_task1/model/input_model.dart';
import 'package:shub_test_task1/model/result_model.dart';

class MainRepository{
  ResultModel? getResult(InputModel input) {
    final bytes = input.file!.readAsBytesSync();
    final excel = Excel.decodeBytes(bytes);
    var totalAmount = 0.0;
    var totalLiters = 0.0;
    var totalTransactions = 0;

    final dateTimeFrom =
        DateTime(0, 0, 0, input.startTime!.hour, input.startTime!.minute, 0);
    final dateTimeTo =
        DateTime(0, 0, 0, input.endTime!.hour, input.endTime!.minute, 0);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        try {
          final transactionTime = DateFormat("HH:mm:ss")
              .parse(row[2] == null ? "" : row[2]!.value.toString());
          final transactionDateTime = DateTime(0, 0, 0, transactionTime.hour,
              transactionTime.minute, transactionTime.second);

          if (transactionDateTime.isAfter(dateTimeFrom) &&
                  transactionDateTime.isBefore(dateTimeTo) ||
              transactionDateTime.isAtSameMomentAs(dateTimeFrom) ||
              transactionDateTime.isAtSameMomentAs(dateTimeTo)) {
            totalTransactions += 1;
            totalAmount += double.parse(row[8]!.value.toString());
            totalLiters += double.parse(row[6]!.value.toString());
          }
        } catch (error) {
          continue;
        }
      }
    }

    return ResultModel(
        totalAmount: totalAmount,
        totalLiters: totalLiters,
        totalTransactions: totalTransactions);
  }
}