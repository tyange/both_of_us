import 'package:flutter/material.dart';

class CenterColumn extends StatelessWidget {
  const CenterColumn({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
