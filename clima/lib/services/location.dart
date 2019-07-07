import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator().getLastKnownPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      print(position);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
      // Default to Cupertino
      latitude = 37.0;
      longitude = -122.0;
    }
  }
}
