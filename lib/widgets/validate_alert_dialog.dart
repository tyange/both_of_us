import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ValidateAlertDialog extends StatelessWidget {
  const ValidateAlertDialog({
    super.key,
    required this.alertMessage,
  });

  final String alertMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '에러',
        style: GoogleFonts.hahmlet(),
      ),
      content: Text(
        alertMessage,
        style: GoogleFonts.hahmlet(),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: GoogleFonts.hahmlet(),
            )),
      ],
    );
  }
}
