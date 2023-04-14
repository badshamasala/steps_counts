import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_app/loyalty.dart';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.activityRecognition.request();
  await Permission.location.request();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
       
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
       
        ),
        home:  LoyaltyPage(),
      ),
    );
  }
}
