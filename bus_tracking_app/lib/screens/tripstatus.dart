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
        appBar: AppBar(
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
                            return Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 54.w),
                                    child: Icon(Icons.arrow_downward),
                                  ),
                                ],
                              ),
                              height: 50.h,
                              width: 0.w,
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
      leading: CircleAvatar(
          radius: 50.r,
          backgroundColor: item['isReached'] ? Colors.green : Colors.red),
      title: Text(
        "${item['stopName']}",
        style: TextStyle(fontSize: 15.sp),
      ),
      trailing:
          Text(item['stopTime'].substring(10, item['stopTime'].length - 1)),
    );
  }
}
