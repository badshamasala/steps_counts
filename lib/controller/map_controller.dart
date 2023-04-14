import 'package:flutter_web_app/steps_ui_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print("-----------------Map Controller Call Hua----------------");
    await getCurrentLocation().then((value) {
      lat = '${value.latitude}';
      long = '${value.longitude}';
      update();
      liveLocation();
      update();
    });
    update();
    calculateDistance();
  }

  GoogleMapController? mapController;

  dynamic lat;
  dynamic long;

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Services Not Enabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Permission are denied Forever');
    }
    return await Geolocator.getCurrentPosition();
  }

  var listen;
  TimerController timecont = Get.put(TimerController());
  liveLocation() async {
    
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 100);
    listen =  Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toDouble();
      long = position.longitude.toDouble();
      update();
    });
    update();
    timecont.startStopwatch();
  }

  List<LatLng> path = [];

  double distance = 0;
  calculateDistance() async {
    await listen.onData((Position position) async {
      LatLng newPosition = LatLng(position.latitude, position.longitude);
      path.add(newPosition);

      if (path.length > 1) {
        double lastDistance = await Geolocator.distanceBetween(
          path[path.length - 2].latitude,
          path[path.length - 2].longitude,
          newPosition.latitude,
          newPosition.longitude,
        );
        distance += lastDistance;
        print("---------------------$lastDistance------------------------");
      }
    });
    print(path);
  }
}
