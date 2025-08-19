import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tilesapp/injection_container.dart' as di;
import 'package:tilesapp/ui/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const TilesApp());
}

class TilesApp extends StatefulWidget {
  const TilesApp({super.key});

  @override
  State<TilesApp> createState() => _TilesAppState();
}

class _TilesAppState extends State<TilesApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      routes: Routes.getRoutes(),
      onInit: () async {},
    );
  }
}
