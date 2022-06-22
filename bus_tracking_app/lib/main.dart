import 'package:bus_tracking_app/login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




void main()=>runApp(Main());

class Main extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
      
      builder: (context , child){
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MyLogin(),
        );
      }
     );
  }
}



