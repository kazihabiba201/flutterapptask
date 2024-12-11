import 'package:flutterapptask/app/config/router/app_router_constants.dart';
import 'package:flutterapptask/app/features/auth/presentation/binding/auth_binding.dart';
import 'package:flutterapptask/app/features/auth/presentation/screen/login_screen.dart';
import 'package:flutterapptask/app/features/contacts/presentation/screen/contact_screen.dart';
import 'package:flutterapptask/app/features/conversation/presentation/screen/conversation_screen.dart';
import 'package:flutterapptask/app/features/home/presentation/binding/home_binding.dart';
import 'package:flutterapptask/app/features/home/presentation/screen/home_screen.dart';
import 'package:flutterapptask/app/features/setting/presentation/binding/setting_binding.dart';
import 'package:flutterapptask/app/features/setting/presentation/screen/setting_screen.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static final routes = [

    GetPage(
      name: RoutesPaths.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,

    ),
    GetPage(
      name: RoutesPaths.setting,
      page: () => const SettingScreen(),
      binding: SettingBinding(),
      transition: Transition.rightToLeft,

    ),
    GetPage(
      name: RoutesPaths.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,

    ),
    GetPage(
      name: RoutesPaths.contacts,
      page: () => const ContactScreen(),
      transition: Transition.rightToLeft,

    ),
    GetPage(
      name: RoutesPaths.conversation,
      page: () => const ConversationScreen(),
      transition: Transition.rightToLeft,

    ),



  ];
}
