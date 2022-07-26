import 'package:bus_tracking_app/screens/tripstatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TripDisplay extends StatefulWidget {
  late List trips;
  TripDisplay(this.trips);

  @override
  State<TripDisplay> createState() => _TripDisplayState();
}

class _TripDisplayState extends State<TripDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 15.h),
        child: Container(
            height: 550.h,
            child: ListView.separated(
              separatorBuilder: ((context, index) => SizedBox(
                    height: 10.h,
                  )),
              itemBuilder: ((context, index) {
                return tripItem(widget.trips[index]);
              }),
              itemCount: widget.trips.length,
            )),
      ),
    );
  }

  tripItem(var item) {
    return ListTile(
      title: Text(item['tripName']),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Row(children: [
          Text(
              "Departure : ${item['sourceTime'].substring(10, item['sourceTime'].length - 1)}"),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Text(
                "Arrival : ${item['destinationTime'].substring(10, item['destinationTime'].length - 1)}"),
          ),
        ]),
      ),
      tileColor: Colors.white,
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => TripStatus(item['_id']))),
    );
  }
}
