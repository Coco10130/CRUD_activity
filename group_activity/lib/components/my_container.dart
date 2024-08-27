import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final String name;
  final String course;
  final String year;
  final bool enrolled;
  final VoidCallback onPressed;

  const MyContainer({
    super.key,
    required this.name,
    required this.course,
    required this.year,
    required this.enrolled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const double spacing = 5;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xFFf9f9f9),
          padding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              width: 2.0,
              color: Color(0xFF000000),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // name
            Text(
              name,
              style: const TextStyle(
                color: Color(0xFF000000),
                fontFamily: "Poppins",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            // spacing
            const SizedBox(
              height: spacing,
            ),

            // course and year
            Row(
              children: [
                //course
                Text(
                  course,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontFamily: "Poppins",
                    fontSize: 12,
                  ),
                ),

                // spacing
                const SizedBox(
                  width: spacing,
                ),

                // year
                Text(
                  year,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontFamily: "Poppins",
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            // spacing
            const SizedBox(
              height: spacing,
            ),

            // enrolled
            Text(
              enrolled ? "Enrolled" : "Not Enrolled",
              style: const TextStyle(
                color: Color(0xFF000000),
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
