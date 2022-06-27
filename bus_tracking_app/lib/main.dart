import 'package:bus_tracking_app/busapp.dart';
import 'package:bus_tracking_app/providers/authlisten.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




void main()=>runApp(Main());

class Main extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
     return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) =>AuthListen()),
      ],
       child:BusApp()
     );
  }
}




