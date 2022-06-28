
import 'package:bus_tracking_app/authentication/authfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../providers/authlisten.dart';

class FirstPage extends StatefulWidget{


 

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  late IO.Socket socket;


  @override
  void initState() {
    
    connect();
    super.initState();
  }

  void connect(){

    socket=IO.io(url,<String,dynamic>{
      "transports":["websocket"],
      "autoConnect":false
    });
    
    socket.connect();

    
    socket.onConnect((data){
      print("flutter connected to socket");

      socket.on('/message', (data) => print(data));
      socket.on('/datachange', (data) => print(data));
      
    });
    
    socket.emit('/listenDB',"hello im here");
    
    
  }


    @override
  Widget build(BuildContext context) {
     
     return Scaffold(
      
      appBar: AppBar(

      actions: [IconButton(onPressed:()async{
        await Auth.signOut();
        Provider.of<AuthListen>(context,listen: false).signOutUser(); 
        
        }, icon: Icon(Icons.logout))],
      leading: const BackButton(
              color: Colors.white
      ),
      title: Text("FirstPage"),),
      body: Center(child: Text("THIS IS MY FIRST NAVIGATION",style: GoogleFonts.adamina(fontSize: 20.sp,fontWeight: FontWeight.w400),)),
     );
  }
}