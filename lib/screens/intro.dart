import 'package:both_of_us/screens/me.dart';
import 'package:both_of_us/widgets/center_column.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  void onStart(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const MeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CenterColumn(
          children: [
            const Text(
              '우리 둘',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onStart(context);
              },
              child: const Text('시작'),
            ),
          ],
        ),
      ),
    );
  }
}
