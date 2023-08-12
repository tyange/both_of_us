import 'package:flutter/material.dart';

class ValidateAlertDialog extends StatelessWidget {
  const ValidateAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('에러'),
      content: const Text('이름을 입력해주세요.'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK')),
      ],
    );
  }
}
