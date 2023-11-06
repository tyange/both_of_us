import 'package:both_of_us/providers/user_info.dart';
import 'package:flutter/material.dart';

import 'package:both_of_us/widgets/validate_alert_dialog.dart';
import 'package:both_of_us/screens/first_day.dart';
import 'package:both_of_us/widgets/name_text_field_area.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoverScreen extends ConsumerStatefulWidget {
  const LoverScreen({
    super.key,
  });

  @override
  ConsumerState<LoverScreen> createState() => _LoverScreenState();
}

class _LoverScreenState extends ConsumerState<LoverScreen> {
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

    ref.read(userInfoProvider.notifier).setLoverName(_loverNameController.text);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const FirstDayScreen(),
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
      body: SafeArea(
        child: NameTextFieldArea(
          controller: _loverNameController,
          labelText: '상대의 이름은?',
          submittedName: _submittedLoverName,
        ),
      ),
    );
  }
}
