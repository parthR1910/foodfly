import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/features/dashboard/controller/dashboard_controller.dart';
import 'package:food_fly_delivery_partner/features/dashboard/ui/screens/widgets/bottom_navbar.dart';
import 'package:food_fly_delivery_partner/features/home/controller/home_controller.dart';
import 'package:food_fly_delivery_partner/features/home/ui/screens/home.dart';
import 'package:food_fly_delivery_partner/features/profile/controller/profile_controller.dart';
import 'package:food_fly_delivery_partner/features/profile/repository/profile_repository.dart';
import 'package:food_fly_delivery_partner/features/profile/ui/screens/profile.dart';
import 'package:food_fly_delivery_partner/features/profile/ui/widgets/profile_shimmer_loading.dart';

import '../widgets/map_fab.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final dashboardWatch = ref.watch(dashboardControllerProvider);
    return Scaffold(
      body: [
        const Home(),
    const Profile(),
      ][dashboardWatch.index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const MapFab(),
      bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}
