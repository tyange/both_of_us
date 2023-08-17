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

  List<Anniversary> _getPastAnniversaries(DateTime baseDay, int diff) {
    List<Anniversary> anniversaries = [];

    DateTime today = DateTime.now();

    DateTime currentAnniversary = baseDay;
    while (currentAnniversary.isBefore(today)) {
      anniversaries
          .add(Anniversary(date: currentAnniversary, isFirstDay: false));
      currentAnniversary = currentAnniversary.add(Duration(days: 100));
    }

    return anniversaries;
  }

  // List<Anniversary> _getFutureAnniversaries(
  //   DateTime baseDay,
  //   int iterationCount,
  // ) {
  //   List<Anniversary> anniversaries = [];
  //   DateTime today = DateTime.now();

  //   DateTime currentAnniversary = today;

  //   while (currentAnniversary.isBefore(baseDay)) {
  //     currentAnniversary = currentAnniversary.add(Duration(days: 100));
  //   }

  //   if (currentAnniversary == baseDay || currentAnniversary.isAfter(baseDay)) {
  //     print("다가올 기념일을 찾을 수 없습니다.");
  //     return [];
  //   }

  //   while (currentAnniversary.isBefore(baseDay)) {
  //     anniversaries
  //         .add(Anniversary(date: currentAnniversary, isFirstDay: false));
  //     currentAnniversary = currentAnniversary.add(Duration(days: 100));
  //   }

  //   return anniversaries;
  // }

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

    List<Anniversary> pastAnniversaries =
        _getPastAnniversaries(widget.firstDay, -difference);

    Anniversary firstDayAnniversary = Anniversary(
      date: widget.firstDay,
      isFirstDay: true,
    );

    // List<Anniversary> futureAnniversaries =
    //     _getFutureAnniversaries(widget.firstDay, 2);

    pastAnniversaries.sort((a, b) => a.date.compareTo(b.date));

    _allAnniversaries = [
      ...pastAnniversaries,
      firstDayAnniversary,
      // ...futureAnniversaries,
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
