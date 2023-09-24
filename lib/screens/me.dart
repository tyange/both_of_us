import 'package:flutter/material.dart';

import 'package:both_of_us/widgets/validate_alert_dialog.dart';
import 'package:both_of_us/screens/lover.dart';
import 'package:both_of_us/widgets/name_text_field_area.dart';

class MeScreen extends StatefulWidget {
  const MeScreen({super.key});

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  final _meNameController = TextEditingController();

  void _submittedMeName() {
    if (_meNameController.text.isEmpty ||
        _meNameController.text.trim().isEmpty) {
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
        builder: (ctx) => LoverScreen(
          meName: _meNameController.text,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _meNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NameTextFieldArea(
        controller: _meNameController,
        labelText: '당신의 이름은?',
        submittedName: _submittedMeName,
      ),
    );
  }
}
