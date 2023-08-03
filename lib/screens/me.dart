import 'package:both_of_us/widgets/center_column.dart';
import 'package:flutter/material.dart';

class MeScreen extends StatefulWidget {
  const MeScreen({super.key});

  @override
  State<MeScreen> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  final _meNameController = TextEditingController();

  @override
  void dispose() {
    _meNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CenterColumn(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              controller: _meNameController,
              decoration: InputDecoration(labelText: '당신의 이름은?'),
            ),
          )
        ],
      ),
    );
  }
}
