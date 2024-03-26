import 'dart:convert';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_detail_model.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/features/home/controller/home_controller.dart';
import 'package:food_fly_delivery_partner/features/home/controller/order_detail_controller.dart';
import 'package:food_fly_delivery_partner/features/home/ui/widgets/order_card.dart';

class PendingOrderView extends ConsumerWidget {
  const PendingOrderView({super.key});

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
                  snapshot.data!.where((element) => !element.isDelivered).toList();
              // pendingOrders.removeWhere((element) => element.deliveryBoyId!= )
              if (pendingOrders.isNotEmpty) {
                return ListView.separated(
                  itemCount: pendingOrders.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  padding:   EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  itemBuilder: (context, index) {
                    final order = pendingOrders[index];
                    print('order.id');
                    print(order.id);
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
                              isFromPendingOrder: true,
                            );
                          }
                          return Center(
                            child: Text(
                              snapshot.error.toString(),
                              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                            ),
                          );;
                        });
                  },
                );
              }
              return Center(
                child: Text(
                  'No Record Found',
                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                ),
              );;
            }
            return Center(
              child: Text(
                'No Record Found',
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
              ),
            );;
          },
        );
  }
}
