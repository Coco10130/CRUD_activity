import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:group_activity/features/student/mappers/student_model.dart';

class StudentRepo {
  static const String serverUrl = "http://192.168.43.96:8080";

  final _dio = Dio();

  Future<List<StudentModel>> fetchStudents() async {
    try {
      final response = await _dio.get("$serverUrl/api/student/get");

      if (response.statusCode == 200) {
        final List<dynamic> studentList = response.data["data"];
        return studentList.map((student) {
          return StudentModel.fromJson(student);
        }).toList();
      } else {
        throw Exception("Error fetching student lists");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<StudentModel> fetchSingleStudent(String id) async {
    try {
      final response = await _dio.get("$serverUrl/api/student/get/$id");

      if (response.statusCode == 200) {
        final studentList = response.data["data"];
        return StudentModel.fromJson(studentList);
      } else {
        throw Exception("Error fetching student");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<bool> addStudent(
    String first,
    String last,
    String? year,
    String course,
    bool? enrolled,
  ) async {
    final payload = {
      "firstName": first,
      "lastName": last,
      "year": year,
      "course": course,
      "enrolled": enrolled
    };
    try {
      final response = await _dio.post(
        "$serverUrl/api/student/add",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(payload),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        Exception("Failed to add sutdent");
        return false;
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<StudentModel> updateStudent(
    String? id,
    String first,
    String last,
    String? year,
    String course,
    bool? enrolled,
  ) async {
    final payload = {
      "firstName": first,
      "lastName": last,
      "year": year,
      "course": course,
      "enrolled": enrolled
    };
    try {
      final response = await _dio.put(
        "$serverUrl/api/student/edit/$id",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final studentList = response.data["data"];
        return StudentModel.fromJson(studentList);
      } else {
        throw Exception("Error fetching student");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<bool> deleteStudent(String? id) async {
    try {
      final response = await _dio.delete("$serverUrl/api/student/delete/$id");

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
