import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:shub_test_task1/bloc/main_event.dart';
import 'package:shub_test_task1/bloc/main_state.dart';
import 'package:shub_test_task1/repository/main_repository.dart';
import 'package:shub_test_task1/utils/file_picker_utils.dart';
import 'package:shub_test_task1/utils/time_picker_utils.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final FilePickerUtils filePickerUtils;
  final TimePickerUtils timePickerUtils;
  final MainRepository mainRepository;

  MainBloc(this.filePickerUtils, this.timePickerUtils, this.mainRepository)
      : super(const MainState()) {
    on<ImportFile>(_onImportFile);
    on<SelectStartTime>(_onSelectStartTime);
    on<SelectEndTime>(_onSelectEndTime);
    on<GetResult>(_onGetResult);
  }

  void _onImportFile(ImportFile event, Emitter<MainState> emit) async {
    File? file = await filePickerUtils.pickFile();
    if (file != null) {
      emit(state.copyWith(file: file));
    }
  }

  void _onSelectStartTime(
      SelectStartTime event, Emitter<MainState> emit) async {
    final time = await timePickerUtils.pickTime(event.context);
    if (time != null) {
      emit(state.copyWith(startTime: time));
    }
  }

  void _onSelectEndTime(SelectEndTime event, Emitter<MainState> emit) async {
    final time = await timePickerUtils.pickTime(event.context);
    if (time != null) {
      emit(state.copyWith(endTime: time));
    }
  }

  void _onGetResult(GetResult event, Emitter<MainState> emit) {
    final result = mainRepository.getResult(event.input);
    emit(state.copyWith(totalAmount: result!.totalAmount, totalLiters: result.totalLiters, totalTransactions: result.totalTransactions));
  }
}
