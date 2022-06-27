import 'package:bus_tracking_app/authentication/authfunctions.dart';
import 'package:flutter/foundation.dart';

class AuthListen with ChangeNotifier{

     bool isSignedIn=false;

    signInUser(){
      isSignedIn=true;
      notifyListeners();  
    }

    signOutUser(){
      isSignedIn=false;
      //Auth.signOut;
      notifyListeners();  
    }


}