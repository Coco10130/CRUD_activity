import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_activity/components/my_input.dart';
import 'package:group_activity/components/my_snackbar.dart';
import 'package:group_activity/features/student/bloc/student_bloc.dart';

class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Add Student",
          style: TextStyle(
            color: Color(0xFFFFFEFF),
            fontSize: 24,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: const AddStudentBody(),
    );
  }
}

class AddStudentBody extends StatefulWidget {
  const AddStudentBody({super.key});

  @override
  State<AddStudentBody> createState() => _AddStudentBodyState();
}

class _AddStudentBodyState extends State<AddStudentBody> {
  String? year;
  bool? enrolled;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _courseController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double parentWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is AddStudentSuccessState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(mySnackBar(message: state.successMessage));
            _firstNameController.clear();
            _lastNameController.clear();
            _courseController.clear();
            setState(() {
              year = null;
              enrolled = null;
            });

            Navigator.pop(context, true);
          }

          if (state is AddStudentFailedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(mySnackBar(message: state.errorMessage));
          }
        },
        builder: (context, state) {
          if (state is StudentFetchLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyInput(
                  label: "First Name",
                  controller: _firstNameController,
                ),
                MyInput(
                  label: "Last Name",
                  controller: _lastNameController,
                ),
                MyInput(
                  label: "Course",
                  controller: _courseController,
                ),

                // year and enrolled
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // year
                    SizedBox(
                      width: parentWidth * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Year",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          DropdownButtonFormField<String>(
                            value: year,
                            items: const [
                              DropdownMenuItem(
                                  value: "First Year",
                                  child: Text("First Year",
                                      style: TextStyle(fontFamily: "Poppins"))),
                              DropdownMenuItem(
                                  value: "Second Year",
                                  child: Text("Second Year",
                                      style: TextStyle(fontFamily: "Poppins"))),
                              DropdownMenuItem(
                                  value: "Third Year",
                                  child: Text("Third Year",
                                      style: TextStyle(fontFamily: "Poppins"))),
                              DropdownMenuItem(
                                  value: "Fourth Year",
                                  child: Text("Fourth Year",
                                      style: TextStyle(fontFamily: "Poppins"))),
                              DropdownMenuItem(
                                  value: "Fifth Year",
                                  child: Text("Fifth Year",
                                      style: TextStyle(fontFamily: "Poppins"))),
                            ],
                            onChanged: (value) {
                              setState(() {
                                year = value;
                              });
                            },
                            hint: const Text("Select"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please select a year";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    // spacing
                    const SizedBox(
                      width: 10,
                    ),

                    // enrolled
                    SizedBox(
                      width: parentWidth * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Status",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          DropdownButtonFormField<bool>(
                            value: enrolled,
                            items: const [
                              DropdownMenuItem(
                                  value: true,
                                  child: Text("Enrolled",
                                      style: TextStyle(fontFamily: "Poppins"))),
                              DropdownMenuItem(
                                  value: false,
                                  child: Text("Not Enrolled",
                                      style: TextStyle(fontFamily: "Poppins"))),
                            ],
                            onChanged: (value) {
                              setState(() {
                                enrolled = value;
                              });
                            },
                            hint: const Text("Select"),
                            validator: (value) {
                              if (value == null) {
                                return "Please select a status";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // spacing
                const SizedBox(
                  height: 20,
                ),

                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () {
                      context.read<StudentBloc>().add(AddNewStudentEvent(
                            course: _courseController.text.trim(),
                            firstName: _firstNameController.text.trim(),
                            lastName: _lastNameController.text.trim(),
                            year: year,
                            enrolled: enrolled,
                          ));
                    },
                    child: const Text(
                      "Add Student",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
