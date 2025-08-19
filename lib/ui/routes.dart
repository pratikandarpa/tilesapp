import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'home/home_screen.dart';
import 'strip/strip_screen.dart';

class Routes {
  Routes._();

  static String home = "/";
  static String strip = "/strip";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      strip: (context) => const StripScreen(),
    };
  }

  static RESULT get<RESULT>() {
    return Get.arguments as RESULT;
  }

  static void back<RESULT>({RESULT? argument}) {
    Get.back<RESULT>(result: argument);
  }

  static Future<RESULT?>? go<RESULT, ARGUMENT>(String name, {ARGUMENT? arguments}) {
    return Get.toNamed<RESULT>(name, arguments: arguments);
  }

  static Future<RESULT?>? replace<RESULT, ARGUMENT>(String name, {ARGUMENT? arguments}) {
    return Get.offNamed<RESULT>(name, arguments: arguments);
  }

  static Future<RESULT?>? replaceAll<RESULT, ARGUMENT>(String name, {ARGUMENT? arguments}) {
    return Get.offAllNamed<RESULT>(name, arguments: arguments);
  }
}
