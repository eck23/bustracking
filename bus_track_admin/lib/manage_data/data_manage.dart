import 'dart:convert';

import 'package:bus_track_admin/values/url.dart';
import 'package:http/http.dart' as http;

class DataManage {
  static saveTrip(var trip) async {
    http.Response response;

    try {
      response = await http.post(Uri.parse("$localurl/api/addtrip"),
          body: trip,
          headers: <String, String>{'content-type': "application/json"});
      print(response.statusCode);
    } catch (e) {}
  }

  static getmytrips(String token) async {
    http.Response response;

    try {
      response = await http.post(Uri.parse("$localurl/api/getmytrips"),
          body: jsonEncode({'token': token}),
          headers: <String, String>{'content-type': "application/json"});
      // print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } catch (e) {}
  }
}
