import 'package:both_of_us/widgets/result_name.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResultName(name: meName),
              const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.favorite,
                size: 30,
                color: Colors.red,
              ),
              const SizedBox(
                width: 20,
              ),
              ResultName(name: loverName),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            '$date일',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
