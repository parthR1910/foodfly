import 'package:flutter/material.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.child,
      required this.onTap,
      this.backgroundColor = AppColors.kPrimary,
      this.foregroundColor = Colors.white,
      this.padding,
      this.radius = 8,
      this.iconButton = false,
      this.icon});

  final Widget child;
  final void Function()? onTap;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final bool iconButton;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    if (!iconButton) {
      return ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius))),
          onPressed: onTap,
          child: Padding(
            padding: padding!,
            child: child,
          ));
    } else {
      return ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius))),
          onPressed: onTap,
          icon: icon!,
          label: child);
    }
  }
}
