import 'package:flutter/material.dart';

import 'package:both_of_us/screens/me.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Both of us',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MeScreen(),
    ),
  );
}
