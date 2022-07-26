import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  List stopsSearchList = [];

  updateList(var data) {
    stopsSearchList = data;
    notifyListeners();
  }
}
