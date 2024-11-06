import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/config/router/app_pages.dart';
import 'app/config/router/app_router_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: RoutesPaths.login ,
      getPages: AppPages.routes,
      );
  }
}

