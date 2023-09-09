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
  late FixedExtentScrollController controller;

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
    List<DateTime> anniversariesDate = [];

    DateTime targetAnniversaryDate = firstDay;

    while (targetAnniversaryDate.isBefore(beforeDate)) {
      anniversariesDate.add(targetAnniversaryDate);

      targetAnniversaryDate = targetAnniversaryDate.add(
        Duration(
          days: interval == 365 && _isLeapYear(targetAnniversaryDate.year + 1)
              ? interval + 1
              : interval,
        ),
      );
    }

    anniversariesDate.add(nowDate);

    return Set.from(anniversariesDate);
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

  void _jumpToCurrentDay() {
    int currentDayAnniversaryIndex =
        _allAnniversaries.indexWhere((element) => element.isCurrentDay);

    if (currentDayAnniversaryIndex == -1) {
      return;
    }

    controller.animateTo(
      currentDayAnniversaryIndex * 100,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.linear,
    );
  }

  @override
  void initState() {
    super.initState();

    controller = FixedExtentScrollController();

    List<Anniversary> allAnniversaries =
        _getAnniversaryList(nowDate, widget.firstDay);

    _targetDate = DateTime(nowDate.year + 1, nowDate.month, nowDate.day);
    _allAnniversaries = [...allAnniversaries];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('both of us'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            tooltip: 'Open shopping cart',
            onPressed: () {
              _jumpToCurrentDay();
            },
          ),
        ],
      ),
      body: ListWheelScrollView(
        onSelectedItemChanged: (value) {
          if (_allAnniversaries.length == value + 1) {
            _onSelectedItemChangedHandler();
          }
        },
        itemExtent: 100,
        squeeze: 0.5,
        physics: const FixedExtentScrollPhysics(),
        controller: controller,
        children: [
          for (final anniversary in _allAnniversaries)
            Container(
              width: 300,
              child: Card(
                elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      anniversary.date.toString(),
                      style: TextStyle(
                        color: anniversary.isCurrentDay
                            ? Colors.red
                            : Colors.black,
                      ),
                    ),
                    Text(
                      _displayDays(anniversary.date, widget.firstDay),
                      style: TextStyle(
                        color: anniversary.isCurrentDay
                            ? Colors.red
                            : Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
