import 'dart:async';
import 'package:flutter/material.dart';

import 'pages/home_pages/home_page_view.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {

  @override
  void initState() {

    Timer(Duration(seconds: 2), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePageView()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Cekrequ", textAlign: TextAlign.center, style: TextStyle(fontSize: 52)),
          Text("dari Fanesya Photo Studio", textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}