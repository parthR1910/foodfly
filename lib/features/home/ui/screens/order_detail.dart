import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/model/order_detail_model.dart';
import 'package:food_fly_delivery_partner/common/model/order_model.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';
import 'package:food_fly_delivery_partner/common/utils/services/fire_base_singleton.dart';
import 'package:food_fly_delivery_partner/common/utils/services/fire_store_service.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/button.dart';
import 'package:food_fly_delivery_partner/common/utils/widgets/text_input.dart';
import 'package:food_fly_delivery_partner/features/home/controller/order_detail_controller.dart';
import 'package:food_fly_delivery_partner/features/home/ui/widgets/order_detail/customer_order_detail.dart';
import 'package:food_fly_delivery_partner/features/map/ui/screens/map.dart';
import 'package:pinput/pinput.dart';

import '../widgets/order_detail/customer_order_product.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetail extends ConsumerWidget {
  const OrderDetail({super.key, required this.orderDetailModel});
  final OrderDetailModel orderDetailModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderDetailWatch = ref.watch(orderDetailControllerProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomerOrderDetail(
                    orderDetailModel: orderDetailModel,
                  ),
                  // if(!orderDetailModel.orderModel .isDelivered && orderDetailModel.orderModel .deliveryBoyId.isNotEmpty)
                  //   ...[

                  //   ],
                  CustomerOrderProduct(
                    orderDetailModel: orderDetailModel,
                  ),
                ],
              ),
            ),
          ),
          if (!orderDetailModel.orderModel.isDelivered &&
              orderDetailModel.orderModel.deliveryBoyId.isEmpty)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: context.screenWidth,
                  height: 1.h,
                  color: Colors.grey,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: CommonButton(
                    backgroundColor: Colors.black,
                    height: 55.h,
                    onTap: () {
                      orderDetailWatch.confirmOrder(
                          context, orderDetailModel.orderModel.id);
                    },
                    btnText: 'Accept',
                    txtColor: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          if (!orderDetailModel.orderModel.isDelivered &&
              orderDetailModel.orderModel.deliveryBoyId.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CommonButton(
                        onTap: () {
                          _launchMapsUrl(
                              orderDetailModel.userModel.latLong!.latitude!,
                              orderDetailModel.userModel.latLong!.longitude!);
                        },
                        btnText: 'Track User',
                        backgroundColor: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: StreamBuilder<OrderModel>(
                        stream: FireStoreService.fireStoreService.fireStore
                            .collection('UserOrders')
                            .doc(orderDetailModel.orderModel.id)
                            .snapshots()
                            .map((event) => OrderModel.fromJson(event.data()!)),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final dataModel = snapshot.data!;

                            return CommonButton(
                                onTap: () {
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      body: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Enter Otp To Confirm Order n🔥🎉',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w800,
                                                  color: context.primaryColor),
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                            Pinput(
                                              length: 4,
                                              onChanged: (value) {
                                                orderDetailWatch
                                                    .confirmOrderOTP = value;
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                            SizedBox(
                                              height: 15.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                      btnOk: Row(
                                        children: [
                                          Expanded(
                                            child: CommonButton(
                                                onTap: () async {
                                                  await orderDetailWatch
                                                      .generateOTP(
                                                          orderDetailModel
                                                              .orderModel.id,
                                                          orderDetailModel
                                                                  .userModel
                                                                  .fcmToken ??
                                                              '',
                                                          orderDetailModel
                                                              .userModel.uid!);
                                                  Fluttertoast.showToast(
                                                      gravity:
                                                          ToastGravity.CENTER,
                                                      msg:
                                                          'OTP send to ${orderDetailModel.userModel.name}');
                                                  context.pop();
                                                },
                                                btnText:
                                                    dataModel.confirmationOTP !=
                                                                null &&
                                                            dataModel
                                                                .confirmationOTP!
                                                                .isNotEmpty
                                                        ? 'Resend OTP'
                                                        : 'Send OTP',
                                                backgroundColor:
                                                    context.primaryColor,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Expanded(
                                            child: CommonButton(
                                                onTap: () {
                                                  orderDetailWatch.verifyOtp(
                                                      dataModel.confirmationOTP,
                                                      orderDetailModel
                                                          .orderModel.id,
                                                      context);
                                                },
                                                btnText: 'Submit',
                                                backgroundColor:
                                                    context.primaryColor,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      )).show();
                                  return;
                                },
                                btnText: 'Deliver Order',
                                backgroundColor: context.primaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600);
                          }
                          return SizedBox();
                        }),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  void _launchMapsUrl(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
