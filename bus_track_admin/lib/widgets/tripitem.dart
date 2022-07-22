import 'package:bus_track_admin/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TripItem extends StatelessWidget {
  late String tripName;

  TripItem(this.tripName);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
      child: Material(
        elevation: 7,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        color: Colors.white,
        shadowColor: Colors.red.shade900,
        child: Container(
          height: 40.h,
          width: 60.w,
          child: Center(
            child: Text(
              tripName,
              style: tripItemFont,
            ),
          ),
        ),
      ),
    );
  }
}
