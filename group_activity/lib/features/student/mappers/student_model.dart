class StudentModel {
  final String firstName;
  final String lastName;
  final String year;
  final String course;
  final bool enrolled;
  final String id;

  StudentModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.year,
    required this.course,
    required this.enrolled,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json["_id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      year: json["year"],
      course: json["course"],
      enrolled: json["enrolled"],
    );
  }
}
