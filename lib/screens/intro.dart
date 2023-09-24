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
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 100,
        elevation: 5,
        automaticallyImplyLeading: false,
        title: const Text('둘이서'),
      ),
      body: SafeArea(
        child: CenterColumn(
          children: [
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
