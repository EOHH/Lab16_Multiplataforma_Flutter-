// main.dart

import 'package:flutter/material.dart';
import 'package:lab15_flutter/page/student_page.dart';
import 'package:lab15_flutter/data/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService(baseUrl: 'http://localhost:8080/api');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentPage(apiService: apiService),
    );
  }
}
