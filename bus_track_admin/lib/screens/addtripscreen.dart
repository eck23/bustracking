import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bus_track_admin/manage_data/data_manage.dart';
import 'package:bus_track_admin/models/admin.dart';
import 'package:bus_track_admin/models/stopdetails.dart';
import 'package:bus_track_admin/widgets/stopitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../connections/socket.dart';

import '../styles/styles.dart';
import '../widgets/widgets.dart';

class AddTrip extends StatefulWidget {
  @override
  State<AddTrip> createState() => _AddTripState();
}

List<StopDetails> addedStops = [];

class _AddTripState extends State<AddTrip> {
  List<Widget> stopsList = []; //store each individual stops widget
  TextEditingController tripNameController = TextEditingController();
  // TextEditingController maxRoundsController=TextEditingController();
  @override
  void initState() {
    connect();
    addedStops.clear();
    stopsList.add(StopItem());
    stopsList.add(StopItem());
    // stopsList.add(StopItem());
    // stopsList.add(StopItem());
    // stopsList.add(StopItem());
    // stopsList.add(StopItem());
    // stopsList.add(StopItem());
    // stopsList.add(StopItem());

    super.initState();
  }

  onSave() {
    List saveStopList = [];

    if (tripNameController.text.trim().isEmpty) {
      return;
    }

    // if(int.tryParse(maxRoundsController.text.trim()) == null){
    //   return;
    // }
    int maxRounds = addedStops[0].stopTimes.length;

    if (maxRounds < 1) {
      return;
    }
    for (int i = 0; i < addedStops.length; i++) {
      if (addedStops[i].stopName.trim().isEmpty ||
          addedStops[i].stopTimes.length != maxRounds) {
        return;
      }

      saveStopList.add({
        'stopId': addedStops[i].stopId,
        'stopName': addedStops[i].stopName,
        'latitude': addedStops[i].latitude,
        'longitude': addedStops[i].longitude,
        'time': addedStops[i].stopTimes,
        'isReached': addedStops[i].isReached
      });
    }

    Map<String, dynamic> trip = {
      'tripName': tripNameController.text.trim(),
      'maxRounds': maxRounds,
      'stops': saveStopList,
      'token': Admin.token
    };
    var jsonTrip = jsonEncode(trip);
    DataManage.saveTrip(jsonTrip);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [WindowButtons()],
        title: WindowTitleBarBox(
          child: Stack(
            children: [
              Text(
                "Add A Trip",
                style: welcomeHeading,
              ),
              Row(
                children: [
                  Expanded(child: MoveWindow()),
                ],
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body:
          //Center(child: StopItem())
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50.h,
                    width: 200.w,
                    child: TextField(
                      maxLines: 1,
                      textInputAction: TextInputAction.none,
                      controller: tripNameController,
                      style: TextStyle(fontSize: 5.sp, color: Colors.black),
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          hintText: "Enter Trip Name",
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  ElevatedButton(onPressed: onSave, child: Text("SAVE TRIP"))
                ],
              ),
            ),
            Container(
                height: 550.h,
                width: 500.w,
                padding: EdgeInsets.all(20),
                child: GridView.builder(
                  itemCount: stopsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 3 / 2),
                  itemBuilder: (BuildContext context, int index) {
                    return stopsList[index];
                  },
                )),
          ]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            stopsList.add(StopItem());
          });
        },
      ),
    );
  }
}
