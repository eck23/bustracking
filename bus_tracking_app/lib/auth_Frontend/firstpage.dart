import 'package:bus_tracking_app/auth_Frontend/styles.dart';
import 'package:bus_tracking_app/authentication/authfunctions.dart';
import 'package:bus_tracking_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../connections/socket.dart';
import '../providers/authlisten.dart';
import '../providers/stopprovider.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController stopController1 = TextEditingController();
  TextEditingController stopController2 = TextEditingController();
  TextEditingController stopSearchController = TextEditingController();

  @override
  void initState() {
    connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    stopProvider = Provider.of<SearchProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                await Auth.signOut();
                Provider.of<AuthListen>(context, listen: false).signOutUser();
              },
              icon: Icon(Icons.logout))
        ],
        leading: const BackButton(color: Colors.white),
        title: Text("FirstPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Select Locations",
              style: authHeading,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.h, top: 20.h),
              child: textContainer("Enter Start Location", stopController1,
                  () => searchDialog(stopController1)),
            ),
            Icon(Icons.arrow_downward),
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 40.h),
              child: textContainer("Enter Destination Location",
                  stopController2, () => searchDialog(stopController2)),
            ),
            SizedBox(
                width: 120.w,
                height: 40.h,
                child: ElevatedButton(onPressed: () {}, child: Text("Search")))
          ],
        ),
      ),
    );
  }

  Widget textContainer(
      String hintText, TextEditingController controller, function) {
    return Material(
      elevation: 5,
      shadowColor: Colors.yellowAccent.shade700,
      child: Container(
        height: 70.h,
        width: 250.w,
        color: Colors.white,
        child: Center(
          child: TextField(
            maxLines: 1,
            onTap: function,
            readOnly: true,
            textInputAction: TextInputAction.none,
            controller: controller,
            style: TextStyle(fontSize: 15.sp, color: Colors.black),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: const TextStyle(color: Colors.black)),
          ),
        ),
      ),
    );
  }

  searchDialog(TextEditingController updateController) async {
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
                        updateController.text =
                            stopSearchController.text.trim();
                        stopSearchController.clear();
                        stopProvider.stopsSearchList.clear();
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
}
