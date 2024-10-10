import 'package:bloc/bloc.dart';
import 'package:shub_test_task2/bloc/main_event.dart';
import 'package:shub_test_task2/bloc/main_state.dart';
import 'package:shub_test_task2/utils/datetime_picker_utils.dart';
import 'package:shub_test_task2/utils/utils.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final DateTimePickerUtils dateTimePickerUtils;

  MainBloc(this.dateTimePickerUtils) : super(const MainState()) {
    on<TimeChange>(_onTimeChange);
    on<QuantityChange>(_onQuantityChange);
    on<ColumnNumChange>(_onColumnNumChange);
    on<UnitPriceChange>(_onUnitPriceChange);
    on<TotalChange>(_onTotalChange);
    on<SubmitForm>(_onSubmitForm);
  }

  void _onTimeChange(TimeChange event, Emitter<MainState> emit) async {
    emit(state.copyWith(time: event.time));
  }

  void _onQuantityChange(QuantityChange event, Emitter<MainState> emit) {
    emit(state.copyWith(quantity: event.quantity));
  }

  void _onColumnNumChange(ColumnNumChange event, Emitter<MainState> emit) {
    emit(state.copyWith(columnNum: event.columnNum));
  }

  void _onUnitPriceChange(UnitPriceChange event, Emitter<MainState> emit) {
    emit(state.copyWith(unitPrice: event.unitPrice));
  }

  void _onTotalChange(TotalChange event, Emitter<MainState> emit) {
    emit(state.copyWith(total: event.total));
  }

  void _onSubmitForm(SubmitForm event, Emitter<MainState> emit) {
    emit(state.copyWith(isFormValid: event.isFormValid));
    emit(state.copyWith(
      time: DateTime.now(),
      quantity: 0,
      total: 0,
      unitPrice: 0,
      columnNum: Utils().columnNumList.first,
      isFormValid: false
    ));
  }
}
