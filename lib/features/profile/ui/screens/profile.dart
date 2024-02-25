import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_fly_delivery_partner/common/config/router/app_routes.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/features/profile/ui/widgets/profile_view.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              'Profile',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
            actions: [
              IconButton.filledTonal(
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r))),
                  onPressed: () {
                    context.pushNamed(AppRoutes.notifications);
                  },
                  icon: const Icon(Icons.notifications_rounded)),
              SizedBox(
                width: 10.w,
              )
            ]),
        body: const ProfileView());
  }
}
