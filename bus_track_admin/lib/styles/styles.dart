import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ButtonStyle loginbuttonstyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.w),
    )));
ButtonStyle timebuttonstyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.black87),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.w),
    )));

TextStyle buttonTextStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w400);

TextStyle authHeading = GoogleFonts.aladin(
    color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold);

TextStyle welcomeHeading = GoogleFonts.roboto(
    color: Colors.black, fontSize: 8.sp, fontWeight: FontWeight.bold);

TextStyle tripHeading = GoogleFonts.saira(
    color: Colors.black, fontSize: 10.sp, fontWeight: FontWeight.bold);

TextStyle tripItemFont = GoogleFonts.roboto(
    color: Colors.black, fontSize: 7.sp, fontWeight: FontWeight.bold);
var buttonwidth = 50.w;
