import 'package:bus_track_admin/manage_data/data_manage.dart';
import 'package:bus_track_admin/screens/addtripscreen.dart';
import 'package:bus_track_admin/styles/styles.dart';
import 'package:bus_track_admin/models/admin.dart';
import 'package:bus_track_admin/widgets/tripitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TripScreen extends StatefulWidget {
  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  addTripsScreen() async {
    var response = await Navigator.push(
        context, MaterialPageRoute(builder: ((context) => AddTrip())));

    if (!mounted) return;

    if (response == "success") {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(Admin.registeredTripId);
    return Scaffold(
      body: FutureBuilder(
          future: DataManage.getmytrips(Admin.token),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Text(
                  "Check Your Connection",
                  style: TextStyle(fontSize: 15.sp),
                ),
              );
            } else if (snapshot.data != null &&
                snapshot.connectionState == ConnectionState.done) {
              var snap = snapshot.data as List;
              // print("hello");
              // for (var item in snap) {
              //   print(item['tripName']);
              // }
              return Container(
                  height: 550.h,
                  width: 500.w,
                  padding: EdgeInsets.all(20),
                  child: GridView.builder(
                    itemCount: snap.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 3 / 2),
                    itemBuilder: (BuildContext context, int index) {
                      // print("hello ${snap[0]['tripName'].toString()}");
                      return TripItem(snap[index]['tripName'].toString());
                    },
                  ));
            } else if (snapshot.data == null &&
                snapshot.connectionState == ConnectionState.done) {
              return Center(
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
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () => addTripsScreen(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget addTripContainer() {
    return InkWell(
      onTap: () => addTripsScreen(),
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
