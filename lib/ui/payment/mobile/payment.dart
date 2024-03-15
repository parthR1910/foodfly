import 'package:flutter_svg/svg.dart';
import 'package:food_fly/framework/controller/payment_order_detail_controller/payment_order_detail_controller.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/ui/payment/mobile/helper/payment_order_detail.dart';
import 'package:food_fly/ui/utils/common_device_config.dart';
import 'package:food_fly/ui/utils/theme/app_routes.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';
import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/widgets/common_loading.dart';

class Payment extends ConsumerStatefulWidget {
  final FoodDataModel foodData;
  final int quantity;
  const Payment({super.key,required this.foodData,required this.quantity});

  @override
  ConsumerState<Payment> createState() => _PaymentMobileState();
}

class _PaymentMobileState extends ConsumerState<Payment> {
  @override
  Widget build(BuildContext context) {
    mobileDeviceConfig(context);
    final paymentOrderDetailWatch = ref.watch(paymentOrderDetailController);

    return CommonLoading(
      show: paymentOrderDetailWatch.isLoadingOverlay,
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 48.h,
              ),
              PaymentOrderDetail(foodData: widget.foodData,quantity: widget.quantity),
              SizedBox(
                height: 64.h,
              ),
              CommonButton(
                onTap: () async {
                  await paymentOrderDetailWatch.postUserFoodCartOrder(quantity: widget.quantity, foodId: widget.foodData.foodId!);
                  if(context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.dashBoard, (route) => false);
                  }
                  },
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text("Add To Cart",
                  style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 10.h,),
              CommonButton(
                onTap: () async{
                 await paymentOrderDetailWatch.postUserFoodOrder(quantity: widget.quantity, foodId: widget.foodData.foodId!);
                 if(context.mounted){
                   Navigator.pushNamed(context, AppRoutes.successOrder);
                 }
                },
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Text(
                  ref.watch(appStringController).keyCheckoutNow,
                  style: AppTextStyle.w5.copyWith(fontSize: 14.sp),
                ),
              ),


            ],
          ),
        ) ,
      ),
    );
  }

  get appBar => AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            AppAssets.arrowBackSvg,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ref.watch(appStringController).keyPayment,
                style: AppTextStyle.w5
                    .copyWith(color: AppColors.kBlack, fontSize: 22.sp)),
            Text(ref.watch(appStringController).keyYouDeserveBetterMeal,
                style: AppTextStyle.w3
                    .copyWith(color: AppColors.kGrey, fontSize: 14.sp))
          ],
        ),
      );
}
