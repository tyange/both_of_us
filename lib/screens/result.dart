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
  DateTime? _targetDate;

  DateTime get nowDate {
    return DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
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
      DateTime beforeDate, DateTime firstDay, int interval) {
    List<Anniversary> anniversaries = [];

    DateTime targetAnniversaryDate = firstDay;

    while (targetAnniversaryDate.isBefore(beforeDate)) {
      anniversaries.add(Anniversary(
          date: targetAnniversaryDate,
          isCurrentDay: false,
          interval: interval));

      targetAnniversaryDate = targetAnniversaryDate.add(
        Duration(
          days: interval == 365 && _isLeapYear(targetAnniversaryDate.year + 1)
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

  List<Anniversary> _calculateAnniversaries(
    Set<Anniversary> yearAnniversaries,
    Set<Anniversary> hundredAnniversaries,
  ) {
    Set<Anniversary> yearAnniversary = yearAnniversaries;
    Set<Anniversary> hundredAnniversary = hundredAnniversaries;
    Set<Anniversary> intersection =
        hundredAnniversary.intersection(yearAnniversary);

    for (Anniversary anniversary in intersection) {
      yearAnniversary.remove(anniversary);
    }

    yearAnniversary.addAll(hundredAnniversary);

    List<Anniversary> calculatedAnniversaries = yearAnniversary.toList();

    return calculatedAnniversaries;
  }

  List<Anniversary> _getAnniversaryList(
      DateTime targetDate, DateTime firstDay) {
    Set<Anniversary> yearAnniversaries =
        _getAnniversaries(targetDate, firstDay, 365);
    Set<Anniversary> hundredAnniversaries =
        _getAnniversaries(targetDate, firstDay, 100);

    List<Anniversary> calculatedAnniversaries =
        _calculateAnniversaries(yearAnniversaries, hundredAnniversaries);

    if (targetDate != nowDate) {
      Anniversary currentDayAnniversary = calculatedAnniversaries
          .firstWhere((element) => element.date == nowDate);
      int currentDayAnniversaryIndex =
          calculatedAnniversaries.indexOf(currentDayAnniversary);
      calculatedAnniversaries[currentDayAnniversaryIndex].isCurrentDay = true;
    }

    // calculatedAnniversaries.removeAt(0);
    calculatedAnniversaries.sort((a, b) => a.date.compareTo(b.date));

    return calculatedAnniversaries;
  }

  void _onSelectedItemChangedHandler() {
    List<Anniversary> futureAnniversaries =
        _getAnniversaryList(_targetDate!, widget.firstDay);

    _targetDate =
        DateTime(_targetDate!.year + 1, _targetDate!.month, _targetDate!.day);

    setState(() {
      _allAnniversaries = [...futureAnniversaries];
    });
  }

  @override
  void initState() {
    super.initState();

    List<Anniversary> allAnniversaries =
        _getAnniversaryList(nowDate, widget.firstDay);

    _targetDate = DateTime(nowDate.year + 1, nowDate.month, nowDate.day);
    _allAnniversaries = [...allAnniversaries];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListWheelScrollView(
        onSelectedItemChanged: (value) {
          if (_allAnniversaries.length == value + 1) {
            _onSelectedItemChangedHandler();
          }
        },
        itemExtent: 250,
        children: [
          for (final anniversary in _allAnniversaries)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  anniversary.date.toString(),
                  style: TextStyle(
                    color: anniversary.isCurrentDay ? Colors.red : Colors.black,
                  ),
                ),
                Text(
                  _displayDays(anniversary.date, widget.firstDay),
                  style: TextStyle(
                    color: anniversary.isCurrentDay ? Colors.red : Colors.black,
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}
