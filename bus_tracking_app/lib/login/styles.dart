import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ButtonStyle loginbuttonstyle=ButtonStyle(
                          backgroundColor:MaterialStateProperty.all<Color>(Colors.orange),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.w),
                        
                        )));

ButtonStyle regbuttonstyle=ButtonStyle(
                          backgroundColor:MaterialStateProperty.all<Color>(Colors.blue.shade900),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.w),
                        
                        )));

TextStyle buttonTextStyle=TextStyle(color: Colors.white,fontWeight: FontWeight.w400);

var buttonwidth= 170.w;