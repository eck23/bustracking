import 'package:bus_tracking_app/functions.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';



void main()=>runApp(const LocationApp());

class LocationApp extends StatefulWidget{
  const LocationApp({Key? key}) : super(key: key);



  @override
  State<LocationApp> createState() => _LocateState();
}

class _LocateState extends State<LocationApp> {


  

 late FindLocation findLocation;
  Location location= Location();
  late LocationData locationData;
  late PermissionStatus permissionStatus;
  bool isListen=false, isget=false;
  bool serviceEnabled=false;

  int index =0;
  
  @override
  void initState() {
    

    location.onLocationChanged.listen((event) {
          
          print("latitude : ${event.latitude} longitude: ${event.longitude}");
          
          //altitude can be accessed - event.altitude
    });

    super.initState();
  }

  
  

  void getLocation()async {

      serviceEnabled= await Location.instance.serviceEnabled();

      if(!serviceEnabled){

        serviceEnabled=await Location.instance.requestService();

        if(!serviceEnabled)return;
      }

      permissionStatus=await Location.instance.hasPermission();

      if(permissionStatus==PermissionStatus.denied){
        permissionStatus=await Location.instance.requestPermission();

        if(permissionStatus!=PermissionStatus.granted)return;
      }

      locationData=await Location.instance.getLocation();

      setState(() {
          isget=true;
      });

  }

  @override
  Widget build(BuildContext context) {
      
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
               
                children: [
                  
                  ElevatedButton(onPressed: getLocation, child: const Text("Get location")),
                  if(isget)Text("Current Latitude : ${locationData.latitude} longitude : ${locationData.longitude}  "),
                  const ElevatedButton(onPressed: null, child: Text("Listen location")),

                  // StreamBuilder(
                  //   stream: location.onLocationChanged,
                  //   builder: ((context, snapshot){
                  //   var snap=snapshot.data as LocationData;
                    
                  //   if(findLocation.isRegionCircle(snap.latitude!, snap.longitude!, 0.000200)==1){
                  //         print("Bus is in ${stops[index]['stopName']}\n");
                  //         index++;
                  //         if(index>1)
                  //           index=0;
                  //         findLocation.updateLocation(double.parse(stops[index]['latitude']), double.parse(stops[index]['longitude']));
                  //   }
                  //   else{
                  //     print("not in stop\n");
                  //   }
                  //   return Text("latitude ${snap.latitude} longitude ${snap.longitude}",style: TextStyle(fontSize: 20),);
                  // }))
        
        
                ],
            ),
          ),
        ),
      );
  }
}