import 'package:flutter/material.dart';

import 'package:both_of_us/widgets/validate_alert_dialog.dart';
import 'package:both_of_us/screens/first_day.dart';
import 'package:both_of_us/widgets/name_text_field_area.dart';

class LoverScreen extends StatefulWidget {
  const LoverScreen({
    super.key,
    required this.meName,
  });

  final String meName;

  @override
  State<LoverScreen> createState() => _LoverScreenState();
}

class _LoverScreenState extends State<LoverScreen> {
  final _loverNameController = TextEditingController();

  void _submittedLoverName() {
    if (_loverNameController.text.isEmpty ||
        _loverNameController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const ValidateAlertDialog(
          alertMessage: '이름을 입력해주세요.',
        ),
      );

      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FirstDayScreen(
          meName: widget.meName,
          loverName: _loverNameController.text,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loverNameController.dispose();
    super.dispose();
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
      body: NameTextFieldArea(
        controller: _loverNameController,
        labelText: '상대의 이름은?',
        submittedName: _submittedLoverName,
      ),
    );
  }
}
