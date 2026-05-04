// ignore_for_file: non_constant_identifier_names

import 'package:cekrequ_frontend/models/package.dart';

class Booking {

  final String booking_id;
  final String status;
  final DateTime schedule;
  final DateTime created_date;
  final Package package;

  Booking({required this.booking_id, required this.status, required this.created_date, required this.schedule, required this.package});

  factory Booking.fromJson(Map<String, dynamic> json){
    return Booking(
      booking_id: json['booking_id'],
      status: json['status'],
      created_date: json['created_date'],
      schedule: json['schedule'],
      package: Package.fromJson(json['packages'])
    );
  }

}