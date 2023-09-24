import 'package:both_of_us/screens/result.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:both_of_us/widgets/center_column.dart';
import 'package:both_of_us/widgets/validate_alert_dialog.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    super.key,
    required this.meName,
    required this.loverName,
    required this.firstDay,
  });

  final String meName;
  final String loverName;
  final DateTime firstDay;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _meNameController;
  late TextEditingController _loverNameController;
  late DateTime _firstDay;

  final now = DateTime.now();

  void _presentDatePicker(DateTime? selectedDate) async {
    final firstDate = DateTime(now.year - 100, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (!context.mounted) return;

    if (pickedDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const ValidateAlertDialog(
          alertMessage: '날짜를 입력해주세요.',
        ),
      );

      return;
    }

    setState(() {
      _firstDay = pickedDate;
    });
  }

  void saveEdit() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ResultScreen(
          meName: _meNameController.text,
          loverName: _loverNameController.text,
          firstDay: _firstDay,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _meNameController = TextEditingController(
      text: widget.meName,
    );
    _loverNameController = TextEditingController(
      text: widget.loverName,
    );
    _firstDay = widget.firstDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CenterColumn(
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: _meNameController,
              decoration: const InputDecoration(
                labelText: '당신의 이름',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 200,
            child: TextField(
              controller: _loverNameController,
              decoration: const InputDecoration(
                labelText: '상대의 이름',
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '처음 만난 날',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      DateFormat('yyyy - MM -dd').format(_firstDay),
                    ),
                    onPressed: () {
                      _presentDatePicker(_firstDay);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () {
                    saveEdit();
                  },
                  child: const Text('저장'),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('취소'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
