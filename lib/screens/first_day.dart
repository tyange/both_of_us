import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:both_of_us/widgets/center_column.dart';
import 'package:both_of_us/screens/result.dart';

class FirstDayScreen extends StatefulWidget {
  const FirstDayScreen({
    super.key,
    required this.meName,
    required this.loverName,
  });

  final String meName;
  final String loverName;

  @override
  State<FirstDayScreen> createState() {
    return _FirstDayScreenState();
  }
}

class _FirstDayScreenState extends State<FirstDayScreen> {
  DateTime? _selectedDate;

  final now = DateTime.now();

  void _presentDatePicker(DateTime? selectedDate) async {
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _navigateResultScreen() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      "bou_me_name",
      widget.meName,
    );
    prefs.setString(
      "bou_lover_name",
      widget.loverName,
    );
    prefs.setString(
      "bou_first_day",
      DateFormat('yyyy-MM-dd').format(_selectedDate!),
    );

    if (!context.mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ResultScreen(
          meName: widget.meName,
          loverName: widget.loverName,
          firstDay: _selectedDate!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        elevation: 5,
        title: const Text('둘이서'),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CenterColumn(
          children: [
            if (_selectedDate == null)
              ElevatedButton(
                onPressed: () {
                  _presentDatePicker(null);
                },
                child: const Text('처음 만난 날은?'),
              )
            else ...[
              OutlinedButton(
                onPressed: () {
                  _presentDatePicker(_selectedDate);
                },
                child: Text(
                  DateFormat('yyyy-MM-dd').format(_selectedDate!).toString(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _navigateResultScreen,
                child: const Text('기념일 확인하기'),
              )
            ]
          ],
        ),
      ),
    );
  }
}
