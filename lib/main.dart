import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:both_of_us/screens/intro.dart';
import 'package:both_of_us/screens/result.dart';

void main() {
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? _meName;
  String? _loverName;
  String? _firstDay;

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _meName = prefs.getString('bou_me_name');
      _loverName = prefs.getString('bou_lover_name');
      _firstDay = prefs.getString('bou_first_day');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Both of us',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: _meName != null && _loverName != null && _firstDay != null
          ? ResultScreen(
              meName: _meName,
              loverName: _loverName,
              firstDay: DateTime(
                int.parse(_firstDay!.split("-")[0]),
                int.parse(_firstDay!.split("-")[1]),
                int.parse(_firstDay!.split("-")[2]),
              ),
            )
          : const IntroScreen(),
    );
  }
}
