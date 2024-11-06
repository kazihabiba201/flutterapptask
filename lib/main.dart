import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/config/router/app_pages.dart';
import 'app/config/router/app_router_constants.dart';
import 'app/core/utils/shared_preference.dart';
import 'app/features/auth/presentation/controller/login_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsService.init();
  final loginController = Get.put(LoginController());
  await loginController.checkLoginStatus();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return GetMaterialApp(
      title: 'Flutter Task',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: loginController.isLoggedIn ? RoutesPaths.home : RoutesPaths.login,
      getPages: AppPages.routes,
      );
  }
}

