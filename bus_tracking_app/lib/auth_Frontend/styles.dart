import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ButtonStyle loginbuttonstyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.w),
    )));

ButtonStyle regbuttonstyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade900),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.w),
    )));

TextStyle buttonTextStyle =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w400);

TextStyle authHeading = GoogleFonts.aladin(
    color: Colors.black, fontSize: 40.sp, fontWeight: FontWeight.bold);

TextStyle drawerFont = GoogleFonts.roboto(
    color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.bold);

TextTheme small = ThemeData.light().textTheme.copyWith(
      titleSmall: GoogleFonts.montserrat(
          fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
    );

var buttonwidth = 170.w;
