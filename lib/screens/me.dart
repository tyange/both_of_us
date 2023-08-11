import 'package:flutter/material.dart';

import 'package:both_of_us/widgets/center_column.dart';
import 'package:both_of_us/screens/lover.dart';

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
        builder: (BuildContext context) => AlertDialog(
          title: const Text('에러'),
          content: const Text('이름을 입력해주세요.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK')),
          ],
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
      body: CenterColumn(
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: _meNameController,
              decoration: const InputDecoration(
                labelText: '당신의 이름은?',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _submittedMeName,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              elevation: 5,
            ),
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }
}
