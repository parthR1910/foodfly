import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';


showSnackBar({required BuildContext context, required String error}) {
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(
    content: Text(
      error,
      style: TextStyle(fontSize: 12.sp, color: Colors.white),
    ),
    backgroundColor: context.primaryColor,
    duration: 3.seconds,
  ));
}
