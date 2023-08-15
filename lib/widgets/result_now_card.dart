import 'package:flutter/material.dart';

import 'package:both_of_us/widgets/result_name.dart';

class ResultNowCard extends StatelessWidget {
  const ResultNowCard({
    super.key,
    required this.meName,
    required this.loverName,
    required this.date,
  });

  final String meName;
  final String loverName;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ResultName(name: meName),
                const SizedBox(
                  width: 20,
                ),
                const Icon(
                  Icons.favorite,
                  size: 30,
                  color: Colors.red,
                ),
                const SizedBox(
                  width: 20,
                ),
                ResultName(name: loverName),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '$date일',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
