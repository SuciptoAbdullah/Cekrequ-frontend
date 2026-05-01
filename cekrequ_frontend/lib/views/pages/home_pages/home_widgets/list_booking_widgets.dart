import 'package:flutter/material.dart';

import '../../../general_widgets/my_container.dart';
import 'item_booking_widgets.dart';

class ListBookingWidgets extends StatefulWidget {
  const ListBookingWidgets({super.key});

  @override
  State<ListBookingWidgets> createState() => _ListBookingWidgetsState();
}

class _ListBookingWidgetsState extends State<ListBookingWidgets> {
  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: Column(
        spacing: 15,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Daftar pesanan", textAlign: TextAlign.center,),
          ItemBookingWidgets(title: "Prewedding", indexStatus: 0),
          ItemBookingWidgets(title: "Wisudah di Polindra", indexStatus: 0),
          ItemBookingWidgets(title: "Ikan Mas kelelep", indexStatus: 2),
          ItemBookingWidgets(title: "Liburan Keluarga", indexStatus: 1),
          ItemBookingWidgets(title: "Penyewaan Kostum wisuda", indexStatus: 2),
          ItemBookingWidgets(title: "Prewedding", indexStatus: 0),
          ItemBookingWidgets(title: "Wisudah di Polindra", indexStatus: 0),
          ItemBookingWidgets(title: "Ikan Mas kelelep", indexStatus: 2),
          ItemBookingWidgets(title: "Liburan Keluarga", indexStatus: 1),
          ItemBookingWidgets(title: "Penyewaan Kostum wisuda", indexStatus: 2),
          ItemBookingWidgets(title: "Prewedding", indexStatus: 0),
          ItemBookingWidgets(title: "Wisudah di Polindra", indexStatus: 0),
          ItemBookingWidgets(title: "Ikan Mas kelelep", indexStatus: 2),
          ItemBookingWidgets(title: "Liburan Keluarga", indexStatus: 1),
          ItemBookingWidgets(title: "Penyewaan Kostum wisuda", indexStatus: 2),
        ],
      ),
    );
  }
}