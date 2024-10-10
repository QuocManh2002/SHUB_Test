import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:shub_test_task1/bloc/main_event.dart';
import 'package:shub_test_task1/bloc/main_state.dart';
import 'package:shub_test_task1/repository/main_repository.dart';
import 'package:shub_test_task1/ui/widget/custom_dialog_style.dart';
import 'package:shub_test_task1/utils/file_picker_utils.dart';
import 'package:shub_test_task1/utils/time_picker_utils.dart';
import 'package:shub_test_task1/utils/utils.dart';

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
    emit(state.copyWith(startTime: event.time));
  }

  void _onSelectEndTime(SelectEndTime event, Emitter<MainState> emit) async {
    emit(state.copyWith(endTime: event.time));
  }

  void _onGetResult(GetResult event, Emitter<MainState> emit) {
    if (event.input.file == null) {
      CustomDialogStyle().warningDialog(
          context: event.context,
          title: "Vui lòng tải lên file báo cáo giao dịch");
    } else if (!Utils()
        .isValidStartEndTime(event.input.startTime!, event.input.endTime!)) {
      CustomDialogStyle().warningDialog(
          context: event.context,
          title: "Giờ kết thúc không thể sớm hơn giờ bắt đầu");
    } else {
      final result = mainRepository.getResult(event.input);
      emit(state.copyWith(
          totalAmount: result!.totalAmount,
          totalLiters: result.totalLiters,
          totalTransactions: result.totalTransactions));
    }
  }
}
