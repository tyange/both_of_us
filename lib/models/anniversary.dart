import 'package:flutter/material.dart';

class Anniversary {
  Anniversary({
    required this.date,
    required this.displayTitle,
    required this.bgColor,
  });

  final DateTime date;
  String displayTitle;
  Color bgColor;
}
