import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_app/controller/map_controller.dart';
import 'package:flutter_web_app/controller/step_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Getuserlocation extends StatelessWidget {
  MapController controller = Get.put(MapController());
  StepController controller1 = Get.put(StepController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: GetBuilder<MapController>(builder: (controller) {
                return GoogleMap(
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse("${controller.lat}"),
                          double.parse("${controller.long}")),
                      zoom: 15),
                );
              }),
            ),
            GetBuilder<TimerController>(builder: (controller) {
              return Text(
                controller._stopwatch.elapsed.inMinutes
                        .toString()
                        .padLeft(2, '0') +
                    ':' +
                    (controller._stopwatch.elapsed.inSeconds % 60)
                        .toString()
                        .padLeft(2, '0'),
                style: const TextStyle(fontSize: 48.0),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: GetBuilder<MapController>(builder: (controller) {
                        return Center(
                            child: Text(
                          controller.distance.toString(),
                          style: TextStyle(fontSize: 30),
                        ));
                      }),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.8),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                        color: Color(0xFFEFEEEE),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    Text("in metre")
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: GetBuilder<MapController>(builder: (controller) {
                        return Center(
                            child: Text(
                          controller1.i.toString(),
                          style: TextStyle(fontSize: 30),
                        ));
                      }),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.8),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                        color: Color(0xFFEFEEEE),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    Text("Steps Taken")
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment : MainAxisAlignment.center,
              children: [
                GetBuilder<TimerController>(builder: (controller) {
                  return Container(
                     decoration: BoxDecoration(
                      shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.8),
                            offset: Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(6.0, 6.0),
                            blurRadius: 16.0,
                          ),
                        ],
                        color: Color(0xFFEFEEEE),
                   
                      ),
                    child: IconButton(
                        onPressed: () {
                          if (controller._stopwatch.isRunning) {
                             controller.stopStopwatch();
                          } else {
                            controller.startStopwatch();
                          }
                         
                        }, icon: Icon(controller._stopwatch.isRunning ? Icons.pause : Icons.play_arrow)),
                  );
                })
              ],
            ),
            Icon(
              controller1.status == 'walking'
                  ? Icons.directions_walk
                  : controller1.status == 'stopped'
                      ? Icons.accessibility_new
                      : Icons.error,
              size: 40,
            ),
            Center(
              child: Text(
                controller1.status == null ? "Stopped" : controller1.status,
                style: controller1.status == 'walking' ||
                        controller1.status == 'stopped'
                    ? const TextStyle(fontSize: 30, color: Colors.black)
                    : const TextStyle(fontSize: 20, color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TimerController extends GetxController {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  void startStopwatch() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      update();
    });
    _stopwatch.start();
   
  }

  void stopStopwatch() {
    _timer!.cancel();
    _stopwatch.stop();
    update();
  }

  void resetStopwatch() {
    _timer!.cancel();
    _stopwatch.reset();
  }
}
