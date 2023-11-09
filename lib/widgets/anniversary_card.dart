import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        elevation: 3,
        color: anniversary.bgColor,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  anniversary.displayTitle,
                  style: GoogleFonts.hahmlet(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  DateFormat('yyyy - MM - dd').format(anniversary.date),
                  style: GoogleFonts.hahmlet(),
                ),
              ],
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
