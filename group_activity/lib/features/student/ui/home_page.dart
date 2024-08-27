import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_activity/components/my_container.dart';
import 'package:group_activity/features/student/bloc/student_bloc.dart';
import 'package:group_activity/features/student/ui/add_student.dart';
import 'package:group_activity/features/student/ui/update_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(StudentsInitialFetchEvent());
  }

  void _fetchStudents() {
    context.read<StudentBloc>().add(StudentsInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Students",
          style: TextStyle(
            color: Color(0xFFFFFEFF),
            fontSize: 24,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BodyPage(fetchStudents: _fetchStudents),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStudent()),
          );

          if (result == true) {
            _fetchStudents();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BodyPage extends StatefulWidget {
  final VoidCallback fetchStudents;
  const BodyPage({super.key, required this.fetchStudents});

  @override
  State<BodyPage> createState() => _BodyPageState();
}

class _BodyPageState extends State<BodyPage> {
  Future<void> _refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentFetchLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StudentFetchSuccessfulState) {
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: state.students.length,
                itemBuilder: (context, index) {
                  final student = state.students[index];
                  final id = student.id;
                  return MyContainer(
                    name: "${student.firstName} ${student.lastName}",
                    course: student.course,
                    year: student.year,
                    enrolled: student.enrolled,
                    onPressed: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpdatePage(
                            uid: id,
                          ),
                        ),
                      );
                      if (result == true) {
                        widget.fetchStudents();
                      }
                    },
                  );
                },
              ),
            );
          } else if (state is StudentFetchFailedState) {
            return Center(
              child: Text("Error: ${state.errorMessage}"),
            );
          } else {
            return const Center(
              child: Text("No Data available"),
            );
          }
        },
      ),
    );
  }
}
