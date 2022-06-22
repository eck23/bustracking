import 'dart:convert';

import 'package:bus_tracking_app/authentication/user.dart';
import 'package:http/http.dart' as http;


//String url="http://bustrack.azurewebsites.net";
String url="http://192.168.137.1:3000";

class Auth{


      
    static Future callSignUp({required String email, required String password, required String name})async {

    try{
          User  body= User(email: email,password: password ,name:name);

          //print(body.toJson());
          var response = await http.post(Uri.parse("$url/api/signup"),
          body: jsonEncode(body.toJson()),
          headers:<String,String>{'content-type': "application/json"}
          );

          return response.body;
    }catch(e){
        // print("an error occured : $e");
         int status=400;
         return  status;
    }

  }

  static Future callSignIn({required String email,required String password})async{

      var body={"email":email,"password":password};

     // print(body);
      try{

          var response = await http.post(Uri.parse("$url/api/signin"),
                                body: jsonEncode(body),
                                headers:<String,String>{'content-type': "application/json"}
                        );
           return response.body;

      }catch(e){
           return 500;
      }
  }

}