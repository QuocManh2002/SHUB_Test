import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<int> numList = [];
  String token = "";
  List<int> resultList = [];
  List<dynamic> queryList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }

  void getData() async {
    var url = "https://test-share.shub.edu.vn/api/intern-test/input";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      for (final item in result["data"]) {
        numList.add(int.parse(item.toString()));
      }
      queryList = result["query"];
      token = result["token"];
    }
    processingData();
  }

  void processingData() async {
    for (final item in queryList) {
      resultList.add(getQueryResult(item));
    }
    postData();
  }

  getQueryResult(dynamic query) {
    int result = 0;
    final l = int.parse(query["range"].first.toString());
    final r = int.parse(query["range"].last.toString());
    if (query["type"] == 1) {
      for (int i = l; i <= r; i++) {
        result += numList[i];
      }
    } else {
      int oddSum = 0;
      int evenSum = 0;

      for (int i = 0; i <= r-l; i++) {
        if (i.isOdd) {
          oddSum += numList[i + l];
        } else {
          evenSum += numList[i + l];
        }
      }
      result = evenSum - oddSum;
    }
    return result;
  }

  void postData() async {
    var url = "https://test-share.shub.edu.vn/api/intern-test/output";
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(resultList));
    if (response.statusCode == 200) {
      print("success");
      print(response);
    } else {
      print("fail");
    }
  }
}
