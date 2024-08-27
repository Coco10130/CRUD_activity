import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const MyInput({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // label
          Text(
            label,
            style: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          TextField(
            controller: controller,
            style: const TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
