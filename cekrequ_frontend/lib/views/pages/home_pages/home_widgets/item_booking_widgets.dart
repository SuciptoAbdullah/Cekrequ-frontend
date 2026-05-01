// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../general_widgets/my_container.dart';

class ItemBookingWidgets extends StatefulWidget {
  final String title;
  int indexStatus;
  ItemBookingWidgets({super.key, this.title = "unkwon", this.indexStatus = 0});

  @override
  State<ItemBookingWidgets> createState() => _ItemBookingWidgetsState();
}

class _ItemBookingWidgetsState extends State<ItemBookingWidgets> {

  List<String> statusName = ["Pending", "Diterima", "Berlangsung", "selesai"];
  List<Color> statusColor = [Colors.yellow, Colors.orange, Colors.greenAccent, Colors.blueAccent];

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.title)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyContainer(
                alignment: Alignment.center,
                color: statusColor[widget.indexStatus],
                child: Text(statusName[widget.indexStatus], style: TextStyle(color: Colors.black),),
              ),
            ],
          )
        ],
      ),
    );
  }
}