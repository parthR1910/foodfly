import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/features/home/controller/home_controller.dart';
import 'package:food_fly_delivery_partner/features/home/ui/widgets/order_card.dart';
import 'package:food_fly_delivery_partner/features/home/ui/widgets/order_shimmer_card.dart';


class PendingOrderView extends ConsumerWidget {
  const PendingOrderView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final homeController = ref.read(homeControllerProvider);
    return StreamBuilder<List<OrderModel>>(stream:homeController.getOrders(context), builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return ListView.separated(
          itemCount: 5,
          separatorBuilder: (context, index) => SizedBox(height: 10.h,),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          itemBuilder: (context, index) {
            return const OrderShimmerCard();
          },);
      }else if(snapshot.hasData) {
        List<OrderModel> pendingOrders = snapshot.data!.where((element) => element.isDelivered).toList();
        if(pendingOrders.isNotEmpty) {
          return ListView.builder(
          itemCount: pendingOrders.length,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          itemBuilder: (context, index) {
            final order = pendingOrders[index];
            return OrderCard(orderModel: order,isFromPendingOrder: true,);
          },);
        }
        return  Center(child: Text('No Record Found',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),);
      }
      return  Center(child: Text('No Record Found',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),);

    },);
  }
}
