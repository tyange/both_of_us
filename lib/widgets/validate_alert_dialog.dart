import 'package:flutter/material.dart';

class ValidateAlertDialog extends StatelessWidget {
  const ValidateAlertDialog({
    super.key,
    required this.alertMessage,
  });

  final String alertMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('에러'),
      content: Text(alertMessage),
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
