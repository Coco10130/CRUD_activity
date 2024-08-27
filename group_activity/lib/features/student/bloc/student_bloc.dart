import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:group_activity/features/student/mappers/student_model.dart';
import 'package:group_activity/features/student/repos/students_repo.dart';
import 'package:meta/meta.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<StudentsInitialFetchEvent>(studentsInitialFetchEvent);
    on<AddNewStudentEvent>(addNewStudentEvent);
    on<GetStudentEvent>(getStudentEvent);
    on<UpdateStudentEvent>(updateStudentEvent);
    on<DeleteStudentEvent>(deleteStudentEvent);
  }

  FutureOr<void> studentsInitialFetchEvent(
      StudentsInitialFetchEvent event, Emitter<StudentState> emit) async {
    emit(StudentFetchLoadingState());
    try {
      final students = await StudentRepo().fetchStudents();
      emit(StudentFetchSuccessfulState(students: students));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  FutureOr<void> addNewStudentEvent(
      AddNewStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentFetchLoadingState());
    try {
      final firstName = event.firstName;
      final lastName = event.lastName;
      final year = event.year;
      final course = event.course;
      final enrolled = event.enrolled;

      if (firstName.isEmpty) {
        return emit(
            AddStudentFailedState(errorMessage: "Please enter First name"));
      } else if (lastName.isEmpty) {
        return emit(
            AddStudentFailedState(errorMessage: "Please enter Last name"));
      } else if (course.isEmpty) {
        return emit(AddStudentFailedState(errorMessage: "Please enter Course"));
      } else if (year == null) {
        return emit(
            AddStudentFailedState(errorMessage: "Please enter Year Level"));
      } else if (enrolled == null) {
        return emit(AddStudentFailedState(errorMessage: "Please enter Status"));
      }

      final response = await StudentRepo().addStudent(
        firstName,
        lastName,
        year,
        course,
        enrolled,
      );

      if (response) {
        emit(AddStudentSuccessState(
            successMessage: "Student added successfully"));
      } else {
        emit(AddStudentFailedState(errorMessage: "Failed to add student"));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  FutureOr<void> getStudentEvent(
      GetStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentFetchLoadingState());

    try {
      final student = await StudentRepo().fetchSingleStudent(event.id);
      emit(FetchStudentSuccessState(student: student));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  FutureOr<void> updateStudentEvent(
      UpdateStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentFetchLoadingState());
    try {
      final student = await StudentRepo().updateStudent(
        event.id,
        event.firstName,
        event.lastName,
        event.year,
        event.course,
        event.enrolled,
      );

      emit(UpdateStudentSuccessState(
          successMessage: "Student updated successfully", student: student));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  FutureOr<void> deleteStudentEvent(
      DeleteStudentEvent event, Emitter<StudentState> emit) async {
    emit(StudentFetchLoadingState());

    try {
      final success = await StudentRepo().deleteStudent(event.id);

      if (success) {
        emit(DeleteStudentSuccessState(
            successMessage: "Student deleted successfully"));
      } else {
        emit(DeleteStudentFailedState(errorMessage: "Error deleting student"));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
