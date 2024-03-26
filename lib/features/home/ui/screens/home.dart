import 'package:flutter/material.dart';
import 'package:food_fly_delivery_partner/common/config/router/app_routes.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/constants/app_const.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/services/auth_service.dart';
import 'package:food_fly_delivery_partner/common/utils/services/local_db.dart';
import 'package:food_fly_delivery_partner/features/home/controller/home_controller.dart';
import 'package:food_fly_delivery_partner/features/home/ui/widgets/tab_bar_view_widget.dart';
import 'package:food_fly_delivery_partner/features/home/ui/widgets/tab_bar_widget.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
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
            ],
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoutes.profile);
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  )),
            ),
            title: Text(
              'Food Fly Delivery Partner',
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700),
            ),
          ),
          body: const Column(
            children: [
              TabBarWidget(),
              Expanded(child: TabBarViewWidget()),
            ],
          )),
    );
  }
}
