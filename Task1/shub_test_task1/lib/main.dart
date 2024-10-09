import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shub_test_task1/bloc/main_bloc.dart';
import 'package:shub_test_task1/repository/main_repository.dart';
import 'package:shub_test_task1/ui/screen/main_screen.dart';
import 'package:shub_test_task1/utils/file_picker_utils.dart';
import 'package:shub_test_task1/utils/time_picker_utils.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainBloc(FilePickerUtils(), TimePickerUtils(), MainRepository()),
      child: MaterialApp(
          title: "Task1 App",
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true),
          home: const MainScreen()),
    );
  }
}
