import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/app_string.dart';
import '../../../utils/theme/app_text_style.dart';
import '../../../utils/theme/theme.dart';

class CustomerOrderDetailView extends StatelessWidget {
  const CustomerOrderDetailView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  leading: const FlutterLogo(size: 30),
                  title: Text("Cherry Healthy", style: AppTextStyle.w4.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.kBlack
                  ),),
                  subtitle: Text('IDR 289.000', style: AppTextStyle.w4.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.kGrey
                  )),
                  trailing: Text("14 items", style: AppTextStyle.w4.copyWith(
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
                    Text("Cherry healthy",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text("IDR 18.390.000",style: AppTextStyle.w4.copyWith(
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
                    Text("IDR 50.000",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kBlack
                    ),)
                  ],
                ),
                SizedBox(height: 6.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(appStringWatch.keyTax,style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text("IDR 1.800.390",style: AppTextStyle.w4.copyWith(
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
                    Text("IDR 390.803.000",style: AppTextStyle.w4.copyWith(
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
            ),
            ///order status
            SizedBox(height: 32.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appStringWatch.keyOrderStatus, style: AppTextStyle.w4.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.kBlack
                ),),
                SizedBox(height: 8.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("#FM209391",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kGrey
                    ),),
                    Text("Paid",style: AppTextStyle.w4.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.kLightGreen
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
