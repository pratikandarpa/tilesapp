import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/base_screen/base_controller.dart';

class StripController extends BaseController {
  late List<StripParameter> parameters;

  @override
  void init() {
    super.init();
    _initializeParameters();
  }

  void _initializeParameters() {
    parameters = [
      StripParameter(
        name: "Total Hardness",
        unit: "(ppm)",
        colors: [
          const Color(0xFF1976D2), // Blue
          const Color(0xFF512DA8), // Purple
          const Color(0xFF7B1FA2), // Dark purple
          const Color(0xFF8E24AA), // Light purple
          const Color(0xFFAD1457), // Pink
        ],
        values: [0, 110, 250, 500, 1000],
      ),
      StripParameter(
        name: "Total Chlorine",
        unit: "(ppm)",
        colors: [
          const Color(0xFFFFF176), // Light yellow
          const Color(0xFFFFEB3B), // Yellow
          const Color(0xFFAED581), // Light green
          const Color(0xFF81C784), // Green
          const Color(0xFF26A69A), // Teal
        ],
        values: [0, 1, 3, 5, 10],
      ),
      StripParameter(
        name: "Free Chlorine",
        unit: "(ppm)",
        colors: [
          const Color(0xFFD7CCC8), // Beige
          const Color(0xFFFFF176), // Light yellow
          const Color(0xFF9575CD), // Purple
          const Color(0xFF7E57C2), // Dark purple
          const Color(0xFF512DA8), // Very dark purple
        ],
        values: [0, 1, 3, 5, 10],
      ),
      StripParameter(
        name: "pH",
        unit: "(ppm)",
        colors: [
          const Color(0xFFFF5722), // Orange red
          const Color(0xFFFF9800), // Orange
          const Color(0xFFFFD54F), // Light orange
          const Color(0xFFE91E63), // Pink
          const Color(0xFFAD1457), // Dark pink
        ],
        values: [6.2, 6.8, 7.2, 7.8, 8.4],
      ),
      StripParameter(
        name: "Total Alkalinity",
        unit: "(ppm)",
        colors: [
          const Color(0xFFFFB74D), // Orange
          const Color(0xFFFFF176), // Light yellow
          const Color(0xFF689F38), // Olive green
          const Color(0xFF388E3C), // Green
          const Color(0xFF00695C), // Dark teal
        ],
        values: [0, 40, 120, 180, 240],
      ),
      StripParameter(
        name: "Cyanuric Acid",
        unit: "(ppm)",
        colors: [
          const Color(0xFFFF8A65), // Light orange
          const Color(0xFFFFB74D), // Orange
          const Color(0xFFAD1457), // Dark pink
          const Color(0xFF7B1FA2), // Dark purple
          const Color(0xFF4A148C), // Very dark purple
        ],
        values: [0, 50, 100, 150, 300],
      ),
    ];
  }

  void selectColor(int parameterIndex, int colorIndex) {
    parameters[parameterIndex].selectedIndex.value = colorIndex;
    parameters[parameterIndex].textController.text =
        parameters[parameterIndex].values[colorIndex].toString();
  }

  void updateValueFromText(int parameterIndex, String value) {
    double? numValue = double.tryParse(value);
    if (numValue != null) {
      // Find the closest color index based on the value
      int closestIndex = _findClosestValueIndex(parameterIndex, numValue);
      parameters[parameterIndex].selectedIndex.value = closestIndex;
    }
  }

  int _findClosestValueIndex(int parameterIndex, double value) {
    List<double> values = parameters[parameterIndex].values;
    int closestIndex = 0;
    double minDifference = (values[0] - value).abs();

    for (int i = 1; i < values.length; i++) {
      double difference = (values[i] - value).abs();
      if (difference < minDifference) {
        minDifference = difference;
        closestIndex = i;
      }
    }

    return closestIndex;
  }

  @override
  void dispose() {
    for (var parameter in parameters) {
      parameter.textController.dispose();
    }
    super.dispose();
  }
}

class StripParameter {
  final String name;
  final String unit;
  final List<Color> colors;
  final List<double> values;
  final RxInt selectedIndex;
  final TextEditingController textController;

  StripParameter({
    required this.name,
    required this.unit,
    required this.colors,
    required this.values,
    int initialIndex = 0,
  }) : selectedIndex = initialIndex.obs,
       textController = TextEditingController(text: values[initialIndex].toString());
}
