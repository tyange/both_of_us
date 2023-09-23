import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

import 'package:both_of_us/models/anniversary.dart';

class AnniversaryCard extends StatelessWidget {
  const AnniversaryCard({
    super.key,
    required this.anniversary,
  });

  final Anniversary anniversary;

  Event buildEvent(DateTime anniversaryDate) {
    return Event(
      title: 'Test eventeee',
      description: 'example',
      startDate: anniversaryDate,
      endDate: anniversaryDate,
      allDay: false,
      // iosParams: IOSParams(
      //   reminder: Duration(minutes: 40),
      //   url: "http://example.com",
      // ),
      // androidParams: AndroidParams(
      //   emailInvites: ["test@example.com"],
      // ),
      // recurrence: recurrence,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 10,
        color: anniversary.bgColor,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: 20,
              child: Text(
                DateFormat('yyyy - MM - dd').format(anniversary.date),
                style: const TextStyle(
                  fontFamily: 'SingleDay',
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              top: 50,
              child: Text(
                anniversary.displayTitle,
                style: const TextStyle(
                  fontFamily: 'SingleDay',
                  fontSize: 22,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.calendar_month),
                onPressed: () {
                  Add2Calendar.addEvent2Cal(
                    buildEvent(anniversary.date),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
