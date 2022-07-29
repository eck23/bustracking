import 'package:bus_tracking_app/busapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../auth_Frontend/styles.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToScreen();
  }

  void navigateToScreen() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BusApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Material(
                elevation: 5,
                color: Colors.white,
                shape: CircleBorder(side: BorderSide.none),
                child: Icon(
                  Icons.directions_bus,
                  size: 100.h,
                )),
          ),
          Text(
            "Where's my Bus",
            style: small.titleSmall,
          ),
          // Container(
          //     padding: EdgeInsets.only(top: 180.h),
          //     child: Column(
          //       children: [
          //         Text(
          //           "Powered by",
          //           style: GoogleFonts.lobster(
          //               color: Colors.white, fontSize: 12.sp),
          //         ),
          //         Text(
          //           "Scicopath Official",
          //           style: small.titleSmall,
          //         )
          //       ],
          //     )),
        ]),
      ),
    ));
  }
}
