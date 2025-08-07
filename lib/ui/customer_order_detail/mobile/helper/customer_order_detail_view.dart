import 'package:easy_localization/easy_localization.dart';
import 'package:food_fly/ui/customer_order_detail/mobile/helper/customer_order_delivery_boy_detail.dart';
import 'package:food_fly/ui/customer_order_detail/mobile/helper/cutomer_oder_detail_food_detail.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_string.dart';
import '../../../utils/theme/app_text_style.dart';

import '../../../utils/theme/theme.dart';

class CustomerOrderDetailView extends StatelessWidget {
  final int quantity;
  final String foodId;
  final String deliveryBoyId;
  final bool isPaid;
  final String dateTime;

  const CustomerOrderDetailView(
      {super.key,
      required this.quantity,
      required this.dateTime,
      required this.foodId,
      required this.deliveryBoyId,
      required this.isPaid});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final appStringWatch = ref.watch(appStringController);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Item Order:
            CustomerOrderDetailFoodDetail(
              foodId: foodId,
              quantity: quantity,
            ),
            SizedBox(
              height: 20.h,
            ),

            /// Delivery boy details ///
            CustomerOrderDeliveryBoyDetail(
              deliveryBoyId: deliveryBoyId,
            ),
            SizedBox(
              height: 20.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Date: ',
                  style: AppTextStyle.w4
                      .copyWith(fontSize: 16.sp, color: AppColors.kBlack),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  dateTime,
                  style: AppTextStyle.w4
                      .copyWith(fontSize: 15.sp, color: AppColors.kGrey),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Text(
                      appStringWatch.keyOrderStatus,
                      style: AppTextStyle.w4
                          .copyWith(fontSize: 16.sp, color: AppColors.kBlack),
                    ),
                    const Spacer(),
                    JustTheTooltip(
                      triggerMode: TooltipTriggerMode.tap,
                      content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (10 -
                                      DateTime.now()
                                          .difference(
                                              DateFormat('dd/MM/yyyy HH:mm:ss')
                                                  .parse(dateTime))
                                          .inMinutes >
                                  1)
                                const Text(
                                  'Time Remaining to \nCancel Order',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.kPrimary),
                                ),
                              if (10 -
                                      DateTime.now()
                                          .difference(
                                              DateFormat('dd/MM/yyyy HH:mm:ss')
                                                  .parse(dateTime))
                                          .inMinutes >
                                  1)
                                Text(
                                  '${10 - DateTime.now().difference(DateFormat('dd/MM/yyyy HH:mm:ss').parse(dateTime)).inMinutes} minutes',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              else
                                Text('Times Up For Cancel Order',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.kPrimary))
                            ],
                          )),
                      child: const Icon(
                        Icons.info,
                        color: AppColors.kPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${foodId.substring(0, 20)}",
                      style: AppTextStyle.w4
                          .copyWith(fontSize: 16.sp, color: AppColors.kGrey),
                    ),
                    Text(
                      isPaid ? "Paid" : "Unpaid",
                      style: AppTextStyle.w4.copyWith(
                          fontSize: 16.sp, color: AppColors.kLightGreen),
                    )
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
