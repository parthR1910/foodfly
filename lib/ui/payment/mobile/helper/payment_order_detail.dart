import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/scheduler.dart';
import 'package:food_fly/framework/controller/payment_order_detail_controller/payment_order_detail_controller.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/service/hive_service/box_service.dart';
import 'package:food_fly/ui/utils/constant/app_const_list.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';
import 'package:geocoding/geocoding.dart';

class PaymentOrderDetail extends ConsumerStatefulWidget {
  final FoodDataModel foodData;
  final int quantity;
  const PaymentOrderDetail({super.key,required this.foodData,required this.quantity});

  @override
  ConsumerState<PaymentOrderDetail> createState() => _PaymentOrderDetailState();
}

class _PaymentOrderDetailState extends ConsumerState<PaymentOrderDetail> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final user = BoxService.boxService.userModelBox.get(userModelDetailKey)!;
      ref.read(paymentOrderDetailController).getUserAddress(user);
    });

  }
  @override
  Widget build(BuildContext context) {
    double productPrice = widget.foodData.price! - widget.foodData.offPrice!;
    double driver = 50.0;
    double productTax = productPrice*widget.quantity*(widget.foodData.tax!/100);
    double totalPrice =productTax+driver+productPrice*widget.quantity;
    final user = BoxService.boxService.userModelBox.get(userModelDetailKey)!;

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final appStringWatch = ref.watch(appStringController);
        final paymentOrderDetailWatch  = ref.watch(paymentOrderDetailController);
        return paymentOrderDetailWatch.isLoading?
        const Center(child: CircularProgressIndicator(),):
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Item Order:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appStringWatch.keyItemOrdered,style: AppTextStyle.w4.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.kBlack
                ),),
                ListTile(
                  contentPadding: const EdgeInsets.only(left: 0),
                  leading: CachedNetworkImage(
                imageUrl: widget.foodData.image!,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const FlutterLogo(),height: 50.w,width: 70.w,fit: BoxFit.cover,
                ),
                  title: Text(widget.foodData.name!, style: AppTextStyle.w4.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.kBlack
                  ),),
                  subtitle: Text('INR ₹ $productPrice', style: AppTextStyle.w4.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.kGrey
                  )),
                  trailing: Text("${widget.quantity} items", style: AppTextStyle.w4.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.kGrey
                  )),
                ),
                SizedBox(height: 10.h,),
                Text(appStringWatch.keyDetailsTransaction, style: AppTextStyle.w4.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.kBlack
                ),),
                SizedBox(height: 8.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.foodData.name!,style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text("INR ₹ ${productPrice*widget.quantity}",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kBlack
                    ),)
                  ],
                ),
                SizedBox(height: 6.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appStringWatch.keyDriver,style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text("INR $driver",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kBlack
                    ),)
                  ],
                ),
                SizedBox(height: 6.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tax ${widget.foodData.tax}%",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text("INR ${productTax.toStringAsFixed(2)}",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kBlack
                    ),)
                  ],
                ),
                SizedBox(height: 6.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appStringWatch.keyTotalPrice,style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text("INR ${totalPrice.toStringAsFixed(2)}",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kLightGreen
                    ),)
                  ],
                ),
                SizedBox(height: 32.h,),
              ],
            ),
            SizedBox(height: 32.h,),
            /// Deliver TO:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appStringWatch.keyDeliverTo, style: AppTextStyle.w4.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.kBlack
                ),),
                SizedBox(height: 8.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appStringWatch.keyName,style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text(user.name??"",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kBlack
                    ),)
                  ],
                ),
                SizedBox(height: 6.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appStringWatch.keyPhoneNo,style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text(user.phone!.substring(3),style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kBlack
                    ),)
                  ],
                ),
                SizedBox(height: 6.h,),
                Text("${appStringWatch.keyAddress}: ",style: AppTextStyle.w4.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.kGrey
                ),),
                SizedBox(height: 6.h,),
                Text(paymentOrderDetailWatch.location,style: AppTextStyle.w4.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.kBlack
                ),)
              ],
            )
          ],
        );
      },
    );
  }
}
