import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_fly/framework/controller/cart_controller/cart_controller.dart';
import 'package:food_fly/ui/utils/extension/context_extension.dart';

import '../../utils/common_device_config.dart';
import '../../utils/theme/app_assets.dart';
import '../../utils/theme/app_colors.dart';
import '../../utils/theme/app_routes.dart';
import '../../utils/theme/app_string.dart';
import '../../utils/theme/app_text_style.dart';
import '../../utils/theme/theme.dart';
import '../../utils/widgets/common_button.dart';
import 'helper/customer_order_detail_view.dart';

class CustomerOderDetail extends ConsumerStatefulWidget {
  final int quantity;
  final String foodId;
  final String deliveryBoyId;
  final String dateTime;
  final String orderId;
  final bool isPaid;
  final String? paymentId;
  const CustomerOderDetail({
    super.key,
    required this.orderId,
    required this.dateTime,
    this.paymentId,
    required this.quantity,
    required this.foodId,
    required this.deliveryBoyId,
    this.isPaid = false,
  });

  @override
  ConsumerState<CustomerOderDetail> createState() => _CancelOrderMobileState();
}

class _CancelOrderMobileState extends ConsumerState<CustomerOderDetail> {
  @override
  Widget build(BuildContext context) {
    final canCancel = 10 -
            DateTime.now()
                .difference(
                    DateFormat('dd/MM/yyyy HH:mm:ss').parse(widget.dateTime))
                .inMinutes >
        1;
    mobileDeviceConfig(context);
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(
            //   height: 48.h,
            // ),
            CustomerOrderDetailView(
              dateTime: widget.dateTime,
              quantity: widget.quantity,
              foodId: widget.foodId,
              deliveryBoyId: widget.deliveryBoyId,
              isPaid: widget.isPaid,
            ),
            SizedBox(
              height: 40.h,
            ),

            CommonButton(
              onTap: canCancel
                  ? () {
                      AwesomeDialog(
                              context: context,
                              btnOkOnPress: () {
                                ref.read(cartController).cancelOrder(
                                    widget.orderId,
                                    context,
                                    widget.paymentId,
                                    widget.deliveryBoyId);
                              },
                              btnCancelOnPress: () {},
                              btnOkText: 'Confirm',
                              title: 'Are your sure to cancel this order',
                              titleTextStyle: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.w600))
                          .show();

                      // Navigator.p`ushNamed(context, AppRoutes.findFoods);
                    }
                  : null,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.timer_outlined),
                  Text(
                    canCancel
                        ? '  ${ref.watch(appStringController).keyCancelMyOrder}'
                        : 'Times Up',
                    style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  get appBar => AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.dashBoard, (route) => false);
          },
          icon: SvgPicture.asset(
            AppAssets.arrowBackSvg,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your order",
                style: AppTextStyle.w5
                    .copyWith(color: AppColors.kBlack, fontSize: 22.sp)),
            Text(ref.watch(appStringController).keyYouDeserveBetterMeal,
                style: AppTextStyle.w3
                    .copyWith(color: AppColors.kGrey, fontSize: 14.sp))
          ],
        ),
      );
}
