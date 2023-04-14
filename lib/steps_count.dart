import 'package:flutter/material.dart';
import 'package:flutter_web_app/controller/map_controller.dart';
import 'package:flutter_web_app/steps_ui_page.dart';
import 'package:get/get.dart';





class StepCountPage extends StatelessWidget {
   StepCountPage({super.key});

MapController controller = Get.put(MapController());


  @override
  Widget build(BuildContext context) {
 print("------1--------0");
    print("----------------------${controller.lat}------------------");
    print("----------------------${controller.long}------------------");
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pedometer example app'),
        ),
        body: Column(
          children: [
          Spacer(),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: () async{
                 await controller.liveLocation();
                     Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  Getuserlocation()),
              );
            
                }, child: Text("Start Walking")),
              ),
            ),
              Spacer(),
            /*  Text(
                    'Steps taken:Real Time',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    i.toString(),
                    style: TextStyle(fontSize: 60),
                  ),
             Text(
                    'Steps taken:Pedometer',
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                   _steps,
                    style: TextStyle(fontSize: 60),
                  ),
            
                  Text(
                    'Pedestrian status:',
                    style: TextStyle(fontSize: 30),
                  ),
                  Icon(
                    _status == 'walking'
                        ? Icons.directions_walk
                        : _status == 'stopped'
                            ? Icons.accessibility_new
                            : Icons.error,
                    size: 100,
                  ),
                  Center(
                    child: Text(
                      _status,
                      style: _status == 'walking' || _status == 'stopped'
                          ? TextStyle(fontSize: 30)
                          : TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ) */
          ],
        ),
      
    );
  }
}