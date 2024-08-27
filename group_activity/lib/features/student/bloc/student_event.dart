part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}

final class StudentsInitialFetchEvent extends StudentEvent {}

final class AddNewStudentEvent extends StudentEvent {
  final String firstName;
  final String lastName;
  final String course;
  final String? year;
  final bool? enrolled;

  AddNewStudentEvent(
      {required this.firstName,
      required this.lastName,
      required this.course,
      required this.year,
      required this.enrolled});
}

final class GetStudentEvent extends StudentEvent {
  final String id;

  GetStudentEvent({required this.id});
}

final class UpdateStudentEvent extends StudentEvent {
  final String? id;
  final String firstName;
  final String lastName;
  final String course;
  final String? year;
  final bool? enrolled;

  UpdateStudentEvent({
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
    required this.id,
  });
}

final class DeleteStudentEvent extends StudentEvent {
  final String? id;

  DeleteStudentEvent({required this.id});
}
