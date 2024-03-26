import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';
import 'package:intl/intl.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_text_style.dart';
import '../../../utils/theme/theme.dart';

class CartTile extends StatelessWidget {
  const CartTile(
      {super.key,
      this.orderStatusColor,
      this.orderStatusText,
      this.foodData,
      this.backgroundColor,
      this.textStyle,
      this.onButtonTap,
      this.quantity = 1,
      this.buttonText,
      this.remainTime,
      this.dateTime,
      this.iconWidget,
      this.paidStatus});
  final FoodDataModel? foodData;
  final Color? orderStatusColor;
  final Color? backgroundColor;
  final void Function()? onButtonTap;
  final String? orderStatusText;
  final String? buttonText;
  final TextStyle? textStyle;
  final String? remainTime;
  final Widget? paidStatus;
  final String? dateTime;
  final int quantity;
  final Widget? iconWidget;

  @override
  Widget build(BuildContext context) {
    double productPrice = foodData!.price! - foodData!.offPrice!;
    double driver = 50.0;
    double productTax = productPrice * quantity * (foodData!.tax! / 100);
    double totalPrice = productTax + driver + productPrice * quantity;
    return Padding(
      padding: EdgeInsets.only(left: 8.h, right: 8.h, top: 16.w),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 75.w,
                    height: 80.h,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r)),
                    child: CachedNetworkImage(
                      imageUrl: foodData!.image!,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const FlutterLogo(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(foodData!.name ?? "Berry Toast",
                                  style: AppTextStyle.w5
                                      .copyWith(fontSize: 16.sp))),
                          Text("₹ ${totalPrice.toStringAsFixed(2)}",
                              style: AppTextStyle.w5.copyWith(
                                  fontSize: 18.sp, color: AppColors.kPrimary)),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              DateFormat('dd-MM-yyyy hh:mm a').format(
                                  DateFormat('dd/MM/yyyy HH:mm:ss')
                                      .parse(dateTime!)),
                              style: AppTextStyle.w4.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColors.textGreyColor)),
                          paidStatus != null
                              ? paidStatus ?? const SizedBox()
                              : remainTime != null
                                  ? Row(
                                      children: [
                                        Image.asset(
                                          AppAssets.timerClockPng,
                                          height: 25.h,
                                          width: 25.w,
                                        ),
                                        Text("20 min",
                                            style: AppTextStyle.w4.copyWith(
                                                fontSize: 12.sp,
                                                color: AppColors.kBlack)),
                                      ],
                                    )
                                  : const SizedBox(),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            AppAssets.tickMarkPng,
                            height: 30,
                            width: 30,
                            color: orderStatusColor,
                          ),
                          Text(orderStatusText ?? "Order on way",
                              style: AppTextStyle.w5.copyWith(
                                  fontSize: 10.sp,
                                  color: orderStatusColor ??
                                      AppColors.kLightGreen)),
                          SizedBox(
                            width: 8.w,
                          ),
                          Expanded(child: iconWidget ?? const SizedBox())
                        ],
                      ),
                    ],
                  ))
                ],
              ),

              /// ------------------------------------ Button -----------------------///
              Row(
                children: [
                  Expanded(
                      child: CommonButton(
                    onTap: onButtonTap,
                    backgroundColor: backgroundColor ?? AppColors.kPrimary,
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                    ),
                    child: Text(
                      buttonText ?? "Track Order",
                      style: textStyle,
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
