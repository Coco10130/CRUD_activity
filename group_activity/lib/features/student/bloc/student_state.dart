part of 'student_bloc.dart';

@immutable
sealed class StudentState {}

sealed class StudentActionState extends StudentState {}

final class StudentInitial extends StudentState {}

final class StudentFetchSuccessfulState extends StudentState {
  final List<StudentModel> students;

  StudentFetchSuccessfulState({required this.students});
}

final class StudentFetchFailedState extends StudentState {
  final String errorMessage;

  StudentFetchFailedState({required this.errorMessage});
}

final class AddStudentSuccessState extends StudentActionState {
  final String successMessage;

  AddStudentSuccessState({required this.successMessage});
}

final class AddStudentFailedState extends StudentActionState {
  final String errorMessage;

  AddStudentFailedState({required this.errorMessage});
}

final class FetchStudentSuccessState extends StudentActionState {
  final StudentModel student;

  FetchStudentSuccessState({required this.student});
}

final class FetchStudentFailedState extends StudentActionState {
  final String errorMessage;

  FetchStudentFailedState({required this.errorMessage});
}

final class UpdateStudentSuccessState extends StudentActionState {
  final String successMessage;
  final StudentModel student;

  UpdateStudentSuccessState(
      {required this.successMessage, required this.student});
}

final class UpdateStudentFailedState extends StudentActionState {
  final String errorMessage;

  UpdateStudentFailedState({required this.errorMessage});
}

final class DeleteStudentSuccessState extends StudentActionState {
  final String successMessage;

  DeleteStudentSuccessState({required this.successMessage});
}

final class DeleteStudentFailedState extends StudentActionState {
  final String errorMessage;

  DeleteStudentFailedState({required this.errorMessage});
}

final class StudentFetchLoadingState extends StudentState {}
