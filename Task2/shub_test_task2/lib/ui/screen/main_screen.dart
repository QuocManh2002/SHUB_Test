import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:shub_test_task2/bloc/main_bloc.dart';
import 'package:shub_test_task2/bloc/main_event.dart';
import 'package:shub_test_task2/bloc/main_state.dart';
import 'package:shub_test_task2/utils/datetime_picker_utils.dart';
import 'package:shub_test_task2/utils/double_validator.dart';
import 'package:shub_test_task2/utils/utils.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late TextEditingController dateTimeController;
  late TextEditingController quantityController;
  late TextEditingController totalController;
  late TextEditingController unitPriceController;

  final quantityFocusNode = FocusNode();
  final totalFocusNode = FocusNode();
  final unitPriceFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final DateTimePickerUtils dateTimePickerUtils = DateTimePickerUtils();

  @override
  void initState() {
    super.initState();
    dateTimeController = TextEditingController();
    quantityController = TextEditingController();
    totalController = TextEditingController();
    unitPriceController = TextEditingController();

    dateTimeController.text =
        DateFormat("dd/MM/yyyy HH:mm:ss").format(DateTime.now());
  }

  @override
  void dispose() {
    dateTimeController.dispose();
    quantityController.dispose();
    totalController.dispose();
    unitPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.96),
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 100),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "Nhập giao dịch",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<MainBloc>()
                                .add(const SubmitForm(isFormValid: true));
                          } else {
                            context
                                .read<MainBloc>()
                                .add(const SubmitForm(isFormValid: false));
                          }
                        },
                        child: const Text(
                          "Cập nhật",
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ),
            )),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: BlocListener<MainBloc, MainState>(
                  listenWhen: (previous, current) =>
                      current.isFormValid != null && current.isFormValid!,
                  listener: (context, state) async {
                    AwesomeDialog(
                            context: context,
                            animType: AnimType.leftSlide,
                            dialogType: DialogType.success,
                            title: "Nhập giao dịch thành công",
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            titleTextStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                        .show();
                    Future.delayed(
                      const Duration(milliseconds: 1500),
                      () {
                        quantityController.clear();
                        totalController.clear();
                        unitPriceController.clear();
                        dateTimeController.text =
                            DateFormat("dd/MM/yyyy HH:mm:ss")
                                .format(DateTime.now());
                        Navigator.of(context).pop();
                      },
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15,),
                      BlocBuilder<MainBloc, MainState>(
                          buildWhen: (previous, current) =>
                              previous.time != current.time,
                          builder: ((context, state) => Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: TextFormField(
                                  controller: dateTimeController,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                      suffixIcon: Icon(Icons.calendar_month),
                                      labelText: "Thời gian",
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(width: 1.5))),
                                  onChanged: (value) {},
                                  onFieldSubmitted: (value) {},
                                  onTap: () async {
                                    final result =
                                        await dateTimePickerUtils.pickDateTime(
                                            context,
                                            state.time ?? DateTime.now());
                                    if (result != null) {
                                      dateTimeController.text =
                                          DateFormat("dd/MM/yyyy HH:mm:ss")
                                              .format(result);
                                      // ignore: use_build_context_synchronously
                                      context
                                          .read<MainBloc>()
                                          .add(TimeChange(time: result));
                                    }
                                  },
                                ),
                              ))),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: quantityController,
                          focusNode: quantityFocusNode,
                          decoration: const InputDecoration(
                              labelText: "Số lượng",
                              hintText: "Số lượng",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1.5))),
                          onChanged: (value) {
                            try {
                              context.read<MainBloc>().add(QuantityChange(
                                  quantity:
                                      value.isEmpty ? 0 : double.parse(value)));
                            } catch (error) {
                              print(error);
                            }
                          },
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Không được để trống số lượng"),
                            DoubleValidator(
                                errorText: "Số lượng chứa kí tự không phù hợp"),
                            MaxLengthValidator(10,
                                errorText: "Số lượng chỉ tối đa 10 kí tự"),
                            RangeValidator(
                                min: 0,
                                max: 9999999999,
                                errorText: "Số lượng không được là số âm"),
                          ]).call,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        height: 60,
                        child: BlocBuilder<MainBloc, MainState>(
                          builder: (context, state) => DropdownButton<String>(
                            hint: const Text("Trụ"),
                            elevation: 16,
                            isExpanded: true,
                            underline: Container(),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            value:
                                state.columnNum ?? Utils().columnNumList.first,
                            items: Utils()
                                .columnNumList
                                .map((value) => DropdownMenuItem(
                                    value: value, child: Text("Trụ $value")))
                                .toList(),
                            onChanged: (value) {
                              context.read<MainBloc>().add(ColumnNumChange(
                                  columnNum:
                                      value ?? Utils().columnNumList.first));
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          controller: totalController,
                          keyboardType: TextInputType.number,
                          focusNode: totalFocusNode,
                          decoration: const InputDecoration(
                              hintText: "Doanh thu",
                              labelText: "Doanh thu",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1.5))),
                          onChanged: (value) {
                            try {
                              context.read<MainBloc>().add(TotalChange(
                                  total:
                                      value.isEmpty ? 0 : double.parse(value)));
                            } catch (error) {
                              print(error);
                            }
                          },
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Không được để trống Doanh thu"),
                            DoubleValidator(
                                errorText:
                                    "Doanh thu chứa kí tự không phù hợp"),
                            MaxLengthValidator(15,
                                errorText: "Doanh thu chỉ tối đa 15 kí tự"),
                            RangeValidator(
                                min: 0,
                                max: 999999999999999,
                                errorText: "Doanh thu không được là số âm"),
                          ]).call,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          controller: unitPriceController,
                          keyboardType: TextInputType.number,
                          focusNode: unitPriceFocusNode,
                          decoration: const InputDecoration(
                              hintText: "Đơn giá",
                              labelText: "Đơn giá",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(width: 1.5))),
                          onChanged: (value) {
                            try {
                              context.read<MainBloc>().add(UnitPriceChange(
                                  unitPrice:
                                      value.isEmpty ? 0 : double.parse(value)));
                            } catch (error) {
                              print(error);
                            }
                          },
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Không được để trống đơn giá"),
                            DoubleValidator(
                                errorText: "Đơn giá chứa kí tự không phù hợp"),
                            MaxLengthValidator(10,
                                errorText: "Đơn giá chỉ tối đa 10 kí tự"),
                            RangeValidator(
                                min: 0,
                                max: 9999999999,
                                errorText: "Đơn giá không được là số âm"),
                          ]).call,
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
