import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_fly/framework/model/food_data_model/food_data_model.dart';
import 'package:food_fly/framework/service/fire_store_service.dart';

import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_string.dart';
import '../../../utils/theme/app_text_style.dart';
import '../../../utils/theme/theme.dart';

class CustomerOrderDetailFoodDetail extends ConsumerWidget {
  final String foodId;
  final int quantity;
  const CustomerOrderDetailFoodDetail( {super.key,required this.foodId, required this.quantity,});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
  final appStringWatch = ref.watch(appStringController);

  return  StreamBuilder<FoodDataModel>(
    stream: FireStoreService.fireStoreService.getFoodDataByIdFireStore(foodId),
    builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator(),);
      }else if(snapshot.hasData){
        final foodData = snapshot.data!;
        double productPrice = foodData.price! - foodData.offPrice!;
        double driver = 50.0;
        double productTax = productPrice*quantity*(foodData.tax!/100);
        double offPrice = foodData.offPrice! * quantity;
        double totalPrice =productTax+driver+productPrice*quantity;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appStringWatch.keyItemOrdered,style: AppTextStyle.w4.copyWith(
                fontSize: 14.sp,
                color: AppColors.kBlack
            ),),
            ListTile(
              leading: CachedNetworkImage(
                imageUrl: foodData.image!,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const FlutterLogo(),height: 50.w,width: 70.w,fit: BoxFit.cover,
              ),
              title: Text(foodData.name??"", style: AppTextStyle.w4.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.kBlack
              ),),
              subtitle: Text('INR ₹${foodData.price}', style: AppTextStyle.w4.copyWith(
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
                Text(foodData.name??"",style: AppTextStyle.w4.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.kGrey
                ),),
                Text('+ INR ₹${foodData.price}',style: AppTextStyle.w4.copyWith(
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
                Text("+ INR ₹$driver",style: AppTextStyle.w4.copyWith(
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
                Text("+ INR ₹$productTax",style: AppTextStyle.w4.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.kBlack
                ),)
              ],
            ),
            SizedBox(height: 6.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Saved",style: AppTextStyle.w4.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.kGrey
                ),),
                Text("- INR ₹$offPrice",style: AppTextStyle.w4.copyWith(
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
                Text("INR ₹$totalPrice",style: AppTextStyle.w4.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.kLightGreen
                ),)
              ],
            ),
          ],
        );
      }else{
        return const Center(child: Text("something went wrong..."),);
      }

  },);
  }
}
