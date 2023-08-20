import 'package:both_of_us/models/anniversary.dart';
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
  List<Anniversary> _allAnniversaries = [];

  int _getDays(DateTime day) {
    return day.difference(DateTime.now()).inDays;
  }

  bool _isLeapYear(int year) {
    if (year % 4 == 0) {
      if (year % 100 == 0) {
        if (year % 400 == 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Set<Anniversary> _getAnniversaries(
      DateTime firstDay, int interval, int iterationTime) {
    List<Anniversary> anniversaries = [];

    DateTime targetDate = DateTime(
      DateTime.now().year + iterationTime,
      DateTime.now().month,
      DateTime.now().day,
    );

    DateTime targetAnniversary = firstDay;

    while (targetAnniversary.isBefore(targetDate)) {
      anniversaries
          .add(Anniversary(date: targetAnniversary, isFirstDay: false));

      targetAnniversary = targetAnniversary.add(
        Duration(
          days: interval == 365 && _isLeapYear(targetAnniversary.year + 1)
              ? interval + 1
              : interval,
        ),
      );
    }

    return Set<Anniversary>.from(anniversaries);
  }

  String _displayDays(DateTime date, DateTime firstDay) {
    int days = date.difference(firstDay).inDays;

    if (days <= 0) {
      return (days + 1).toString();
    }

    return days.toString();
  }

  @override
  void initState() {
    super.initState();

    List<Anniversary> anniversaries() {
      Set<Anniversary> yearAnniversary =
          _getAnniversaries(widget.firstDay, 365, 2);
      Set<Anniversary> hundredAnniversary =
          _getAnniversaries(widget.firstDay, 100, 2);
      Set<Anniversary> intersection =
          hundredAnniversary.intersection(yearAnniversary);

      for (Anniversary anniversary in intersection) {
        yearAnniversary.remove(anniversary);
      }

      yearAnniversary.addAll(hundredAnniversary);

      List<Anniversary> calculatedAnniversaries = yearAnniversary.toList();

      Anniversary currentDay = Anniversary(
        date: DateTime.now(),
        isFirstDay: true,
      );

      calculatedAnniversaries.add(currentDay);

      calculatedAnniversaries.sort((a, b) => a.date.compareTo(b.date));

      return calculatedAnniversaries;
    }

    _allAnniversaries = [...anniversaries()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWheelScrollView(
        itemExtent: 250,
        children: [
          for (final anniversary in _allAnniversaries)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  anniversary.date.toString(),
                  style: TextStyle(
                    color: anniversary.isFirstDay ? Colors.red : Colors.black,
                  ),
                ),
                Text(
                  _displayDays(anniversary.date, widget.firstDay),
                  style: TextStyle(
                    color: anniversary.isFirstDay ? Colors.red : Colors.black,
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}
