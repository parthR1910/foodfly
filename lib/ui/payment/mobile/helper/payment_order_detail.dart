import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_string.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class PaymentOrderDetail extends StatelessWidget {
  final FoodDataModel foodData;
  final int quantity;
  const PaymentOrderDetail({super.key,required this.foodData,required this.quantity});

  @override
  Widget build(BuildContext context) {

    double productPrice = foodData.price! - foodData.offPrice!;
    double driver = 50.0;
    double productTax = productPrice*quantity*(foodData.tax!/100);
    double totalPrice =productTax+driver+productPrice*quantity;
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final appStringWatch = ref.watch(appStringController);
        return Column(
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
                imageUrl: foodData.image!,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const FlutterLogo(),height: 50.w,width: 70.w,fit: BoxFit.cover,
                ),
                  title: Text(foodData.name!, style: AppTextStyle.w4.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.kBlack
                  ),),
                  subtitle: Text('INR ₹ $productPrice', style: AppTextStyle.w4.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.kGrey
                  )),
                  trailing: Text("$quantity items", style: AppTextStyle.w4.copyWith(
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
                    Text(foodData.name!,style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text("INR ₹ ${productPrice*quantity}",style: AppTextStyle.w4.copyWith(
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
                    Text("Tax ${foodData.tax}%",style: AppTextStyle.w4.copyWith(
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
                    Text("Angga Risky",style: AppTextStyle.w4.copyWith(
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
                    Text("0822 0819 9688",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kBlack
                    ),)
                  ],
                ),
                SizedBox(height: 6.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appStringWatch.keyAddress,style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text("Setra Duta Palima",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kBlack
                    ),)
                  ],
                ),
                SizedBox(height: 6.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appStringWatch.keyHouseNo,style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text("A5 Hook",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kBlack
                    ),)
                  ],
                ),
                SizedBox(height: 6.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appStringWatch.keyCity,style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text("Bandung",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kBlack
                    ),)
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
