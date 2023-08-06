import 'package:flutter/cupertino.dart';

class ResultName extends StatelessWidget {
  const ResultName({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 50,
      ),
    );
  }
}
