import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bus_track_admin/auth_Frontend/loginpage.dart';
import 'package:bus_track_admin/homescreen.dart';
import 'package:bus_track_admin/providers/stopprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'providers/authlisten.dart';

void main() {
  runApp(Main());

  doWhenWindowReady(() {
    const initialSize = Size(1024, 680);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;

    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setAsFrameless();
      await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
      await windowManager.setResizable(false);
    });
    appWindow.show();
  });
}

var stopProvider;

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthListen()),
          ChangeNotifierProvider(create: (_) => SearchProvider()),
        ],
        child: ScreenUtilInit(
          builder: ((context, child) {
            stopProvider = Provider.of<SearchProvider>(context, listen: false);
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Provider.of<AuthListen>(context, listen: true).isSignedIn
                    ? Home()
                    : Home());
          }),
        ));
  }
}
