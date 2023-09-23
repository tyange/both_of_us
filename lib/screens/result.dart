import 'package:both_of_us/models/anniversary.dart';
import 'package:both_of_us/widgets/anniversary_card.dart';
import 'package:flutter/material.dart';

const Map<String, int> anniversaryInterval = {
  "hundred": 100,
  "year": 365,
};

const double extent = 120.0;

const int firstDayColorHex = 0xffFBF0B2;
const int currentDayColorHex = 0xffFFC7EA;
const int yearAnniversaryColorHex = 0xffD8B4F8;
const int hundredAnniversaryColorHex = 0xffCAEDFF;

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

  String _displayDays(DateTime anniversaryDate, DateTime firstDay) {
    int days = anniversaryDate.difference(firstDay).inDays;

    if (days == 0) {
      return 'FIRST DAY';
    }

    bool isYearAnniversary = anniversaryDate.month == widget.firstDay.month &&
        anniversaryDate.day == widget.firstDay.day;

    if (isYearAnniversary) {
      final years = anniversaryDate.year - firstDay.year;

      return '$years주년';
    }

    return '$days일';
  }

  Color _displayColor(DateTime anniversaryDate) {
    if (anniversaryDate == widget.firstDay) {
      return const Color(firstDayColorHex);
    }

    if (anniversaryDate == nowDate) {
      return const Color(currentDayColorHex);
    }

    if (anniversaryDate.month == widget.firstDay.month &&
        anniversaryDate.day == widget.firstDay.day) {
      return const Color(yearAnniversaryColorHex);
    } else {
      return const Color(hundredAnniversaryColorHex);
    }
  }

  List<Anniversary> _getAnniversaryList(
      DateTime targetDate, DateTime firstDay) {
    Set<DateTime> hundredAnniversaries = _getAnniversaries(
        targetDate, firstDay, anniversaryInterval['hundred']!);
    Set<DateTime> yearAnniversaries =
        _getAnniversaries(targetDate, firstDay, anniversaryInterval['year']!);

    List<DateTime> calculatedAnniversariesDate =
        yearAnniversaries.union(hundredAnniversaries).toList();

    List<Anniversary> anniversaries = [];

    for (DateTime anniversaryDate in calculatedAnniversariesDate) {
      anniversaries.add(Anniversary(
          date: anniversaryDate,
          displayTitle: _displayDays(anniversaryDate, firstDay),
          bgColor: _displayColor(anniversaryDate)));
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
        _allAnniversaries.indexWhere((element) => element.date == nowDate);

    if (currentDayAnniversaryIndex == -1) {
      return;
    }

    controller.animateTo(
      currentDayAnniversaryIndex * extent,
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
        itemExtent: extent,
        squeeze: 0.5,
        physics: const FixedExtentScrollPhysics(),
        controller: controller,
        children: [
          for (final anniversary in _allAnniversaries)
            AnniversaryCard(
              anniversary: anniversary,
            )
        ],
      ),
    );
  }
}
