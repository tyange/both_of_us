import 'package:flutter/material.dart';
import 'package:both_of_us/widgets/center_column.dart';

class NameTextFieldArea extends StatelessWidget {
  const NameTextFieldArea({
    super.key,
    required this.controller,
    required this.labelText,
    required this.submittedName,
  });

  final TextEditingController controller;
  final String labelText;
  final Function submittedName;

  @override
  Widget build(BuildContext context) {
    return CenterColumn(
      children: [
        SizedBox(
          width: 200,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            submittedName();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            elevation: 5,
          ),
          child: const Text('저장'),
        ),
      ],
    );
  }
}
