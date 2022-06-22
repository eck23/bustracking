import 'dart:math';

class FindLocation {
  double longitude = 0;
  double latitude = 0;
  double longitudeMax = 0;
  double latitudeMax = 0;
  double longitudeMin = 0;
  double latitudeMin = 0;
  double distance = 0;
  FindLocation(
    double latitude,
    double longitude,
  ) {
    this.longitude = longitude;
    this.latitude = latitude;
  }
  void updateLocation(double latitude, double longitude) {
    this.longitude = longitude;
    this.latitude = latitude;
  }

  void calculateRegionBox(double factor) {
    //double factor = 0.000200;
    this.longitudeMax = this.longitude + factor;
    this.longitudeMin = this.longitude - factor;
    this.latitudeMax = this.latitude + factor;
    this.latitudeMin = this.latitude - factor;
  }

  int isRegionBox(double realLatitude, double realLongitude) {
    if (realLongitude <= longitudeMax &&
        realLongitude >= longitudeMin &&
        realLatitude <= latitudeMax &&
        realLatitude >= latitudeMin) {
      return 1;
    }
    return 0;
  }

  int isRegionCircle(double realLatitude, double realLongitude, double factor) {
    this.distance = sqrt((this.latitude - realLatitude) *
            (this.latitude - realLatitude) +
        (this.longitude - realLongitude) * (this.longitude - realLongitude));
    if (this.distance <= factor) {
      return 1;
    }
    return 0;
  }
}

