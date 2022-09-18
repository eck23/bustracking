import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../values/values.dart';

class Auth {
  static getUserFromLocal() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    var user = shared_User.getString('user');
    // print(user);
    var returnval = user != null ? "OK" : "Error";

    return returnval;

    // Map<String,dynamic> userMap = jsonDecode(getuser!) as Map<String, dynamic>;
    // print("user: ${userMap['email']} ");
  }

  static saveuser(var response) async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    await shared_User.setString('user', jsonEncode(response));
  }

  static Future callSignUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      // User  body= User(email: email,password: password ,name:name);

      //print(body.toJson());
      var response = await http.post(Uri.parse("$url/api/signup"),
          body:
              jsonEncode({"email": email, "password": password, "name": name}),
          headers: <String, String>{'content-type': "application/json"});

      // print("status code  :${response.statusCode}");

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        // await signOut();
        await saveuser(res);
        return "OK";
      } else {
        if (response.statusCode == 400) {
          return jsonDecode(response.body)['msg'];
        } else {
          if (response.statusCode == 500 &&
              jsonDecode(response.body)['error'] ==
                  "User validation failed: email: incorrect email format") {
            return "Invalid";
          }

          return "Error";
        }
      }
    } catch (e) {
      // print("an error occured : $e");
      int status = 400;
      return status;
    }
  }

  static Future callSignIn(
      {required String email, required String password}) async {
    var body = {"email": email, "password": password};

    // print(body);
    http.Response response;
    try {
      response = await http.post(Uri.parse("$url/api/signin"),
          body: jsonEncode(body),
          headers: <String, String>{'content-type': "application/json"});

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        await saveuser(res);

        return "OK";
      } else {
        if (response.statusCode == 400) {
          return jsonDecode(response.body)['msg'];
        } else {
          return "Error";
        }
      }
    } catch (e) {
      return "Error";
    }
  }

  static signOut() async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    shared_User.remove('user');
  }
}
