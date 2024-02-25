import 'dart:convert';

import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/features/home/controller/home_controller.dart';

import '../order_shimmer_card.dart';
import '../order_card.dart';


class DeliveredOrdersView extends StatelessWidget {
  const DeliveredOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    /*return FutureBuilder<List<OrderModel>>(future: context.read<HomeController>().getOrders(context), builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return ListView.separated(
          itemCount: 5,
          separatorBuilder: (context, index) => SizedBox(height: 10.h,),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          itemBuilder: (context, index) {
            return const OrderShimmerCard();
          },);
      }else if(snapshot.hasData) {
        List<OrderModel> deliveredOrders = snapshot.data!.where((element) => element.orderStatus=='Order Accepted').toList();
    if(deliveredOrders.isNotEmpty) {
      return ListView.builder(
        itemCount: deliveredOrders.length,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        itemBuilder: (context, index) {
          final order = deliveredOrders[index];
          return OrderCard(orderModel: order,);
        },);
    }
        return  Center(child: Text('No Record Found',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600),),);

      }
      return const Center(child: Text('No Record Found'),);
    },);*/
  }
}
