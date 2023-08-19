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

  Set<Anniversary> _getPastAnniversaries(
      DateTime firstDay, int diff, int interval) {
    List<Anniversary> anniversaries = [];

    DateTime today = DateTime.now();

    DateTime targetHundredAnniversary = firstDay;

    while (targetHundredAnniversary.isBefore(today)) {
      anniversaries
          .add(Anniversary(date: targetHundredAnniversary, isFirstDay: false));

      targetHundredAnniversary =
          targetHundredAnniversary.add(Duration(days: interval));
    }

    return Set<Anniversary>.from(anniversaries);
  }

  List<Anniversary> _getFutureAnniversaries(
    DateTime baseDay,
    int iterationCount,
  ) {
    List<Anniversary> anniversaries = [];
    DateTime today = DateTime.now();

    int diff = today.difference(baseDay).inDays;

    DateTime nextAnniversary;

    if (diff % 100 == 0) {
      DateTime afterHundred = today.add(const Duration(days: 100));

      nextAnniversary = afterHundred;
    } else {
      DateTime afterRestOfTheDay = today.add(
        Duration(
          days: 100 - (diff % 100),
        ),
      );

      nextAnniversary = afterRestOfTheDay;
    }

    anniversaries.add(Anniversary(date: nextAnniversary, isFirstDay: false));

    for (int i = 1; i < iterationCount; i++) {
      nextAnniversary = nextAnniversary.add(
        const Duration(days: 100),
      );

      anniversaries.add(Anniversary(date: nextAnniversary, isFirstDay: false));
    }

    return anniversaries;
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

    int difference = _getDays(widget.firstDay);

    List<Anniversary> pastAnniversaries() {
      Set<Anniversary> pastYearAnniversary =
          _getPastAnniversaries(widget.firstDay, -difference, 365);
      Set<Anniversary> pastHundredAnniversary =
          _getPastAnniversaries(widget.firstDay, -difference, 100);
      Set<Anniversary> intersection =
          pastHundredAnniversary.intersection(pastYearAnniversary);

      for (Anniversary anniversary in intersection) {
        pastYearAnniversary.remove(anniversary);
      }

      pastYearAnniversary.addAll(pastHundredAnniversary);

      List<Anniversary> pastAnniversaries = pastYearAnniversary.toList();

      pastAnniversaries.sort((a, b) => a.date.compareTo(b.date));

      return pastAnniversaries;
    }

    Anniversary currentDay = Anniversary(
      date: widget.firstDay,
      isFirstDay: true,
    );

    List<Anniversary> futureAnniversaries =
        _getFutureAnniversaries(widget.firstDay, 2);

    _allAnniversaries = [
      ...pastAnniversaries(),
      currentDay,
      ...futureAnniversaries,
    ];
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
                  anniversary.isFirstDay
                      ? _displayDays(DateTime.now(), widget.firstDay)
                      : _displayDays(anniversary.date, widget.firstDay),
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
