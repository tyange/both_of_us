import 'package:flutter/material.dart';

import 'package:both_of_us/widgets/result_now_card.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
    required this.meName,
    required this.loverName,
    required this.firstDay,
  });

  final String meName;
  final String loverName;
  final DateTime firstDay;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<DateTime> _allAnniversaries = [];

  List<DateTime> _getAnniversaries(
      DateTime baseDay, int iterationCount, bool isSubtract) {
    List<DateTime> anniversaries = [];

    for (int i = iterationCount; i <= iterationCount + 2; i++) {
      DateTime hundredAnniversary = isSubtract
          ? baseDay.subtract(Duration(days: 100 * i))
          : baseDay.add(Duration(days: 100 * i));

      anniversaries.add(hundredAnniversary);
    }

    return anniversaries;
  }

  @override
  void initState() {
    super.initState();
    _allAnniversaries = [
      ..._getAnniversaries(widget.firstDay, 1, true),
      widget.firstDay,
      ..._getAnniversaries(widget.firstDay, 1, false)
    ];

    _allAnniversaries.sort((a, b) => a.compareTo(b));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWheelScrollView(
        itemExtent: 250,
        children: [
          for (final anniversary in _allAnniversaries)
            Text(
              anniversary.toString(),
            )
        ],
      ),
    );
  }
}
