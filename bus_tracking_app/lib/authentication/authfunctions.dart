import 'dart:convert';
import 'dart:io';
import 'package:bus_tracking_app/authentication/user.dart';
import 'package:bus_tracking_app/authentication/user_details.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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

  static signOut()async {
      SharedPreferences shared_User = await SharedPreferences.getInstance();
      shared_User.remove('user');
  }

  static getuser()async{
      SharedPreferences shared_User = await SharedPreferences.getInstance();
      var user=shared_User.getString('user');
      print(user);
      var returnval=user!=null?"OK":"Error";
      
      return returnval;
      
      // Map<String,dynamic> userMap = jsonDecode(getuser!) as Map<String, dynamic>;
      // print("user: ${userMap['email']} ");
  }

  static saveuser(var response)async{
      SharedPreferences shared_User = await SharedPreferences.getInstance();
      await shared_User.setString('user',jsonEncode( response));
  }

  static Future callSignIn({required String email,required String password})async{

      var body={"email":email,"password":password};

     // print(body);
     http.Response response;
      try{

          response = await http.post(Uri.parse("$url/api/signin"),
                                body: jsonEncode(body),
                                headers:<String,String>{'content-type': "application/json"}
                        );
           
          
          if(response.statusCode==200){

             var res=jsonDecode(response.body);
             await saveuser(res);

             return "OK";

          }
          else{
            
             if(response.statusCode==400){
                return jsonDecode(response.body)['msg'];
             }
             else{
              return "Error";
             }
          }


           

      }catch(e){
          return "Error";
      }
    }
}