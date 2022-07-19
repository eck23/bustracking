import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bus_track_admin/widgets/stopitem.dart';
import 'package:flutter/material.dart';

import '../connections/socket.dart';

import '../styles/styles.dart';
import '../widgets/widgets.dart';

class AddTrip extends StatefulWidget {
  @override
  State<AddTrip> createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  List<Widget> stopsList = []; //store each individual stops widget
  // List stopsSearchList = [];

  @override
  void initState() {
    connect();

    super.initState();
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
        body: Center(child: StopItem())
        //Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        //   Container(
        //       height: 300.h,
        //       width: 500.w,
        //       child: GridView.builder(
        //         itemCount: stopsList.length,
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 3,
        //           crossAxisSpacing: 4.0,
        //           mainAxisSpacing: 4.0,
        //         ),
        //         itemBuilder: (BuildContext context, int index) {
        //           return stopsList[index];
        //         },
        //       )),
        // ])

        );
  }
}
