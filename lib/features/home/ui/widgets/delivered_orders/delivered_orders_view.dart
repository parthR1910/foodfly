import 'dart:convert';

import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_detail_model.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/utils/services/auth_service.dart';
import 'package:food_fly_delivery_partner/features/home/controller/home_controller.dart';
import 'package:food_fly_delivery_partner/features/home/controller/order_detail_controller.dart';
import 'package:geocoding/geocoding.dart';

import '../order_shimmer_card.dart';
import '../order_card.dart';

class DeliveredOrdersView extends ConsumerWidget {
  const DeliveredOrdersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeController = ref.read(homeControllerProvider);

    return StreamBuilder<List<OrderModel>>(
      stream: homeController.getOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasData) {
          List<OrderModel> pendingOrders =
          snapshot.data!.where((element){
            return element.isDelivered && element.deliveryBoyId.toString()==AuthService.authService.auth.currentUser!.uid;
          }).toList();
          if (pendingOrders.isNotEmpty) {
            return ListView.separated(
              itemCount: pendingOrders.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10
              ),
              padding:   EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              itemBuilder: (context, index) {
                final order = pendingOrders[index];
                return StreamBuilder<OrderDetailModel>(
                    stream: ref
                        .read(orderDetailControllerProvider)
                        .orderDetailStream(order.userId, order.foodId,order.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox();
                      } else if (snapshot.hasData) {
                        final orderDetailModel = snapshot.data!;
                        return OrderCard(
                          orderDetailModel: orderDetailModel,
                          isFromPendingOrder: false,
                        );
                      }
                      return noRecordFound;
                    });
              },
            );
          }
          return noRecordFound;
        }
        return noRecordFound;
      },
    );
  }

  Widget get noRecordFound => Center(
        child: Text(
          'No Record Found',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
      );

  // Widget get shimmerLoading => ListView.separated(
  //   itemCount: 5,
  //   separatorBuilder: (context, index) => SizedBox(
  //     height: 10.h,
  //   ),
  //   padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
  //   itemBuilder: (context, index) {
  //     return const OrderShimmerCard();
  //   },
  // );
}
