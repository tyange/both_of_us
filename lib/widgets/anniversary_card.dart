import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:both_of_us/models/anniversary.dart';

const int firstDayColorHex = 0xffFBF0B2;
const int currentDayColorHex = 0xffFFC7EA;
const int yearAnniversaryColorHex = 0xffD8B4F8;
const int hundredAnniversaryColorHex = 0xffCAEDFF;

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

  Color _displayColor(Anniversary anniversary) {
    if (anniversary.isFirstDay) {
      return const Color(firstDayColorHex);
    }

    if (anniversary.isCurrentDay) {
      return const Color(currentDayColorHex);
    }

    if (anniversary.isYearAnniversary) {
      return const Color(yearAnniversaryColorHex);
    } else {
      return const Color(hundredAnniversaryColorHex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 10,
        color: _displayColor(anniversary),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('yyyy - MM - dd').format(anniversary.date),
              style: const TextStyle(
                fontFamily: 'JosefinSans',
                fontSize: 18,
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
              style: const TextStyle(
                fontFamily: 'JosefinSans',
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
