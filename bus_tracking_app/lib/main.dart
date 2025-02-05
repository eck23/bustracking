import 'package:bus_tracking_app/busapp.dart';
import 'package:bus_tracking_app/providers/authlisten.dart';
import 'package:bus_tracking_app/providers/stopprovider.dart';
import 'package:bus_tracking_app/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() => runApp(Main());

var stopProvider;

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthListen()),
          ChangeNotifierProvider(create: (_) => SearchProvider())
        ],
        child: ScreenUtilInit(builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false, home: SplashScreen());
        }));
  }
}
