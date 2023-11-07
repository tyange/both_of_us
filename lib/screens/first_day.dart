import 'package:both_of_us/models/user_info.dart';
import 'package:both_of_us/providers/user_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:both_of_us/widgets/center_column.dart';
import 'package:both_of_us/screens/result.dart';

class FirstDayScreen extends ConsumerStatefulWidget {
  const FirstDayScreen({
    super.key,
  });

  @override
  ConsumerState<FirstDayScreen> createState() {
    return _FirstDayScreenState();
  }
}

class _FirstDayScreenState extends ConsumerState<FirstDayScreen> {
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

    ref.read(userInfoProvider.notifier).setFirstDay(_selectedDate!);
  }

  void _saveDataInPrefs() async {
    final userInfo = ref.read(userInfoProvider);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      "bou_me_name",
      userInfo.meName!,
    );
    prefs.setString(
      "bou_lover_name",
      userInfo.loverName!,
    );
    prefs.setString(
      "bou_first_day",
      DateFormat('yyyy-MM-dd').format(userInfo.firstDay!),
    );
  }

  void _navigateResultScreen() {
    _saveDataInPrefs();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ResultScreen(),
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
