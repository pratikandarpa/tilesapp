import 'package:flutter/material.dart';

import '../../../common/constants/color_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstants.primary,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.tune, color: ColorConstants.white),
          onPressed: () {
            // Filter functionality
          },
        ),
        IconButton(
          icon: const Icon(Icons.search, color: ColorConstants.white),
          onPressed: () {
            // Search functionality
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
