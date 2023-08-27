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
  Anniversary? _lastAnniversary;

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

  bool _isAnniversary(DateTime firstDay, DateTime currentDate) {
    Duration diff = firstDay.difference(currentDate);
    int diffInDays = diff.inDays;

    bool isHundredAnniversary = diffInDays % 100 == 0;
    bool isYearAnniversary =
        firstDay.month == currentDate.month && firstDay.day == currentDate.day;

    return isHundredAnniversary || isYearAnniversary;
  }

  Set<Anniversary> _getAnniversaries(DateTime firstDay, int interval) {
    List<Anniversary> anniversaries = [];

    DateTime targetAnniversaryDate = firstDay;

    while (targetAnniversaryDate.isBefore(nowDate)) {
      anniversaries.add(Anniversary(
        date: targetAnniversaryDate,
        isCurrentDay: false,
      ));

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

  void _getFutureAnniversaries() {
    List<Anniversary> anniversaries = [];

    DateTime nowDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    DateTime targetAnniversaryDate = _lastAnniversary!.date;

    print(targetAnniversaryDate);
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

  void _onSelectedItemChangedHandler() {
    _getFutureAnniversaries();
  }

  @override
  void initState() {
    super.initState();

    List<Anniversary> anniversaries() {
      Set<Anniversary> yearAnniversaries =
          _getAnniversaries(widget.firstDay, 365);
      Set<Anniversary> hundredAnniversaries =
          _getAnniversaries(widget.firstDay, 100);

      List<Anniversary> calculatedAnniversaries =
          _calculateAnniversaries(yearAnniversaries, hundredAnniversaries);

      calculatedAnniversaries.sort((a, b) => a.date.compareTo(b.date));

      Anniversary currentDay = Anniversary(
        date: nowDate,
        isCurrentDay: true,
      );
      calculatedAnniversaries.add(currentDay);

      if (_isAnniversary(widget.firstDay, currentDay.date)) {
        _lastAnniversary =
            calculatedAnniversaries[calculatedAnniversaries.length - 1];
      } else {
        _lastAnniversary =
            calculatedAnniversaries[calculatedAnniversaries.length - 2];
      }

      return calculatedAnniversaries;
    }

    List<Anniversary> allAnniversaries = anniversaries();

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
