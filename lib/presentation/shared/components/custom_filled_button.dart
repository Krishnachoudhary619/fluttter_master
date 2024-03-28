import 'package:flutter/material.dart';

import '../../theme/config/app_color.dart';
import 'app_text_theme.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    super.key,
    required this.title,
    this.onTap,
    this.borderRadius,
    this.radius,
    this.size,
    this.color,
    this.textColor,
  });

  factory CustomFilledButton.secondary({
    double? radius,
    required String title,
    required VoidCallback? onTap,
    BorderRadius? borderRadius,
    final Size? size,
  }) =>
      CustomFilledButton(
        title: title,
        size: size,
        radius: radius,
        borderRadius: borderRadius,
        onTap: onTap,
        textColor: AppColor.primary,
        color: AppColor.primary.withOpacity(0.12),
      );

  final String title;
  final double? radius;
  final VoidCallback? onTap;
  final Size? size;
  final Color? color;
  final Color? textColor;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? AppColor.primary,
          shadowColor: color,
          foregroundColor: color,
          surfaceTintColor: color,
          shape: RoundedRectangleBorder(
            borderRadius:
                borderRadius ?? BorderRadius.all(Radius.circular(radius ?? 0)),
          ),
          elevation: 0,
          fixedSize: size ?? const Size.fromHeight(50),
        ),
        child: Text(
          title,
          style: AppTextTheme.semiBold14.copyWith(
            color: textColor ?? Colors.white,
            letterSpacing: 0.5,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
