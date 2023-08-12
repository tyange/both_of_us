import 'package:flutter/material.dart';

import 'package:both_of_us/widgets/center_column.dart';
import 'package:both_of_us/screens/result.dart';

class FirstTimeScreen extends StatefulWidget {
  const FirstTimeScreen({
    super.key,
    required this.meName,
    required this.loverName,
  });

  final String meName;
  final String loverName;

  @override
  State<FirstTimeScreen> createState() {
    return _FirstTimeScreenState();
  }
}

class _FirstTimeScreenState extends State<FirstTimeScreen> {
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ResultScreen(
          meName: widget.meName,
          loverName: widget.loverName,
          date: (now.day - _selectedDate!.day + 1).toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CenterColumn(
        children: [
          ElevatedButton(
            onPressed: _presentDatePicker,
            child: const Text('처음 만난 날은?'),
          ),
        ],
      ),
    );
  }
}
