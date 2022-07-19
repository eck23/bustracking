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

// class AppDrawer extends StatefulWidget {
//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> {
//   changeScreenIndex(int index) {
//     setState(() {
//       itemindex = index;
//       switch (index) {
//         case 0:
//           itemtext = "Admin Screen";
//           break;
//         case 1:
//           itemtext = "Trips Screen";
//           break;
//         case 2:
//           itemtext = " Screen";
//           break;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Stack(
//         children: [
//           ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                 ),
//                 child: Text('Drawer Header'),
//               ),
//               ListTile(
//                 title: const Text('Admin Details'),
//                 leading: Icon(Icons.admin_panel_settings_rounded),
//                 onTap: () => changeScreenIndex(0),
//               ),
//               ListTile(
//                 title: const Text('Added Trips'),
//                 leading: Icon(Icons.bus_alert_outlined),
//                 onTap: () => changeScreenIndex(1),
//               ),
//               ListTile(
//                 title: const Text('About'),
//                 leading: Icon(Icons.info_outline_rounded),
//                 onTap: () => changeScreenIndex(2),
//               ),
//             ],
//           ),
//           WindowTitleBarBox(
//             child: Expanded(child: MoveWindow()),
//           ),
//         ],
//       ),
//     );
//   }
// }


