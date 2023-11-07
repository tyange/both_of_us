import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:both_of_us/providers/user_info.dart';
import 'package:both_of_us/widgets/validate_alert_dialog.dart';
import 'package:both_of_us/screens/lover.dart';
import 'package:both_of_us/widgets/name_text_field_area.dart';

class MeScreen extends ConsumerStatefulWidget {
  const MeScreen({super.key});

  @override
  ConsumerState<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends ConsumerState<MeScreen> {
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

    ref.read(userInfoProvider.notifier).setMeName(_meNameController.text);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const LoverScreen(),
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
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        elevation: 5,
        title: const Text('둘이서'),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: NameTextFieldArea(
          controller: _meNameController,
          labelText: '당신의 이름은?',
          submittedName: _submittedMeName,
        ),
      ),
    );
  }
}
