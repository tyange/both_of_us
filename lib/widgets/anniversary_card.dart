import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:both_of_us/models/anniversary.dart';
import 'package:intl/intl.dart';

class AnniversaryCard extends StatelessWidget {
  const AnniversaryCard({
    super.key,
    required this.anniversary,
    required this.firstDay,
  });

  final Anniversary anniversary;
  final DateTime firstDay;

  String _displayDays(DateTime date, DateTime firstDay) {
    int days = date.difference(firstDay).inDays;

    if (days == 0) {
      return 'FIRST DAY';
    }

    return days.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('yyyy - MM - dd').format(anniversary.date),
              style: TextStyle(
                color: anniversary.isCurrentDay ? Colors.red : Colors.black,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _displayDays(
                anniversary.date,
                firstDay,
              ),
              style: TextStyle(
                color: anniversary.isCurrentDay ? Colors.red : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
