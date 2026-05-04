import 'package:cekrequ_frontend/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';

class Mydata extends StatefulWidget {
  final String token;
  const Mydata({super.key, required this.token});

  @override
  State<Mydata> createState() => _MydataState();
}

class _MydataState extends State<Mydata> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserController.getUser(widget.token),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text("loading...");
        }

        if(snapshot.hasError){
          return Text("Error cuy");
        }

        final user = snapshot.data!;

        return Text(user.toString());

      }
    );
  }
}