import 'package:animations/animations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_detail_model.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/date_time_formater.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../map/ui/screens/map.dart';
import '../screens/order_detail.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      required this.orderDetailModel,
      this.isFromPendingOrder = false});
  final OrderDetailModel orderDetailModel;
  final bool isFromPendingOrder;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        openBuilder: (context, action) {
          return OrderDetail(
            orderDetailModel: orderDetailModel,
          );
        },
        closedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        openElevation: 0,
        closedElevation: 0,
        closedColor: context.colorScheme.background,
        closedBuilder: (context, w) {
          return Card(
              elevation: 0,
              color: Colors.white,
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                isFromPendingOrder
                                    ? 'DELIVERY TO '
                                    : 'DELIVERED TO   ',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                              if (orderDetailModel
                                      .orderModel.deliveryBoyId.isNotEmpty &&
                                  !orderDetailModel.orderModel.isDelivered)
                                const Icon(
                                  Icons.delivery_dining,
                                  color: Colors.green,
                                )
                            ],
                          ),
                          Text(
                            orderDetailModel.orderModel.orderDate,
                            // orderModel.orderDateTime.format('dd-MMM-yyyy hh:mm'),
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderDetailModel.foodDataModel.name!,
                                  // orderModel.orderDateTime.format('dd-MMM-yyyy hh:mm'),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  orderDetailModel.userModel.address ?? '',
                                  // orderModel.userAddress,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          IconButton.filledTonal(
                              style: IconButton.styleFrom(
                                  backgroundColor: isFromPendingOrder
                                      ? Colors.grey.shade300
                                      : Colors.grey.shade50,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r))),
                              onPressed: !isFromPendingOrder
                                  ? null
                                  : () {
                                      context.push(MapScreen(
                                          latLong: LatLng(
                                              orderDetailModel.userModel
                                                      .latLong!.latitude ??
                                                  0.0,
                                              orderDetailModel.userModel.latLong
                                                      ?.longitude ??
                                                  0.0)));
                                    },
                              icon: Icon(
                                isFromPendingOrder
                                    ? Icons.navigation_rounded
                                    : Icons.verified,
                                color: isFromPendingOrder
                                    ? Colors.black
                                    : Colors.blue,
                              ))
                        ],
                      ),
                      Divider(
                        height: 20.h,
                        color: Colors.grey.shade300,
                      ),
                      Row(
                        children: [
                          Text(
                            'Order Id : ',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '#${orderDetailModel.orderModel.id.substring(0, 5)}',
                            // '#${orderModel.orderId}',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Text(
                            '₹ ${((orderDetailModel.foodDataModel.price ?? 0 - (orderDetailModel.foodDataModel.offPrice ?? 0)) * 0.30).round()}',
                            // '₹ ${orderModel.paymentAmount}',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Customer Name : ',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${orderDetailModel.userModel.name}',
                            // '#${orderModel.orderId}',
                            style: TextStyle(
                                fontSize: 13.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      )
                    ],
                  )));
        });
  }
}
