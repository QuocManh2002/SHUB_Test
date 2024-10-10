import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shub_test_task2/bloc/main_bloc.dart';
import 'package:shub_test_task2/ui/screen/main_screen.dart';
import 'package:shub_test_task2/utils/datetime_picker_utils.dart';

late FlutterLocalization localization;
void main() {
  localization = FlutterLocalization.instance;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainBloc(DateTimePickerUtils()),
      child: MaterialApp(
          localizationsDelegates: localization.localizationsDelegates,
          supportedLocales: const [Locale('vi')],
          title: "Task1 App",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
              useMaterial3: true),
          home: const MainScreen()),
    );
  }
}
