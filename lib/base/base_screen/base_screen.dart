import 'package:flutter/material.dart';

import '../../injection_container.dart';
import 'base_controller.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});
}

abstract class BaseScreenState<Page extends BaseScreen, Controller extends BaseController>
    extends State<Page> {
  Controller controller = di.get<Controller>();
  late double mediaQueryHeight;
  late double mediaQueryWidth;

  @override
  void initState() {
    super.initState();
    controller.setContext(context);
    controller.init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Page oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.didUpdateWidget();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryHeight = MediaQuery.of(context).size.height;
    mediaQueryWidth = MediaQuery.of(context).size.width;
    return buildWidget();
  }

  Widget buildWidget();
}
