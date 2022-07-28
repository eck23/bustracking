import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bus_track_admin/styles/styles.dart';
import 'package:bus_track_admin/screens/trip_screen.dart';
import 'package:bus_track_admin/widgets/widgets.dart';
import 'package:flutter/material.dart';

int itemindex = 0;
String itemtext = "Admin Screen";

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          title: WindowTitleBarBox(
            child: Stack(
              children: [
                Text(
                  "Where's My Bus",
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
          actions: [WindowButtons()],
          bottom: const TabBar(
            labelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 5,
            indicatorColor: Colors.red,
            unselectedLabelColor: Colors.black38,
            tabs: [
              Tab(
                icon: Icon(Icons.admin_panel_settings),
                text: "Admin Details",
              ),
              Tab(
                icon: Icon(
                  Icons.directions_bus,
                ),
                text: "Trip Details",
              ),
              Tab(
                icon: Icon(Icons.info),
                text: "Info",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.admin_panel_settings),
            TripScreen(),
            Icon(Icons.info),
          ],
        ),
      ),
    );
  }
}
