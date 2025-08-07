import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_fly/framework/controller/order_controller.dart';
import 'package:food_fly/ui/utils/extension/context_extension.dart';
import 'package:food_fly/ui/utils/extension/widget_extension.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/widgets/common_form_field.dart';
import '../../../../framework/model/food_data_model/food_data_model.dart';
import '../../../../framework/model/user_orders/user_orders_model.dart';
import '../../../../framework/service/auth_service.dart';
import '../../../../framework/service/fire_store_service.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_text_style.dart';
import 'cart_tile.dart';

class CompletedOrders extends StatelessWidget {
  const CompletedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UserOrdersModel>>(
        stream: FireStoreService.fireStoreService.getUserFoodOrdersFireStore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final uid = AuthService.authService.auth.currentUser!.uid;
            final completedOrdersList = snapshot.data!
                .where(
                    (element) => element.userId == uid && element.isDelivered!)
                .toList();
            DateTime getDateTimeFromString(String dateTime) {
              return DateFormat('dd/MM/yyyy HH:mm:ss').parse(dateTime);
            }

            completedOrdersList.sort((a, b) =>
                getDateTimeFromString(b.dateTime!)
                    .compareTo(getDateTimeFromString(a.dateTime!)));

            if (completedOrdersList.isEmpty) {
              return const Center(
                child: Text('No orders yet'),
              );
            }
            return ListView.builder(
              itemCount: completedOrdersList.length,
              itemBuilder: (context, index) {
                final order = completedOrdersList[index];
                return StreamBuilder(
                  stream: FireStoreService.fireStoreService
                      .getFoodDataByIdFireStore(order.foodId!),
                  builder: (context, snapshot) {
                    ///-------------- LOADING-----------///
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }

                    /// -------------- DATA LOADED -------///
                    else if (snapshot.hasData) {
                      final foodData = snapshot.data!;
                      return completedOrdersList.isEmpty
                          ? const Center(
                              child: Text("ADD data to cart"),
                            )
                          : CartTile(
                              buttonText: "Review",
                              quantity: order.quantity ?? 1,
                              dateTime: order.dateTime,
                              onButtonTap: foodData.ratings?.any((element) =>
                                          element.orderId == order.uOrderId) ??
                                      false
                                  ? null
                                  : () {
                                      showBottomSheet(
                                          backgroundColor: Colors.black,
                                          context: context,
                                          builder: (context) {
                                            return ReviewOrderBottomSheet(
                                                foodData,
                                                orderId: order.uOrderId ?? '');
                                          });
                                    },
                              backgroundColor: AppColors.kPrimary,
                              foodData: foodData,
                              paidStatus: Text("Paid",
                                  style: AppTextStyle.w5.copyWith(
                                      fontSize: 16.sp,
                                      color: AppColors.kLightGreen)),
                              orderStatusText: "Successfully delivered",
                              orderStatusColor: AppColors.kLightGreen,
                            );
                    }

                    ///------------ NO DATA FOUND ----------- ///
                    else {
                      return const Center(
                        child: Text("No data available"),
                      );
                    }
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text("No data available"),
            );
          }
        });
  }
}

class ReviewOrderBottomSheet extends ConsumerWidget {
  const ReviewOrderBottomSheet(this.foodData,
      {required this.orderId, super.key});
  final FoodDataModel foodData;
  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderWatch = ref.watch(orderControllerProvider);

    return Ink(
      child: BottomSheet(
        backgroundColor: Colors.white,
        elevation: 0,
        enableDrag: true,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
          side: const BorderSide(color: Colors.grey),
        ),
        onClosing: () {
          orderWatch.clearData();
          context.pop();
        },
        onDragStart: (details) {
          orderWatch.clearData();

          context.pop();
        },
        builder: (context) {
          return Container(
            width: context.screenWidth,
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     boxShadow: [
            //       BoxShadow(
            //           color: Colors.black26, spreadRadius: 200, blurRadius: 100)
            //     ]),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Leave a Review',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w700),
                  ).marginOnly(bottom: 15.h),
                  Divider(
                    color: Colors.grey.shade200,
                  ).marginSymmetric(horizontal: 10.w),
                  Divider(
                    color: Colors.grey.shade200,
                  ).marginSymmetric(horizontal: 10.w),
                  Text(
                    'How is your Order?',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w800),
                  ).marginOnly(bottom: 10.h),
                  Text(
                    'Please give your rating & also your review',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    glowColor: AppColors.kPrimary.withOpacity(.5),
                    glow: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(Icons.star_rounded,
                        color: AppColors.kPrimary),
                    onRatingUpdate: (rating) {
                      orderWatch.rating = rating;
                      orderWatch.notifyListeners();
                    },
                  ).marginSymmetric(vertical: 10.h),
                  CommonFormField(
                    controller: orderWatch.reviewController,
                    hintText: 'Review',
                    suffixIcon: const Icon(Icons.reviews),
                    // padding:
                    //     EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
                  ).marginSymmetric(vertical: 10.h),
                  Divider(
                    color: Colors.grey.shade200,
                  ).marginSymmetric(horizontal: 10.w),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                  side: const BorderSide(
                                      color: AppColors.kPrimary)),
                              backgroundColor: Colors.white),
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.kPrimary,
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r)),
                              backgroundColor: AppColors.kPrimary),
                          onPressed: () async {
                            await orderWatch.submitReview(foodData, orderId);
                            Fluttertoast.showToast(
                                msg: 'Review Submitted',
                                gravity: ToastGravity.CENTER,
                                backgroundColor: AppColors.kPrimary,
                                textColor: Colors.white);
                            context.pop();
                          },
                          child: Text(
                            "Submit!",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ],
                  ).marginOnly(bottom: 10.h)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
