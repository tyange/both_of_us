import 'package:flutter/material.dart';

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
  List<Map<String, dynamic>> _allAnniversaries = [];

  int _getDays(DateTime day) {
    return day.difference(DateTime.now()).inDays + 1;
  }

  List<Map<String, dynamic>> _getAnniversaries(
      DateTime baseDay, int iterationCount, bool isSubtract) {
    List<Map<String, dynamic>> anniversaries = [];

    for (int i = 1; i <= 1 + iterationCount; i++) {
      DateTime hundredAnniversary = isSubtract
          ? baseDay.subtract(Duration(days: 100 * i))
          : baseDay.add(Duration(days: 100 * i));

      anniversaries.add({
        "date": hundredAnniversary,
        "isFirstDay": false,
      });
    }

    return anniversaries;
  }

  String _displayDays(DateTime date) {
    int days = date.difference(DateTime.now()).inDays;

    if (days > 0) {
      return (days + 1).toString();
    }

    return days.toString();
  }

  @override
  void initState() {
    super.initState();

    int difference = _getDays(widget.firstDay) - 1;

    Map<String, dynamic> firstDayAnniversary = {
      'date': widget.firstDay,
      'isFirstDay': true,
    };

    if (difference <= -300) {
      _allAnniversaries = [
        ..._getAnniversaries(widget.firstDay, 2, true),
        firstDayAnniversary,
        ..._getAnniversaries(widget.firstDay, 2, false)
      ];
    } else if (difference <= -200) {
      _allAnniversaries = [
        ..._getAnniversaries(widget.firstDay, 1, true),
        firstDayAnniversary,
        ..._getAnniversaries(widget.firstDay, 2, false)
      ];
    } else {
      _allAnniversaries = [
        firstDayAnniversary,
        ..._getAnniversaries(widget.firstDay, 2, false)
      ];
    }

    _allAnniversaries.sort((a, b) => a['date'].compareTo(b['date']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWheelScrollView(
        itemExtent: 250,
        children: [
          for (final anniversary in _allAnniversaries)
            Text(
              _displayDays(anniversary['date']),
              style: TextStyle(
                color: anniversary['isFirstDay'] ? Colors.red : Colors.black,
              ),
            )
        ],
      ),
    );
  }
}
