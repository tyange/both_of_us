import 'package:flutter/material.dart';

import 'package:both_of_us/screens/intro.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Both of us',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const IntroScreen(),
    );
  }
}
