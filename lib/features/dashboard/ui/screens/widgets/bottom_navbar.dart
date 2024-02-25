import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';

import '../../../controller/dashboard_controller.dart';

class BottomNavBarWidget extends ConsumerWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final dashboardController =ref.watch(dashboardControllerProvider);
    return Container(
      height: kBottomNavigationBarHeight+20.h,
      // margin: EdgeInsets.all(10.r),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,spreadRadius: 3,blurRadius: 3
          )
        ],
      color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15.r)),
      child:  BottomAppBar(
        notchMargin: 10.r,
        color: Colors.white,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  style: IconButton.styleFrom(
                      shape: CircleBorder(side: BorderSide(color: dashboardController.index==0?Colors.black:Colors.transparent)),
                      backgroundColor:dashboardController.index==0?null:Colors.transparent),
                  onPressed: (){
                    dashboardController.setIndex(0);
              }, icon: const Icon(Icons.delivery_dining)),
                if(dashboardController.index==0)
                  Text('Orders',style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w600),)

            ],
          ),
          SizedBox(width: context.screenWidth*0.10,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  style: IconButton.styleFrom(
                      shape: CircleBorder(side: BorderSide(color: dashboardController.index==1?Colors.black:Colors.transparent)),
                      backgroundColor:dashboardController.index==0?null:Colors.transparent),
                  onPressed: (){
                    dashboardController.setIndex(1);
              }, icon: const Icon(Icons.person)),
              if(dashboardController.index==1)
              Text('Profile',style: TextStyle(fontSize: 11.sp,fontWeight: FontWeight.w600),)
            ],
          ),
        ],),
      ),
    );
  }
}
