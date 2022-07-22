import 'package:bus_track_admin/screens/addtripscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../connections/socket.dart';
import '../main.dart';
import '../models/stopdetails.dart';

import '../styles/styles.dart';

class StopItem extends StatefulWidget {
  @override
  State<StopItem> createState() => _StopItemState();
}

class _StopItemState extends State<StopItem> {
  TextEditingController stopController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController stopSearchController = TextEditingController();
  StopDetails stopDetails = StopDetails();
  TimeOfDay selectedTime = TimeOfDay.now();

  void initState() {
    addedStops.add(stopDetails);
    stopController.text = stopDetails.stopName;
    for (int i = 0; i < addedStops.length; i++) {
      print(
          "${addedStops[i].stopName} ${addedStops[i].stopId}  ${addedStops[i].stopTimes}");
    }
    super.initState();
  }

  void didStateChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: Colors.white,
      child: Container(
        height: 170.h,
        width: 80.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textContainer("Select Stop", () => searchDialog()),
            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
            ),
            ElevatedButton(
                onPressed: () => timeDialog(),
                style: timebuttonstyle,
                child: Text("Add time"))
          ],
        ),
      ),
    );
  }

  Widget textContainer(String hintText, function) {
    return Container(
      height: 40.h,
      width: 60.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      child: TextField(
        maxLines: 1,
        onTap: function,
        readOnly: true,
        textInputAction: TextInputAction.none,
        controller: stopController,
        style: TextStyle(fontSize: 5.sp, color: Colors.white),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            fillColor: Colors.black87,
            contentPadding: EdgeInsets.zero,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white)),
      ),
    );
  }

  searchDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: TextField(
                controller: stopSearchController,
                decoration: InputDecoration(hintText: "Search for stops"),
                onChanged: (val) async {
                  if (val.trim().isEmpty) {
                    setState(() => stopProvider.stopsSearchList.clear());
                  } else {
                    setState(() => socket.emit('/stopsearch', val.trim()));
                  }
                },
              ),
              content: SizedBox(
                height: 300.h,
                width: 100.w,
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    print(stopProvider.stopsSearchList);
                    return stopSearchItem(stopProvider.stopsSearchList[index]);
                  }),
                  itemCount: stopProvider.stopsSearchList.length,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('SUBMIT'),
                  onPressed: () {
                    for (int i = 0;
                        i < stopProvider.stopsSearchList.length;
                        i++) {
                      if (stopProvider.stopsSearchList[i]['name'] ==
                          stopSearchController.text.trim()) {
                        stopDetails.stopName = stopSearchController.text;
                        stopDetails.stopId =
                            stopProvider.stopsSearchList[i]['_id'];
                        stopDetails.latitude =
                            stopProvider.stopsSearchList[i]['latitude'];
                        stopDetails.longitude =
                            stopProvider.stopsSearchList[i]['longitude'];

                        stopController.text = stopDetails.stopName;
                        break;
                      }
                    }

                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }));
        });
  }

  timeDialog() async {
    List stopTimeList;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            // stopTimeList = stopDetails.stopTimes;
            return AlertDialog(
              title: Text("Stop Timings"),
              content: SizedBox(
                height: 300.h,
                width: 100.w,
                child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return stopTimeItem(stopDetails.stopTimes[index]);
                  }),
                  itemCount: stopDetails.stopTimes.length,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('ADD TIME'),
                  onPressed: () async {
                    TimeOfDay? timepick = await showTimePicker(
                        context: context, initialTime: new TimeOfDay.now());
                    setState(
                        () => stopDetails.stopTimes.add(timepick.toString()));
                  },
                )
              ],
            );
          }));
        });
  }

  Widget stopSearchItem(var stop) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(stop['name']),
        textColor: Colors.black,
        tileColor: Colors.white,
        onTap: () => stopSearchController.text = stop['name'],
      ),
    );
  }

  Widget stopTimeItem(String time) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(time),
        textColor: Colors.black,
        tileColor: Colors.white,
      ),
    );
  }
}
