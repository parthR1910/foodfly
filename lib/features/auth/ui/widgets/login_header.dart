import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';

import '../../../../common/utils/constants/app_assets.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350.h,
        width: context.screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.r),
              bottomRight: Radius.circular(30.r)),
          color: context.primaryColor,
        ),
        child: Column(
          children: [
            Lottie.asset(AppAssets.deliveryBoyLottie, height: 250),
            Text(
              'Food Fly Delivery \nPartner',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )
          ],
        ));
  }
}
