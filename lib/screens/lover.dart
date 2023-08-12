import 'package:flutter/material.dart';

import 'package:both_of_us/widgets/validate_alert_dialog.dart';
import 'package:both_of_us/screens/first_time.dart';
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
        builder: (BuildContext context) => const ValidateAlertDialog(),
      );

      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => FirstTimeScreen(
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
      resizeToAvoidBottomInset: false,
      body: NameTextFieldArea(
        controller: _loverNameController,
        labelText: '상대의 이름은?',
        submittedName: _submittedLoverName,
      ),
    );
  }
}
