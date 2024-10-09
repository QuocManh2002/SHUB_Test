import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shub_test_task1/bloc/main_bloc.dart';
import 'package:shub_test_task1/bloc/main_event.dart';
import 'package:shub_test_task1/bloc/main_state.dart';
import 'package:shub_test_task1/model/input_model.dart';
import 'package:shub_test_task1/ui/widget/elevated_button_style.dart';
import 'package:shub_test_task1/ui/widget/result_row.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Truy vấn giao dịch",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<MainBloc, MainState>(builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: state.file == null ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    state.file == null
                        ? "Chưa nhập file"
                        : "Nhập file thành công",
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    context.read<MainBloc>().add(ImportFile());
                  },
                  style: elevatedButtonStyle,
                  icon: const Icon(Icons.upload_file),
                  label: BlocBuilder<MainBloc, MainState>(
                    builder: (context, state) => Text(
                        state.file == null ? "Nhập file" : "Nhập lại file"),
                  )),
              const SizedBox(
                height: 15,
              ),
              Divider(
                color: Colors.grey.withOpacity(0.6),
                thickness: 1.5,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Vui lòng nhập thời gian để thực hiện truy vấn",
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  BlocBuilder<MainBloc, MainState>(
                    buildWhen: (previous, current) =>
                        previous.startTime != current.startTime,
                    builder: (context, state) {
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            context
                                .read<MainBloc>()
                                .add(SelectStartTime(context: context));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Text(
                              DateFormat("HH:mm").format(state.startTime == null
                                  ? DateTime.now()
                                  : DateTime(0, 0, 0, state.startTime!.hour,
                                      state.startTime!.minute)),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 4,
                    width: 25,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(1)),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  BlocBuilder<MainBloc, MainState>(
                    buildWhen: (previous, current) =>
                        previous.endTime != current.endTime,
                    builder: (context, state) {
                      return Expanded(
                        child: InkWell(
                          onTap: () {
                            context
                                .read<MainBloc>()
                                .add(SelectEndTime(context: context));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Text(
                              DateFormat("HH:mm").format(state.endTime == null
                                  ? DateTime.now()
                                  : DateTime(0, 0, 0, state.endTime!.hour,
                                      state.endTime!.minute)),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                  return ElevatedButton.icon(
                      onPressed: () {
                        context.read<MainBloc>().add(GetResult(
                            input: InputModel(
                                file: state.file,
                                startTime: state.startTime ?? TimeOfDay.now(),
                                endTime: state.endTime ?? TimeOfDay.now()),
                            context: context));
                      },
                      style: elevatedButtonStyle,
                      icon: const Icon(Icons.search),
                      label: const Text("Lấy kết quả"));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<MainBloc, MainState>(builder: (context, state) {
                return state.totalAmount == null
                    ? Container()
                    : Column(
                        children: [
                          Divider(
                            color: Colors.grey.withOpacity(0.6),
                            thickness: 1.5,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ResultRow(
                            title: "Số giao dịch",
                            value: NumberFormat.simpleCurrency(
                                    locale: 'vi_VN', decimalDigits: 0, name: '')
                                .format(state.totalTransactions),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ResultRow(
                            title: "Tổng số lượng (lít)",
                            value: NumberFormat.simpleCurrency(
                                    locale: 'vi_VN', decimalDigits: 2, name: '')
                                .format(state.totalLiters),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ResultRow(
                            title: "Tổng tiền (VND)",
                            value: NumberFormat.simpleCurrency(
                                    locale: 'vi_VN', decimalDigits: 0, name: '')
                                .format(state.totalAmount),
                          )
                        ],
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
