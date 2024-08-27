import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_activity/components/my_input.dart';
import 'package:group_activity/components/my_snackbar.dart';
import 'package:group_activity/features/student/bloc/student_bloc.dart';

class UpdatePage extends StatefulWidget {
  final String uid;
  const UpdatePage({super.key, required this.uid});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<StudentBloc>(context).add(GetStudentEvent(id: widget.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Student Details",
          style: TextStyle(
            color: Color(0xFFFFFEFF),
            fontSize: 24,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: const UpdatePageBody(),
    );
  }
}

class UpdatePageBody extends StatefulWidget {
  const UpdatePageBody({super.key});

  @override
  State<UpdatePageBody> createState() => _UpdatePageBodyState();
}

class _UpdatePageBodyState extends State<UpdatePageBody> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _courseController = TextEditingController();
  String? year;
  bool? enrolled;
  String? id;

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

    return BlocConsumer<StudentBloc, StudentState>(listener: (context, state) {
      if (state is UpdateStudentSuccessState) {
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

      if (state is UpdateStudentFailedState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackBar(message: state.errorMessage));
        _firstNameController.clear();
        _lastNameController.clear();
        _courseController.clear();
        setState(() {
          year = null;
          enrolled = null;
        });
      }

      if (state is DeleteStudentSuccessState) {
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

      if (state is DeleteStudentFailedState) {
        ScaffoldMessenger.of(context)
            .showSnackBar(mySnackBar(message: state.errorMessage));
        _firstNameController.clear();
        _lastNameController.clear();
        _courseController.clear();
        setState(() {
          year = null;
          enrolled = null;
        });
      }
    }, builder: (context, state) {
      if (state is FetchStudentSuccessState ||
          state is UpdateStudentSuccessState) {
        final student = (state as dynamic).student;

        _firstNameController.text = student.firstName;
        _lastNameController.text = student.lastName;
        _courseController.text = student.course;
        year = student.year;
        enrolled = student.enrolled;
        id = student.id;

        return SingleChildScrollView(
          child: Padding(
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
                              year = value;
                            },
                            hint: const Text("Select"),
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
                              enrolled = value;
                            },
                            hint: const Text("Select"),
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: () {
                        context.read<StudentBloc>().add(UpdateStudentEvent(
                              id: id,
                              course: _courseController.text.trim(),
                              firstName: _firstNameController.text.trim(),
                              lastName: _lastNameController.text.trim(),
                              year: year,
                              enrolled: enrolled,
                            ));
                      },
                      child: const Text(
                        "Update Student",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 14,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: () {
                        context
                            .read<StudentBloc>()
                            .add(DeleteStudentEvent(id: id));
                      },
                      child: const Text(
                        "Delete Student",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
