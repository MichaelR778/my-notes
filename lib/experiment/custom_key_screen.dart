import 'package:flutter/material.dart';
import 'package:my_notes/experiment/mock_db.dart';
import 'package:my_notes/utils/encrypt_util.dart';

class CustomKeyScreen extends StatefulWidget {
  const CustomKeyScreen({super.key});

  @override
  State<CustomKeyScreen> createState() => _CustomKeyScreenState();
}

class _CustomKeyScreenState extends State<CustomKeyScreen> {
  String _text = 'Choose a key';

  @override
  void initState() {
    changeKey('myKey');
    setData('You chose the correct key');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_text),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  changeKey('myKey');
                  setState(() {
                    _text = data;
                  });
                },
                child: const Text('myKey'),
              ),
              TextButton(
                onPressed: () {
                  changeKey('burger');
                  setState(() {
                    _text = data;
                  });
                },
                child: const Text('burger'),
              ),
              TextButton(
                onPressed: () {
                  changeKey('wowzer');
                  setState(() {
                    _text = data;
                  });
                },
                child: const Text('wowzer'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
