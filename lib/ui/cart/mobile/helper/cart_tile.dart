import 'package:food_fly/ui/utils/theme/app_assets.dart';
import 'package:food_fly/ui/utils/widgets/common_button.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_text_style.dart';
import '../../../utils/theme/theme.dart';

class CartTile extends StatelessWidget {
  const CartTile({super.key, this.orderStatusColor, this.orderStatusText});
  final Color? orderStatusColor;
  final String? orderStatusText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h,right: 8.h,top: 16.w),
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey,
        child: Container(
          height: 150.h,
          width: 379.h,
          margin: EdgeInsets.symmetric(vertical:8.h,horizontal: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r)
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 75.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r)
                    ),
                    child: Image.asset(AppAssets.burgerBoyPng),
                  ),
                  SizedBox(width: 15.w,),
                  Expanded(child: Column(
                    children: [
                      SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Berry Toast",style: AppTextStyle.w5.copyWith(fontSize: 16.sp)),
                        Text("\$ 400",style: AppTextStyle.w5.copyWith(fontSize: 18.sp,color: AppColors.kPrimary)),
                      ],
                    ),
                      SizedBox(height: 6.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("10 september 2024",style: AppTextStyle.w4.copyWith(fontSize: 12.sp,color: AppColors.textGreyColor)),
                          Row(
                            children: [
                              Image.asset(AppAssets.timerClockPng,height: 25.h,width: 25.w,),
                              Text("20 min",style: AppTextStyle.w4.copyWith(fontSize: 12.sp,color: AppColors.kBlack)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h,),
                      Row(
                        children: [
                          Image.asset(AppAssets.tickMarkPng,height: 30,width: 30,color: orderStatusColor,),
                          Text(orderStatusText??"Order on way",style: AppTextStyle.w5.copyWith(fontSize: 11.sp,color:orderStatusColor?? AppColors.kLightGreen)),
                        ],
                      ),

                    ],))
                ],
              ),
              const Spacer(),
              /// ------------------------------------ Button -----------------------///
              Row(
                children: [
                  Expanded(child: CommonButton(onTap: (){},padding: EdgeInsets.symmetric(vertical: 8.h,),child: const Text("Track Order"),)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
