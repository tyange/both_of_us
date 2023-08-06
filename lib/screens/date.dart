import 'package:flutter/material.dart';

import 'package:both_of_us/widgets/center_column.dart';
import 'package:both_of_us/screens/result.dart';

class DateScreen extends StatefulWidget {
  DateScreen({
    super.key,
    required this.meName,
    required this.loverName,
  });

  String meName;
  String loverName;

  @override
  State<DateScreen> createState() {
    return _DateScreenState();
  }
}

class _DateScreenState extends State<DateScreen> {
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
