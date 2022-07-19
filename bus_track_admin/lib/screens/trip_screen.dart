import 'package:bus_track_admin/screens/addtripscreen.dart';
import 'package:bus_track_admin/styles/styles.dart';
import 'package:bus_track_admin/models/admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TripScreen extends StatefulWidget {
  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Admin.registeredTripId.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: Text(
                        "No trips added yet",
                        style: tripHeading,
                      ),
                    ),
                    addTripContainer(),
                  ],
                ),
              )
            : addTripContainer());
  }

  Widget addTripContainer() {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: ((context) => AddTrip()))),
      child: Material(
        elevation: 10,
        child: Container(
          height: 150.h,
          width: 70.w,
          decoration: BoxDecoration(
              color: Colors.white70,
              // border: Border.all(width: 3, color: Colors.black),
              borderRadius: BorderRadius.circular(12.r)),
          child: Icon(
            Icons.add,
            color: Colors.blue.shade900,
            size: 50.h,
          ),
        ),
      ),
    );
  }
}
