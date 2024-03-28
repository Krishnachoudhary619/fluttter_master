import 'package:flutter/material.dart';

import 'config/app_color.dart';

class AppStyle {
  AppStyle._();

  static List<BoxShadow> get shadow => [
        BoxShadow(
          color: AppColor.grey.withOpacity(0.2),
          blurRadius: 3,
          spreadRadius: 3,
          offset: const Offset(1, 3),
        ),
      ];
}
