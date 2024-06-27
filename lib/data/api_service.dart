import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lab15_flutter/model/student.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Student>> getStudents() async {
    final response = await http.get(Uri.parse('$baseUrl/students'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Student> students = body.map((dynamic item) => Student.fromJson(item)).toList();
      return students;
    } else {
      throw Exception('Failed to load students');
    }
  }

  Future<Student> createStudent(Student student) async {
    final response = await http.post(
      Uri.parse('$baseUrl/students'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode == 201) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create student');
    }
  }

  Future<Student> updateStudent(Student student) async {
    final response = await http.put(
      Uri.parse('$baseUrl/students/${student.id}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode == 200) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update student');
    }
  }

  Future<void> deleteStudent(int studentId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/students/$studentId'),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete student');
    }
  }
}
