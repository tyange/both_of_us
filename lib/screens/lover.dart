import 'package:flutter/material.dart';

import 'package:both_of_us/widgets/center_column.dart';
import 'package:both_of_us/screens/date.dart';

class LoverScreen extends StatefulWidget {
  LoverScreen({
    super.key,
    required this.meName,
  });

  String meName;

  @override
  State<LoverScreen> createState() => _LoverScreenState();
}

class _LoverScreenState extends State<LoverScreen> {
  final _loverNameController = TextEditingController();

  void _submittedLoverName() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => DateScreen(
          meName: widget.meName,
          loverName: _loverNameController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CenterColumn(
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              controller: _loverNameController,
              decoration: const InputDecoration(
                labelText: '상대의 이름은?',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: _submittedLoverName,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              elevation: 5,
            ),
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }
}
