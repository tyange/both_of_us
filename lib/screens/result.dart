import 'package:flutter/material.dart';

import 'package:both_of_us/widgets/center_column.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({
    super.key,
    required this.meName,
    required this.loverName,
    required this.date,
  });

  String meName;
  String loverName;
  String date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CenterColumn(
        children: [
          Text(meName),
          Text(loverName),
          Text(date),
        ],
      ),
    );
  }
}
