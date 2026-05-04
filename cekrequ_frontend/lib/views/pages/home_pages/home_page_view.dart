import 'package:cekrequ_frontend/controllers/user_controller.dart';
import 'package:cekrequ_frontend/models/user.dart';
import 'package:cekrequ_frontend/services/user_api_services.dart';
import 'package:cekrequ_frontend/views/pages/home_pages/home_widgets/future_builder.dart';
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
  String token = "aKhKlhaRTE76diiO8UwTffJN65SOWSVQ";
  final userService = UserApiService('aKhKlhaRTE76diiO8UwTffJN65SOWSVQ');

  User? user;

  @override
  void initState(){
    super.initState();
  }
  
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
              Mydata(token: token),
              WelcomeHeaderWidgets(),
              ListBookingWidgets(),
            ],
          )
          ),
      ),
    );
  }
}