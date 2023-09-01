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

  Set<DateTime> _getAnniversaries(
      DateTime beforeDate, DateTime firstDay, int interval) {
    List<DateTime> anniversaries = [];

    DateTime targetAnniversaryDate = firstDay;

    while (targetAnniversaryDate.isBefore(beforeDate)) {
      anniversaries.add(targetAnniversaryDate);

      targetAnniversaryDate = targetAnniversaryDate.add(
        Duration(
          days: interval == 365 && _isLeapYear(targetAnniversaryDate.year + 1)
              ? interval + 1
              : interval,
        ),
      );
    }

    return Set.from(anniversaries);
  }

  String _displayDays(DateTime date, DateTime firstDay) {
    int days = date.difference(firstDay).inDays;

    if (days <= 0) {
      return (days + 1).toString();
    }

    return days.toString();
  }

  List<Anniversary> _getAnniversaryList(
      DateTime targetDate, DateTime firstDay) {
    Set<DateTime> yearAnniversaries =
        _getAnniversaries(targetDate, firstDay, 365);
    Set<DateTime> hundredAnniversaries =
        _getAnniversaries(targetDate, firstDay, 100);

    List<DateTime> calculatedAnniversariesDate =
        yearAnniversaries.union(hundredAnniversaries).toList();

    List<Anniversary> anniversaries = [];

    for (DateTime anniversaryDate in calculatedAnniversariesDate) {
      anniversaries.add(Anniversary(
        date: anniversaryDate,
        isCurrentDay: anniversaryDate == nowDate,
      ));
    }

    anniversaries.add(Anniversary(
      date: firstDay,
      isCurrentDay: false,
    ));

    if (targetDate != nowDate) {
      Anniversary currentDayAnniversary =
          anniversaries.firstWhere((element) => element.date == nowDate);
      int currentDayAnniversaryIndex =
          anniversaries.indexOf(currentDayAnniversary);
      anniversaries[currentDayAnniversaryIndex].isCurrentDay = true;
    }

    anniversaries.removeAt(0);
    anniversaries.sort((a, b) => a.date.compareTo(b.date));

    return anniversaries;
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
