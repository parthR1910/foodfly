
import 'package:animations/animations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/date_time_formater.dart';

import '../../../map/ui/screens/map.dart';
import '../screens/order_detail.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.orderModel,  this.isFromPendingOrder=false});
  final OrderModel orderModel;
  final bool isFromPendingOrder;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        openBuilder: (context, action) {
          return OrderDetail(orderModel: orderModel,);
        },
        closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        openElevation: 0,
        closedElevation: 0,
        closedColor: context.colorScheme.background,
        closedBuilder: (context,w) {
        return Card(
            elevation: 0,
            color: Colors.white,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isFromPendingOrder?'DELIVERY TO':'DELIVERED TO ',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                        Text(
                          '23-02-2004',
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
                                '',
                                // orderModel.userAddress,
                                style: TextStyle(
                                    fontSize: 14.sp, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        OpenContainer(
                            closedColor: Colors.transparent,
                            closedElevation: 0,
                            openColor: Colors.transparent,
                            openElevation: 0,
                            transitionDuration: 500.ms,
                            tappable: isFromPendingOrder,
                            openBuilder: (context, action) {
                              return const MapScreen();
                            },
                            closedBuilder: (context, action) {
                            return IconButton.filledTonal(
                                style: IconButton.styleFrom(
                                    backgroundColor: Colors.grey.shade300,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.r))),
                                onPressed:!isFromPendingOrder?null:(){
                                  action.call();
                                },
                                icon:  Icon(
                                isFromPendingOrder?Icons.navigation_rounded:  Icons.check_circle_outline_outlined,
                                  color: Colors.black,
                                ));
                          }
                        )
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
                          '#00000',
                          // '#${orderModel.orderId}',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Text(
                          '₹ 499',
                          // '₹ ${orderModel.paymentAmount}',
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                )));
      }
    );
  }
}
