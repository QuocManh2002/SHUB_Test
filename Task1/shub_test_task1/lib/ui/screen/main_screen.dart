import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shub_test_task1/bloc/main_bloc.dart';
import 'package:shub_test_task1/bloc/main_event.dart';
import 'package:shub_test_task1/bloc/main_state.dart';
import 'package:shub_test_task1/model/input_model.dart';

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
        title: const Text("Excel import"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<MainBloc, MainState>(builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: state.file == null ? Colors.red : Colors.green,
                ),
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
                style: const ButtonStyle().copyWith(
                    backgroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.blue),
                    shape: const MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue, width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))))),
                icon: const Icon(Icons.upload_file),
                label: BlocBuilder<MainBloc, MainState>(
                  builder: (context, state) =>
                      Text(state.file == null ? "Nhập file" : "Nhập lại file"),
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
                          // final time = await showTimePicker(
                          //   context: context,
                          //   initialTime: TimeOfDay.now(),
                          //   cancelText: "Huỷ",
                          //   confirmText: "Xác nhận",
                          // );
                          // if (time != null) {
                            context
                                .read<MainBloc>()
                                .add(SelectStartTime(context: context));
                          // }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
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
                  height: 2,
                  width: 20,
                  color: Colors.grey,
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
                          // final toTime = await showTimePicker(
                          //   context: context,
                          //   initialTime: TimeOfDay.now(),
                          //   cancelText: "Huỷ",
                          //   confirmText: "Xác nhận",
                          // );
                          // if (toTime != null) {
                            // ignore: use_build_context_synchronously
                            context
                                .read<MainBloc>()
                                .add(SelectEndTime(context: context));
                          // }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
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
              height: 15,
            ),
            BlocBuilder<MainBloc, MainState>(
              builder: (context, state) {
                return ElevatedButton.icon(
                    onPressed: () {
                      context.read<MainBloc>().add(GetResult(
                          input: InputModel(file: state.file!,
                          startTime: state.startTime!,
                          endTime: state.endTime!)));
                    },
                    style: const ButtonStyle().copyWith(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.white),
                        foregroundColor:
                            const MaterialStatePropertyAll(Colors.blue),
                        shape: const MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.blue, width: 1.5),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))))),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Số giao dịch",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                state.totalTransactions.toString(),
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.clip,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Tổng số lượng (lít)",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                state.totalLiters.toString(),
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.clip,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Tổng tiền (VND)",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: BlocBuilder<MainBloc, MainState>(
                                builder: (context, state) {
                                  return Text(
                                    state.totalAmount.toString(),
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.right,
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    );
            })
          ],
        ),
      ),
    );
  }
}