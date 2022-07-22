import 'dart:convert';
import 'package:bus_track_admin/models/admin.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// String url = "http://bustrack.azurewebsites.net";
String url = "http://localhost:3000";

class Auth {
  static Future callSignIn(
      {required String username, required String password}) async {
    var body = {"username": username, "password": password};

    // print(body);
    http.Response response;
    try {
      response = await http.post(Uri.parse("$url/api/admin/signin"),
          body: jsonEncode(body),
          headers: <String, String>{'content-type': "application/json"});

      if (response.statusCode == 200) {
        var res = await jsonDecode(response.body);

        print(res);
        Admin.username = res['username'];

        Admin.email = res['email'];

        Admin.companyname = res['companyname'];

        Admin.companytype = res['companytype'];

        Admin.token = res['token'];

        Admin.registeredTripId = res['registeredTripId'];
        // await saveuser(res);

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
