import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../connections/socket.dart';

class TripStatus extends StatefulWidget {
  late String tripId;
  late int index;
  late int maxRounds;
  TripStatus(this.tripId, this.index, this.maxRounds);

  @override
  State<TripStatus> createState() => _TripStatusState();
}

class _TripStatusState extends State<TripStatus> {
  var tripData = null;
  late int tempindex;
  @override
  void initState() {
    //socket.connect();
    tripData = null;
    tempindex = widget.index;
    getTripdata(widget.index);

    socket.on('/returnData', (data) {
      tripData = data;
      // print(tripData);

      if (this.mounted) setState(() {});
    });

    socket.on('/datachange', ((data) {
      getTripdata(widget.index);
    }));

    super.initState();
  }

  getTripdata(int index) {
    var data = {'id': widget.tripId, 'index': index};
    socket.emit('/getTripStatus', data);
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
                "View Bus Status",
                style: TextStyle(fontSize: 20.sp),
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (tripData != null)
              Padding(
                padding: EdgeInsets.only(
                    top: 10.h, bottom: 10.h, left: 10.w, right: 10.w),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 40.h,
                          width: 2.w,
                          color: Colors.white,
                        ),
                        Container(
                          height: 40.h,
                          width: 2.w,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.grey.shade800, width: 6),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.h),
                            child: ListTile(
                              title: Text(
                                "${tripData[0]['tripName']}",
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Padding(
                                  padding: EdgeInsets.only(top: 8.h),
                                  child: Text(
                                    "${tripData[0]['regno']}",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  )),
                              trailing: tripData[0]['tripStarted'] == false
                                  ? Text(
                                      "Trip not yet started",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 11.sp),
                                    )
                                  : null,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Container(
                  height: 450.h,
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
                            bool isLast =
                                index == tripData[0]['stops'].length - 1
                                    ? true
                                    : false;
                            return listItem(
                                tripData[0]['stops'][index], isLast);
                          }),
                          itemCount: tripData[0]['stops'].length,
                        )
                      : Center(child: CircularProgressIndicator())),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            tempindex = (tempindex + 1) % widget.maxRounds;
            getTripdata(tempindex);
          },
          backgroundColor: Colors.grey.shade700,
          child: Icon(Icons.arrow_forward_ios)),
    );
  }

  Widget listItem(var item, bool isLast) {
    return ListTile(
      textColor: Colors.white,
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 50.r,
        child: Center(
          child: CircleAvatar(
              radius: 20.r,
              backgroundColor: tripData[0]['tripStarted'] == false
                  ? Colors.orange
                  : ((item['isReached']) ? Colors.green : Colors.red)),
        ),
      ),
      title: Text(
        "${item['stopName']}",
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              isLast
                  ? "Arrival : ${item['stopTime']}"
                  : "Departure : ${item['stopTime']}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (item['isReached'] && tripData[0]['tripStarted'])
            Text("Arrived      : ${item['arrivedTime']}",
                style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
