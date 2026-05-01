import 'package:flutter/material.dart';

import '../../general_widgets/app_bar_widgets.dart';

import 'home_widgets/welcome_header_widgets.dart';
import 'home_widgets/list_booking_widgets.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidgets(),
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 15, right: 15),
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(top: 15), 
            children: [
              WelcomeHeaderWidgets(),
              ListBookingWidgets()
            ],
          )
          ),
      ),
    );
  }
}