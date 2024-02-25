import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/button.dart';
import 'package:food_fly_delivery_partner/features/home/ui/widgets/order_detail/customer_order_detail.dart';

import '../widgets/order_detail/customer_order_product.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            CustomerOrderDetail(
              orderModel: orderModel,
            ),
            CustomerOrderProduct(
              orderModel: orderModel,
            ),
          ],
        ),
      ),
      bottomNavigationBar:
      // orderModel.orderStatus == 'Order Packed'
      true    ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: context.screenWidth,
                  height: 1.h,
                  color: Colors.grey,
                ),
                Container(
                  height: 90,
                  // decoration: BoxDecoration(border: Border.symmetric(horizontal:)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Row(
                    children: [
                      Expanded(
                          child: CommonButton(
                        backgroundColor: Colors.black,
                        height: 55.h,
                        onTap: () {
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              title: 'Order Accepted Successfully',
                              titleTextStyle: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.w700),
                              btnOkOnPress: () {
                                context.pop();
                              }).show();
                        },
                        btnText: 'Accept',
                        txtColor: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                          child: CommonButton(
                              backgroundColor: Colors.grey.shade200,
                              height: 55.h,
                              onTap: () {
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.warning,
                                    title: 'Order Rejected',
                                    titleTextStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700),
                                    btnOkOnPress: () {
                                      context.pop();
                                    }).show();
                              },
                              btnText: 'Decline',
                              txtColor: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp)),
                    ],
                  ),
                ),
              ],
            )
          : null,
    );
  }
}
