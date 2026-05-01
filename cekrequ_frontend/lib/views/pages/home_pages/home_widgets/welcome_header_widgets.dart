import 'package:flutter/material.dart';

import '../../../general_widgets/my_container.dart';

class WelcomeHeaderWidgets extends StatelessWidget {
  const WelcomeHeaderWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    
    String someText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";

    return MyContainer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text("Sebuah Gambar"),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Hallo Sucipto!", style: TextStyle(fontSize: 41, fontWeight: FontWeight.bold)),
              Text(someText, style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      )
    );
  }
}