import 'package:doctor/widgets/digital_input/digital_input_widget.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.clear),
        onPressed: () {

        },
      ),
      body: Column(
        children: [
          DigitalInput(
            onDone: () {
              print('done');
            },
            onChanged: (value) {
              print('DigitalInput: $value');
            },
          ),
        ],
      ),
    );
  }
}
