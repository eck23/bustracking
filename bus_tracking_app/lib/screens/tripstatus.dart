import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../connections/socket.dart';

class TripStatus extends StatefulWidget {
  late String tripId;
  TripStatus(this.tripId);

  @override
  State<TripStatus> createState() => _TripStatusState();
}

class _TripStatusState extends State<TripStatus> {
  var tripData = null;
  @override
  void initState() {
    //socket.connect();
    tripData = null;
    getTripdata();

    socket.on('/returnData', (data) {
      tripData = data;
      print(tripData);

      if (this.mounted) setState(() {});
    });

    socket.on('/datachange', ((data) {
      getTripdata();
    }));

    super.initState();
  }

  getTripdata() {
    socket.emit('/getTripStatus', widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          elevation: 2,
          shadowColor: Colors.white,
          backgroundColor: Colors.grey.shade900,
          title: tripData != null
              ? Text(
                  "${tripData[0]['tripName']}",
                  style: TextStyle(fontSize: 20.sp),
                )
              : null,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Container(
                  height: 560.h,
                  child: tripData != null
                      ? ListView.separated(
                          separatorBuilder: ((context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: 294.w,
                                  left: 64.w,
                                  top: 10.h,
                                  bottom: 10.h),
                              child: SizedBox(
                                  height: 30.h,
                                  width: 0.w,
                                  child: Container(color: Colors.white)),
                            );
                          }),
                          itemBuilder: ((context, index) {
                            return listItem(tripData[0]['stops'][0]);
                          }),
                          itemCount: 20,
                        )
                      : Center(child: CircularProgressIndicator())),
            ),
          ],
        ));
  }

  Widget listItem(var item) {
    return ListTile(
      textColor: Colors.white,
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 50.r,
        child: Center(
          child: CircleAvatar(
              radius: 20.r,
              backgroundColor: item['isReached'] ? Colors.green : Colors.red),
        ),
      ),
      title: Text(
        "${item['stopName']}",
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (item['isReached'])
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: Text(
                "Arrived: ${item['arrivedTime']}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          Text("Departure: ${item['stopTime']}",
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
