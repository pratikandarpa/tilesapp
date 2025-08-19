import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/base_screen/base_screen.dart';
import 'strip_controller.dart';

class StripScreen extends BaseScreen {
  const StripScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StripScreenState();
}

class _StripScreenState extends BaseScreenState<StripScreen, StripController> {
  @override
  Widget buildWidget() {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Next', style: TextStyle(color: Colors.black54)),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'Test Strip',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B365D),
                ),
              ),
            ),
            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Left vertical color bar
                    _buildVerticalColorBar(),
                    const SizedBox(width: 20),
                    // Parameters section
                    Expanded(child: _buildParametersSection()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalColorBar() {
    return Container(
      width: 40,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: List.generate(controller.parameters.length, (index) {
          final parameter = controller.parameters[index];
          return Expanded(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Obx(
                () => Container(
                  width: double.infinity,
                  height: 32,
                  decoration: BoxDecoration(
                    color: parameter.colors[parameter.selectedIndex.value],
                    borderRadius: BorderRadius.vertical(
                      top: index == 0 ? const Radius.circular(7) : Radius.zero,
                      bottom:
                          index == controller.parameters.length - 1
                              ? const Radius.circular(7)
                              : Radius.zero,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildParametersSection() {
    return Column(
      children: List.generate(controller.parameters.length, (index) {
        return Expanded(child: _buildParameterRow(index));
      }),
    );
  }

  Widget _buildParameterRow(int parameterIndex) {
    final parameter = controller.parameters[parameterIndex];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Parameter name and unit
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        parameter.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(parameter.unit, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ),
                // Input field
                SizedBox(
                  width: 60,
                  height: 30,
                  child: TextField(
                    controller: parameter.textController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    onChanged: (value) {
                      controller.updateValueFromText(parameterIndex, value);
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          // Color options with values below
          Row(
            children: List.generate(parameter.colors.length, (colorIndex) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.selectColor(parameterIndex, colorIndex);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      children: [
                        // Color block
                        Obx(
                          () => Container(
                            height: 32,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: parameter.colors[colorIndex],
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  parameter.selectedIndex.value == colorIndex
                                      ? Border.all(color: Colors.black, width: 2)
                                      : Border.all(color: Colors.grey[300]!, width: 0.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Value text below color
                        Text(
                          parameter.values[colorIndex] == parameter.values[colorIndex].toInt()
                              ? parameter.values[colorIndex].toInt().toString()
                              : parameter.values[colorIndex].toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
