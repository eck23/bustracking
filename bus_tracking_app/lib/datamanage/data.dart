import 'dart:convert';

import 'package:http/http.dart' as http;

import '../values/values.dart';

class DataManage {
  static getTrips(String source, String destination) async {
    try {
      var response = await http.get(
          Uri.parse("$url/api/get_trips_by_location/$source/$destination"));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return "Error";
      }
    } catch (e) {
      return "Error";
    }
  }
}
