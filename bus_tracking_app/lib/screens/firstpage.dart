import 'package:bus_tracking_app/authentication/authfunctions.dart';
import 'package:bus_tracking_app/datamanage/data.dart';
import 'package:bus_tracking_app/main.dart';
import 'package:bus_tracking_app/screens/tripstatus.dart';
import 'package:bus_tracking_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../auth_Frontend/styles.dart';
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

  List searchResponse = [];

  @override
  void initState() {
    connect();
    super.initState();
  }

  onSearch() async {
    if (stopController1.text.trim().isEmpty ||
        stopController2.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select the stops'),
      ));
      return;
    }
    if (stopController1.text == stopController2.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select different stops'),
      ));
      return;
    }

    loading(context);
    var response = await DataManage.getTrips(
        stopController1.text.trim(), stopController2.text.trim());

    Navigator.pop(context);
    if (response == "error") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred while searching'),
      ));
      return;
    }

    if (response.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Couldn\'t find trips'),
      ));
      return;
    }
    print(response);

    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (_) => TripDisplay(response)));

    setState(() {
      searchResponse = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    stopProvider = Provider.of<SearchProvider>(context, listen: false);
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
        // leading: const BackButton(color: Colors.white),
        title: Text("Where's my Bus"),
      ),
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (searchResponse.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 100.h, bottom: 10.h),
                child: Center(
                    child: Column(
                  children: [
                    Icon(
                      Icons.directions_bus_filled,
                      color: Colors.white,
                      size: 80.h,
                    ),
                    Text(
                      "Search Buses",
                      style: TextStyle(fontSize: 20.sp, color: Colors.white),
                    )
                  ],
                )),
              ),
            Padding(
                padding: EdgeInsets.only(
                    left: 10.w, right: 10.w, bottom: 20.h, top: 20.h),
                child: searchContainer()),
            SizedBox(
                width: 120.w,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: onSearch,
                  child: Text("Search"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red.shade700),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      ))),
                )),
            if (searchResponse.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: tripsListContainer(),
              )
          ],
        ),
      ),
    );
  }

  Widget tripsListContainer() {
    return Material(
      elevation: 5,
      shadowColor: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
      child: Container(
        height: 390.h,
        padding: EdgeInsets.all(30.w),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r))),
        child: SizedBox(
          height: 350.h,
          width: 300.w,
          child: ListView.separated(
            separatorBuilder: ((context, index) => Divider(
                  thickness: 0,
                )),
            itemBuilder: ((context, index) {
              return tripItem(searchResponse[index]);
            }),
            itemCount: searchResponse.length,
          ),
        ),
      ),
    );
  }

  tripItem(var item) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => TripStatus(item['_id']))),
      child: Container(
          height: 80.h,
          width: 200.w,
          decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.all(Radius.circular(20.r))),
          child: Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      item['tripName'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Row(children: [
                    Text(
                      "Departure : ${item['sourceTime']}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        "Arrival : ${item['destinationTime']}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          )),
    );
  }

  Widget searchContainer() {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
      elevation: 10,
      color: Colors.white,
      child: Row(children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: SizedBox(
            child: Column(
              children: [
                CircleAvatar(
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.shade300,
                    radius: 4.r,
                  ),
                  radius: 7.r,
                  backgroundColor: Colors.blue.shade700,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.h, bottom: 3.h),
                  child: Container(
                    height: 20.h,
                    width: 1.w,
                    color: Colors.grey.shade500,
                  ),
                ),
                CircleAvatar(
                  child: CircleAvatar(
                    backgroundColor: Colors.red.shade300,
                    radius: 4.r,
                  ),
                  radius: 7.r,
                  backgroundColor: Colors.red.shade700,
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: SizedBox(
            height: 120.h,
            width: 180.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textContainer("Start Location", stopController1,
                    () => searchDialog(stopController1)),
                Divider(
                  height: 1,
                  thickness: 2,
                ),
                textContainer("Destination Location", stopController2,
                    () => searchDialog(stopController2))
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w),
          child: InkWell(
            onTap: () {
              var temp = stopController1.text;
              stopController1.text = stopController2.text;
              stopController2.text = temp;
            },
            child: CircleAvatar(
                backgroundColor: Colors.grey.shade700,
                radius: 25.r,
                child: Center(
                  child: SizedBox(
                    child: Row(
                      children: [
                        Icon(Icons.arrow_upward),
                        Icon(Icons.arrow_downward)
                      ],
                    ),
                  ),
                )),
          ),
        )
      ]),
    );
  }

  Widget textContainer(
      String hintText, TextEditingController controller, function) {
    return TextField(
      maxLines: 1,
      onTap: function,
      readOnly: true,
      textInputAction: TextInputAction.none,
      controller: controller,
      style: TextStyle(fontSize: 15.sp, color: Colors.black),
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.black)),
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

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.directions_bus,
                  color: Colors.white,
                  size: 80.h,
                ),
                Text(
                  "Where's my Bus",
                  style: small.titleSmall,
                )
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Dev Info',
              style: drawerFont,
            ),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              // context,
              // MaterialPageRoute(builder: (context) => DevInfo()),
              // );
            },
          ),
          Divider(
            height: 0.2,
            thickness: 2,
          ),
          ListTile(
            title: Text(
              'LogOut',
              style: drawerFont,
            ),
            onTap: () async {
              await Auth.signOut();
              Provider.of<AuthListen>(context, listen: false).signOutUser();
            },
          ),
        ],
      ),
    );
  }
}
