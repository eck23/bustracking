import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'auth_Frontend/firstpage.dart';
import 'auth_Frontend/loginpage.dart';
import 'authentication/authfunctions.dart';
import 'providers/authlisten.dart';

class BusApp extends StatefulWidget{


  @override
  State<BusApp> createState() => _BusAppState();
}

class _BusAppState extends State<BusApp> {



   @override
  void initState() {
    findUser();
    super.initState();
  }

  findUser()async{

      String res=await Auth.getUserFromLocal();

      // print(res);
      
      if(res=="OK"){
        Provider.of<AuthListen>(context,listen: false).signInUser();
      }
      else{
          Provider.of<AuthListen>(context,listen: false).signOutUser();
      }

      
  }


  @override
  Widget build(BuildContext context) {
     return ScreenUtilInit(
        
        builder: (context , child){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Provider.of<AuthListen>(context,listen: true).isSignedIn?FirstPage():MyLogin(),
          );
        }
       );
  }
}