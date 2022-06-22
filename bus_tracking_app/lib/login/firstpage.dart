
import 'package:bus_tracking_app/login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class FirstPage extends StatelessWidget{


 

    @override
  Widget build(BuildContext context) {
     
     return Scaffold(
      
      appBar: AppBar(

      actions: [IconButton(onPressed:()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyLogin())) , icon: Icon(Icons.logout))],
      leading: const BackButton(
              color: Colors.white
      ),
      title: Text("FirstPage"),),
      body: Center(child: Text("THIS IS MY FIRST NAVIGATION",style: GoogleFonts.adamina(fontSize: 20.sp,fontWeight: FontWeight.w400),)),
     );
  }

}