class StopDetails {
  String _stopname = "";
  List<String> _stopTimes = [];

  updateStopName(String name) {
    this._stopname = name;
  }

  updateStopTimeList(String time) {
    this._stopTimes.add(time);
  }

  List<String> get getStopTime {
    return this._stopTimes;
  }
}
